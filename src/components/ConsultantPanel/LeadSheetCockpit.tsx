import React, { useState, useEffect, useMemo } from 'react';
import * as XLSX from 'xlsx';
import { User, LeadSheet, LeadRow, LeadRowStatus, SheetMessage } from '../../types';
import { 
  getStoredLeadSheets, 
  saveLeadSheet, 
  updateLeadRow,
  getStoredConcerns,
  getStoredSheetMessages,
  saveSheetMessage,
  syncWithServer 
} from '../../services/storage';
import { getCurrentShamsiDate, toPersianDigits, shamsiToDate, getDailyReportWindowStatus } from '../../utils/shamsi';
import { exportLeadSheetToExcel, printOfficialLeadSheet } from '../../utils/export';
import { FOLLOW_UP_STATUS_CODES } from '../../data/defaultData';
import confetti from 'canvas-confetti';
import { 
  FileSpreadsheet, 
  CheckCircle2, 
  Clock, 
  AlertTriangle, 
  Sparkles, 
  Phone, 
  MapPin, 
  Users, 
  Calendar, 
  Award, 
  Download, 
  Printer, 
  Filter, 
  Search, 
  MessageSquare, 
  Send, 
  X, 
  Lock, 
  Check, 
  ChevronDown,
  Layers,
  Flame,
  Info
} from 'lucide-react';

interface LeadSheetCockpitProps {
  currentUser: User;
  onGoToDailyReport?: () => void;
}

export const LeadSheetCockpit: React.FC<LeadSheetCockpitProps> = ({ currentUser, onGoToDailyReport }) => {
  const [leadSheets, setLeadSheets] = useState<LeadSheet[]>(getStoredLeadSheets());
  const [concernsList, setConcernsList] = useState<string[]>(getStoredConcerns());
  const [sheetMessages, setSheetMessages] = useState<SheetMessage[]>(getStoredSheetMessages());

  // My sheets
  const mySheets = useMemo(() => {
    return leadSheets.filter(s => 
      s.assignedToConsultantId === currentUser.id || 
      (currentUser.consultantCode && s.assignedToConsultantCode?.toUpperCase() === currentUser.consultantCode.toUpperCase())
    );
  }, [leadSheets, currentUser]);

  const [selectedSheetId, setSelectedSheetId] = useState<string>('');

  // Active sheet
  const activeSheet = useMemo(() => {
    if (selectedSheetId) {
      const found = mySheets.find(s => s.id === selectedSheetId);
      if (found) return found;
    }
    return mySheets.length > 0 ? mySheets[0] : null;
  }, [mySheets, selectedSheetId]);

  // Filters & Search
  const [filterMode, setFilterMode] = useState<'all' | 'missions_today' | 'fresh' | 'overdue' | 'won'>('all');
  const [searchQuery, setSearchQuery] = useState('');
  const [successToast, setSuccessToast] = useState('');

  // Popover for in-place follow-up symbol edit
  const [editingFollowUpCell, setEditingFollowUpCell] = useState<{
    row: LeadRow;
    stepIndex: 1 | 2 | 3 | 4;
  } | null>(null);

  // Won meeting prompt modal
  const [wonPromptRow, setWonPromptRow] = useState<LeadRow | null>(null);
  const [meetingTopicInput, setMeetingTopicInput] = useState('');

  // In-Row Chat Modal with Supervisor
  const [activeMessageRow, setActiveMessageRow] = useState<LeadRow | null>(null);
  const [newMessageText, setNewMessageText] = useState('');

  // Window status (17:00 lock)
  const windowStatus = useMemo(() => {
    return getDailyReportWindowStatus(getCurrentShamsiDate().formatted);
  }, []);

  const isAfterHours = windowStatus.isPastDeadline;

  // Reload data
  const reloadData = () => {
    setLeadSheets(getStoredLeadSheets());
    setConcernsList(getStoredConcerns());
    setSheetMessages(getStoredSheetMessages());
  };

  useEffect(() => {
    const handleSync = () => reloadData();
    window.addEventListener('karino_db_synced', handleSync);
    return () => window.removeEventListener('karino_db_synced', handleSync);
  }, []);

  // Set default sheet if not set
  useEffect(() => {
    if (mySheets.length > 0 && !selectedSheetId) {
      setSelectedSheetId(mySheets[0].id);
    }
  }, [mySheets, selectedSheetId]);

  // Handle follow-up symbol selection
  const handleSelectSymbol = async (row: LeadRow, stepIndex: 1 | 2 | 3 | 4, symbol: string) => {
    if (!activeSheet) return;

    const todayShamsi = getCurrentShamsiDate().formatted;
    const nowIso = new Date().toISOString();

    const updates: Partial<LeadRow> = {
      updatedAt: nowIso
    };

    if (stepIndex === 1) {
      updates.followUp1 = symbol;
      updates.followUp1Date = nowIso;
      updates.followUp1DateShamsi = todayShamsi;
    } else if (stepIndex === 2) {
      updates.followUp2 = symbol;
      updates.followUp2Date = nowIso;
      updates.followUp2DateShamsi = todayShamsi;
    } else if (stepIndex === 3) {
      updates.followUp3 = symbol;
      updates.followUp3Date = nowIso;
      updates.followUp3DateShamsi = todayShamsi;
    } else if (stepIndex === 4) {
      updates.followUp4 = symbol;
      updates.followUp4Date = nowIso;
      updates.followUp4DateShamsi = todayShamsi;
    }

    // Determine status & result label
    if (symbol === '✓') {
      updates.status = 'won';
      updates.followUpResult = 'جلسه نهایی و توافق';
      setWonPromptRow({ ...row, ...updates });
      setMeetingTopicInput(row.meetingTopic || '');
      confetti({
        particleCount: 70,
        spread: 70,
        origin: { y: 0.6 }
      });
    } else if (symbol === '-') {
      updates.status = 'lost';
      updates.followUpResult = 'عدم نیاز / انصراف';
    } else if (symbol === '*') {
      updates.status = 'invalid';
      updates.followUpResult = 'شماره اشتباه / باطل';
    } else {
      updates.status = 'in_progress';
      const codeObj = FOLLOW_UP_STATUS_CODES.find(c => c.symbol === symbol || c.code === symbol);
      updates.followUpResult = codeObj ? codeObj.label : 'در حال پیگیری';
    }

    await updateLeadRow(activeSheet.id, row.id, updates);
    reloadData();
    setEditingFollowUpCell(null);

    setSuccessToast(`پیگیری ردیف ${toPersianDigits(row.rowNumber)} با نماد «${symbol}» ثبت شد.`);
    setTimeout(() => setSuccessToast(''), 3000);
  };

  // Save won meeting topic
  const handleSaveMeetingTopic = async () => {
    if (!activeSheet || !wonPromptRow) return;

    await updateLeadRow(activeSheet.id, wonPromptRow.id, {
      meetingTopic: meetingTopicInput.trim() || 'جلسه نهایی',
      updatedAt: new Date().toISOString()
    });

    reloadData();
    setWonPromptRow(null);
    setMeetingTopicInput('');
    setSuccessToast('موضوع و جزئیات جلسه با موفقیت ثبت شد.');
    setTimeout(() => setSuccessToast(''), 3000);
  };

  // Send message to supervisor on this row
  const handleSendMessage = async () => {
    if (!activeSheet || !activeMessageRow || !newMessageText.trim()) return;

    const newMsg: SheetMessage = {
      id: `msg-${Date.now()}`,
      sheetId: activeSheet.id,
      rowId: activeMessageRow.id,
      clientName: activeMessageRow.clientName,
      senderId: currentUser.id,
      senderName: currentUser.fullName,
      senderRole: currentUser.role,
      content: newMessageText.trim(),
      createdAt: new Date().toISOString(),
      timeShamsi: `${getCurrentShamsiDate().formatted} ${new Date().toLocaleTimeString('fa-IR', { hour: '2-digit', minute: '2-digit' })}`,
      isRead: false
    };

    await saveSheetMessage(newMsg);
    reloadData();
    setNewMessageText('');
    setSuccessToast('پیام شما با موفقیت برای سرپرست ارسال شد.');
    setTimeout(() => setSuccessToast(''), 3500);
  };

  // Update employer concern directly
  const handleUpdateConcern = async (rowId: string, concern: string) => {
    if (!activeSheet) return;
    await updateLeadRow(activeSheet.id, rowId, { employerConcern: concern, updatedAt: new Date().toISOString() });
    reloadData();
  };

  // Export Sheet to Excel matching official 11-column PDF format
  const handleExportExcel = () => {
    if (!activeSheet) return;
    exportLeadSheetToExcel(activeSheet);
  };

  // Print official landscape sheet matching PDF format
  const handlePrintSheet = () => {
    if (!activeSheet) return;
    printOfficialLeadSheet(activeSheet);
  };

  // Compute stats for HUD
  const hudStats = useMemo(() => {
    if (!activeSheet) {
      return { fresh: 0, dueToday: 0, overdue: 0, won: 0, total: 0, completed: 0 };
    }

    let fresh = 0;
    let dueToday = 0;
    let overdue = 0;
    let won = 0;
    let completed = 0;

    const now = Date.now();

    activeSheet.rows.forEach(r => {
      const isConcluded = r.status === 'won' || r.status === 'lost' || r.status === 'invalid' || r.followUpResult === '✓' || r.followUp1 === '✓' || r.followUp2 === '✓' || r.followUp3 === '✓' || r.followUp4 === '✓';

      if (r.status === 'won' || r.followUpResult === '✓' || r.followUp1 === '✓' || r.followUp2 === '✓' || r.followUp3 === '✓' || r.followUp4 === '✓') {
        won++;
      }

      if (!r.followUp1) {
        fresh++;
      } else {
        completed++;
        if (!isConcluded) {
          // Calculate elapsed days from last follow-up
          let lastDateStr = r.followUp3Date || r.followUp2Date || r.followUp1Date || activeSheet.createdAt;
          const lastTime = new Date(lastDateStr).getTime();
          const elapsed = Math.floor((now - lastTime) / (1000 * 60 * 60 * 24));

          if (elapsed >= 4) {
            overdue++;
          } else if (elapsed === 3 || elapsed === 4) {
            dueToday++;
          }
        }
      }
    });

    return { fresh, dueToday, overdue, won, total: activeSheet.rows.length, completed };
  }, [activeSheet]);

  // Filtered rows for the active sheet
  const displayRows = useMemo(() => {
    if (!activeSheet) return [];

    return activeSheet.rows.filter(r => {
      const now = Date.now();
      const isConcluded = r.status === 'won' || r.status === 'lost' || r.status === 'invalid' || r.followUpResult === '✓' || r.followUp1 === '✓' || r.followUp2 === '✓' || r.followUp3 === '✓' || r.followUp4 === '✓';
      let lastDateStr = r.followUp3Date || r.followUp2Date || r.followUp1Date || activeSheet.createdAt;
      const elapsed = Math.floor((now - new Date(lastDateStr).getTime()) / (1000 * 60 * 60 * 24));

      if (filterMode === 'fresh' && r.followUp1) return false;
      if (filterMode === 'won' && !isConcluded) return false;
      if (filterMode === 'overdue' && (isConcluded || !r.followUp1 || elapsed < 4)) return false;
      if (filterMode === 'missions_today') {
        const needsCallToday = !r.followUp1 || (!isConcluded && elapsed >= 4);
        if (!needsCallToday) return false;
      }

      if (searchQuery.trim()) {
        const q = searchQuery.toLowerCase();
        const matchName = r.clientName.toLowerCase().includes(q);
        const matchPhone = r.phone.includes(q);
        const matchGuild = r.activityField.toLowerCase().includes(q);
        const matchConcern = (r.employerConcern || '').toLowerCase().includes(q);
        if (!matchName && !matchPhone && !matchGuild && !matchConcern) return false;
      }

      return true;
    });
  }, [activeSheet, filterMode, searchQuery]);

  const isReadyForArchive = activeSheet && activeSheet.rows.length > 0 && activeSheet.rows.every(r => r.followUp1 && r.followUp1 !== '');

  return (
    <div className="space-y-6 font-['Vazirmatn',sans-serif] animate-fadeIn">
      
      {/* Toast */}
      {successToast && (
        <div className="p-3 bg-emerald-950/80 border border-emerald-500/40 rounded-2xl text-emerald-200 text-xs flex items-center gap-2 font-bold animate-fadeIn shadow-lg">
          <CheckCircle2 className="w-4 h-4 text-emerald-400 shrink-0" />
          <span>{successToast}</span>
        </div>
      )}

      {/* After-Hours Read-Only Warning */}
      {isAfterHours && (
        <div className="p-3.5 bg-amber-950/70 border border-amber-500/40 rounded-2xl text-amber-200 text-xs flex items-center justify-between font-bold">
          <div className="flex items-center gap-2">
            <Lock className="w-4 h-4 text-amber-400 shrink-0" />
            <span>ساعت اداری خاتمه یافته است (پس از ۱۷:۰۰ عصر). تغییرات اعمال‌شده در لاگ سیستم ثبت خواهد شد.</span>
          </div>
          <span className="text-[10px] bg-amber-500/20 px-2 py-0.5 rounded font-mono">
            Read-Only Enabled
          </span>
        </div>
      )}

      {/* NO SHEETS AVAILABLE */}
      {mySheets.length === 0 ? (
        <div className="navy-card-glass rounded-3xl border border-blue-500/30 p-12 text-center space-y-4 shadow-xl">
          <div className="w-16 h-16 rounded-2xl bg-blue-500/10 border border-blue-500/30 flex items-center justify-center text-blue-400 mx-auto">
            <FileSpreadsheet className="w-8 h-8" />
          </div>
          <h3 className="text-base font-bold text-white">
            شیت ۲۵ تایی جدیدی به شما تخصیص داده نشده است
          </h3>
          <p className="text-xs text-slate-400 max-w-md mx-auto leading-relaxed">
            سرپرست محترم روزانه اکسل کارفرمایان را در قالب شیت‌های اختصاصی ۲۵ ردیفه در کارتابل شما قرار خواهد داد. به محض تخصیص، اطلاعات در این بخش نمایش داده می‌شود.
          </p>
          {onGoToDailyReport && (
            <button
              type="button"
              onClick={onGoToDailyReport}
              className="px-5 py-2.5 bg-gradient-to-r from-amber-600 to-amber-500 hover:from-amber-500 hover:to-amber-400 text-white text-xs font-black rounded-xl shadow-lg cursor-pointer"
            >
              انتقال به ثبت فرم گزارش روزانه تماس‌ها
            </button>
          )}
        </div>
      ) : (
        <>
          {/* SHEET SWITCHER & READY FOR ARCHIVE BADGE */}
          <div className="navy-card-glass rounded-2xl border border-blue-500/30 p-4 shadow-lg flex flex-col sm:flex-row items-center justify-between gap-3">
            
            <div className="flex items-center gap-2.5 w-full sm:w-auto">
              <div className="w-9 h-9 rounded-xl bg-blue-500/20 border border-blue-500/30 flex items-center justify-center text-blue-300 shrink-0">
                <FileSpreadsheet className="w-5 h-5" />
              </div>
              <div className="space-y-0.5">
                <span className="text-[10px] text-slate-400 block">انتخاب شیت پرونده در دست اقدام:</span>
                <select
                  value={activeSheet?.id || ''}
                  onChange={(e) => setSelectedSheetId(e.target.value)}
                  className="bg-[#081525] border border-blue-500/40 rounded-xl px-3 py-1.5 text-xs text-white font-bold outline-none cursor-pointer"
                >
                  {mySheets.map(s => (
                    <option key={s.id} value={s.id}>
                      {s.title} ({toPersianDigits(s.dateShamsi)})
                    </option>
                  ))}
                </select>
              </div>
            </div>

            {/* Status & Archive Badge */}
            <div className="flex items-center gap-2">
              {isReadyForArchive ? (
                <div className="px-3 py-1.5 bg-gradient-to-r from-emerald-600 to-teal-600 border border-emerald-400/50 rounded-xl text-white text-xs font-black flex items-center gap-1.5 shadow-lg animate-pulse">
                  <CheckCircle2 className="w-4 h-4" />
                  <span>آماده بایگانی توسط سرپرست (۲۵ از ۲۵)</span>
                </div>
              ) : (
                <div className="px-3 py-1.5 bg-blue-950/60 border border-blue-500/30 rounded-xl text-blue-300 text-xs font-bold flex items-center gap-1.5">
                  <Clock className="w-4 h-4 text-blue-400" />
                  <span>پیشرفت شیت: {toPersianDigits(hudStats.completed)} از {toPersianDigits(hudStats.total)} کارفرما</span>
                </div>
              )}

              <button
                type="button"
                onClick={handleExportExcel}
                className="p-2 bg-emerald-600/30 hover:bg-emerald-600/50 border border-emerald-500/40 text-emerald-200 rounded-xl text-xs flex items-center justify-center cursor-pointer transition-colors"
                title="دانلود خروجی اکسل این شیت"
              >
                <Download className="w-4 h-4" />
              </button>

              <button
                type="button"
                onClick={handlePrintSheet}
                className="p-2 bg-blue-600/30 hover:bg-blue-600/50 border border-blue-500/40 text-blue-200 rounded-xl text-xs flex items-center justify-center cursor-pointer transition-colors"
                title="چاپ لنداسکیپ رسمی (طرح PDF)"
              >
                <Printer className="w-4 h-4" />
              </button>
            </div>

          </div>

          {/* 4 HUD METRIC CARDS */}
          <div className="grid grid-cols-2 lg:grid-cols-4 gap-3">
            
            {/* Card 1: Fresh Leads */}
            <div 
              onClick={() => setFilterMode(filterMode === 'fresh' ? 'all' : 'fresh')}
              className={`navy-card-glass rounded-2xl border p-4 shadow-lg cursor-pointer transition-all ${
                filterMode === 'fresh' ? 'border-blue-400 ring-2 ring-blue-400/30' : 'border-blue-500/20 hover:border-blue-400/50'
              }`}
            >
              <div className="flex items-center justify-between">
                <span className="text-xs text-slate-400">لیدهای تازه (بدون تماس)</span>
                <Sparkles className="w-4 h-4 text-blue-400" />
              </div>
              <div className="text-2xl font-black text-white font-mono mt-2">
                {toPersianDigits(hudStats.fresh)} <span className="text-xs text-slate-400 font-normal">مورد</span>
              </div>
              <span className="text-[10px] text-blue-400 block mt-0.5">آماده برقراری اولین تماس</span>
            </div>

            {/* Card 2: Due Today */}
            <div 
              onClick={() => setFilterMode(filterMode === 'missions_today' ? 'all' : 'missions_today')}
              className={`navy-card-glass rounded-2xl border p-4 shadow-lg cursor-pointer transition-all ${
                filterMode === 'missions_today' ? 'border-amber-400 ring-2 ring-amber-400/30' : 'border-amber-500/20 hover:border-amber-400/50'
              }`}
            >
              <div className="flex items-center justify-between">
                <span className="text-xs text-amber-300">ماموریت‌های امروز من</span>
                <Flame className="w-4 h-4 text-amber-400 animate-pulse" />
              </div>
              <div className="text-2xl font-black text-amber-300 font-mono mt-2">
                {toPersianDigits(hudStats.fresh + hudStats.overdue + hudStats.dueToday)} <span className="text-xs text-slate-400 font-normal">کارفرما</span>
              </div>
              <span className="text-[10px] text-amber-400/90 block mt-0.5">سیکل ۴ روزه و لیدهای جدید</span>
            </div>

            {/* Card 3: Overdue (+4 Days) */}
            <div 
              onClick={() => setFilterMode(filterMode === 'overdue' ? 'all' : 'overdue')}
              className={`navy-card-glass rounded-2xl border p-4 shadow-lg cursor-pointer transition-all ${
                filterMode === 'overdue' ? 'border-rose-400 ring-2 ring-rose-400/30' : 'border-rose-500/20 hover:border-rose-400/50'
              }`}
            >
              <div className="flex items-center justify-between">
                <span className="text-xs text-rose-300">پیگیری‌های معوقه (+۴ روز)</span>
                <AlertTriangle className="w-4 h-4 text-rose-400" />
              </div>
              <div className="text-2xl font-black text-rose-400 font-mono mt-2">
                {toPersianDigits(hudStats.overdue)} <span className="text-xs text-slate-400 font-normal">مورد</span>
              </div>
              <span className="text-[10px] text-rose-400 block mt-0.5">نیاز فوری به تماس مجدد</span>
            </div>

            {/* Card 4: Won / Closed */}
            <div 
              onClick={() => setFilterMode(filterMode === 'won' ? 'all' : 'won')}
              className={`navy-card-glass rounded-2xl border p-4 shadow-lg cursor-pointer transition-all ${
                filterMode === 'won' ? 'border-emerald-400 ring-2 ring-emerald-400/30' : 'border-emerald-500/20 hover:border-emerald-400/50'
              }`}
            >
              <div className="flex items-center justify-between">
                <span className="text-xs text-emerald-300">جلسات قطعی ست‌شده (✓)</span>
                <Award className="w-4 h-4 text-emerald-400" />
              </div>
              <div className="text-2xl font-black text-emerald-400 font-mono mt-2">
                {toPersianDigits(hudStats.won)} <span className="text-xs text-slate-400 font-normal">جلسه</span>
              </div>
              <span className="text-[10px] text-emerald-400 block mt-0.5">موفقیت‌های این شیت</span>
            </div>

          </div>

          {/* SEARCH & FILTER BAR */}
          <div className="navy-card-glass rounded-2xl border border-blue-500/20 p-3 shadow-lg flex flex-col sm:flex-row items-center justify-between gap-3">
            <div className="relative flex-1 w-full">
              <input
                type="text"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                placeholder="جستجوی نام کارفرما، شماره تماس، صنف یا دغدغه در جدول..."
                className="w-full bg-[#081525] border border-slate-700 focus:border-blue-400 rounded-xl pr-9 pl-3 py-2 text-xs text-white placeholder-slate-500 outline-none"
              />
              <Search className="w-4 h-4 text-slate-400 absolute right-3 top-2.5" />
            </div>

            <div className="flex items-center gap-1.5 w-full sm:w-auto overflow-x-auto pb-1 sm:pb-0">
              <button
                type="button"
                onClick={() => setFilterMode('all')}
                className={`px-3 py-1.5 rounded-xl text-xs font-bold transition-all cursor-pointer whitespace-nowrap ${
                  filterMode === 'all'
                    ? 'bg-blue-600 text-white shadow-md'
                    : 'bg-[#081525] text-slate-300 hover:bg-slate-800'
                }`}
              >
                همه ({toPersianDigits(activeSheet ? activeSheet.rows.length : 0)})
              </button>

              <button
                type="button"
                onClick={() => setFilterMode('missions_today')}
                className={`px-3 py-1.5 rounded-xl text-xs font-bold transition-all cursor-pointer whitespace-nowrap flex items-center gap-1 ${
                  filterMode === 'missions_today'
                    ? 'bg-amber-600 text-white shadow-md'
                    : 'bg-[#081525] text-amber-300 hover:bg-slate-800'
                }`}
              >
                <Flame className="w-3.5 h-3.5" />
                <span>ماموریت‌های امروز من</span>
              </button>

              <button
                type="button"
                onClick={() => setFilterMode('overdue')}
                className={`px-3 py-1.5 rounded-xl text-xs font-bold transition-all cursor-pointer whitespace-nowrap ${
                  filterMode === 'overdue'
                    ? 'bg-rose-600 text-white shadow-md'
                    : 'bg-[#081525] text-rose-300 hover:bg-slate-800'
                }`}
              >
                معوق (+۴ روز)
              </button>

              <button
                type="button"
                onClick={() => setFilterMode('won')}
                className={`px-3 py-1.5 rounded-xl text-xs font-bold transition-all cursor-pointer whitespace-nowrap ${
                  filterMode === 'won'
                    ? 'bg-emerald-600 text-white shadow-md'
                    : 'bg-[#081525] text-emerald-300 hover:bg-slate-800'
                }`}
              >
                جلسات ست‌شده (✓)
              </button>
            </div>
          </div>

          {/* THE 11-COLUMN 25-ROW TABLE MATCHING PDF */}
          <div className="navy-card-glass rounded-2xl border border-blue-500/30 overflow-hidden shadow-2xl">
            <div className="overflow-x-auto">
              <table className="w-full text-right text-xs border-collapse">
                <thead>
                  <tr className="bg-[#071322] text-blue-300 border-b border-blue-500/30">
                    <th className="py-3 px-2 text-center border-l border-slate-800 w-10">ردیف</th>
                    <th className="py-3 px-3 border-l border-slate-800 min-w-[130px]">نام کارفرما</th>
                    <th className="py-3 px-3 border-l border-slate-800 min-w-[100px]">صنف</th>
                    <th className="py-3 px-2 text-center border-l border-slate-800 w-14">پرسنل</th>
                    <th className="py-3 px-3 border-l border-slate-800 min-w-[110px]">شماره تماس</th>
                    <th className="py-3 px-3 border-l border-slate-800 min-w-[130px]">آدرس</th>
                    <th className="py-3 px-3 border-l border-slate-800 min-w-[130px]">دغدغه کارفرما</th>
                    <th className="py-3 px-2 text-center border-l border-slate-800 w-16">پیگیری ۱</th>
                    <th className="py-3 px-2 text-center border-l border-slate-800 w-16">پیگیری ۲</th>
                    <th className="py-3 px-2 text-center border-l border-slate-800 w-16">پیگیری ۳</th>
                    <th className="py-3 px-2 text-center border-l border-slate-800 w-16">پیگیری ۴</th>
                    <th className="py-3 px-3 border-l border-slate-800 min-w-[100px]">نتیجه</th>
                    <th className="py-3 px-3 min-w-[160px]">موضوع جلسه / دستور سرپرست</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-slate-800 text-slate-300">
                  {displayRows.map((row) => {
                    const rowMessages = sheetMessages.filter(m => m.rowId === row.id);
                    const hasUnread = rowMessages.some(m => !m.isRead && m.senderRole === 'ceo');

                    return (
                      <tr 
                        key={row.id} 
                        className={`hover:bg-slate-800/40 transition-colors ${
                          row.status === 'won' ? 'bg-emerald-950/20' : ''
                        }`}
                      >
                        {/* 1. Row Number */}
                        <td className="py-2.5 px-2 text-center font-mono font-bold text-amber-300 border-l border-slate-800/80">
                          {toPersianDigits(row.rowNumber)}
                        </td>

                        {/* 2. Client Name */}
                        <td className="py-2.5 px-3 font-bold text-white border-l border-slate-800/80">
                          {row.clientName}
                        </td>

                        {/* 3. Activity Field */}
                        <td className="py-2.5 px-3 text-[11px] text-slate-300 border-l border-slate-800/80">
                          {row.activityField}
                        </td>

                        {/* 4. Personnel Count */}
                        <td className="py-2.5 px-2 text-center font-mono text-[11px] text-slate-400 border-l border-slate-800/80">
                          {row.personnelCount ? toPersianDigits(row.personnelCount) : '-'}
                        </td>

                        {/* 5. Phone (Click to Call) */}
                        <td className="py-2.5 px-3 border-l border-slate-800/80" dir="ltr">
                          <a
                            href={`tel:${row.phone}`}
                            className="text-blue-400 hover:text-blue-300 font-mono font-bold flex items-center gap-1.5 transition-colors"
                          >
                            <Phone className="w-3 h-3 text-emerald-400" />
                            <span>{row.phone}</span>
                          </a>
                        </td>

                        {/* 6. Address */}
                        <td className="py-2.5 px-3 text-[11px] text-slate-400 border-l border-slate-800/80 truncate max-w-xs" title={row.address}>
                          {row.address || '-'}
                        </td>

                        {/* 7. Employer Concern */}
                        <td className="py-2 px-2 border-l border-slate-800/80">
                          <select
                            value={row.employerConcern || ''}
                            onChange={(e) => handleUpdateConcern(row.id, e.target.value)}
                            className="w-full bg-[#06111e] border border-slate-800 focus:border-blue-400 rounded-lg px-2 py-1 text-[11px] text-amber-300 outline-none cursor-pointer"
                          >
                            <option value="">انتخاب دغدغه...</option>
                            {concernsList.map((c, i) => (
                              <option key={i} value={c}>{c}</option>
                            ))}
                          </select>
                        </td>

                        {/* 8. Follow-up 1 */}
                        <td className="py-2 px-1.5 text-center border-l border-slate-800/80">
                          <button
                            type="button"
                            onClick={() => setEditingFollowUpCell({ row, stepIndex: 1 })}
                            className={`w-9 h-8 rounded-lg font-black text-sm transition-all flex items-center justify-center mx-auto cursor-pointer ${
                              row.followUp1 === '✓'
                                ? 'bg-emerald-600 text-white shadow-emerald-600/40 shadow-sm'
                                : row.followUp1
                                ? 'bg-blue-600/40 text-blue-200 border border-blue-500/40'
                                : 'bg-[#081525] text-slate-500 hover:text-white border border-slate-800'
                            }`}
                            title={row.followUp1DateShamsi ? `تاریخ: ${toPersianDigits(row.followUp1DateShamsi)}` : 'کلیک جهت ثبت تماس اول'}
                          >
                            {row.followUp1 || '+'}
                          </button>
                          {row.followUp1DateShamsi && (
                            <span className="text-[9px] text-slate-400 font-mono block mt-0.5">
                              {toPersianDigits(row.followUp1DateShamsi.slice(5))}
                            </span>
                          )}
                        </td>

                        {/* 9. Follow-up 2 */}
                        <td className="py-2 px-1.5 text-center border-l border-slate-800/80">
                          <button
                            type="button"
                            disabled={!row.followUp1}
                            onClick={() => setEditingFollowUpCell({ row, stepIndex: 2 })}
                            className={`w-9 h-8 rounded-lg font-black text-sm transition-all flex items-center justify-center mx-auto ${
                              !row.followUp1
                                ? 'opacity-30 cursor-not-allowed bg-[#081525] text-slate-600'
                                : row.followUp2 === '✓'
                                ? 'bg-emerald-600 text-white shadow-emerald-600/40 shadow-sm cursor-pointer'
                                : row.followUp2
                                ? 'bg-blue-600/40 text-blue-200 border border-blue-500/40 cursor-pointer'
                                : 'bg-[#081525] text-slate-500 hover:text-white border border-slate-800 cursor-pointer'
                            }`}
                            title={row.followUp2DateShamsi ? `تاریخ: ${toPersianDigits(row.followUp2DateShamsi)}` : 'کلیک جهت ثبت پیگیری دوم'}
                          >
                            {row.followUp2 || (row.followUp1 ? '+' : '.')}
                          </button>
                          {row.followUp2DateShamsi && (
                            <span className="text-[9px] text-slate-400 font-mono block mt-0.5">
                              {toPersianDigits(row.followUp2DateShamsi.slice(5))}
                            </span>
                          )}
                        </td>

                        {/* 10. Follow-up 3 */}
                        <td className="py-2 px-1.5 text-center border-l border-slate-800/80">
                          <button
                            type="button"
                            disabled={!row.followUp2}
                            onClick={() => setEditingFollowUpCell({ row, stepIndex: 3 })}
                            className={`w-9 h-8 rounded-lg font-black text-sm transition-all flex items-center justify-center mx-auto ${
                              !row.followUp2
                                ? 'opacity-30 cursor-not-allowed bg-[#081525] text-slate-600'
                                : row.followUp3 === '✓'
                                ? 'bg-emerald-600 text-white shadow-emerald-600/40 shadow-sm cursor-pointer'
                                : row.followUp3
                                ? 'bg-blue-600/40 text-blue-200 border border-blue-500/40 cursor-pointer'
                                : 'bg-[#081525] text-slate-500 hover:text-white border border-slate-800 cursor-pointer'
                            }`}
                            title={row.followUp3DateShamsi ? `تاریخ: ${toPersianDigits(row.followUp3DateShamsi)}` : 'کلیک جهت ثبت پیگیری سوم'}
                          >
                            {row.followUp3 || (row.followUp2 ? '+' : '.')}
                          </button>
                          {row.followUp3DateShamsi && (
                            <span className="text-[9px] text-slate-400 font-mono block mt-0.5">
                              {toPersianDigits(row.followUp3DateShamsi.slice(5))}
                            </span>
                          )}
                        </td>

                        {/* 11. Follow-up 4 */}
                        <td className="py-2 px-1.5 text-center border-l border-slate-800/80">
                          <button
                            type="button"
                            disabled={!row.followUp3}
                            onClick={() => setEditingFollowUpCell({ row, stepIndex: 4 })}
                            className={`w-9 h-8 rounded-lg font-black text-sm transition-all flex items-center justify-center mx-auto ${
                              !row.followUp3
                                ? 'opacity-30 cursor-not-allowed bg-[#081525] text-slate-600'
                                : row.followUp4 === '✓'
                                ? 'bg-emerald-600 text-white shadow-emerald-600/40 shadow-sm cursor-pointer'
                                : row.followUp4
                                ? 'bg-blue-600/40 text-blue-200 border border-blue-500/40 cursor-pointer'
                                : 'bg-[#081525] text-slate-500 hover:text-white border border-slate-800 cursor-pointer'
                            }`}
                            title={row.followUp4DateShamsi ? `تاریخ: ${toPersianDigits(row.followUp4DateShamsi)}` : 'کلیک جهت ثبت پیگیری چهارم'}
                          >
                            {row.followUp4 || (row.followUp3 ? '+' : '.')}
                          </button>
                          {row.followUp4DateShamsi && (
                            <span className="text-[9px] text-slate-400 font-mono block mt-0.5">
                              {toPersianDigits(row.followUp4DateShamsi.slice(5))}
                            </span>
                          )}
                        </td>

                        {/* Result Badge */}
                        <td className="py-2.5 px-3 border-l border-slate-800/80">
                          <span className={`text-[10px] px-2 py-0.5 rounded font-bold whitespace-nowrap ${
                            row.status === 'won' || row.followUpResult === '✓'
                              ? 'bg-emerald-950 text-emerald-300 border border-emerald-500/40'
                              : row.status === 'lost'
                              ? 'bg-rose-950 text-rose-300 border border-rose-500/40'
                              : row.status === 'invalid'
                              ? 'bg-slate-800 text-slate-400 border border-slate-700'
                              : 'bg-blue-950 text-blue-300 border border-blue-500/40'
                          }`}>
                            {row.followUpResult || (row.status === 'won' ? 'جلسه نهایی' : row.status === 'lost' ? 'عدم نیاز' : 'در جریان')}
                          </span>
                        </td>

                        {/* Notes / Meeting Topic / Supervisor Chat */}
                        <td className="py-2 px-3">
                          <div className="flex items-center justify-between gap-1.5">
                            <span className="text-[11px] text-slate-300 truncate max-w-[140px]" title={row.notes || row.meetingTopic}>
                              {row.meetingTopic || row.notes || 'بدون یادداشت'}
                            </span>
                            <button
                              type="button"
                              onClick={() => setActiveMessageRow(row)}
                              className={`p-1.5 rounded-lg text-xs flex items-center gap-1 cursor-pointer transition-colors shrink-0 ${
                                hasUnread
                                  ? 'bg-amber-600 text-white animate-bounce'
                                  : rowMessages.length > 0
                                  ? 'bg-blue-600/30 text-blue-200 border border-blue-500/40 hover:bg-blue-600/50'
                                  : 'bg-[#081525] hover:bg-slate-800 text-slate-400 border border-slate-800'
                              }`}
                              title="گفت‌وگو با سرپرست بر روی این ردیف"
                            >
                              <MessageSquare className="w-3.5 h-3.5" />
                              {rowMessages.length > 0 && (
                                <span className="font-mono text-[10px] font-bold">
                                  {toPersianDigits(rowMessages.length)}
                                </span>
                              )}
                            </button>
                          </div>
                        </td>

                      </tr>
                    );
                  })}
                </tbody>
              </table>
            </div>
          </div>

          {/* ----------------------------------------------------------- */}
          {/* POPOVER MODAL FOR SYMBOL PICKER (+, -, ., *, ✓) */}
          {/* ----------------------------------------------------------- */}
          {editingFollowUpCell && (
            <div className="fixed inset-0 z-50 bg-black/80 backdrop-blur-sm flex items-center justify-center p-4">
              <div className="bg-[#0a192c] border border-blue-500/40 rounded-2xl max-w-sm w-full p-5 space-y-4 shadow-2xl animate-scaleIn">
                <div className="flex items-center justify-between border-b border-slate-800 pb-3">
                  <div>
                    <h4 className="text-xs font-bold text-white">
                      ثبت پیگیری مرحله {toPersianDigits(editingFollowUpCell.stepIndex)}
                    </h4>
                    <p className="text-[11px] text-slate-400">
                      کارفرما: <span className="text-amber-300 font-bold">{editingFollowUpCell.row.clientName}</span>
                    </p>
                  </div>
                  <button onClick={() => setEditingFollowUpCell(null)} className="text-slate-400 hover:text-white">
                    <X className="w-4 h-4" />
                  </button>
                </div>

                <div className="space-y-2">
                  <span className="text-xs text-slate-300 block">نماد نتیجه این تماس را انتخاب فرمایید:</span>
                  <div className="grid grid-cols-1 gap-2">
                    {FOLLOW_UP_STATUS_CODES.map((item) => (
                      <button
                        key={item.code}
                        type="button"
                        onClick={() => handleSelectSymbol(editingFollowUpCell.row, editingFollowUpCell.stepIndex, item.symbol)}
                        className={`p-2.5 rounded-xl border flex items-center justify-between transition-all cursor-pointer ${
                          item.symbol === '✓'
                            ? 'bg-emerald-950/60 hover:bg-emerald-900 border-emerald-500/40 text-emerald-200'
                            : item.symbol === '-'
                            ? 'bg-rose-950/60 hover:bg-rose-900 border-rose-500/40 text-rose-200'
                            : item.symbol === '*'
                            ? 'bg-slate-900 hover:bg-slate-800 border-slate-700 text-slate-300'
                            : 'bg-[#081525] hover:bg-slate-800 border-slate-700 text-white'
                        }`}
                      >
                        <span className="text-xs font-bold">{item.label}</span>
                        <span className="w-7 h-7 rounded-lg bg-black/40 flex items-center justify-center font-black text-sm font-mono">
                          {item.symbol}
                        </span>
                      </button>
                    ))}
                  </div>
                </div>

                <div className="flex justify-end pt-2 border-t border-slate-800">
                  <button
                    type="button"
                    onClick={() => setEditingFollowUpCell(null)}
                    className="px-4 py-1.5 bg-slate-800 hover:bg-slate-700 text-slate-300 text-xs rounded-xl cursor-pointer"
                  >
                    انصراف
                  </button>
                </div>
              </div>
            </div>
          )}

          {/* ----------------------------------------------------------- */}
          {/* WON MEETING MODAL PROMPT */}
          {/* ----------------------------------------------------------- */}
          {wonPromptRow && (
            <div className="fixed inset-0 z-50 bg-black/85 backdrop-blur-md flex items-center justify-center p-4">
              <div className="bg-[#091f1a] border border-emerald-500/60 rounded-3xl max-w-md w-full p-6 space-y-4 shadow-2xl animate-scaleIn text-white">
                <div className="flex items-center gap-3 border-b border-emerald-800/60 pb-3">
                  <div className="w-10 h-10 rounded-xl bg-emerald-500/20 border border-emerald-500/40 flex items-center justify-center text-emerald-400">
                    <Award className="w-6 h-6" />
                  </div>
                  <div>
                    <h3 className="text-sm font-black text-emerald-200">
                      تبریک! هماهنگی جلسه نهایی ست شد (✓)
                    </h3>
                    <p className="text-[11px] text-emerald-400/80">
                      کارفرما: {wonPromptRow.clientName} ({wonPromptRow.activityField})
                    </p>
                  </div>
                </div>

                <div className="space-y-1.5">
                  <label className="text-xs font-bold text-emerald-200 block">
                    موضوع جلسه، بسته پیشنهادی یا توضیحات توافق:
                  </label>
                  <textarea
                    rows={3}
                    value={meetingTopicInput}
                    onChange={(e) => setMeetingTopicInput(e.target.value)}
                    placeholder="مثال: جلسه حضوری روز دوشنبه ساعت ۱۰ جهت انعقاد قرارداد بسته نقره‌ای..."
                    className="w-full bg-[#051410] border border-emerald-500/40 focus:border-emerald-300 rounded-xl p-3 text-xs text-white outline-none"
                    autoFocus
                  />
                </div>

                <div className="flex items-center justify-end gap-2 pt-2 border-t border-emerald-800/60">
                  <button
                    type="button"
                    onClick={() => setWonPromptRow(null)}
                    className="px-4 py-2 bg-emerald-950 hover:bg-emerald-900 text-emerald-300 text-xs rounded-xl cursor-pointer"
                  >
                    بستن
                  </button>
                  <button
                    type="button"
                    onClick={handleSaveMeetingTopic}
                    className="px-5 py-2 bg-gradient-to-r from-emerald-600 to-teal-600 hover:from-emerald-500 hover:to-teal-500 text-white text-xs font-black rounded-xl cursor-pointer shadow-lg"
                  >
                    ثبت و ذخیره جلسه
                  </button>
                </div>
              </div>
            </div>
          )}

          {/* ----------------------------------------------------------- */}
          {/* IN-ROW CHAT MODAL WITH SUPERVISOR */}
          {/* ----------------------------------------------------------- */}
          {activeMessageRow && (
            <div className="fixed inset-0 z-50 bg-black/80 backdrop-blur-sm flex items-center justify-center p-4">
              <div className="bg-[#0a192c] border border-blue-500/40 rounded-2xl max-w-md w-full p-5 space-y-4 shadow-2xl animate-scaleIn">
                <div className="flex items-center justify-between border-b border-slate-800 pb-3">
                  <div className="flex items-center gap-2">
                    <MessageSquare className="w-4 h-4 text-blue-400" />
                    <h4 className="text-xs font-bold text-white">
                      گفت‌وگو با سرپرست: {activeMessageRow.clientName}
                    </h4>
                  </div>
                  <button onClick={() => setActiveMessageRow(null)} className="text-slate-400 hover:text-white">
                    <X className="w-4 h-4" />
                  </button>
                </div>

                <div className="p-2.5 bg-[#06111e] rounded-xl border border-slate-800 text-[11px] space-y-1">
                  <div>شماره تماس: <span className="font-mono text-blue-300">{activeMessageRow.phone}</span></div>
                  <div>دغدغه: <span className="text-amber-300">{activeMessageRow.employerConcern || 'ثبت نشده'}</span></div>
                </div>

                {/* Message Log */}
                <div className="space-y-2 max-h-48 overflow-y-auto p-2.5 bg-[#06111e] rounded-xl border border-slate-800">
                  {sheetMessages.filter(m => m.rowId === activeMessageRow.id).length === 0 ? (
                    <div className="text-center py-4 text-xs text-slate-500">
                      هنوز پیامی بر روی این پرونده تبادل نشده است.
                    </div>
                  ) : (
                    sheetMessages.filter(m => m.rowId === activeMessageRow.id).map(msg => (
                      <div 
                        key={msg.id}
                        className={`p-2 rounded-xl text-xs space-y-0.5 ${
                          msg.senderRole === 'ceo'
                            ? 'bg-amber-950/40 border border-amber-500/30 text-amber-200 ml-4'
                            : 'bg-blue-950/40 border border-blue-500/30 text-blue-200 mr-4'
                        }`}
                      >
                        <div className="flex items-center justify-between text-[10px] text-slate-400">
                          <span className="font-bold">{msg.senderName} ({msg.senderRole === 'ceo' ? 'سرپرست' : 'مشاور'}):</span>
                          <span>{toPersianDigits(msg.timeShamsi)}</span>
                        </div>
                        <p className="pt-1 text-slate-200 leading-relaxed">{msg.content}</p>
                      </div>
                    ))
                  )}
                </div>

                {/* Reply Input */}
                <div className="space-y-1.5">
                  <label className="text-[11px] text-slate-300 block">ارسال سوال یا پیام جدید به سرپرست:</label>
                  <div className="flex items-center gap-2">
                    <input
                      type="text"
                      value={newMessageText}
                      onChange={(e) => setNewMessageText(e.target.value)}
                      placeholder="مثال: کارفرما تقاضای تخفیف ۵ درصدی دارد..."
                      className="flex-1 bg-[#06111e] border border-slate-700 focus:border-blue-400 rounded-xl px-3 py-2 text-xs text-white outline-none"
                      onKeyDown={(e) => e.key === 'Enter' && handleSendMessage()}
                    />
                    <button
                      type="button"
                      onClick={handleSendMessage}
                      className="p-2 bg-blue-600 hover:bg-blue-500 text-white rounded-xl cursor-pointer transition-colors shrink-0"
                    >
                      <Send className="w-4 h-4" />
                    </button>
                  </div>
                </div>

                <div className="flex justify-end pt-2 border-t border-slate-800">
                  <button
                    type="button"
                    onClick={() => setActiveMessageRow(null)}
                    className="px-4 py-1.5 bg-slate-800 hover:bg-slate-700 text-slate-300 text-xs rounded-xl cursor-pointer"
                  >
                    بستن
                  </button>
                </div>
              </div>
            </div>
          )}

        </>
      )}

    </div>
  );
};

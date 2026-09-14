import React, { useState, useEffect, useMemo } from 'react';
import * as XLSX from 'xlsx';
import { User, LeadSheet, LeadRow, LeadRowStatus, LeadSheetStatus, SheetMessage } from '../../types';
import { 
  getStoredLeadSheets, 
  saveLeadSheet, 
  saveLeadSheets, 
  deleteLeadSheet, 
  updateLeadRow,
  getStoredUsers,
  getStoredConcerns,
  getStoredSheetMessages,
  saveSheetMessage,
  syncWithServer 
} from '../../services/storage';
import { getCurrentShamsiDate, toPersianDigits } from '../../utils/shamsi';
import { 
  Upload, 
  FileSpreadsheet, 
  CheckCircle2, 
  AlertTriangle, 
  Users, 
  Calendar, 
  Clock, 
  Search, 
  Filter, 
  Eye, 
  Trash2, 
  UserCheck, 
  Phone, 
  Building, 
  Download, 
  MessageSquare, 
  Send, 
  X, 
  Plus, 
  ArrowRight, 
  RefreshCw,
  Award,
  ChevronDown,
  FileCheck,
  Layers,
  CheckSquare,
  Square
} from 'lucide-react';

export interface ParsedExcelTab {
  tabIndex: number;
  tabName: string;
  guild: string;
  rows: any[];
  selected: boolean;
  assignedConsultantId?: string;
}

interface LeadSheetManagerProps {
  currentUser: User;
}

/**
 * Normalizes Iranian phone numbers:
 * - Persian/Arabic digits to English
 * - Strips non-digits
 * - Replaces +98 / 0098 / 98 with 0
 * - Prepends 0 to 10-digit numbers starting with 9
 */
export function sanitizeIranianPhone(input: any): string {
  if (!input) return '';
  let str = String(input).trim();
  str = str.replace(/[۰-۹]/g, d => String('۰۱۲۳۴۵۶۷۸۹'.indexOf(d)));
  str = str.replace(/[٠-٩]/g, d => String('٠١٢٣٤٥٦٧٨٩'.indexOf(d)));
  str = str.replace(/[^\d+]/g, '');
  if (str.startsWith('+98')) {
    str = '0' + str.slice(3);
  } else if (str.startsWith('0098')) {
    str = '0' + str.slice(4);
  } else if (str.startsWith('98') && str.length >= 12) {
    str = '0' + str.slice(2);
  } else if (str.length === 10 && str.startsWith('9')) {
    str = '0' + str;
  }
  return str;
}

export const LeadSheetManager: React.FC<LeadSheetManagerProps> = ({ currentUser }) => {
  const [leadSheets, setLeadSheets] = useState<LeadSheet[]>(getStoredLeadSheets());
  const [users, setUsers] = useState<User[]>(getStoredUsers());
  const [concerns, setConcerns] = useState<string[]>(getStoredConcerns());
  const [sheetMessages, setSheetMessages] = useState<SheetMessage[]>(getStoredSheetMessages());

  // Upload & Multi-Sheet Chunking State
  const [showUploadModal, setShowUploadModal] = useState(false);
  const [parsedTabs, setParsedTabs] = useState<ParsedExcelTab[]>([]);
  const [activePreviewTabIdx, setActivePreviewTabIdx] = useState<number>(0);
  const [uploadFileName, setUploadFileName] = useState('');
  const [uploadGuild, setUploadGuild] = useState('عمومی');
  const [uploadTargetDate, setUploadTargetDate] = useState(getCurrentShamsiDate().formatted);
  const [selectedConsultantForBatch, setSelectedConsultantForBatch] = useState<string>('auto_split');
  const [uploadError, setUploadError] = useState('');
  const [isProcessingUpload, setIsProcessingUpload] = useState(false);

  // Multi-Tab Derived Metrics
  const selectedTabs = useMemo(() => parsedTabs.filter(t => t.selected && t.rows.length > 0), [parsedTabs]);
  const totalSelectedLeads = useMemo(() => selectedTabs.reduce((acc, t) => acc + t.rows.length, 0), [selectedTabs]);
  const totalEstimatedOutputSheets = useMemo(() => selectedTabs.reduce((acc, t) => acc + Math.ceil(t.rows.length / 25), 0), [selectedTabs]);
  const activeTabForPreview = useMemo(() => {
    if (parsedTabs.length === 0) return null;
    return parsedTabs[activePreviewTabIdx] || parsedTabs[0];
  }, [parsedTabs, activePreviewTabIdx]);

  const toggleTabSelection = (tabIndex: number) => {
    setParsedTabs(prev => prev.map(t => t.tabIndex === tabIndex ? { ...t, selected: !t.selected } : t));
  };

  const toggleAllTabs = (selectAll: boolean) => {
    setParsedTabs(prev => prev.map(t => ({ ...t, selected: selectAll })));
  };

  const setTabConsultant = (tabIndex: number, consultantId: string) => {
    setParsedTabs(prev => prev.map(t => t.tabIndex === tabIndex ? { ...t, assignedConsultantId: consultantId } : t));
  };

  // Filter & Search State
  const [searchQuery, setSearchQuery] = useState('');
  const [filterConsultant, setFilterConsultant] = useState('all');
  const [filterStatus, setFilterStatus] = useState<string>('all');
  const [successMsg, setSuccessMsg] = useState('');

  // Sheet Detail Modal
  const [viewingSheet, setViewingSheet] = useState<LeadSheet | null>(null);

  // In-Row Message / Directive Modal
  const [activeMessageRow, setActiveMessageRow] = useState<{ sheet: LeadSheet; row: LeadRow } | null>(null);
  const [newMessageText, setNewMessageText] = useState('');

  // Reassign Modal
  const [reassigningSheet, setReassigningSheet] = useState<LeadSheet | null>(null);
  const [newConsultantId, setNewConsultantId] = useState('');

  // Active Consultants
  const activeConsultants = useMemo(() => {
    return users.filter(u => u.role === 'consultant' && (u.status === 'active' || !u.status));
  }, [users]);

  // Reload data
  const reloadData = () => {
    setLeadSheets(getStoredLeadSheets());
    setUsers(getStoredUsers());
    setConcerns(getStoredConcerns());
    setSheetMessages(getStoredSheetMessages());
  };

  useEffect(() => {
    const handleSync = () => {
      reloadData();
      setViewingSheet(prev => {
        if (!prev) return null;
        const fresh = getStoredLeadSheets().find(s => s.id === prev.id);
        return fresh || prev;
      });
    };
    window.addEventListener('karino_db_synced', handleSync);
    return () => window.removeEventListener('karino_db_synced', handleSync);
  }, []);

  // Handle Excel / CSV File Selection with Complete Multi-Sheet Matrix Engine
  const handleFileSelect = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    const currentFileName = file.name;
    setUploadFileName(currentFileName);
    setUploadError('');
    setIsProcessingUpload(false);
    setActivePreviewTabIdx(0);

    const reader = new FileReader();
    reader.onload = (evt) => {
      try {
        const data = new Uint8Array(evt.target?.result as ArrayBuffer);
        const workbook = XLSX.read(data, { type: 'array' });
        
        if (!workbook.SheetNames || workbook.SheetNames.length === 0) {
          setUploadError('فایل اکسل فاقد هرگونه کاربرگ (Sheet) است.');
          setParsedTabs([]);
          setShowUploadModal(true);
          return;
        }

        const tabs: ParsedExcelTab[] = [];
        let globalDetectedGuild = uploadGuild;

        // Iterate over ALL sheets in workbook
        for (let sIdx = 0; sIdx < workbook.SheetNames.length; sIdx++) {
          const sheetName = workbook.SheetNames[sIdx];
          const worksheet = workbook.Sheets[sheetName];
          if (!worksheet) continue;

          // Read sheet as 2D cell matrix
          const matrix: any[][] = XLSX.utils.sheet_to_json(worksheet, { header: 1, defval: '' });
          if (!matrix || matrix.length === 0) continue;

          // 1. Scan for Guild (صنف) in top metadata rows of this tab
          let tabGuild = '';
          for (let r = 0; r < Math.min(matrix.length, 6); r++) {
            const rowCells = matrix[r] || [];
            for (const cell of rowCells) {
              const text = String(cell || '').trim();
              if (text.includes('صنف:') || text.includes('صنف :')) {
                const parts = text.split(/صنف\s*:\s*/);
                if (parts[1]) {
                  const cleaned = parts[1].split(/\s+تاریخ|\s+کد|\s+نام/)[0].trim();
                  if (cleaned && cleaned.length > 1) {
                    tabGuild = cleaned;
                    if (!globalDetectedGuild || globalDetectedGuild === 'عمومی') {
                      globalDetectedGuild = cleaned;
                      setUploadGuild(cleaned);
                    }
                  }
                }
              }
            }
          }

          // 2. Score rows to accurately identify the real table header row in this tab
          let bestHeaderIdx = -1;
          let bestHeaderScore = 0;

          for (let r = 0; r < Math.min(matrix.length, 15); r++) {
            const row = (matrix[r] || []).map((c: any) => String(c || '').trim().toLowerCase());
            let score = 0;
            if (row.some(c => c === 'ردیف' || c.startsWith('ردیف'))) score += 2;
            if (row.some(c => c.includes('نام و نام') || (c.includes('نام') && !c.includes('مشاور')) || c.includes('کارفرما') || c.includes('client'))) score += 3;
            if (row.some(c => c.includes('تلفن') || c.includes('تماس') || c.includes('موبایل') || c.includes('همراه') || c.includes('phone') || c.includes('mobile'))) score += 3;
            if (row.some(c => (c.includes('صنف') && !c.includes(':')) || c.includes('زمینه') || c.includes('فعالیت') || c.includes('guild'))) score += 2;
            if (row.some(c => c.includes('آدرس') || c.includes('نشانی') || c.includes('address'))) score += 2;
            if (row.some(c => c.includes('پرسنل') || c.includes('تعداد'))) score += 1;
            if (row.some(c => c.includes('پیگیری'))) score += 2;
            if (row.some(c => c.includes('موضوع') || c.includes('جلسه') || c.includes('بسته'))) score += 1;

            if (score > bestHeaderScore) {
              bestHeaderScore = score;
              bestHeaderIdx = r;
            }
          }

          let tabRows: any[] = [];

          if (bestHeaderIdx !== -1 && bestHeaderScore >= 2) {
            const headerRow = matrix[bestHeaderIdx].map((c: any) => String(c || '').trim().toLowerCase());
            const colMap = { 
              name: -1, 
              activity: -1, 
              count: -1, 
              phone: -1, 
              addr: -1, 
              f1: -1, 
              f2: -1, 
              f3: -1, 
              f4: -1, 
              topic: -1, 
              concern: -1 
            };

            headerRow.forEach((col: string, idx: number) => {
              if (col.includes('نام و نام') || (col.includes('نام') && !col.includes('مشاور')) || col.includes('کارفرما') || col.includes('client')) {
                if (colMap.name === -1) colMap.name = idx;
              } else if (col.includes('صنف') || col.includes('زمینه') || col.includes('فعالیت') || col.includes('guild')) {
                if (colMap.activity === -1) colMap.activity = idx;
              } else if (col.includes('پرسنل') || col.includes('تعداد')) {
                if (colMap.count === -1) colMap.count = idx;
              } else if (col.includes('تلفن') || col.includes('تماس') || col.includes('موبایل') || col.includes('همراه') || col.includes('phone') || col.includes('mobile')) {
                if (colMap.phone === -1) colMap.phone = idx;
              } else if (col.includes('آدرس') || col.includes('نشانی') || col.includes('address')) {
                if (colMap.addr === -1) colMap.addr = idx;
              } else if (col.includes('پیگیری 1') || col.includes('پیگیری ۱') || col.includes('پیگیری اول') || col.includes('followup 1') || col.includes('follow-up 1')) {
                if (colMap.f1 === -1) colMap.f1 = idx;
              } else if (col.includes('پیگیری 2') || col.includes('پیگیری ۲') || col.includes('پیگیری دوم') || col.includes('followup 2') || col.includes('follow-up 2')) {
                if (colMap.f2 === -1) colMap.f2 = idx;
              } else if (col.includes('پیگیری 3') || col.includes('پیگیری ۳') || col.includes('پیگیری سوم') || col.includes('followup 3') || col.includes('follow-up 3')) {
                if (colMap.f3 === -1) colMap.f3 = idx;
              } else if (col.includes('پیگیری 4') || col.includes('پیگیری ۴') || col.includes('پیگیری چهارم') || col.includes('followup 4') || col.includes('follow-up 4')) {
                if (colMap.f4 === -1) colMap.f4 = idx;
              } else if (col.includes('دغدغه') || col.includes('نیاز') || col.includes('concern')) {
                if (colMap.concern === -1) colMap.concern = idx;
              } else if (col.includes('موضوع') || col.includes('جلسه') || col.includes('بسته') || col.includes('توضیح') || col.includes('نتیجه')) {
                if (colMap.topic === -1) colMap.topic = idx;
              }
            });

            // Fallback: scan values for 10-11 digit phone numbers
            if (colMap.phone === -1 && matrix.length > bestHeaderIdx + 1) {
              for (let c = 0; c < 20; c++) {
                for (let r = bestHeaderIdx + 1; r < Math.min(matrix.length, bestHeaderIdx + 6); r++) {
                  const val = String(matrix[r]?.[c] || '');
                  const cleaned = val.replace(/\D/g, '');
                  if (cleaned.length >= 8 && cleaned.length <= 13) {
                    colMap.phone = c;
                    break;
                  }
                }
                if (colMap.phone !== -1) break;
              }
            }

            // Extract rows
            for (let r = bestHeaderIdx + 1; r < matrix.length; r++) {
              const row = matrix[r];
              if (!row || row.length === 0) continue;

              const clientName = colMap.name !== -1 ? String(row[colMap.name] || '').trim() : '';
              const activityField = colMap.activity !== -1 ? String(row[colMap.activity] || '').trim() : (tabGuild || globalDetectedGuild || 'عمومی');
              const personnelCount = colMap.count !== -1 ? String(row[colMap.count] || '').trim() : '';
              const rawPhone = colMap.phone !== -1 ? String(row[colMap.phone] || '').trim() : '';
              const phone = sanitizeIranianPhone(rawPhone);
              const address = colMap.addr !== -1 ? String(row[colMap.addr] || '').trim() : '';
              const employerConcern = colMap.concern !== -1 ? String(row[colMap.concern] || '').trim() : '';
              const meetingTopic = colMap.topic !== -1 ? String(row[colMap.topic] || '').trim() : '';

              if (!clientName && !phone) continue;
              if (clientName === 'نام و نام خانوادگی' || clientName === 'نام کارفرما' || clientName === 'ردیف') continue;

              tabRows.push({
                clientName: clientName || 'کارفرمای بدون نام',
                activityField: activityField || tabGuild || globalDetectedGuild || 'عمومی',
                personnelCount,
                phone,
                address,
                employerConcern,
                meetingTopic
              });
            }
          } else {
            // Flat json fallback for non-standard sheets
            const rawJson: any[] = XLSX.utils.sheet_to_json(worksheet, { defval: '' });
            tabRows = rawJson.map((row) => {
              let clientName = '';
              let activityField = '';
              let personnelCount = '';
              let phone = '';
              let address = '';
              let employerConcern = '';
              let meetingTopic = '';

              for (const key of Object.keys(row)) {
                const val = String(row[key]).trim();
                const lowerKey = key.toLowerCase();

                if (lowerKey.includes('نام') || lowerKey.includes('کارفرما') || lowerKey.includes('client') || lowerKey.includes('name')) {
                  if (!clientName) clientName = val;
                } else if (lowerKey.includes('صنف') || lowerKey.includes('زمینه') || lowerKey.includes('فعالیت') || lowerKey.includes('guild')) {
                  if (!activityField) activityField = val;
                } else if (lowerKey.includes('پرسنل') || lowerKey.includes('تعداد')) {
                  if (!personnelCount) personnelCount = val;
                } else if (lowerKey.includes('تلفن') || lowerKey.includes('تماس') || lowerKey.includes('موبایل') || lowerKey.includes('phone')) {
                  if (!phone) phone = val;
                } else if (lowerKey.includes('آدرس') || lowerKey.includes('نشانی') || lowerKey.includes('address')) {
                  if (!address) address = val;
                } else if (lowerKey.includes('دغدغه') || lowerKey.includes('نیاز') || lowerKey.includes('concern')) {
                  if (!employerConcern) employerConcern = val;
                } else if (lowerKey.includes('موضوع') || lowerKey.includes('جلسه') || lowerKey.includes('topic')) {
                  if (!meetingTopic) meetingTopic = val;
                }
              }

              return {
                clientName: clientName || row['نام و نام خانوادگی'] || row['نام'] || 'بدون نام',
                activityField: activityField || row['صنف'] || row['زمینه فعالیت'] || tabGuild || globalDetectedGuild || 'عمومی',
                personnelCount: personnelCount || row['تعداد پرسنل'] || '',
                phone: sanitizeIranianPhone(phone || row['شماره تماس'] || row['موبایل'] || ''),
                address: address || row['آدرس'] || '',
                employerConcern: employerConcern || row['دغدغه کارفرما'] || '',
                meetingTopic: meetingTopic || row['توضیحات'] || ''
              };
            }).filter(r => r.clientName !== 'بدون نام' || r.phone !== '');
          }

          if (tabRows.length > 0) {
            tabs.push({
              tabIndex: sIdx,
              tabName: sheetName,
              guild: tabGuild || globalDetectedGuild || 'عمومی',
              rows: tabRows,
              selected: true
            });
          }
        }

        if (tabs.length === 0) {
          setUploadError('هیچ ردیف معتبری (حاوی نام کارفرما یا شماره تماس) در هیچ‌یک از کاربرگ‌های این فایل اکسل شناسایی نشد.');
          setParsedTabs([]);
          setShowUploadModal(true);
          return;
        }

        setParsedTabs(tabs);
        setUploadError('');
        setShowUploadModal(true);
      } catch (err: any) {
        console.error('[LeadSheetManager] Multi-tab Excel upload parse error:', err);
        setUploadError(`خطا در پردازش فایل اکسل: ${err.message || 'فرمت فایل معتبر نیست'}`);
        setParsedTabs([]);
        setShowUploadModal(true);
      } finally {
        if (e.target) {
          e.target.value = '';
        }
      }
    };

    reader.onerror = () => {
      setUploadError('خطا در خواندن فایل از روی سیستم.');
      setParsedTabs([]);
      setShowUploadModal(true);
      if (e.target) e.target.value = '';
    };

    reader.readAsArrayBuffer(file);
  };

  // Process and Chunk Multi-Tab Workbook into 25-Row Sheets
  const handleConfirmChunkAndAssign = async () => {
    const activeSelectedTabs = parsedTabs.filter(t => t.selected && t.rows.length > 0);
    if (activeSelectedTabs.length === 0) {
      setUploadError('هیچ کاربرگی برای تخصیص انتخاب نشده است.');
      return;
    }
    if (activeConsultants.length === 0) {
      setUploadError('هیچ مشاور فعالی در سیستم برای تخصیص لیدها یافت نشد.');
      return;
    }

    setIsProcessingUpload(true);
    setUploadError('');

    try {
      const newSheets: LeadSheet[] = [];
      const nowIso = new Date().toISOString();

      let existingMaxSheetNumber = 0;
      leadSheets.forEach(s => {
        if (s.sheetNumber > existingMaxSheetNumber) existingMaxSheetNumber = s.sheetNumber;
      });

      let sheetCounter = 0;
      let totalCreatedLeadsCount = 0;

      activeSelectedTabs.forEach((tab) => {
        const chunkSize = 25;
        const totalChunks = Math.ceil(tab.rows.length / chunkSize);

        for (let i = 0; i < totalChunks; i++) {
          sheetCounter++;
          const sheetNum = existingMaxSheetNumber + sheetCounter;
          const chunkSlice = tab.rows.slice(i * chunkSize, (i + 1) * chunkSize);

          // Determine consultant assignment:
          // 1. Tab-level consultant override
          // 2. Or global batch assignment: auto_split or specific consultant
          let assignedConsultant = activeConsultants[0];
          if (tab.assignedConsultantId && tab.assignedConsultantId !== 'auto_split') {
            const match = activeConsultants.find(c => c.id === tab.assignedConsultantId);
            if (match) assignedConsultant = match;
          } else if (selectedConsultantForBatch === 'auto_split') {
            assignedConsultant = activeConsultants[(sheetCounter - 1) % activeConsultants.length];
          } else {
            const match = activeConsultants.find(c => c.id === selectedConsultantForBatch);
            if (match) assignedConsultant = match;
          }

          const rows: LeadRow[] = chunkSlice.map((raw: any, idx: number) => ({
            id: `row-${Date.now()}-${sheetCounter}-${idx + 1}`,
            rowNumber: idx + 1,
            clientName: raw.clientName,
            activityField: raw.activityField || tab.guild || uploadGuild,
            personnelCount: raw.personnelCount,
            phone: raw.phone,
            address: raw.address,
            employerConcern: raw.employerConcern,
            meetingTopic: raw.meetingTopic,
            status: 'in_progress',
            updatedAt: nowIso
          }));

          totalCreatedLeadsCount += rows.length;

          const sheetTitle = totalChunks > 1 
            ? `شیت شماره ${toPersianDigits(sheetNum)} - ${tab.tabName} (بخش ${toPersianDigits(i + 1)} از ${toPersianDigits(totalChunks)}) - ${tab.guild}`
            : `شیت شماره ${toPersianDigits(sheetNum)} - ${tab.tabName} (${tab.guild})`;

          const newSheet: LeadSheet = {
            id: `sheet-${Date.now()}-${sheetCounter}`,
            sheetNumber: sheetNum,
            title: sheetTitle,
            guild: tab.guild || uploadGuild,
            assignedToConsultantId: assignedConsultant.id,
            assignedToConsultantName: assignedConsultant.fullName,
            assignedToConsultantCode: assignedConsultant.consultantCode,
            assignedByManagerId: currentUser.id,
            assignedAt: nowIso,
            dateShamsi: uploadTargetDate,
            targetCallsCount: rows.length,
            rows: rows,
            status: 'active',
            createdAt: nowIso,
            updatedAt: nowIso
          };

          newSheets.push(newSheet);
        }
      });

      await saveLeadSheets(newSheets);
      reloadData();
      setShowUploadModal(false);
      setParsedTabs([]);
      setUploadFileName('');
      setSuccessMsg(`تعداد ${toPersianDigits(totalCreatedLeadsCount)} لید از ${toPersianDigits(activeSelectedTabs.length)} کاربرگ در قالب ${toPersianDigits(newSheets.length)} شیت ۲۵ تایی با موفقیت تفکیک و به کارتابل مشاورین تخصیص داده شد.`);
      setTimeout(() => setSuccessMsg(''), 6000);
    } catch (err: any) {
      setUploadError('خطا در ذخیره‌سازی و تخصیص شیت‌ها.');
    } finally {
      setIsProcessingUpload(false);
    }
  };

  // Reassign sheet to another consultant
  const handleExecuteReassign = async () => {
    if (!reassigningSheet || !newConsultantId) return;
    const targetUser = users.find(u => u.id === newConsultantId);
    if (!targetUser) return;

    const updatedSheet: LeadSheet = {
      ...reassigningSheet,
      assignedToConsultantId: targetUser.id,
      assignedToConsultantName: targetUser.fullName,
      assignedToConsultantCode: targetUser.consultantCode,
      updatedAt: new Date().toISOString()
    };

    await saveLeadSheet(updatedSheet);
    reloadData();
    setReassigningSheet(null);
    setNewConsultantId('');
    setSuccessMsg(`شیت شماره ${toPersianDigits(updatedSheet.sheetNumber)} با موفقیت به «${targetUser.fullName}» واگذار گردید.`);
    setTimeout(() => setSuccessMsg(''), 4000);
  };

  // Delete sheet
  const handleDeleteSheet = async (sheetId: string) => {
    if (!confirm('آیا از حذف این شیت اطمینان دارید؟ تمامی ۲۵ ردیف آن حذف خواهد شد.')) return;
    await deleteLeadSheet(sheetId);
    reloadData();
    if (viewingSheet?.id === sheetId) setViewingSheet(null);
    setSuccessMsg('شیت لید با موفقیت از سیستم حذف گردید.');
    setTimeout(() => setSuccessMsg(''), 3000);
  };

  // Send Direct Message / Directive on a Specific Row
  const handleSendMessageOnRow = async () => {
    if (!activeMessageRow || !newMessageText.trim()) return;

    const newMsg: SheetMessage = {
      id: `msg-${Date.now()}`,
      sheetId: activeMessageRow.sheet.id,
      rowId: activeMessageRow.row.id,
      clientName: activeMessageRow.row.clientName,
      senderId: currentUser.id,
      senderName: currentUser.fullName || 'سرپرست',
      senderRole: currentUser.role,
      content: newMessageText.trim(),
      createdAt: new Date().toISOString(),
      timeShamsi: `${getCurrentShamsiDate().formatted} ${new Date().toLocaleTimeString('fa-IR', { hour: '2-digit', minute: '2-digit' })}`,
      isRead: false
    };

    await saveSheetMessage(newMsg);

    // Also update row notes
    const updatedNotes = activeMessageRow.row.notes 
      ? `${activeMessageRow.row.notes} | سرپرست: ${newMessageText.trim()}`
      : `سرپرست: ${newMessageText.trim()}`;

    await updateLeadRow(activeMessageRow.sheet.id, activeMessageRow.row.id, { notes: updatedNotes });

    reloadData();
    setNewMessageText('');
    setActiveMessageRow(null);
    setSuccessMsg('پیام و دستور شما مستقیماً بر روی این ردیف ثبت و به مشاور ابلاغ گردید.');
    setTimeout(() => setSuccessMsg(''), 3500);
  };

  // Export Sheet to Excel matching official 11-column PDF table
  const handleExportSheetToExcel = (sheet: LeadSheet) => {
    const headers = [
      'ردیف',
      'نام و نام خانوادگی کارفرما',
      'صنف / زمینه فعالیت',
      'تعداد پرسنل',
      'شماره تماس',
      'آدرس',
      'دغدغه کارفرما',
      'پیگیری ۱',
      'پیگیری ۲',
      'پیگیری ۳',
      'پیگیری ۴',
      'نتیجه پیگیری',
      'موضوع جلسه و بسته پیشنهادی / توضیحات'
    ];

    const dataRows = sheet.rows.map(r => [
      r.rowNumber,
      r.clientName,
      r.activityField,
      r.personnelCount || '',
      r.phone,
      r.address,
      r.employerConcern || '',
      r.followUp1 || '',
      r.followUp2 || '',
      r.followUp3 || '',
      r.followUp4 || '',
      r.followUpResult || (r.status === 'won' ? '✓ موفق' : r.status === 'lost' ? '- عدم نیاز' : '. در جریان'),
      r.meetingTopic || r.notes || ''
    ]);

    const worksheet = XLSX.utils.aoa_to_sheet([headers, ...dataRows]);
    const workbook = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(workbook, worksheet, `شیت_${sheet.sheetNumber}`);

    XLSX.writeFile(workbook, `شیت_۲۵_لید_شماره_${sheet.sheetNumber}_${sheet.assignedToConsultantName.replace(/\s+/g, '_')}_${sheet.dateShamsi.replace(/\//g, '-')}.xlsx`);
  };

  // Filtered sheets
  const filteredSheets = useMemo(() => {
    return leadSheets.filter(s => {
      if (filterConsultant !== 'all' && s.assignedToConsultantId !== filterConsultant) return false;
      if (filterStatus !== 'all' && s.status !== filterStatus) return false;
      if (searchQuery.trim()) {
        const q = searchQuery.toLowerCase();
        const matchTitle = s.title.toLowerCase().includes(q);
        const matchConsultant = s.assignedToConsultantName.toLowerCase().includes(q) || s.assignedToConsultantCode.toLowerCase().includes(q);
        const matchRow = s.rows.some(r => r.clientName.toLowerCase().includes(q) || r.phone.includes(q) || r.activityField.toLowerCase().includes(q));
        if (!matchTitle && !matchConsultant && !matchRow) return false;
      }
      return true;
    });
  }, [leadSheets, filterConsultant, filterStatus, searchQuery]);

  // Aggregate stats
  const totalLeadsCount = useMemo(() => {
    return leadSheets.reduce((acc, s) => acc + s.rows.length, 0);
  }, [leadSheets]);

  const totalWonMeetingsCount = useMemo(() => {
    return leadSheets.reduce((acc, s) => {
      const wonRows = s.rows.filter(r => r.status === 'won' || r.followUpResult === '✓' || r.followUp1 === '✓' || r.followUp2 === '✓' || r.followUp3 === '✓' || r.followUp4 === '✓');
      return acc + wonRows.length;
    }, 0);
  }, [leadSheets]);

  const totalFollowUpsDone = useMemo(() => {
    return leadSheets.reduce((acc, s) => {
      const touched = s.rows.filter(r => r.followUp1 || r.followUp2 || r.followUp3 || r.followUp4);
      return acc + touched.length;
    }, 0);
  }, [leadSheets]);

  return (
    <div className="space-y-6 animate-fadeIn">
      
      {/* SUCCESS MESSAGE */}
      {successMsg && (
        <div className="p-3.5 bg-emerald-950/80 border border-emerald-500/40 rounded-2xl text-emerald-200 text-xs flex items-center justify-between font-bold animate-fadeIn shadow-lg">
          <div className="flex items-center gap-2">
            <CheckCircle2 className="w-5 h-5 text-emerald-400 shrink-0" />
            <span>{successMsg}</span>
          </div>
          <button onClick={() => setSuccessMsg('')} className="text-emerald-400 hover:text-white cursor-pointer">
            <X className="w-4 h-4" />
          </button>
        </div>
      )}

      {/* TOP STATS & UPLOAD CTA */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        
        {/* Total Sheets */}
        <div className="bg-white rounded-2xl border border-[#E6DAC8] p-4 shadow-sm flex items-center justify-between">
          <div className="space-y-1">
            <span className="text-xs text-[#7F4F24] font-medium">کل شیت‌های فعال ۲۵ ردیفه</span>
            <div className="text-2xl font-black text-[#3E2723] font-mono">
              {toPersianDigits(leadSheets.length)} <span className="text-xs text-[#7F4F24] font-normal">شیت</span>
            </div>
            <span className="text-[10px] text-[#A0522D]">
              {toPersianDigits(leadSheets.filter(s => s.status === 'active').length)} شیت در دست اقدام
            </span>
          </div>
          <div className="w-12 h-12 rounded-xl bg-[#FAF7F2] border border-[#E6DAC8] flex items-center justify-center text-[#9C6644]">
            <FileSpreadsheet className="w-6 h-6" />
          </div>
        </div>

        {/* Total Leads */}
        <div className="bg-white rounded-2xl border border-[#E6DAC8] p-4 shadow-sm flex items-center justify-between">
          <div className="space-y-1">
            <span className="text-xs text-[#7F4F24] font-medium">مجموع لیدهای تحت پوشش</span>
            <div className="text-2xl font-black text-[#3E2723] font-mono">
              {toPersianDigits(totalLeadsCount)} <span className="text-xs text-[#7F4F24] font-normal">کارفرما</span>
            </div>
            <span className="text-[10px] text-emerald-700 font-bold">
              {toPersianDigits(totalFollowUpsDone)} لید پیگیری شده
            </span>
          </div>
          <div className="w-12 h-12 rounded-xl bg-[#FAF7F2] border border-[#E6DAC8] flex items-center justify-center text-[#9C6644]">
            <Users className="w-6 h-6" />
          </div>
        </div>

        {/* Won Meetings */}
        <div className="bg-white rounded-2xl border border-emerald-200 p-4 shadow-sm flex items-center justify-between bg-gradient-to-br from-white to-emerald-50/40">
          <div className="space-y-1">
            <span className="text-xs text-emerald-800 font-medium">جلسات نهایی ست‌شده (✓)</span>
            <div className="text-2xl font-black text-emerald-700 font-mono">
              {toPersianDigits(totalWonMeetingsCount)} <span className="text-xs text-emerald-600 font-normal">جلسه</span>
            </div>
            <span className="text-[10px] text-emerald-600">
              نرخ موفقیت: {totalLeadsCount > 0 ? toPersianDigits(Math.round((totalWonMeetingsCount / totalLeadsCount) * 100)) : '۰'}٪
            </span>
          </div>
          <div className="w-12 h-12 rounded-xl bg-emerald-100 border border-emerald-300 flex items-center justify-center text-emerald-700">
            <Award className="w-6 h-6" />
          </div>
        </div>

        {/* Upload Excel CTA */}
        <div className="bg-gradient-to-br from-[#9C6644] to-[#7F4F24] rounded-2xl p-4 shadow-md text-white flex flex-col justify-between space-y-2">
          <div className="flex items-center justify-between">
            <span className="text-xs font-bold text-amber-100">بارگذاری فایل لید روزانه</span>
            <Upload className="w-5 h-5 text-amber-200" />
          </div>
          <p className="text-[11px] text-amber-100/90 leading-tight">
            ورود فایل اکسل/CSV، استانداردسازی تلفن‌ها و شکستن خودکار به صفحات ۲۵ کارفرمایی.
          </p>
          <label className="w-full py-2 px-3 bg-white hover:bg-amber-50 text-[#5C4033] text-xs font-black rounded-xl flex items-center justify-center gap-1.5 cursor-pointer shadow transition-all active:scale-95">
            <Upload className="w-4 h-4 text-[#9C6644]" />
            <span>انتخاب فایل اکسل (.xlsx / .csv)</span>
            <input
              type="file"
              accept=".xlsx,.xls,.csv"
              onChange={handleFileSelect}
              className="hidden"
            />
          </label>
        </div>

      </div>

      {/* SEARCH, FILTER & ACTION BAR */}
      <div className="bg-white rounded-2xl border border-[#E6DAC8] p-4 shadow-sm flex flex-col sm:flex-row items-center justify-between gap-3">
        
        {/* Search */}
        <div className="relative flex-1 w-full">
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="جستجوی نام کارفرما، شماره تماس، مشاور یا صنف..."
            className="w-full bg-[#FAF7F2] border border-[#E6DAC8] focus:border-[#9C6644] rounded-xl pr-9 pl-3 py-2 text-xs text-[#3E2723] placeholder-[#A0522D]/60 outline-none"
          />
          <Search className="w-4 h-4 text-[#A0522D] absolute right-3 top-2.5" />
        </div>

        {/* Filter Consultant */}
        <div className="flex items-center gap-2 w-full sm:w-auto">
          <select
            value={filterConsultant}
            onChange={(e) => setFilterConsultant(e.target.value)}
            className="bg-[#FAF7F2] border border-[#E6DAC8] rounded-xl px-3 py-2 text-xs text-[#3E2723] font-bold outline-none cursor-pointer"
          >
            <option value="all">همه مشاورین ({toPersianDigits(activeConsultants.length)})</option>
            {activeConsultants.map(u => (
              <option key={u.id} value={u.id}>مشاور: {u.fullName} ({u.consultantCode})</option>
            ))}
          </select>

          {/* Filter Status */}
          <select
            value={filterStatus}
            onChange={(e) => setFilterStatus(e.target.value)}
            className="bg-[#FAF7F2] border border-[#E6DAC8] rounded-xl px-3 py-2 text-xs text-[#3E2723] font-bold outline-none cursor-pointer"
          >
            <option value="all">تمامی وضعیت‌ها</option>
            <option value="active">در دست اقدام (Active)</option>
            <option value="completed">تکمیل‌شده (Completed)</option>
            <option value="archived">بایگانی‌شده (Archived)</option>
          </select>
        </div>

      </div>

      {/* LEAD SHEETS CARDS / TABLE */}
      {filteredSheets.length === 0 ? (
        <div className="bg-white rounded-2xl border border-dashed border-[#DEC8B0] p-12 text-center space-y-4">
          <FileSpreadsheet className="w-12 h-12 text-[#DEC8B0] mx-auto" />
          <h4 className="text-sm font-bold text-[#5C4033]">هنوز هیچ شیت لیدی بارگذاری یا تخصیص داده نشده است</h4>
          <p className="text-xs text-[#7F4F24] max-w-md mx-auto">
            سرپرست گرامی، می‌توانید از دکمه «بارگذاری فایل لید روزانه» استفاده نمایید تا اکسل کارفرمایان به صورت خودکار به شیت‌های ۲۵ ردیفه تفکیک و به کارتابل مشاورین اضافه شود.
          </p>
          <div className="pt-2">
            <label className="inline-flex py-2.5 px-5 bg-[#9C6644] hover:bg-[#7F4F24] text-white text-xs font-black rounded-xl items-center justify-center gap-2 cursor-pointer shadow-md transition-all active:scale-95">
              <Upload className="w-4 h-4" />
              <span>انتخاب فایل اکسل (.xlsx / .csv)</span>
              <input
                type="file"
                accept=".xlsx,.xls,.csv"
                onChange={handleFileSelect}
                className="hidden"
              />
            </label>
          </div>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {filteredSheets.map((sheet) => {
            const completedRowsCount = sheet.rows.filter(r => r.followUp1 || r.followUp2 || r.followUp3 || r.followUp4).length;
            const meetingsCount = sheet.rows.filter(r => r.status === 'won' || r.followUpResult === '✓' || r.followUp1 === '✓' || r.followUp2 === '✓' || r.followUp3 === '✓' || r.followUp4 === '✓').length;
            const isReadyForArchive = sheet.rows.length > 0 && sheet.rows.every(r => r.followUp1 && r.followUp1 !== '');

            return (
              <div 
                key={sheet.id}
                className="bg-white rounded-2xl border border-[#E6DAC8] hover:border-[#9C6644] p-4 shadow-sm hover:shadow-md transition-all space-y-3 flex flex-col justify-between"
              >
                {/* Header */}
                <div className="flex items-start justify-between gap-2 border-b border-[#F5EDE2] pb-2.5">
                  <div className="space-y-0.5">
                    <div className="flex items-center gap-1.5">
                      <span className="w-6 h-6 rounded-lg bg-[#FAF7F2] text-[#9C6644] font-bold font-mono text-xs flex items-center justify-center border border-[#E6DAC8]">
                        {toPersianDigits(sheet.sheetNumber)}
                      </span>
                      <h4 className="text-xs font-black text-[#3E2723]">{sheet.title}</h4>
                    </div>
                    <div className="flex items-center gap-2 text-[11px] text-[#7F4F24]">
                      <Calendar className="w-3.5 h-3.5 text-[#9C6644]" />
                      <span>تخصیص: {toPersianDigits(sheet.dateShamsi)}</span>
                    </div>
                  </div>

                  <span className={`text-[10px] px-2 py-0.5 rounded font-bold whitespace-nowrap ${
                    sheet.status === 'completed'
                      ? 'bg-emerald-100 text-emerald-800 border border-emerald-200'
                      : isReadyForArchive
                      ? 'bg-amber-100 text-amber-800 border border-amber-300 animate-pulse'
                      : 'bg-blue-100 text-blue-800 border border-blue-200'
                  }`}>
                    {sheet.status === 'completed' ? 'تکمیل‌شده' : isReadyForArchive ? 'آماده بایگانی' : 'در دست اقدام'}
                  </span>
                </div>

                {/* Assigned Consultant */}
                <div className="p-2.5 bg-[#FAF7F2] rounded-xl border border-[#E6DAC8] flex items-center justify-between">
                  <div className="space-y-0.5">
                    <span className="text-[10px] text-[#7F4F24]">مشاور مسئول پرونده:</span>
                    <div className="text-xs font-bold text-[#3E2723] flex items-center gap-1">
                      <UserCheck className="w-3.5 h-3.5 text-[#9C6644]" />
                      <span>{sheet.assignedToConsultantName}</span>
                    </div>
                  </div>
                  <span className="text-xs font-mono font-bold text-[#9C6644] bg-white px-2 py-0.5 rounded border border-[#E6DAC8]">
                    {sheet.assignedToConsultantCode}
                  </span>
                </div>

                {/* Progress Bar */}
                <div className="space-y-1">
                  <div className="flex items-center justify-between text-[11px]">
                    <span className="text-[#7F4F24]">پیشرفت پیگیری‌ها:</span>
                    <span className="font-mono font-bold text-[#3E2723]">
                      {toPersianDigits(completedRowsCount)} از {toPersianDigits(sheet.rows.length)}
                    </span>
                  </div>
                  <div className="w-full h-2 bg-[#F5EDE2] rounded-full overflow-hidden">
                    <div 
                      className="h-full bg-gradient-to-r from-[#9C6644] to-emerald-600 rounded-full transition-all duration-500"
                      style={{ width: `${(completedRowsCount / sheet.rows.length) * 100}%` }}
                    />
                  </div>
                  <div className="flex items-center justify-between text-[10px] text-[#A0522D] pt-0.5">
                    <span>جلسات ست‌شده (✓): <strong className="text-emerald-700 font-bold">{toPersianDigits(meetingsCount)}</strong></span>
                    <span>صنف: <strong>{sheet.guild}</strong></span>
                  </div>
                </div>

                {/* Action Buttons */}
                <div className="flex items-center justify-between gap-1.5 pt-2 border-t border-[#F5EDE2]">
                  <div className="flex items-center gap-1">
                    <button
                      type="button"
                      onClick={() => setViewingSheet(sheet)}
                      className="px-2.5 py-1.5 bg-[#9C6644] hover:bg-[#7F4F24] text-white text-xs font-bold rounded-xl flex items-center gap-1 cursor-pointer transition-colors shadow-sm"
                    >
                      <Eye className="w-3.5 h-3.5" />
                      <span>مشاهده ۲۵ ردیف</span>
                    </button>
                    <button
                      type="button"
                      onClick={() => {
                        setReassigningSheet(sheet);
                        setNewConsultantId(sheet.assignedToConsultantId);
                      }}
                      className="p-1.5 bg-[#FAF7F2] hover:bg-[#F5EDE2] text-[#5C4033] border border-[#E6DAC8] rounded-xl text-xs flex items-center justify-center cursor-pointer transition-colors"
                      title="واگذاری به مشاور دیگر"
                    >
                      <RefreshCw className="w-3.5 h-3.5" />
                    </button>
                  </div>

                  <div className="flex items-center gap-1">
                    <button
                      type="button"
                      onClick={() => handleExportSheetToExcel(sheet)}
                      className="p-1.5 bg-emerald-50 hover:bg-emerald-100 text-emerald-800 border border-emerald-200 rounded-xl text-xs flex items-center justify-center cursor-pointer transition-colors"
                      title="خروجی اکسل این شیت"
                    >
                      <Download className="w-3.5 h-3.5" />
                    </button>
                    <button
                      type="button"
                      onClick={() => handleDeleteSheet(sheet.id)}
                      className="p-1.5 bg-rose-50 hover:bg-rose-100 text-rose-700 border border-rose-200 rounded-xl text-xs flex items-center justify-center cursor-pointer transition-colors"
                      title="حذف شیت"
                    >
                      <Trash2 className="w-3.5 h-3.5" />
                    </button>
                  </div>
                </div>

              </div>
            );
          })}
        </div>
      )}

      {/* ------------------------------------------------------------- */}
      {/* MODAL 1: EXCEL CHUNKING & ALLOCATION PREVIEW */}
      {/* ------------------------------------------------------------- */}
      {showUploadModal && (
        <div className="fixed inset-0 z-50 bg-black/80 backdrop-blur-sm flex items-center justify-center p-3 sm:p-4">
          <div className="bg-white rounded-3xl border border-[#E6DAC8] max-w-4xl w-full p-5 sm:p-6 space-y-4 shadow-2xl animate-scaleIn max-h-[92vh] overflow-y-auto flex flex-col">
            
            {/* Header */}
            <div className="flex items-center justify-between border-b border-[#E6DAC8] pb-3 shrink-0">
              <div className="flex items-center gap-2">
                <FileSpreadsheet className="w-5 h-5 text-[#9C6644]" />
                <h4 className="text-sm font-black text-[#3E2723]">
                  تفکیک چندکاربرگی (Multi-Tab) و تخصیص صفحات ۲۵ تایی
                </h4>
              </div>
              <button
                type="button"
                onClick={() => setShowUploadModal(false)}
                className="text-slate-400 hover:text-slate-700 p-1 rounded-lg"
              >
                <X className="w-4 h-4" />
              </button>
            </div>

            {uploadError && (
              <div className="p-3.5 bg-rose-50 border border-rose-200 rounded-2xl text-rose-700 text-xs flex flex-col sm:flex-row items-center justify-between gap-3 shadow-sm shrink-0">
                <div className="flex items-center gap-2">
                  <AlertTriangle className="w-5 h-5 shrink-0 text-rose-600" />
                  <span className="font-bold">{uploadError}</span>
                </div>
                <label className="px-3.5 py-1.5 bg-white border border-rose-300 hover:bg-rose-100 text-rose-800 rounded-xl font-bold text-xs cursor-pointer shrink-0 shadow-sm transition-all flex items-center gap-1.5">
                  <Upload className="w-3.5 h-3.5" />
                  <span>انتخاب مجدد فایل</span>
                  <input type="file" accept=".xlsx,.xls,.csv" onChange={handleFileSelect} className="hidden" />
                </label>
              </div>
            )}

            {parsedTabs.length > 0 ? (
              <div className="space-y-4 flex-1">
                {/* Overview Banner */}
                <div className="p-4 rounded-2xl bg-[#FAF7F2] border border-[#E6DAC8] space-y-2 shrink-0">
                  <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 text-xs">
                    <div>
                      <span className="text-[#7F4F24] block text-[10px]">فایل بارگذاری‌شده:</span>
                      <span className="font-bold text-[#3E2723] truncate block" title={uploadFileName}>{uploadFileName}</span>
                    </div>
                    <div>
                      <span className="text-[#7F4F24] block text-[10px]">تعداد کل تب‌های اکسل:</span>
                      <span className="font-bold font-mono text-[#9C6644] text-sm">{toPersianDigits(parsedTabs.length)} تب/شیت</span>
                    </div>
                    <div>
                      <span className="text-[#7F4F24] block text-[10px]">لیدهای انتخاب‌شده:</span>
                      <span className="font-bold font-mono text-emerald-700 text-sm">
                        {toPersianDigits(totalSelectedLeads)} لید ({toPersianDigits(selectedTabs.length)} تب فعال)
                      </span>
                    </div>
                    <div>
                      <span className="text-[#7F4F24] block text-[10px]">خروجی شیت‌های ۲۵ تایی:</span>
                      <span className="font-bold font-mono text-indigo-700 text-sm">
                        {toPersianDigits(totalEstimatedOutputSheets)} شیت ۲۵ تایی
                      </span>
                    </div>
                  </div>
                  <p className="text-[11px] text-emerald-800 font-medium pt-1 border-t border-[#E6DAC8]/60 flex items-center gap-1">
                    <CheckCircle2 className="w-3.5 h-3.5 text-emerald-600 shrink-0" />
                    <span>تمامی شماره‌های تلفن همراه با پیش‌کد استاندارد ۰ در دیتابیس ثبت خواهند شد.</span>
                  </p>
                </div>

                {/* Global Config Settings */}
                <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 shrink-0">
                  <div className="space-y-1">
                    <label className="text-xs font-bold text-[#5C4033] block">صنف پیش‌فرض:</label>
                    <input
                      type="text"
                      value={uploadGuild}
                      onChange={(e) => setUploadGuild(e.target.value)}
                      placeholder="مثال: قطعات خودرو، رستوران..."
                      className="w-full bg-[#FAF7F2] border border-[#E6DAC8] focus:border-[#9C6644] rounded-xl px-3 py-2 text-xs text-[#3E2723] outline-none font-bold"
                    />
                  </div>

                  <div className="space-y-1">
                    <label className="text-xs font-bold text-[#5C4033] block">تاریخ موعد پیگیری (شمسی):</label>
                    <input
                      type="text"
                      value={uploadTargetDate}
                      onChange={(e) => setUploadTargetDate(e.target.value)}
                      className="w-full bg-[#FAF7F2] border border-[#E6DAC8] focus:border-[#9C6644] rounded-xl px-3 py-2 text-xs text-[#3E2723] outline-none font-mono"
                      dir="ltr"
                    />
                  </div>

                  <div className="space-y-1">
                    <label className="text-xs font-bold text-[#5C4033] block">روش تخصیص سراسری:</label>
                    <select
                      value={selectedConsultantForBatch}
                      onChange={(e) => setSelectedConsultantForBatch(e.target.value)}
                      className="w-full bg-[#FAF7F2] border border-[#E6DAC8] focus:border-[#9C6644] rounded-xl px-3 py-2 text-xs text-[#3E2723] outline-none font-bold cursor-pointer"
                    >
                      <option value="auto_split">تقسیم مساوی بین مشاورین فعال (چرخشی)</option>
                      {activeConsultants.map(u => (
                        <option key={u.id} value={u.id}>تخصیص تمام شیت‌ها به: {u.fullName}</option>
                      ))}
                    </select>
                  </div>
                </div>

                {/* Tabs Multi-Selection List */}
                <div className="space-y-2">
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-1.5">
                      <Layers className="w-4 h-4 text-[#9C6644]" />
                      <span className="text-xs font-black text-[#3E2723]">
                        انتخاب و تخصیص تب‌های اکسل ({toPersianDigits(parsedTabs.length)} تب شناسایی‌شده):
                      </span>
                    </div>
                    <div className="flex items-center gap-2">
                      <button
                        type="button"
                        onClick={() => toggleAllTabs(true)}
                        className="text-[11px] text-[#9C6644] hover:underline font-bold cursor-pointer"
                      >
                        انتخاب همه
                      </button>
                      <span className="text-[#DEC8B0]">|</span>
                      <button
                        type="button"
                        onClick={() => toggleAllTabs(false)}
                        className="text-[11px] text-slate-500 hover:underline cursor-pointer"
                      >
                        عدم انتخاب همه
                      </button>
                    </div>
                  </div>

                  <div className="max-h-48 overflow-y-auto space-y-2 border border-[#E6DAC8] rounded-2xl p-2 bg-[#FAF7F2]/50">
                    {parsedTabs.map((tab) => {
                      const isSelected = tab.selected;
                      const isPreviewing = activeTabForPreview?.tabIndex === tab.tabIndex;
                      const estimatedChunks = Math.ceil(tab.rows.length / 25);
                      return (
                        <div 
                          key={tab.tabIndex}
                          className={`p-2.5 rounded-xl border transition-all flex flex-col sm:flex-row sm:items-center justify-between gap-2 ${
                            isPreviewing 
                              ? 'bg-amber-50/80 border-[#9C6644] shadow-sm ring-1 ring-[#9C6644]' 
                              : isSelected 
                                ? 'bg-white border-[#DEC8B0]' 
                                : 'bg-slate-50 border-slate-200 opacity-60'
                          }`}
                        >
                          <div className="flex items-center gap-2.5">
                            <input
                              type="checkbox"
                              checked={isSelected}
                              onChange={() => toggleTabSelection(tab.tabIndex)}
                              className="w-4 h-4 text-[#9C6644] rounded cursor-pointer accent-[#9C6644]"
                            />
                            <div>
                              <div className="flex items-center gap-2">
                                <span className="font-bold text-xs text-[#3E2723]">{tab.tabName}</span>
                                <span className="px-2 py-0.5 rounded-full text-[10px] font-mono font-bold bg-[#F5EDE2] text-[#7F4F24]">
                                  {toPersianDigits(tab.rows.length)} لید
                                </span>
                                <span className="px-2 py-0.5 rounded-full text-[10px] font-mono font-bold bg-emerald-50 text-emerald-700 border border-emerald-200">
                                  {toPersianDigits(estimatedChunks)} شیت ۲۵ تایی
                                </span>
                              </div>
                              <div className="text-[10px] text-[#A0522D] flex items-center gap-2 pt-0.5">
                                <span>صنف تب: <strong>{tab.guild || uploadGuild}</strong></span>
                              </div>
                            </div>
                          </div>

                          <div className="flex items-center gap-2 shrink-0">
                            <div className="flex items-center gap-1.5 text-xs">
                              <span className="text-[10px] text-[#7F4F24]">تخصیص:</span>
                              <select
                                value={tab.assignedConsultantId || 'auto_split'}
                                onChange={(e) => setTabConsultant(tab.tabIndex, e.target.value)}
                                disabled={!isSelected}
                                className="bg-white border border-[#DEC8B0] text-[#3E2723] rounded-xl px-2 py-1 text-xs outline-none cursor-pointer disabled:bg-slate-100 disabled:opacity-50"
                              >
                                <option value="auto_split">پیروی از روش سراسری</option>
                                {activeConsultants.map(c => (
                                  <option key={c.id} value={c.id}>اختصاص به: {c.fullName}</option>
                                ))}
                              </select>
                            </div>

                            <button
                              type="button"
                              onClick={() => setActivePreviewTabIdx(tab.tabIndex)}
                              className={`px-2.5 py-1 text-xs rounded-xl font-bold transition-all cursor-pointer ${
                                isPreviewing 
                                  ? 'bg-[#9C6644] text-white' 
                                  : 'bg-white hover:bg-[#F5EDE2] text-[#5C4033] border border-[#DEC8B0]'
                              }`}
                            >
                              {isPreviewing ? 'پیش‌نمایش فعال' : 'مشاهده ردیف‌ها'}
                            </button>
                          </div>
                        </div>
                      );
                    })}
                  </div>
                </div>

                {/* Active Tab Preview Table (first 5 rows) */}
                {activeTabForPreview && (
                  <div className="space-y-1.5 pt-1">
                    <div className="flex items-center justify-between">
                      <span className="text-xs font-bold text-[#5C4033] block">
                        پیش‌نمایش ردیف‌های تب «{activeTabForPreview.tabName}» ({toPersianDigits(activeTabForPreview.rows.length)} لید - ۵ ردیف اول):
                      </span>
                      <span className="text-[10px] text-[#A0522D]">
                        صنف شناسایی‌شده: <strong>{activeTabForPreview.guild}</strong>
                      </span>
                    </div>
                    <div className="border border-[#E6DAC8] rounded-xl overflow-x-auto max-h-44 overflow-y-auto">
                      <table className="w-full text-right text-[11px]">
                        <thead className="bg-[#FAF7F2] text-[#7F4F24] border-b border-[#E6DAC8] sticky top-0">
                          <tr>
                            <th className="p-2">ردیف</th>
                            <th className="p-2">نام کارفرما</th>
                            <th className="p-2">تلفن استاندارد</th>
                            <th className="p-2">صنف</th>
                            <th className="p-2">پرسنل</th>
                            <th className="p-2">آدرس</th>
                          </tr>
                        </thead>
                        <tbody className="divide-y divide-[#F5EDE2] text-[#3E2723]">
                          {activeTabForPreview.rows.slice(0, 5).map((row: any, idx: number) => (
                            <tr key={idx} className="hover:bg-amber-50/40">
                              <td className="p-2 font-mono">{toPersianDigits(idx + 1)}</td>
                              <td className="p-2 font-bold">{row.clientName}</td>
                              <td className="p-2 font-mono text-[#9C6644] text-left" dir="ltr">{row.phone}</td>
                              <td className="p-2">{row.activityField}</td>
                              <td className="p-2 font-mono">{toPersianDigits(row.personnelCount || '-')}</td>
                              <td className="p-2 truncate max-w-xs">{row.address || '-'}</td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    </div>
                  </div>
                )}
              </div>
            ) : (
              <div className="p-8 text-center space-y-3 bg-[#FAF7F2] rounded-2xl border border-dashed border-[#DEC8B0]">
                <FileSpreadsheet className="w-10 h-10 text-[#DEC8B0] mx-auto" />
                <p className="text-xs text-[#7F4F24]">داده‌ای برای نمایش وجود ندارد. لطفاً یک فایل معتبر انتخاب نمایید.</p>
              </div>
            )}

            {/* Footer */}
            <div className="flex items-center justify-between pt-3 border-t border-[#E6DAC8] shrink-0">
              <div className="text-xs text-[#7F4F24]">
                {totalSelectedLeads > 0 && (
                  <span>
                    مجموع: <strong className="text-emerald-700 font-bold font-mono">{toPersianDigits(totalSelectedLeads)}</strong> لید 
                    در قالب <strong className="text-[#9C6644] font-bold font-mono">{toPersianDigits(totalEstimatedOutputSheets)}</strong> شیت ۲۵ تایی
                  </span>
                )}
              </div>
              <div className="flex items-center gap-2">
                <button
                  type="button"
                  onClick={() => setShowUploadModal(false)}
                  className="px-4 py-2 bg-slate-100 hover:bg-slate-200 text-slate-700 text-xs rounded-xl cursor-pointer"
                >
                  انصراف
                </button>
                <button
                  type="button"
                  disabled={isProcessingUpload || selectedTabs.length === 0 || totalSelectedLeads === 0}
                  onClick={handleConfirmChunkAndAssign}
                  className="px-5 py-2 bg-[#9C6644] hover:bg-[#7F4F24] text-white text-xs font-black rounded-xl cursor-pointer shadow-lg disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-1.5"
                >
                  <CheckCircle2 className="w-4 h-4" />
                  <span>
                    {isProcessingUpload 
                      ? 'در حال ثبت و تخصیص شیت‌ها...' 
                      : `تأیید و ایجاد ${toPersianDigits(totalEstimatedOutputSheets)} شیت ۲۵ تایی (${toPersianDigits(totalSelectedLeads)} لید)`
                    }
                  </span>
                </button>
              </div>
            </div>

          </div>
        </div>
      )}

      {/* ------------------------------------------------------------- */}
      {/* MODAL 2: LIVE 25-ROW SHEET VIEWER & SUPERVISOR DIRECTIVES */}
      {/* ------------------------------------------------------------- */}
      {viewingSheet && (
        <div className="fixed inset-0 z-50 bg-black/85 backdrop-blur-md flex items-center justify-center p-2 sm:p-4">
          <div className="bg-white rounded-3xl border border-[#E6DAC8] max-w-6xl w-full p-4 sm:p-6 space-y-4 shadow-2xl animate-scaleIn max-h-[94vh] flex flex-col">
            
            {/* Header */}
            <div className="flex items-center justify-between border-b border-[#E6DAC8] pb-3 shrink-0">
              <div className="flex items-center gap-2.5">
                <div className="w-9 h-9 rounded-xl bg-[#FAF7F2] border border-[#E6DAC8] flex items-center justify-center text-[#9C6644]">
                  <FileSpreadsheet className="w-5 h-5" />
                </div>
                <div>
                  <h3 className="text-sm font-black text-[#3E2723]">
                    {viewingSheet.title}
                  </h3>
                  <div className="flex items-center gap-3 text-xs text-[#7F4F24]">
                    <span>مشاور مسئول: <strong className="text-[#3E2723]">{viewingSheet.assignedToConsultantName} ({viewingSheet.assignedToConsultantCode})</strong></span>
                    <span>تاریخ: <strong className="font-mono text-[#9C6644]">{toPersianDigits(viewingSheet.dateShamsi)}</strong></span>
                  </div>
                </div>
              </div>

              <div className="flex items-center gap-2">
                <button
                  type="button"
                  onClick={() => handleExportSheetToExcel(viewingSheet)}
                  className="px-3 py-1.5 bg-emerald-600 hover:bg-emerald-700 text-white text-xs font-bold rounded-xl flex items-center gap-1 cursor-pointer shadow-sm"
                >
                  <Download className="w-4 h-4" />
                  <span>دانلود اکسل</span>
                </button>
                <button
                  type="button"
                  onClick={() => setViewingSheet(null)}
                  className="text-slate-400 hover:text-slate-700 p-1 rounded-lg"
                >
                  <X className="w-5 h-5" />
                </button>
              </div>
            </div>

            {/* 11-Column Live Table */}
            <div className="flex-1 overflow-x-auto overflow-y-auto border border-[#E6DAC8] rounded-2xl">
              <table className="w-full text-right text-xs border-collapse">
                <thead className="bg-[#FAF7F2] text-[#5C4033] sticky top-0 z-10 border-b border-[#E6DAC8]">
                  <tr>
                    <th className="p-2.5 text-center font-bold border-l border-[#E6DAC8] w-10">ردیف</th>
                    <th className="p-2.5 font-bold border-l border-[#E6DAC8] min-w-[130px]">نام کارفرما</th>
                    <th className="p-2.5 font-bold border-l border-[#E6DAC8] min-w-[100px]">صنف</th>
                    <th className="p-2.5 font-bold border-l border-[#E6DAC8] text-center w-16">پرسنل</th>
                    <th className="p-2.5 font-bold border-l border-[#E6DAC8] min-w-[105px]">شماره تماس</th>
                    <th className="p-2.5 font-bold border-l border-[#E6DAC8] min-w-[140px]">آدرس</th>
                    <th className="p-2.5 font-bold border-l border-[#E6DAC8] min-w-[120px]">دغدغه کارفرما</th>
                    <th className="p-2 text-center border-l border-[#E6DAC8] w-14">پیگیری ۱</th>
                    <th className="p-2 text-center border-l border-[#E6DAC8] w-14">پیگیری ۲</th>
                    <th className="p-2 text-center border-l border-[#E6DAC8] w-14">پیگیری ۳</th>
                    <th className="p-2 text-center border-l border-[#E6DAC8] w-14">پیگیری ۴</th>
                    <th className="p-2.5 font-bold border-l border-[#E6DAC8] min-w-[100px]">نتیجه</th>
                    <th className="p-2.5 font-bold min-w-[160px]">دستور سرپرست / موضوع جلسه</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-[#F5EDE2] text-[#3E2723]">
                  {viewingSheet.rows.map((row) => {
                    const rowMessages = sheetMessages.filter(m => m.rowId === row.id);

                    return (
                      <tr key={row.id} className="hover:bg-[#FAF7F2]/60 transition-colors">
                        <td className="p-2 text-center font-mono font-bold text-[#9C6644] border-l border-[#F5EDE2]">
                          {toPersianDigits(row.rowNumber)}
                        </td>
                        <td className="p-2 font-bold border-l border-[#F5EDE2]">
                          {row.clientName}
                        </td>
                        <td className="p-2 border-l border-[#F5EDE2] text-[11px] text-[#7F4F24]">
                          {row.activityField}
                        </td>
                        <td className="p-2 text-center font-mono border-l border-[#F5EDE2] text-[11px]">
                          {row.personnelCount ? toPersianDigits(row.personnelCount) : '-'}
                        </td>
                        <td className="p-2 font-mono font-bold text-blue-900 border-l border-[#F5EDE2] text-[11px]" dir="ltr">
                          {row.phone}
                        </td>
                        <td className="p-2 border-l border-[#F5EDE2] text-[11px] text-slate-600 truncate max-w-xs" title={row.address}>
                          {row.address || '-'}
                        </td>
                        <td className="p-2 border-l border-[#F5EDE2] text-[11px] text-amber-900 truncate max-w-xs" title={row.employerConcern}>
                          {row.employerConcern || '-'}
                        </td>
                        <td className="p-2 text-center border-l border-[#F5EDE2] font-black text-sm">
                          <span className={row.followUp1 === '✓' ? 'text-emerald-700' : 'text-[#9C6644]'}>
                            {row.followUp1 || '.'}
                          </span>
                        </td>
                        <td className="p-2 text-center border-l border-[#F5EDE2] font-black text-sm">
                          <span className={row.followUp2 === '✓' ? 'text-emerald-700' : 'text-[#9C6644]'}>
                            {row.followUp2 || '.'}
                          </span>
                        </td>
                        <td className="p-2 text-center border-l border-[#F5EDE2] font-black text-sm">
                          <span className={row.followUp3 === '✓' ? 'text-emerald-700' : 'text-[#9C6644]'}>
                            {row.followUp3 || '.'}
                          </span>
                        </td>
                        <td className="p-2 text-center border-l border-[#F5EDE2] font-black text-sm">
                          <span className={row.followUp4 === '✓' ? 'text-emerald-700' : 'text-[#9C6644]'}>
                            {row.followUp4 || '.'}
                          </span>
                        </td>
                        <td className="p-2 border-l border-[#F5EDE2]">
                          <span className={`text-[10px] px-2 py-0.5 rounded font-bold whitespace-nowrap ${
                            row.status === 'won' || row.followUpResult === '✓'
                              ? 'bg-emerald-100 text-emerald-800'
                              : row.status === 'lost'
                              ? 'bg-rose-100 text-rose-800'
                              : 'bg-slate-100 text-slate-700'
                          }`}>
                            {row.followUpResult || (row.status === 'won' ? 'جلسه نهایی' : row.status === 'lost' ? 'عدم نیاز' : 'در جریان')}
                          </span>
                        </td>
                        <td className="p-2">
                          <div className="flex items-center justify-between gap-1">
                            <span className="text-[11px] text-slate-700 truncate max-w-[200px]" title={row.notes || row.meetingTopic}>
                              {row.notes || row.meetingTopic || 'بدون یادداشت'}
                            </span>
                            <button
                              type="button"
                              onClick={() => setActiveMessageRow({ sheet: viewingSheet, row })}
                              className="px-2 py-1 bg-amber-100 hover:bg-amber-200 text-amber-900 rounded-lg text-[10px] font-bold flex items-center gap-1 shrink-0 cursor-pointer"
                              title="ارسال دستور / یادداشت مستقیم به مشاور"
                            >
                              <MessageSquare className="w-3 h-3" />
                              <span>دستور سرپرست</span>
                              {rowMessages.length > 0 && (
                                <span className="bg-[#9C6644] text-white px-1 rounded-full text-[9px] font-mono">
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

            {/* Footer */}
            <div className="flex items-center justify-between pt-2 border-t border-[#E6DAC8] shrink-0 text-xs">
              <span className="text-[#7F4F24]">
                مجموع: <strong>{toPersianDigits(viewingSheet.rows.length)} ردیف</strong> | جلسات ست‌شده: <strong className="text-emerald-700">{toPersianDigits(viewingSheet.rows.filter(r => r.status === 'won' || r.followUpResult === '✓').length)}</strong>
              </span>
              <button
                type="button"
                onClick={() => setViewingSheet(null)}
                className="px-5 py-2 bg-slate-800 hover:bg-slate-700 text-white text-xs font-bold rounded-xl cursor-pointer"
              >
                بستن جدول
              </button>
            </div>

          </div>
        </div>
      )}

      {/* ------------------------------------------------------------- */}
      {/* MODAL 3: IN-ROW DIRECTIVE / MESSAGE PROMPT */}
      {/* ------------------------------------------------------------- */}
      {activeMessageRow && (
        <div className="fixed inset-0 z-50 bg-black/80 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-white rounded-3xl border border-[#E6DAC8] max-w-md w-full p-5 space-y-4 shadow-2xl animate-scaleIn">
            <div className="flex items-center justify-between border-b border-[#E6DAC8] pb-3">
              <div className="flex items-center gap-2">
                <MessageSquare className="w-4 h-4 text-[#9C6644]" />
                <h4 className="text-xs font-black text-[#3E2723]">
                  دستور و راهنمایی روی ردیف «{activeMessageRow.row.clientName}»
                </h4>
              </div>
              <button onClick={() => setActiveMessageRow(null)} className="text-slate-400 hover:text-slate-700">
                <X className="w-4 h-4" />
              </button>
            </div>

            <div className="p-3 bg-[#FAF7F2] rounded-xl border border-[#E6DAC8] space-y-1 text-xs">
              <div>کارفرما: <strong className="text-[#3E2723]">{activeMessageRow.row.clientName}</strong> ({activeMessageRow.row.activityField})</div>
              <div>شماره تماس: <strong className="font-mono text-blue-900">{activeMessageRow.row.phone}</strong></div>
              <div>مشاور مسئول: <strong className="text-[#9C6644]">{activeMessageRow.sheet.assignedToConsultantName}</strong></div>
            </div>

            {/* Previous messages on this row */}
            {sheetMessages.filter(m => m.rowId === activeMessageRow.row.id).length > 0 && (
              <div className="space-y-1.5 max-h-36 overflow-y-auto p-2 bg-slate-50 rounded-xl border border-slate-200 text-xs">
                {sheetMessages.filter(m => m.rowId === activeMessageRow.row.id).map(msg => (
                  <div key={msg.id} className="p-1.5 bg-white rounded-lg border border-slate-200">
                    <div className="flex items-center justify-between text-[10px] text-slate-400">
                      <span className="font-bold text-[#9C6644]">{msg.senderName}:</span>
                      <span>{toPersianDigits(msg.timeShamsi)}</span>
                    </div>
                    <p className="text-[#3E2723] text-[11px] pt-0.5">{msg.content}</p>
                  </div>
                ))}
              </div>
            )}

            <div className="space-y-1">
              <label className="text-xs font-bold text-[#5C4033] block">متن دستور / رهنمود سرپرست به مشاور:</label>
              <textarea
                rows={3}
                value={newMessageText}
                onChange={(e) => setNewMessageText(e.target.value)}
                placeholder="مثلاً: تخفیف ۱۰ درصدی برای این مشتری مجاز است. جلسه حضوری هماهنگ شود."
                className="w-full bg-[#FAF7F2] border border-[#E6DAC8] focus:border-[#9C6644] rounded-xl p-3 text-xs text-[#3E2723] outline-none"
              />
            </div>

            <div className="flex items-center justify-end gap-2 pt-2 border-t border-[#E6DAC8]">
              <button
                type="button"
                onClick={() => setActiveMessageRow(null)}
                className="px-3.5 py-1.5 bg-slate-100 hover:bg-slate-200 text-slate-700 text-xs rounded-xl cursor-pointer"
              >
                انصراف
              </button>
              <button
                type="button"
                onClick={handleSendMessageOnRow}
                className="px-4 py-1.5 bg-[#9C6644] hover:bg-[#7F4F24] text-white text-xs font-bold rounded-xl cursor-pointer shadow-md flex items-center gap-1"
              >
                <Send className="w-3.5 h-3.5" />
                <span>ثبت و ابلاغ به مشاور</span>
              </button>
            </div>
          </div>
        </div>
      )}

      {/* ------------------------------------------------------------- */}
      {/* MODAL 4: REASSIGN SHEET MODAL */}
      {/* ------------------------------------------------------------- */}
      {reassigningSheet && (
        <div className="fixed inset-0 z-50 bg-black/80 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-white rounded-3xl border border-[#E6DAC8] max-w-md w-full p-5 space-y-4 shadow-2xl animate-scaleIn">
            <div className="flex items-center justify-between border-b border-[#E6DAC8] pb-3">
              <div className="flex items-center gap-2">
                <RefreshCw className="w-4 h-4 text-[#9C6644]" />
                <h4 className="text-xs font-black text-[#3E2723]">
                  واگذاری مجدد شیت شماره {toPersianDigits(reassigningSheet.sheetNumber)}
                </h4>
              </div>
              <button onClick={() => setReassigningSheet(null)} className="text-slate-400 hover:text-slate-700">
                <X className="w-4 h-4" />
              </button>
            </div>

            <p className="text-xs text-[#5C4033] leading-relaxed">
              مشاور جدید را جهت تحویل گرفتن کلیه ۲۵ ردیف این شیت انتخاب فرمایید:
            </p>

            <select
              value={newConsultantId}
              onChange={(e) => setNewConsultantId(e.target.value)}
              className="w-full bg-[#FAF7F2] border border-[#E6DAC8] focus:border-[#9C6644] rounded-xl px-3 py-2 text-xs text-[#3E2723] font-bold outline-none cursor-pointer"
            >
              {activeConsultants.map(u => (
                <option key={u.id} value={u.id}>
                  {u.fullName} ({u.consultantCode}) - {u.branch || 'تیم اجرایی'}
                </option>
              ))}
            </select>

            <div className="flex items-center justify-end gap-2 pt-2 border-t border-[#E6DAC8]">
              <button
                type="button"
                onClick={() => setReassigningSheet(null)}
                className="px-3.5 py-1.5 bg-slate-100 hover:bg-slate-200 text-slate-700 text-xs rounded-xl cursor-pointer"
              >
                انصراف
              </button>
              <button
                type="button"
                onClick={handleExecuteReassign}
                className="px-4 py-1.5 bg-[#9C6644] hover:bg-[#7F4F24] text-white text-xs font-bold rounded-xl cursor-pointer shadow-md"
              >
                تأیید و واگذاری پرونده‌ها
              </button>
            </div>
          </div>
        </div>
      )}

    </div>
  );
};

import React, { useState, useEffect, useMemo } from 'react';
import { User, MemoMessage, MemoCategory, MemoPriority } from '../../types';
import { 
  getStoredMemos, 
  saveMemo, 
  markMemoRead, 
  getStoredUsers, 
  syncWithServer 
} from '../../services/storage';
import { getCurrentShamsiDate, toPersianDigits } from '../../utils/shamsi';
import { 
  Mail, 
  Send, 
  AlertTriangle, 
  CheckCircle2, 
  Plus, 
  Search, 
  FileText, 
  X, 
  Clock, 
  User as UserIcon, 
  Tag, 
  ShieldAlert,
  Inbox,
  SendHorizontal,
  Bookmark,
  Building,
  Check
} from 'lucide-react';

interface EnterpriseMemoBoxProps {
  currentUser: User;
}

export const EnterpriseMemoBox: React.FC<EnterpriseMemoBoxProps> = ({ currentUser }) => {
  const [memos, setMemos] = useState<MemoMessage[]>(getStoredMemos());
  const [users, setUsers] = useState<User[]>(getStoredUsers());

  // Filter & Search
  const [activeTab, setActiveTab] = useState<'inbox' | 'sent'>('inbox');
  const [selectedCategory, setSelectedCategory] = useState<string>('all');
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedMemo, setSelectedMemo] = useState<MemoMessage | null>(null);

  const isManager = currentUser.role === 'ceo' || currentUser.role === 'it_admin';

  // Find CEO / Supervisor user
  const ceoUser = useMemo(() => {
    return users.find(u => u.role === 'ceo') || { id: 'user-ceo', fullName: 'سرپرست ارشد (مدیریت)' };
  }, [users]);

  // New Memo Modal
  const [showCreateModal, setShowCreateModal] = useState(false);
  const [newTitle, setNewTitle] = useState('');
  const [newContent, setNewContent] = useState('');
  const [newRecipientId, setNewRecipientId] = useState(isManager ? 'all' : 'user-ceo');
  const [newPriority, setNewPriority] = useState<MemoPriority>('normal');
  const [newCategory, setNewCategory] = useState<MemoCategory>(isManager ? 'directive' : 'consultant_query');
  const [isSending, setIsSending] = useState(false);
  const [successMsg, setSuccessMsg] = useState('');

  const reloadData = () => {
    setMemos(getStoredMemos());
    setUsers(getStoredUsers());
  };

  useEffect(() => {
    const handleSync = () => reloadData();
    window.addEventListener('karino_db_synced', handleSync);
    return () => window.removeEventListener('karino_db_synced', handleSync);
  }, []);

  // Consultants list
  const activeConsultants = useMemo(() => {
    return users.filter(u => u.role === 'consultant' && (u.status === 'active' || !u.status));
  }, [users]);

  const handleOpenCreateModal = () => {
    if (!isManager) {
      setNewRecipientId(ceoUser.id || 'user-ceo');
      setNewCategory('consultant_query');
    } else {
      setNewRecipientId('all');
      setNewCategory('directive');
    }
    setShowCreateModal(true);
  };

  // Inbox memos: STRICT CONFIDENTIALITY ISOLATION
  // 1. Consultant must NEVER see other consultants' memos under any circumstances
  // 2. Consultant sees: direct memos sent to them by management, and general circulars ('all') from management (CEO/IT)
  // 3. Manager sees: all consultant reports/memos addressed to supervisor/management, and memos addressed to them
  const inboxMemos = useMemo(() => {
    return memos.filter(m => {
      // Never show own sent memos in inbox (they belong in Sent tab)
      if (m.senderId === currentUser.id) return false;

      // STRICT CONSULTANT ISOLATION:
      if (!isManager) {
        // Under no circumstances can a consultant see another consultant's correspondence
        if (m.senderRole === 'consultant') {
          return m.recipientId === currentUser.id || (m as any).targetUserId === currentUser.id;
        }

        // Memos from management (CEO / IT Admin)
        const isTargetedToMe = m.recipientId === currentUser.id || (m as any).targetUserId === currentUser.id;
        const isBroadcastDirective = (m.recipientId === 'all' || (m as any).targetUserId === 'all') &&
                                      (m.senderRole === 'ceo' || m.senderRole === 'it_admin');
        return isTargetedToMe || isBroadcastDirective;
      }

      // MANAGER INBOX (CEO / IT Admin):
      // 1. All consultant queries/reports sent to supervisor
      if (m.senderRole === 'consultant') return true;
      // 2. Memos addressed directly to current manager
      if (m.recipientId === currentUser.id || (m as any).targetUserId === currentUser.id) return true;
      // 3. Memos addressed to management role keywords or circulars
      const managementKeys = ['all', 'ceo', 'user-ceo', 'it_admin', 'user-it', 'management'];
      if (managementKeys.includes(m.recipientId) || managementKeys.includes((m as any).targetUserId)) return true;

      return false;
    });
  }, [memos, currentUser, isManager]);

  // Sent memos
  const sentMemos = useMemo(() => {
    return memos.filter(m => m.senderId === currentUser.id);
  }, [memos, currentUser]);

  // Unread status checker
  const isMemoUnread = (memo: MemoMessage) => {
    if (memo.isRead) return false;
    if (memo.recipientId === currentUser.id || (memo as any).targetUserId === currentUser.id) return true;
    if (isManager && memo.senderRole === 'consultant') return true;
    if (!isManager && (memo.recipientId === 'all' || (memo as any).targetUserId === 'all')) return true;
    return false;
  };

  // Filtered list
  const displayedMemos = useMemo(() => {
    const base = activeTab === 'inbox' ? inboxMemos : sentMemos;

    return base.filter(m => {
      if (selectedCategory !== 'all' && m.category !== selectedCategory) return false;
      if (searchQuery.trim()) {
        const q = searchQuery.toLowerCase();
        const matchTitle = m.title.toLowerCase().includes(q);
        const matchContent = m.content.toLowerCase().includes(q);
        const matchSender = m.senderName.toLowerCase().includes(q);
        const matchNumber = m.memoNumber.toLowerCase().includes(q);
        if (!matchTitle && !matchContent && !matchSender && !matchNumber) return false;
      }
      return true;
    });
  }, [activeTab, inboxMemos, sentMemos, selectedCategory, searchQuery]);

  // Read Memo & Mark Read
  const handleOpenMemo = async (memo: MemoMessage) => {
    setSelectedMemo(memo);
    const shouldMarkRead = !memo.isRead && (
      memo.recipientId === currentUser.id ||
      (memo as any).targetUserId === currentUser.id ||
      (isManager && memo.senderRole === 'consultant') ||
      (!isManager && (memo.recipientId === 'all' || (memo as any).targetUserId === 'all'))
    );
    if (shouldMarkRead) {
      await markMemoRead(memo.id);
      reloadData();
    }
  };

  // Send New Memo
  const handleCreateMemo = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!newTitle.trim() || !newContent.trim()) return;

    setIsSending(true);
    try {
      let targetRecipientId = newRecipientId;
      let targetRecipientName = 'کلیه مشاورین (بخشنامه عمومی)';

      if (!isManager) {
        // Consultants can ONLY send to management / supervisor
        targetRecipientId = ceoUser.id || 'user-ceo';
        targetRecipientName = ceoUser.fullName || 'سرپرست ارشد (مدیریت)';
      } else {
        if (newRecipientId !== 'all') {
          const target = users.find(u => u.id === newRecipientId);
          if (target) targetRecipientName = target.fullName;
        }
      }

      const memoNumber = `KRN-${getCurrentShamsiDate().formatted.replace(/\//g, '')}-${Date.now().toString().slice(-3)}`;

      const newMemo: MemoMessage = {
        id: `memo-${Date.now()}`,
        memoNumber,
        senderId: currentUser.id,
        senderName: currentUser.fullName,
        senderRole: currentUser.role,
        recipientId: targetRecipientId,
        recipientName: targetRecipientName,
        title: newTitle.trim(),
        content: newContent.trim(),
        priority: newPriority,
        category: newCategory,
        createdAt: new Date().toISOString(),
        dateShamsi: getCurrentShamsiDate().formatted,
        isRead: false
      };
      (newMemo as any).targetUserId = targetRecipientId;

      await saveMemo(newMemo);
      reloadData();
      setShowCreateModal(false);
      setNewTitle('');
      setNewContent('');
      setNewRecipientId(isManager ? 'all' : (ceoUser.id || 'user-ceo'));
      setNewPriority('normal');
      setNewCategory(isManager ? 'directive' : 'consultant_query');
      setSuccessMsg(`مکاتبه شماره «${memoNumber}» با موفقیت صادر و ارسال گردید.`);
      setTimeout(() => setSuccessMsg(''), 4000);
    } catch {
      alert('خطا در ارسال مکاتبه.');
    } finally {
      setIsSending(false);
    }
  };

  const getCategoryLabel = (cat: MemoCategory) => {
    switch (cat) {
      case 'directive': return { label: 'بخشنامه / دستورالعمل', color: 'bg-blue-500/20 text-blue-300 border-blue-500/30' };
      case 'warning': return { label: 'تذکر انضباطی / مهم', color: 'bg-rose-500/20 text-rose-300 border-rose-500/30' };
      case 'report_request': return { label: 'درخواست گزارش کارفرما', color: 'bg-amber-500/20 text-amber-300 border-amber-500/30' };
      case 'consultant_query': return { label: 'گزارش / استعلام مشاور', color: 'bg-emerald-500/20 text-emerald-300 border-emerald-500/30' };
      default: return { label: 'مکاتبه عادی', color: 'bg-slate-500/20 text-slate-300 border-slate-500/30' };
    }
  };

  return (
    <div className="space-y-4 font-['Vazirmatn',sans-serif] animate-fadeIn">
      
      {/* Toast */}
      {successMsg && (
        <div className="p-3 bg-emerald-950/80 border border-emerald-500/40 rounded-2xl text-emerald-200 text-xs flex items-center gap-2 font-bold animate-fadeIn shadow-lg">
          <CheckCircle2 className="w-4 h-4 text-emerald-400 shrink-0" />
          <span>{successMsg}</span>
        </div>
      )}

      {/* Top Header & CTA */}
      <div className="navy-card-glass rounded-2xl border border-blue-500/20 p-4 shadow-lg flex flex-col sm:flex-row items-center justify-between gap-3">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-xl bg-blue-500/20 border border-blue-500/30 flex items-center justify-center text-blue-300">
            <Mail className="w-5 h-5" />
          </div>
          <div>
            <h3 className="text-sm font-black text-white">
              سامانه مکاتبات و بخشنامه‌های رسمی (Enterprise Dispatch)
            </h3>
            <p className="text-[11px] text-slate-400">
              دستورالعمل‌ها، نامه‌های سازمانی و ابلاغیه‌های رسمی میان سرپرست و مشاورین
            </p>
          </div>
        </div>

        <button
          type="button"
          onClick={handleOpenCreateModal}
          className="w-full sm:w-auto px-4 py-2 bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-500 hover:to-indigo-500 text-white text-xs font-bold rounded-xl flex items-center justify-center gap-1.5 cursor-pointer shadow-lg active:scale-95 transition-all"
        >
          <Plus className="w-4 h-4" />
          <span>{isManager ? 'صدور بخشنامه / دستور جدید' : 'ارسال نامه / استعلام به سرپرست'}</span>
        </button>
      </div>

      {/* Navigation Sub-Tabs & Category Filter */}
      <div className="flex flex-col sm:flex-row items-center justify-between gap-3">
        
        {/* Inbox vs Sent */}
        <div className="flex items-center gap-2 w-full sm:w-auto bg-[#081525] p-1 rounded-xl border border-slate-800">
          <button
            type="button"
            onClick={() => setActiveTab('inbox')}
            className={`px-4 py-1.5 rounded-lg text-xs font-bold transition-all flex items-center gap-1.5 cursor-pointer ${
              activeTab === 'inbox'
                ? 'bg-blue-600 text-white shadow-md'
                : 'text-slate-400 hover:text-white'
            }`}
          >
            <Inbox className="w-3.5 h-3.5" />
            <span>صندوق ورودی ({toPersianDigits(inboxMemos.length)})</span>
            {inboxMemos.some(isMemoUnread) && (
              <span className="w-2 h-2 rounded-full bg-rose-500 animate-ping" />
            )}
          </button>

          <button
            type="button"
            onClick={() => setActiveTab('sent')}
            className={`px-4 py-1.5 rounded-lg text-xs font-bold transition-all flex items-center gap-1.5 cursor-pointer ${
              activeTab === 'sent'
                ? 'bg-blue-600 text-white shadow-md'
                : 'text-slate-400 hover:text-white'
            }`}
          >
            <SendHorizontal className="w-3.5 h-3.5" />
            <span>ارسال‌شده‌ها ({toPersianDigits(sentMemos.length)})</span>
          </button>
        </div>

        {/* Search */}
        <div className="relative w-full sm:w-72">
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="جستجوی موضوع یا شماره نامه..."
            className="w-full bg-[#081525] border border-slate-800 focus:border-blue-400 rounded-xl pr-9 pl-3 py-1.5 text-xs text-white placeholder-slate-500 outline-none"
          />
          <Search className="w-4 h-4 text-slate-400 absolute right-3 top-2" />
        </div>

      </div>

      {/* Memos List */}
      {displayedMemos.length === 0 ? (
        <div className="navy-card-glass rounded-2xl border border-slate-800 p-12 text-center space-y-2">
          <Mail className="w-10 h-10 text-slate-600 mx-auto" />
          <h4 className="text-xs font-bold text-slate-300">هیچ نامه‌ای در این بخش موجود نیست</h4>
        </div>
      ) : (
        <div className="grid grid-cols-1 gap-2.5">
          {displayedMemos.map((memo) => {
            const catInfo = getCategoryLabel(memo.category);
            const isUnread = isMemoUnread(memo);

            return (
              <div
                key={memo.id}
                onClick={() => handleOpenMemo(memo)}
                className={`navy-card-glass rounded-xl border p-3.5 transition-all cursor-pointer flex flex-col sm:flex-row items-start sm:items-center justify-between gap-3 ${
                  isUnread
                    ? 'border-blue-500/60 bg-blue-950/30 hover:border-blue-400'
                    : 'border-slate-800 hover:border-slate-700'
                }`}
              >
                <div className="flex items-start sm:items-center gap-3">
                  <div className={`w-8 h-8 rounded-lg flex items-center justify-center shrink-0 ${
                    memo.priority === 'urgent'
                      ? 'bg-rose-500/20 text-rose-400 border border-rose-500/40'
                      : 'bg-blue-500/10 text-blue-400 border border-blue-500/30'
                  }`}>
                    {memo.priority === 'urgent' ? <ShieldAlert className="w-4 h-4" /> : <FileText className="w-4 h-4" />}
                  </div>

                  <div className="space-y-0.5">
                    <div className="flex items-center gap-2 flex-wrap">
                      <span className="text-xs font-bold text-white">{memo.title}</span>
                      <span className={`text-[10px] px-2 py-0.5 rounded border font-bold ${catInfo.color}`}>
                        {catInfo.label}
                      </span>
                      {memo.priority === 'urgent' && (
                        <span className="text-[10px] px-2 py-0.5 rounded bg-rose-950 text-rose-300 border border-rose-500/40 font-bold animate-pulse">
                          فوری
                        </span>
                      )}
                    </div>
                    <p className="text-[11px] text-slate-400 line-clamp-1">
                      {memo.content}
                    </p>
                  </div>
                </div>

                <div className="flex items-center gap-3 text-[11px] text-slate-400 shrink-0 self-end sm:self-center">
                  <span>فرستنده: <strong className="text-slate-200">{memo.senderName}</strong></span>
                  <span className="font-mono text-slate-500">{toPersianDigits(memo.dateShamsi)}</span>
                  <span className="font-mono text-[10px] text-blue-400 bg-[#06111e] px-1.5 py-0.5 rounded border border-slate-800">
                    {memo.memoNumber}
                  </span>
                </div>
              </div>
            );
          })}
        </div>
      )}

      {/* ------------------------------------------------------------- */}
      {/* MODAL 1: VIEW MEMO DETAILS */}
      {/* ------------------------------------------------------------- */}
      {selectedMemo && (
        <div className="fixed inset-0 z-50 bg-black/80 backdrop-blur-sm flex items-center justify-center p-4">
          <div className="bg-[#0a192c] border border-blue-500/40 rounded-3xl max-w-xl w-full p-6 space-y-4 shadow-2xl animate-scaleIn text-white">
            
            {/* Memo Header Banner */}
            <div className="border-b border-slate-800 pb-3 flex items-start justify-between">
              <div className="space-y-1">
                <div className="flex items-center gap-2">
                  <span className="text-xs font-mono text-blue-300 bg-blue-500/20 px-2 py-0.5 rounded border border-blue-500/30">
                    {selectedMemo.memoNumber}
                  </span>
                  <span className={`text-[10px] px-2 py-0.5 rounded border font-bold ${getCategoryLabel(selectedMemo.category).color}`}>
                    {getCategoryLabel(selectedMemo.category).label}
                  </span>
                </div>
                <h3 className="text-sm font-black text-white pt-1">{selectedMemo.title}</h3>
              </div>
              <button onClick={() => setSelectedMemo(null)} className="text-slate-400 hover:text-white">
                <X className="w-4 h-4" />
              </button>
            </div>

            {/* Meta */}
            <div className="grid grid-cols-2 gap-2 text-xs bg-[#06111e] p-3 rounded-xl border border-slate-800">
              <div>فرستنده: <strong className="text-blue-300">{selectedMemo.senderName}</strong></div>
              <div>گیرنده: <strong className="text-amber-300">{selectedMemo.recipientName}</strong></div>
              <div>تاریخ صدور: <strong className="font-mono text-slate-300">{toPersianDigits(selectedMemo.dateShamsi)}</strong></div>
              <div>اولویت: <strong className={selectedMemo.priority === 'urgent' ? 'text-rose-400' : 'text-emerald-400'}>
                {selectedMemo.priority === 'urgent' ? 'فوری و آنی' : 'عادی'}
              </strong></div>
            </div>

            {/* Body */}
            <div className="p-4 bg-[#081525] rounded-xl border border-slate-800/80 text-xs text-slate-200 leading-relaxed whitespace-pre-wrap min-h-[120px]">
              {selectedMemo.content}
            </div>

            {/* Footer */}
            <div className="flex justify-end pt-2 border-t border-slate-800">
              <button
                type="button"
                onClick={() => setSelectedMemo(null)}
                className="px-5 py-2 bg-slate-800 hover:bg-slate-700 text-white text-xs font-bold rounded-xl cursor-pointer"
              >
                بستن نامه
              </button>
            </div>

          </div>
        </div>
      )}

      {/* ------------------------------------------------------------- */}
      {/* MODAL 2: CREATE NEW MEMO */}
      {/* ------------------------------------------------------------- */}
      {showCreateModal && (
        <div className="fixed inset-0 z-50 bg-black/85 backdrop-blur-md flex items-center justify-center p-4">
          <div className="bg-[#0a192c] border border-blue-500/40 rounded-3xl max-w-lg w-full p-6 space-y-4 shadow-2xl animate-scaleIn text-white">
            
            <div className="flex items-center justify-between border-b border-slate-800 pb-3">
              <div className="flex items-center gap-2">
                <FileText className="w-5 h-5 text-blue-400" />
                <h4 className="text-sm font-bold text-white">
                  {isManager ? 'صدور بخشنامه / دستورالعمل رسمی' : 'ارسال نامه رسمی به سرپرست'}
                </h4>
              </div>
              <button onClick={() => setShowCreateModal(false)} className="text-slate-400 hover:text-white">
                <X className="w-4 h-4" />
              </button>
            </div>

            <form onSubmit={handleCreateMemo} className="space-y-3">
              
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                <div className="space-y-1">
                  <label className="text-xs text-slate-300 block font-bold">گیرنده نامه:</label>
                  {isManager ? (
                    <select
                      value={newRecipientId}
                      onChange={(e) => setNewRecipientId(e.target.value)}
                      className="w-full bg-[#06111e] border border-slate-700 focus:border-blue-400 rounded-xl px-3 py-2 text-xs text-white outline-none font-bold"
                    >
                      <option value="all">کلیه مشاورین (بخشنامه عمومی)</option>
                      {activeConsultants.map(u => (
                        <option key={u.id} value={u.id}>{u.fullName} ({u.consultantCode})</option>
                      ))}
                    </select>
                  ) : (
                    <input
                      type="text"
                      disabled
                      value={`${ceoUser.fullName} (سرپرست ارشد)`}
                      className="w-full bg-[#06111e] border border-slate-800 rounded-xl px-3 py-2 text-xs text-amber-300 font-bold outline-none cursor-not-allowed"
                    />
                  )}
                </div>

                <div className="space-y-1">
                  <label className="text-xs text-slate-300 block font-bold">دسته‌بندی موضوعی:</label>
                  <select
                    value={newCategory}
                    onChange={(e) => setNewCategory(e.target.value as MemoCategory)}
                    className="w-full bg-[#06111e] border border-slate-700 focus:border-blue-400 rounded-xl px-3 py-2 text-xs text-white outline-none"
                  >
                    <option value="directive">بخشنامه / دستورالعمل</option>
                    <option value="report_request">درخواست گزارش ویژه</option>
                    <option value="warning">تذکر انضباطی</option>
                    <option value="consultant_query">استعلام / گزارش مشاور</option>
                    <option value="other">سایر مکاتبات</option>
                  </select>
                </div>
              </div>

              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                <div className="space-y-1">
                  <label className="text-xs text-slate-300 block font-bold">عنوان نامه / بخشنامه:</label>
                  <input
                    type="text"
                    required
                    value={newTitle}
                    onChange={(e) => setNewTitle(e.target.value)}
                    placeholder="مثلاً: ابلاغ شیوه پیگیری صنف قطعات خودرو"
                    className="w-full bg-[#06111e] border border-slate-700 focus:border-blue-400 rounded-xl px-3 py-2 text-xs text-white outline-none"
                  />
                </div>

                <div className="space-y-1">
                  <label className="text-xs text-slate-300 block font-bold">اولویت اقدام:</label>
                  <select
                    value={newPriority}
                    onChange={(e) => setNewPriority(e.target.value as MemoPriority)}
                    className="w-full bg-[#06111e] border border-slate-700 focus:border-blue-400 rounded-xl px-3 py-2 text-xs text-white outline-none font-bold"
                  >
                    <option value="normal">عادی (Normal)</option>
                    <option value="urgent">فوری و مهم (Urgent)</option>
                  </select>
                </div>
              </div>

              <div className="space-y-1">
                <label className="text-xs text-slate-300 block font-bold">متن کامل نامه / ابلاغیه:</label>
                <textarea
                  rows={5}
                  required
                  value={newContent}
                  onChange={(e) => setNewContent(e.target.value)}
                  placeholder="شرح مفصل دستورالعمل یا گزارش..."
                  className="w-full bg-[#06111e] border border-slate-700 focus:border-blue-400 rounded-xl p-3 text-xs text-white outline-none leading-relaxed"
                />
              </div>

              <div className="flex items-center justify-end gap-2 pt-2 border-t border-slate-800">
                <button
                  type="button"
                  onClick={() => setShowCreateModal(false)}
                  className="px-4 py-2 bg-slate-800 hover:bg-slate-700 text-slate-300 text-xs rounded-xl cursor-pointer"
                >
                  انصراف
                </button>
                <button
                  type="submit"
                  disabled={isSending}
                  className="px-5 py-2 bg-blue-600 hover:bg-blue-500 text-white text-xs font-bold rounded-xl cursor-pointer shadow-lg disabled:opacity-60 flex items-center gap-1.5"
                >
                  <Send className="w-3.5 h-3.5" />
                  <span>{isSending ? 'در حال صدور...' : 'ثبت و ارسال نامه رسمی'}</span>
                </button>
              </div>

            </form>

          </div>
        </div>
      )}

    </div>
  );
};

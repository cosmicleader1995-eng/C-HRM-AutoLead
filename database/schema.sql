-- ====================================================================
-- سامانه مدیریت ارتباط با کارفرمایان و ارزیابی عملکرد مشاوران کارینو (Karino CRM/HRM)
-- ساختار رابطه‌ای کامل پایگاه داده (Relational Database Schema)
-- سازگار با PostgreSQL و Supabase به همراه Row Level Security (RLS)
-- ====================================================================

-- ۱. فعال‌سازی اکستنشن‌های مورد نیاز
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ====================================================================
-- جدول ۱: کاربران و سطوح دسترسی (users)
-- ====================================================================
CREATE TABLE IF NOT EXISTS public.users (
    id TEXT PRIMARY KEY,
    username TEXT UNIQUE NOT NULL,
    full_name TEXT NOT NULL,
    consultant_code TEXT UNIQUE,
    role TEXT NOT NULL CHECK (role IN ('ceo', 'it_admin', 'consultant')),
    password_hash TEXT NOT NULL,
    phone TEXT,
    branch TEXT DEFAULT 'دفتر مرکزی کارینو',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_users_username ON public.users(username);
CREATE INDEX IF NOT EXISTS idx_users_consultant_code ON public.users(consultant_code);
CREATE INDEX IF NOT EXISTS idx_users_role ON public.users(role);

-- ====================================================================
-- جدول ۲: گزارش‌های روزانه مشاوران (daily_reports)
-- ====================================================================
CREATE TABLE IF NOT EXISTS public.daily_reports (
    id TEXT PRIMARY KEY,
    consultant_id TEXT REFERENCES public.users(id) ON DELETE SET NULL,
    consultant_name TEXT NOT NULL,
    consultant_code TEXT NOT NULL,
    branch TEXT,
    date_shamsi TEXT NOT NULL,
    day_of_week_shamsi TEXT NOT NULL,
    submitted_at TEXT NOT NULL,
    guild TEXT NOT NULL,
    personal_opinion TEXT,
    manager_feedback TEXT,
    manager_rating NUMERIC(3, 1),
    status TEXT NOT NULL DEFAULT 'submitted' CHECK (status IN ('submitted', 'approved', 'rejected')),
    reviewed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_daily_reports_date_shamsi ON public.daily_reports(date_shamsi);
CREATE INDEX IF NOT EXISTS idx_daily_reports_consultant_code ON public.daily_reports(consultant_code);
CREATE INDEX IF NOT EXISTS idx_daily_reports_status ON public.daily_reports(status);

-- ====================================================================
-- جدول ۳: ردیف‌های تماس و پیگیری کارفرمایان (report_rows)
-- ====================================================================
CREATE TABLE IF NOT EXISTS public.report_rows (
    id TEXT PRIMARY KEY,
    report_id TEXT NOT NULL REFERENCES public.daily_reports(id) ON DELETE CASCADE,
    row_number INTEGER NOT NULL,
    client_name TEXT NOT NULL,
    activity_field TEXT NOT NULL,
    personnel_count TEXT,
    phone TEXT NOT NULL,
    address TEXT NOT NULL,
    employer_concern TEXT NOT NULL,
    follow_up_1 TEXT NOT NULL,
    follow_up_1_date TIMESTAMPTZ,
    follow_up_1_date_shamsi TEXT,
    follow_up_2 TEXT,
    follow_up_2_date TIMESTAMPTZ,
    follow_up_2_date_shamsi TEXT,
    follow_up_3 TEXT,
    follow_up_3_date TIMESTAMPTZ,
    follow_up_3_date_shamsi TEXT,
    follow_up_4 TEXT,
    follow_up_4_date TIMESTAMPTZ,
    follow_up_4_date_shamsi TEXT,
    follow_up_result TEXT NOT NULL,
    meeting_topic TEXT,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_report_rows_report_id ON public.report_rows(report_id);
CREATE INDEX IF NOT EXISTS idx_report_rows_phone ON public.report_rows(phone);
CREATE INDEX IF NOT EXISTS idx_report_rows_client_name ON public.report_rows(client_name);

-- ====================================================================
-- جدول ۴: گزارش‌های تحلیلی ادواری (روزانه، هفتگی، ماهانه) (periodic_reports)
-- ====================================================================
CREATE TABLE IF NOT EXISTS public.periodic_reports (
    id TEXT PRIMARY KEY,
    consultant_id TEXT REFERENCES public.users(id) ON DELETE SET NULL,
    consultant_name TEXT NOT NULL,
    consultant_code TEXT NOT NULL,
    period_type TEXT NOT NULL CHECK (period_type IN ('daily', 'weekly', 'monthly')),
    date_shamsi TEXT NOT NULL,
    day_of_week_shamsi TEXT NOT NULL,
    submitted_at TEXT NOT NULL,
    period_label TEXT NOT NULL,
    summary TEXT NOT NULL,
    key_achievements TEXT,
    challenges_or_barriers TEXT,
    plans_or_priorities TEXT,
    self_rating NUMERIC(3, 1),
    manager_feedback TEXT,
    manager_status TEXT DEFAULT 'pending' CHECK (manager_status IN ('pending', 'approved', 'rewarded', 'rejected')),
    reviewed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_periodic_reports_date_shamsi ON public.periodic_reports(date_shamsi);
CREATE INDEX IF NOT EXISTS idx_periodic_reports_period_type ON public.periodic_reports(period_type);
CREATE INDEX IF NOT EXISTS idx_periodic_reports_consultant_code ON public.periodic_reports(consultant_code);

-- ====================================================================
-- جدول ۵: رکوردهای بایگانی تاریخی سیستم (archives)
-- ====================================================================
CREATE TABLE IF NOT EXISTS public.archives (
    id TEXT PRIMARY KEY,
    file_name TEXT NOT NULL,
    date_shamsi TEXT NOT NULL,
    day_of_week TEXT NOT NULL,
    timestamp TIMESTAMPTZ NOT NULL,
    archive_type TEXT NOT NULL DEFAULT 'calls_daily',
    period_title TEXT,
    total_consultants INTEGER NOT NULL DEFAULT 0,
    total_clients_contacted INTEGER NOT NULL DEFAULT 0,
    top_concerns JSONB DEFAULT '[]'::jsonb,
    reports_snapshot JSONB DEFAULT '[]'::jsonb,
    overall_reports_snapshot JSONB DEFAULT '[]'::jsonb,
    auto_generated BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_archives_date_shamsi ON public.archives(date_shamsi);
CREATE INDEX IF NOT EXISTS idx_archives_archive_type ON public.archives(archive_type);

-- ====================================================================
-- جدول ۶: واژگان و سرفصل‌های دغدغه‌های کارفرمایان (employer_concerns)
-- ====================================================================
CREATE TABLE IF NOT EXISTS public.employer_concerns (
    id SERIAL PRIMARY KEY,
    title TEXT UNIQUE NOT NULL,
    category TEXT DEFAULT 'عمومی',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ====================================================================
-- جدول ۷: دستورات و ابلاغیه‌های راهبردی مدیریت (directives)
-- ====================================================================
CREATE TABLE IF NOT EXISTS public.directives (
    id TEXT PRIMARY KEY,
    author_id TEXT NOT NULL,
    author_name TEXT NOT NULL,
    target_consultant_id TEXT NOT NULL DEFAULT 'all',
    content TEXT NOT NULL,
    priority TEXT NOT NULL DEFAULT 'normal' CHECK (priority IN ('normal', 'high')),
    date_shamsi TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_directives_target ON public.directives(target_consultant_id);

-- ====================================================================
-- جدول ۸: گزارش‌های نظارتی و ردپای تغییرات (audit_logs)
-- ====================================================================
CREATE TABLE IF NOT EXISTS public.audit_logs (
    id TEXT PRIMARY KEY,
    timestamp TIMESTAMPTZ DEFAULT NOW(),
    time_shamsi TEXT,
    category TEXT NOT NULL,
    level TEXT NOT NULL,
    message TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_audit_logs_timestamp ON public.audit_logs(timestamp DESC);

-- ====================================================================
-- جدول ۹: شیت‌های ۲۵ کارفرمایی لیدها (lead_sheets)
-- ====================================================================
CREATE TABLE IF NOT EXISTS public.lead_sheets (
    id TEXT PRIMARY KEY,
    sheet_number INTEGER NOT NULL,
    title TEXT NOT NULL,
    guild TEXT NOT NULL,
    assigned_to_consultant_id TEXT REFERENCES public.users(id) ON DELETE SET NULL,
    assigned_to_consultant_name TEXT NOT NULL,
    assigned_to_consultant_code TEXT NOT NULL,
    assigned_by_manager_id TEXT,
    assigned_at TIMESTAMPTZ DEFAULT NOW(),
    date_shamsi TEXT NOT NULL,
    target_calls_count INTEGER NOT NULL DEFAULT 25,
    status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'completed', 'archived')),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_lead_sheets_consultant_id ON public.lead_sheets(assigned_to_consultant_id);
CREATE INDEX IF NOT EXISTS idx_lead_sheets_status ON public.lead_sheets(status);
CREATE INDEX IF NOT EXISTS idx_lead_sheets_date_shamsi ON public.lead_sheets(date_shamsi);

-- ====================================================================
-- جدول ۱۰: ردیف‌های کارفرمایان شیت لید (lead_rows)
-- ====================================================================
CREATE TABLE IF NOT EXISTS public.lead_rows (
    id TEXT PRIMARY KEY,
    sheet_id TEXT NOT NULL REFERENCES public.lead_sheets(id) ON DELETE CASCADE,
    row_number INTEGER NOT NULL,
    client_name TEXT NOT NULL,
    activity_field TEXT NOT NULL,
    personnel_count TEXT,
    phone TEXT NOT NULL,
    address TEXT,
    employer_concern TEXT,
    follow_up_1 TEXT DEFAULT '',
    follow_up_1_date TIMESTAMPTZ,
    follow_up_1_date_shamsi TEXT,
    follow_up_2 TEXT DEFAULT '',
    follow_up_2_date TIMESTAMPTZ,
    follow_up_2_date_shamsi TEXT,
    follow_up_3 TEXT DEFAULT '',
    follow_up_3_date TIMESTAMPTZ,
    follow_up_3_date_shamsi TEXT,
    follow_up_4 TEXT DEFAULT '',
    follow_up_4_date TIMESTAMPTZ,
    follow_up_4_date_shamsi TEXT,
    follow_up_result TEXT DEFAULT 'در حال پیگیری',
    meeting_topic TEXT,
    status TEXT NOT NULL DEFAULT 'in_progress' CHECK (status IN ('in_progress', 'completed', 'no_answer', 'cancelled', 'won', 'lost', 'archived')),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_lead_rows_sheet_id ON public.lead_rows(sheet_id);
CREATE INDEX IF NOT EXISTS idx_lead_rows_phone ON public.lead_rows(phone);
CREATE INDEX IF NOT EXISTS idx_lead_rows_status ON public.lead_rows(status);

-- ====================================================================
-- جدول ۱۱: گفت‌وگوها و یادداشت‌های پرونده‌ای روی سطرها (sheet_messages)
-- ====================================================================
CREATE TABLE IF NOT EXISTS public.sheet_messages (
    id TEXT PRIMARY KEY,
    sheet_id TEXT NOT NULL REFERENCES public.lead_sheets(id) ON DELETE CASCADE,
    row_id TEXT,
    sender_id TEXT NOT NULL,
    sender_name TEXT NOT NULL,
    sender_role TEXT NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_sheet_messages_sheet_id ON public.sheet_messages(sheet_id);
CREATE INDEX IF NOT EXISTS idx_sheet_messages_row_id ON public.sheet_messages(row_id);

-- ====================================================================
-- جدول ۱۲: مکاتبات رسمی و ابلاغیه‌های درون‌سازمانی (memos)
-- ====================================================================
CREATE TABLE IF NOT EXISTS public.memos (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    sender_id TEXT NOT NULL,
    sender_name TEXT NOT NULL,
    sender_role TEXT NOT NULL,
    target_user_id TEXT NOT NULL DEFAULT 'all',
    is_urgent BOOLEAN DEFAULT FALSE,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_memos_target ON public.memos(target_user_id);

-- ====================================================================
-- تنظیمات امنیت سطح ردیف (Row Level Security - RLS)
-- ====================================================================
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.daily_reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.report_rows ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.periodic_reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.archives ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.employer_concerns ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.directives ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.audit_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lead_sheets ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lead_rows ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sheet_messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.memos ENABLE ROW LEVEL SECURITY;

-- سیاست‌های دسترسی کامل برای کلاینت و سرویس (سازگار با کلید anon و authenticated)
DROP POLICY IF EXISTS "Allow all access to users" ON public.users;
CREATE POLICY "Allow all access to users" ON public.users FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Allow all access to daily_reports" ON public.daily_reports;
CREATE POLICY "Allow all access to daily_reports" ON public.daily_reports FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Allow all access to report_rows" ON public.report_rows;
CREATE POLICY "Allow all access to report_rows" ON public.report_rows FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Allow all access to periodic_reports" ON public.periodic_reports;
CREATE POLICY "Allow all access to periodic_reports" ON public.periodic_reports FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Allow all access to archives" ON public.archives;
CREATE POLICY "Allow all access to archives" ON public.archives FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Allow all access to employer_concerns" ON public.employer_concerns;
CREATE POLICY "Allow all access to employer_concerns" ON public.employer_concerns FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Allow all access to directives" ON public.directives;
CREATE POLICY "Allow all access to directives" ON public.directives FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Allow all access to audit_logs" ON public.audit_logs;
CREATE POLICY "Allow all access to audit_logs" ON public.audit_logs FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Allow all access to lead_sheets" ON public.lead_sheets;
CREATE POLICY "Allow all access to lead_sheets" ON public.lead_sheets FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Allow all access to lead_rows" ON public.lead_rows;
CREATE POLICY "Allow all access to lead_rows" ON public.lead_rows FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Allow all access to sheet_messages" ON public.sheet_messages;
CREATE POLICY "Allow all access to sheet_messages" ON public.sheet_messages FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Allow all access to memos" ON public.memos;
CREATE POLICY "Allow all access to memos" ON public.memos FOR ALL TO anon, authenticated USING (true) WITH CHECK (true);



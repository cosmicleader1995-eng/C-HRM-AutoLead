import fs from 'fs';
import path from 'path';
import dotenv from 'dotenv';

dotenv.config();

const DB_FILE = path.join(process.cwd(), 'data', 'db.json');
const OUTPUT_SQL = path.join(process.cwd(), 'database', 'seed_data.sql');

const SUPABASE_URL = process.env.SUPABASE_URL || 'https://xwjodiszshqitcjanamo.supabase.co';
const SUPABASE_KEY = process.env.SUPABASE_KEY || 'sb_publishable_c4UXK09vyRD-MrO0Uk-rcQ_Ln7NylKN';

function escapeSql(str: string | null | undefined): string {
  if (str === null || str === undefined) return 'NULL';
  return `'${String(str).replace(/'/g, "''")}'`;
}

async function runMigration() {
  console.log('[Migration] Reading local db.json...');
  if (!fs.existsSync(DB_FILE)) {
    console.error('[Migration] db.json not found at:', DB_FILE);
    process.exit(1);
  }

  const raw = fs.readFileSync(DB_FILE, 'utf-8');
  const db = JSON.parse(raw);

  const users = db.users || [];
  const reports = db.reports || [];
  const archives = db.archives || [];
  const directives = db.directives || [];
  const concerns = db.concerns || [];
  const periodicReports = db.overallReports || [];
  const logs = db.logs || [];

  console.log(`[Migration] Found:
    - ${users.length} users
    - ${reports.length} daily reports
    - ${periodicReports.length} periodic reports
    - ${directives.length} directives
    - ${archives.length} archives
    - ${concerns.length} concerns
    - ${logs.length} logs`);

  const sqlStatements: string[] = [];
  sqlStatements.push('-- Karino CRM Relational Seed Data Generated Automatically');
  sqlStatements.push('-- Safe upsert queries with ON CONFLICT DO UPDATE\n');

  // 1. Users
  for (const u of users) {
    sqlStatements.push(`
INSERT INTO public.users (id, username, full_name, consultant_code, role, password_hash, phone, branch)
VALUES (${escapeSql(u.id)}, ${escapeSql(u.username?.toLowerCase())}, ${escapeSql(u.fullName)}, ${escapeSql(u.consultantCode)}, ${escapeSql(u.role || 'consultant')}, ${escapeSql(u.password || '')}, ${escapeSql(u.phone)}, ${escapeSql(u.branch || 'دفتر مرکزی کارینو')})
ON CONFLICT (id) DO UPDATE SET
  full_name = EXCLUDED.full_name,
  consultant_code = EXCLUDED.consultant_code,
  role = EXCLUDED.role,
  phone = EXCLUDED.phone,
  branch = EXCLUDED.branch;`);
  }

  // 2. Concerns
  for (const c of concerns) {
    sqlStatements.push(`
INSERT INTO public.employer_concerns (title, category)
VALUES (${escapeSql(c)}, 'عمومی')
ON CONFLICT (title) DO NOTHING;`);
  }

  // 3. Directives
  for (const d of directives) {
    sqlStatements.push(`
INSERT INTO public.directives (id, author_id, author_name, target_consultant_id, content, priority, date_shamsi)
VALUES (${escapeSql(d.id)}, ${escapeSql(d.authorId)}, ${escapeSql(d.authorName)}, ${escapeSql(d.targetConsultantId || 'all')}, ${escapeSql(d.content)}, ${escapeSql(d.priority || 'normal')}, ${escapeSql(d.dateShamsi)})
ON CONFLICT (id) DO UPDATE SET content = EXCLUDED.content, priority = EXCLUDED.priority;`);
  }

  // 4. Daily Reports & Report Rows
  let totalRowsCount = 0;
  for (const r of reports) {
    sqlStatements.push(`
INSERT INTO public.daily_reports (id, consultant_id, consultant_name, consultant_code, branch, date_shamsi, day_of_week_shamsi, submitted_at, guild, personal_opinion, manager_feedback, manager_rating, status, reviewed_at, created_at, updated_at)
VALUES (
  ${escapeSql(r.id)},
  ${escapeSql(r.consultantId)},
  ${escapeSql(r.consultantName || 'مشاور کارینو')},
  ${escapeSql(r.consultantCode || 'C-100')},
  ${escapeSql(r.branch || 'دفتر مرکزی کارینو')},
  ${escapeSql(r.dateShamsi)},
  ${escapeSql(r.dayOfWeekShamsi || '')},
  ${escapeSql(r.submittedAt || '')},
  ${escapeSql(r.guild || 'اصناف و بنگاه‌های اقتصادی')},
  ${escapeSql(r.personalOpinion)},
  ${escapeSql(r.managerFeedback)},
  ${r.managerRating !== undefined && r.managerRating !== null ? Number(r.managerRating) : 'NULL'},
  ${escapeSql(r.status || 'submitted')},
  ${escapeSql(r.reviewedAt)},
  ${escapeSql(r.createdAt || new Date().toISOString())},
  ${escapeSql(r.updatedAt || new Date().toISOString())}
)
ON CONFLICT (id) DO UPDATE SET
  status = EXCLUDED.status,
  manager_feedback = EXCLUDED.manager_feedback,
  manager_rating = EXCLUDED.manager_rating,
  reviewed_at = EXCLUDED.reviewed_at,
  updated_at = EXCLUDED.updated_at;`);

    if (Array.isArray(r.rows)) {
      totalRowsCount += r.rows.length;
      r.rows.forEach((row: any, idx: number) => {
        const rowId = row.id || `${r.id}-row-${idx + 1}`;
        sqlStatements.push(`
INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  ${escapeSql(rowId)},
  ${escapeSql(r.id)},
  ${idx + 1},
  ${escapeSql(row.clientName || 'نامشخص')},
  ${escapeSql(row.activityField || 'نامشخص')},
  ${escapeSql(row.personnelCount || '')},
  ${escapeSql(row.phone || '')},
  ${escapeSql(row.address || '')},
  ${escapeSql(row.employerConcern || 'سایر دغدغه‌ها')},
  ${escapeSql(row.followUp1 || '')},
  ${escapeSql(row.followUp1Date)},
  ${escapeSql(row.followUp1DateShamsi)},
  ${escapeSql(row.followUp2)},
  ${escapeSql(row.followUp2Date)},
  ${escapeSql(row.followUp2DateShamsi)},
  ${escapeSql(row.followUp3)},
  ${escapeSql(row.followUp3Date)},
  ${escapeSql(row.followUp3DateShamsi)},
  ${escapeSql(row.followUp4)},
  ${escapeSql(row.followUp4Date)},
  ${escapeSql(row.followUp4DateShamsi)},
  ${escapeSql(row.followUpResult || 'در حال پیگیری')},
  ${escapeSql(row.meetingTopic)},
  ${escapeSql(row.notes)},
  ${escapeSql(r.createdAt || new Date().toISOString())},
  ${escapeSql(r.updatedAt || new Date().toISOString())}
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;`);
      });
    }
  }

  // 5. Periodic Reports
  for (const p of periodicReports) {
    sqlStatements.push(`
INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  ${escapeSql(p.id)},
  ${escapeSql(p.consultantId)},
  ${escapeSql(p.consultantName || 'مشاور کارینو')},
  ${escapeSql(p.consultantCode || 'C-100')},
  ${escapeSql(p.periodType || 'daily')},
  ${escapeSql(p.dateShamsi)},
  ${escapeSql(p.dayOfWeekShamsi || '')},
  ${escapeSql(p.submittedAt || '')},
  ${escapeSql(p.periodLabel || '')},
  ${escapeSql(p.summary || '')},
  ${escapeSql(p.keyAchievements)},
  ${escapeSql(p.challengesOrBarriers)},
  ${escapeSql(p.plansOrPriorities)},
  ${p.selfRating !== undefined && p.selfRating !== null ? Number(p.selfRating) : 'NULL'},
  ${escapeSql(p.managerFeedback)},
  ${escapeSql(p.managerStatus || 'pending')},
  ${escapeSql(p.managerReviewedAt)}
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;`);
  }

  // 6. Archives
  for (const a of archives) {
    sqlStatements.push(`
INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  ${escapeSql(a.id)},
  ${escapeSql(a.fileName || 'archive.json')},
  ${escapeSql(a.dateShamsi)},
  ${escapeSql(a.dayOfWeek || '')},
  ${escapeSql(a.timestamp || new Date().toISOString())},
  ${escapeSql(a.archiveType || 'calls_daily')},
  ${escapeSql(a.periodTitle)},
  ${Number(a.totalConsultants || 0)},
  ${Number(a.totalClientsContacted || 0)},
  ${escapeSql(JSON.stringify(a.topConcerns || []))}::jsonb,
  ${escapeSql(JSON.stringify(a.reports || []))}::jsonb,
  ${escapeSql(JSON.stringify(a.overallReports || []))}::jsonb,
  ${Boolean(a.autoGenerated)}
)
ON CONFLICT (id) DO NOTHING;`);
  }

  fs.writeFileSync(OUTPUT_SQL, sqlStatements.join('\n'), 'utf-8');
  console.log(`[Migration] Successfully exported ${sqlStatements.length} SQL statements to: ${OUTPUT_SQL}`);
  console.log(`[Migration] Total report rows extracted: ${totalRowsCount}`);
}

runMigration().catch(err => {
  console.error('[Migration] Failed:', err);
  process.exit(1);
});

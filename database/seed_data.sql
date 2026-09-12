-- Karino CRM Relational Seed Data Generated Automatically
-- Safe upsert queries with ON CONFLICT DO UPDATE


INSERT INTO public.users (id, username, full_name, consultant_code, role, password_hash, phone, branch)
VALUES ('user-ceo', 'ceo', 'مدیریت کارینو (CEO)', 'KARINO-CEO', 'ceo', '$2b$10$y/q9w.0cwCF/On1kk2LLS.MA.Ij/WGfWZ4kRbEUR40bd1kS638kR6', '09120000000', 'دفتر مرکزی کارینو')
ON CONFLICT (id) DO UPDATE SET
  full_name = EXCLUDED.full_name,
  consultant_code = EXCLUDED.consultant_code,
  role = EXCLUDED.role,
  phone = EXCLUDED.phone,
  branch = EXCLUDED.branch;

INSERT INTO public.users (id, username, full_name, consultant_code, role, password_hash, phone, branch)
VALUES ('user-it', 'it_admin', 'مدیر فاوا و فناوری اطلاعات', 'KARINO-IT', 'it_admin', '$2b$10$mLfus36TEBeaKYzHPD5IEeq3ERd9zs6nc3vcKtyZCJ6zc6IOjGhL.', '09120000001', 'واحد فناوری اطلاعات')
ON CONFLICT (id) DO UPDATE SET
  full_name = EXCLUDED.full_name,
  consultant_code = EXCLUDED.consultant_code,
  role = EXCLUDED.role,
  phone = EXCLUDED.phone,
  branch = EXCLUDED.branch;

INSERT INTO public.users (id, username, full_name, consultant_code, role, password_hash, phone, branch)
VALUES ('user-c101', 'rezaei', 'علیرضا رضایی', 'C-101', 'consultant', '$2b$10$7SsBkjowkYm9psJ6ycm.Des1zS1UyTO5mp9JKxTkhBLEU2HMFm7oS', '09151112233', 'تیم اجرایی مشهد')
ON CONFLICT (id) DO UPDATE SET
  full_name = EXCLUDED.full_name,
  consultant_code = EXCLUDED.consultant_code,
  role = EXCLUDED.role,
  phone = EXCLUDED.phone,
  branch = EXCLUDED.branch;

INSERT INTO public.users (id, username, full_name, consultant_code, role, password_hash, phone, branch)
VALUES ('user-c102', 'mohammadi', 'مریم محمدی', 'C-102', 'consultant', '$2b$10$pYWDKzOucZiaf3Om.MlpG.jM6eh/PWO9phaV3J91hSCFCii6/rHym', '09152223344', 'تیم اجرایی مشهد')
ON CONFLICT (id) DO UPDATE SET
  full_name = EXCLUDED.full_name,
  consultant_code = EXCLUDED.consultant_code,
  role = EXCLUDED.role,
  phone = EXCLUDED.phone,
  branch = EXCLUDED.branch;

INSERT INTO public.users (id, username, full_name, consultant_code, role, password_hash, phone, branch)
VALUES ('user-c103', 'hosseini', 'سعید حسینی', 'C-103', 'consultant', '$2b$10$P26A0mTisc9vSbmFq6Mjn.u05BI4N/6cwG74V5.7uDYnKrXWCrS.6', '09123334455', 'تیم اجرایی تهران')
ON CONFLICT (id) DO UPDATE SET
  full_name = EXCLUDED.full_name,
  consultant_code = EXCLUDED.consultant_code,
  role = EXCLUDED.role,
  phone = EXCLUDED.phone,
  branch = EXCLUDED.branch;

INSERT INTO public.users (id, username, full_name, consultant_code, role, password_hash, phone, branch)
VALUES ('user-c104', 'karimi', 'ندا کریمی', 'C-104', 'consultant', '$2b$10$SiRpskWeeD765H0sVVQQR.TaxOXJzPtnN0oTv6rmCnCCWnoHOd.he', '09154445566', 'تیم اجرایی مشهد')
ON CONFLICT (id) DO UPDATE SET
  full_name = EXCLUDED.full_name,
  consultant_code = EXCLUDED.consultant_code,
  role = EXCLUDED.role,
  phone = EXCLUDED.phone,
  branch = EXCLUDED.branch;

INSERT INTO public.users (id, username, full_name, consultant_code, role, password_hash, phone, branch)
VALUES ('user-1788870728032', 'a.z', 'علی زارع', '110', 'consultant', '$2b$10$q6GZM0qB1AZXB4ULo1Ij3eepq3x4eENMyHa774Zwz.ZJMvKmT3lmS', '', 'تیم اجرایی مشهد')
ON CONFLICT (id) DO UPDATE SET
  full_name = EXCLUDED.full_name,
  consultant_code = EXCLUDED.consultant_code,
  role = EXCLUDED.role,
  phone = EXCLUDED.phone,
  branch = EXCLUDED.branch;

INSERT INTO public.users (id, username, full_name, consultant_code, role, password_hash, phone, branch)
VALUES ('user-1788870918188', 'asghar', 'اصغر', '897', 'consultant', '$2b$10$s7Yod4t7OWY1pMGr04W8ieufZBNkrOA/LXbLc40TM5.V1mehIEWyy', '', 'تیم اجرایی مشهد')
ON CONFLICT (id) DO UPDATE SET
  full_name = EXCLUDED.full_name,
  consultant_code = EXCLUDED.consultant_code,
  role = EXCLUDED.role,
  phone = EXCLUDED.phone,
  branch = EXCLUDED.branch;

INSERT INTO public.employer_concerns (title, category)
VALUES ('دعاوی و شکایات در اداره کار و هیئت‌های تشخیص/حل اختلاف', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('عدم شفافیت قراردادهای کار، الحاقیه‌ها و تضامین پرسنلی', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('جرایم بازرسی و مغایرت‌های حق بیمه تأمین اجتماعی', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('عدم تطابق فیش حقوقی، مزایای قانونی و تراز مالی با پرداختی واقعی', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('فقدان آیین‌نامه انضباطی مصوب و رویه مشخص اخراج یا توبیخ', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('ریزش مداوم نیروی انسانی و تعارضات درون‌سازمانی', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('وابستگی کامل سیستم به حضور فیزیکی کارفرما (عدم تفویض اختیار)', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('نبود چارت سازمانی مصوب و تداخل در شرح وظایف پرسنل', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('افت شدید بهره‌وری و نبود نظام ارزیابی عملکرد (KPI)', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('ریسک‌های مالیاتی و حسابداری مرتبط با حقوق و دستمزد', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('ابهام در فرمول‌های پورسانت، پاداش و تارگت‌های فروش', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('چالش‌های توزیع مویرگی، وصول مطالبات و کسری انبار', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('ترک کار ناگهانی پرسنل کلیدی و بردن اطلاعات/اسرار تجاری', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('حوادث ناشی از کار، مسئولیت‌های مدنی و دیه کارفرمایی', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('پرونده‌های سخت و زیان‌آور و بازنشستگی‌های زودرس پیش‌بینی نشده', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('چالش محاسبه اضافه کاری، شب‌کاری، نوبت‌کاری و تعطیل‌کاری', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('عدم رعایت دوره‌های آزمایشی و بلاتکلیفی حقوقی قراردادهای موقت', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('ضعف در فرآیند جذب، غربالگری و مصاحبه استخدامی (Onboarding)', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('قیمت‌گذاری غیراصولی خدمات/محصول و حاشیه سود کاهشی', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('نبود دستورالعمل‌های مکتوب و استانداردهای اجرایی (SOP)', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('عدم وجود سیستم کنترل داخلی و پیشگیری از تبانی یا فساد اداری', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('عدم انگیزه کافی در تیم بازاریابی و فروش', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('نارضایتی کارگران از شیفت‌های سنگین و افت کیفیت خروجی', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('عدم تسلط تیم مالی شرکت به آخرین بخشنامه‌های اداره کار', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.employer_concerns (title, category)
VALUES ('سایر دغدغه‌ها (نیاز به عارضه‌یابی تخصصی و مشاوره حضوری)', 'عمومی')
ON CONFLICT (title) DO NOTHING;

INSERT INTO public.directives (id, author_id, author_name, target_consultant_id, content, priority, date_shamsi)
VALUES ('dir-1789220331683', 'user-ceo', 'مدیریت کارینو (CEO)', 'user-c103', 'همکار گرامی جناب/سرکار سعید حسینی (کد C-103)، موعد قانونی ثبت گزارش عملکرد شما در بازه «امروز (روزانه)» سپری گردیده و گزارشی واصل نشده است. این عدم ارسال در پرونده انضباطی و شاخص KPI منظور می‌گردد. لطفاً در صورت داشتن عذر موجه، فوراً به مدیریت اعلام فرمایید.', 'high', '1405/06/21')
ON CONFLICT (id) DO UPDATE SET content = EXCLUDED.content, priority = EXCLUDED.priority;

INSERT INTO public.directives (id, author_id, author_name, target_consultant_id, content, priority, date_shamsi)
VALUES ('dir-1789217766017', 'user-ceo', 'مدیریت کارینو (CEO)', 'user-1788870918188', 'همکار گرامی جناب/سرکار اصغر (کد 897)، موعد قانونی ثبت گزارش عملکرد شما در بازه «این هفته (هفتگی)» سپری گردیده و گزارشی واصل نشده است. این عدم ارسال در پرونده انضباطی و شاخص KPI منظور می‌گردد. لطفاً در صورت داشتن عذر موجه، فوراً به مدیریت اعلام فرمایید.', 'high', '1405/06/21')
ON CONFLICT (id) DO UPDATE SET content = EXCLUDED.content, priority = EXCLUDED.priority;

INSERT INTO public.directives (id, author_id, author_name, target_consultant_id, content, priority, date_shamsi)
VALUES ('dir-seed-1', NULL, 'مدیریت کارینو (CEO)', 'user-c101', 'پرونده کریمی و صنایع ریخته‌گری توس فولاد رو در اولویت قطعی امروز قرار بده.', 'high', 'امروز')
ON CONFLICT (id) DO UPDATE SET content = EXCLUDED.content, priority = EXCLUDED.priority;

INSERT INTO public.directives (id, author_id, author_name, target_consultant_id, content, priority, date_shamsi)
VALUES ('dir-seed-2', NULL, 'مدیریت کارینو (CEO)', 'all', 'تمرکز تماس‌های این هفته بر روی عارضه‌یابی قراردادهای کار و پیشگیری از جرایم بازرسی تأمین اجتماعی است.', 'normal', 'امروز')
ON CONFLICT (id) DO UPDATE SET content = EXCLUDED.content, priority = EXCLUDED.priority;

INSERT INTO public.directives (id, author_id, author_name, target_consultant_id, content, priority, date_shamsi)
VALUES ('dir-seed-3', NULL, 'مدیریت کارینو (CEO)', 'user-c102', 'جلسه شرکت فرآورده‌های لبنی کوهستان رو با بسته پیشنهادی سطح ۲ هماهنگ فرمایید.', 'high', 'امروز')
ON CONFLICT (id) DO UPDATE SET content = EXCLUDED.content, priority = EXCLUDED.priority;

INSERT INTO public.directives (id, author_id, author_name, target_consultant_id, content, priority, date_shamsi)
VALUES ('dir-seed-4', NULL, 'مدیریت کارینو (CEO)', 'user-c103', 'تمرکز تماس‌های امروز بر مبالغ سفته و تضامین پرسنلی ویزیتورها و رانندگان پخش باشد.', 'normal', 'امروز')
ON CONFLICT (id) DO UPDATE SET content = EXCLUDED.content, priority = EXCLUDED.priority;

INSERT INTO public.directives (id, author_id, author_name, target_consultant_id, content, priority, date_shamsi)
VALUES ('dir-1788861935011', 'user-ceo', 'مدیریت کارینو (CEO)', 'all', 'فورا دستور میدهیم با تمام توان رو به جلو', 'high', '1405/06/17')
ON CONFLICT (id) DO UPDATE SET content = EXCLUDED.content, priority = EXCLUDED.priority;

INSERT INTO public.directives (id, author_id, author_name, target_consultant_id, content, priority, date_shamsi)
VALUES ('dir-1788864359175', 'user-ceo', 'مدیریت کارینو (CEO)', 'user-c102', 'شنبلیله هارو بردی یا نه؟؟؟؟', 'high', '1405/06/17')
ON CONFLICT (id) DO UPDATE SET content = EXCLUDED.content, priority = EXCLUDED.priority;

INSERT INTO public.daily_reports (id, consultant_id, consultant_name, consultant_code, branch, date_shamsi, day_of_week_shamsi, submitted_at, guild, personal_opinion, manager_feedback, manager_rating, status, reviewed_at, created_at, updated_at)
VALUES (
  'rep-c101-today',
  'user-c101',
  'علیرضا رضایی',
  'C-101',
  'دفتر مرکزی کارینو',
  '1405/06/21',
  'شنبه',
  '۱۴:۳۰',
  'تولیدی قطعات خودرو و ریخته‌گری',
  'به دلیل افزایش نظارت و بازرسی‌های تأمین اجتماعی، کارفرمایان این صنف استقبال چشمگیری از خدمات بازبینی قراردادها و تراز مالی دارند.',
  'عملکرد بسیار عالی در برقراری ارتباط با صنایع ریخته‌گری توس فولاد. جلسه حضوری به خوبی هماهنگ شد.',
  5,
  'approved',
  '2026-09-12T12:22:40.435Z',
  '2026-09-12T12:22:40.435Z',
  '2026-09-12T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  status = EXCLUDED.status,
  manager_feedback = EXCLUDED.manager_feedback,
  manager_rating = EXCLUDED.manager_rating,
  reviewed_at = EXCLUDED.reviewed_at,
  updated_at = EXCLUDED.updated_at;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c101-today-1',
  'rep-c101-today',
  1,
  'صنایع ریخته‌گری توس فولاد',
  'تولید قطعات چدنی خودرو',
  '48',
  '05138401122',
  'شهرک صنعتی توس، فاز ۱، تلاش جنوبی',
  'دعاوی و شکایات در اداره کار و هیئت‌های تشخیص/حل اختلاف',
  '+',
  NULL,
  '1405/06/21',
  '+',
  NULL,
  '1405/06/21',
  '✓',
  NULL,
  '1405/06/21',
  '',
  NULL,
  NULL,
  '✓ (جلسه حضوری ست شد)',
  'آنالیز ریسک حقوقی قراردادها و پیشگیری از شکایات اداره کار',
  'جلسه با مهندس صادقی (مدیرعامل) دوشنبه ساعت ۱۰:۰۰ در محل کارخانه تنظیم شد.',
  '2026-09-12T12:22:40.435Z',
  '2026-09-12T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c101-today-2',
  'rep-c101-today',
  2,
  'کارگاه تراشکاری نوین صنعت',
  'تراشکاری قطعات برنجی',
  '14',
  '05132456677',
  'بزرگراه آسیایی، آزادی ۱۲۵',
  'جرایم بازرسی و مغایرت‌های حق بیمه تأمین اجتماعی',
  '.',
  NULL,
  '1405/06/21',
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '. (در انتظار تماس مجدد)',
  '',
  'مدیر کارگاه در خط تولید بود؛ تماس مجدد هماهنگ خواهد شد.',
  '2026-09-12T12:22:40.435Z',
  '2026-09-12T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c101-today-3',
  'rep-c101-today',
  3,
  'قالب‌سازی دقیق البرز',
  'طراحی قالب‌های سنبه ماتریس',
  '9',
  '05136518899',
  'شهرک صنعتی کلات',
  'افت شدید بهره‌وری و نبود نظام ارزیابی عملکرد (KPI)',
  '-',
  NULL,
  '1405/06/21',
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '- (اعلام عدم نیاز فعلی)',
  '',
  'کارفرما عنوان کرد فعلاً برنامه اصلاح ساختار ندارند.',
  '2026-09-12T12:22:40.435Z',
  '2026-09-12T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c101-today-4',
  'rep-c101-today',
  4,
  'شرکت پترو فرایند پایا',
  'تولید اتصالات فشار قوی نفت و گاز',
  '85',
  '05135421190',
  'شهرک صنعتی توس، فاز ۲، بلوار اندیشه',
  'جرایم بازرسی و مغایرت‌های حق بیمه تأمین اجتماعی',
  '+',
  NULL,
  '1405/06/12',
  '+',
  NULL,
  '1405/06/16',
  '✓',
  NULL,
  '1405/06/19',
  '',
  NULL,
  NULL,
  '✓ (جلسه حضوری هماهنگ شد)',
  'رسیدگی به اعلام بدهی حسابرسی بیمه تامین اجتماعی و دفاعیات تخصصی',
  'جلسه با مدیر مالی و قائم مقام مدیرعامل یکشنبه ساعت ۱۱ در کارخانه قطعی شد.',
  '2026-09-12T12:22:40.435Z',
  '2026-09-12T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c101-today-5',
  'rep-c101-today',
  5,
  'صنایع ماشین‌سازی پارس تکنیک',
  'ساخت ماشین‌آلات بسته‌بندی پیلوپک',
  '32',
  '05138472255',
  'جاده سنتو، سه راه فردوسی',
  'فقدان آیین‌نامه انضباطی مصوب و رویه مشخص اخراج یا توبیخ',
  '+',
  NULL,
  '1405/06/15',
  '+',
  NULL,
  '1405/06/19',
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '+ (مذاکره مثبت، در انتظار پروپوزال)',
  'تنظیم و اخذ تاییدیه آیین‌نامه انضباطی کارگاه از اداره تعاون و کار',
  'پروپوزال خدمات تدوین آیین‌نامه ارسال گردید؛ پیگیری ۳ برای دوشنبه تنظیم شد.',
  '2026-09-12T12:22:40.435Z',
  '2026-09-12T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c101-today-6',
  'rep-c101-today',
  6,
  'صنایع فورج و اکستروژن نوین',
  'تولید مقاطع برنجی و آلومینیومی فورجینگ',
  '64',
  '05136528811',
  'شهرک صنعتی چناران، فاز ۱',
  'خطرات ناشی از حوادث کارگاهی و مسئولیت‌های کیفری کارفرما',
  '+',
  NULL,
  '1405/06/19',
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '+ (ابراز علاقه اولیه)',
  'بررسی پوشش‌های بیمه مسئولیت مدنی کارفرما در قبال کارکنان',
  'تماس اولیه بسیار موثر بود؛ کاتالوگ خدمات ایمنی و حقوقی ارسال شد.',
  '2026-09-12T12:22:40.435Z',
  '2026-09-12T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c101-today-7',
  'rep-c101-today',
  7,
  'کارگاه قالب‌سازی دقیق توس',
  'قالب‌های تزریق پلاستیک قطعات پزشکی',
  '12',
  '05137249900',
  'بلوار توس، توس ۷۵',
  'سفته و ضمانت‌نامه‌های بدون پشتوانه حقوقی مکفی',
  '*',
  NULL,
  '1405/06/19',
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '* (عدم پاسخگویی)',
  '',
  'تلفن همراه روی منشی تلفنی بود؛ پیامک اطلاع‌رسانی ارسال گردید.',
  '2026-09-12T12:22:40.435Z',
  '2026-09-12T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c101-today-8',
  'rep-c101-today',
  8,
  'مجموعه قطعه‌سازی متالوژی سپهر',
  'تولید بلبرینگ و قطعات دنده‌ای',
  '52',
  '05135414433',
  'شهرک صنعتی توس، فاز ۳',
  'بازنشستگی پیش از موعد در مشاغل سخت و زیان‌آور',
  '+',
  NULL,
  '1405/06/11',
  '+',
  NULL,
  '1405/06/15',
  '+',
  NULL,
  '1405/06/19',
  '',
  NULL,
  NULL,
  '+ (در حال نهایی‌سازی هماهنگی جلسه)',
  'محاسبه ۴ درصد مشاغل سخت و مدیریت سوابق زیان‌آور پرسنل',
  'مدیر اداری تایید اولیه داد، منتظر تایید زمان جلسه از طرف مدیرعامل هستند.',
  '2026-09-12T12:22:40.435Z',
  '2026-09-12T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.daily_reports (id, consultant_id, consultant_name, consultant_code, branch, date_shamsi, day_of_week_shamsi, submitted_at, guild, personal_opinion, manager_feedback, manager_rating, status, reviewed_at, created_at, updated_at)
VALUES (
  'rep-1788869621659',
  'user-c103',
  'سعید حسینی',
  'C-103',
  'دفتر مرکزی کارینو',
  '1405/06/17',
  'سه‌شنبه',
  '۱۵:۴۳',
  'صنف سیستم',
  'ایشان خفنه جهانن',
  'اذیت نکنید این دکتر عزیز رو',
  5,
  'approved',
  '2026-09-10T13:30:39.484Z',
  '2026-09-08T12:13:41.659Z',
  '2026-09-10T13:30:39.484Z'
)
ON CONFLICT (id) DO UPDATE SET
  status = EXCLUDED.status,
  manager_feedback = EXCLUDED.manager_feedback,
  manager_rating = EXCLUDED.manager_rating,
  reviewed_at = EXCLUDED.reviewed_at,
  updated_at = EXCLUDED.updated_at;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-1788869523910-2',
  'rep-1788869621659',
  1,
  'مهندس زارع',
  'هوش مصنوعی',
  '۱۰۰۰',
  '09995443211',
  'سیلیکون ولی',
  'افت شدید بهره‌وری و نبود نظام ارزیابی عملکرد (KPI)',
  '✓',
  NULL,
  NULL,
  '✓',
  NULL,
  NULL,
  '-',
  NULL,
  NULL,
  '✓',
  NULL,
  NULL,
  'میگن که بدرد من نمیخوره و زنگ نزنید دیگه',
  'بسیار خوش برخورد و متشخص میباشند این مهندس',
  '',
  '2026-09-08T12:13:41.659Z',
  '2026-09-10T13:30:39.484Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.daily_reports (id, consultant_id, consultant_name, consultant_code, branch, date_shamsi, day_of_week_shamsi, submitted_at, guild, personal_opinion, manager_feedback, manager_rating, status, reviewed_at, created_at, updated_at)
VALUES (
  'rep-c102-today',
  'user-c102',
  'مریم محمدی',
  'C-102',
  'دفتر مرکزی کارینو',
  '1405/06/21',
  'شنبه',
  '۱۳:۱۵',
  'فناوری اطلاعات و تجارت الکترونیک',
  'شرکت‌های نرم‌افزاری به شدت نگران حفظ محرمانگی کدها و ترک ناگهانی برنامه‌نویسان ارشد هستند.',
  'جلسه شرکت فرآورده‌های لبنی کوهستان رو با بسته پیشنهادی سطح ۲ هماهنگ فرمایید.',
  5,
  'approved',
  '2026-09-12T12:22:40.435Z',
  '2026-09-12T12:22:40.435Z',
  '2026-09-12T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  status = EXCLUDED.status,
  manager_feedback = EXCLUDED.manager_feedback,
  manager_rating = EXCLUDED.manager_rating,
  reviewed_at = EXCLUDED.reviewed_at,
  updated_at = EXCLUDED.updated_at;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c102-1',
  'rep-c102-today',
  1,
  'شرکت دانش‌بنیان داده‌پردازان عصر نوین',
  'توسعه نرم‌افزارهای سازمانی و هوش مصنوعی',
  '36',
  '05138479900',
  'بلوار سجاد، خیابان بهار',
  'ترک کار ناگهانی پرسنل کلیدی و بردن اطلاعات/اسرار تجاری',
  '+',
  NULL,
  '1405/06/21',
  '+',
  NULL,
  '1405/06/21',
  '✓',
  NULL,
  '1405/06/21',
  '',
  NULL,
  NULL,
  '✓ (جلسه آنلاین با هم‌بنیان‌گذار ست شد)',
  'تنظیم آیین‌نامه انضباطی مصوب و الحاقیه‌های محرمانگی',
  'جلسه گوگل میت چهارشنبه ساعت ۱۴:۳۰ ست شد.',
  '2026-09-12T12:22:40.435Z',
  '2026-09-12T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c102-today-1',
  'rep-c102-today',
  2,
  'کارخانجات آرد خوشه طوس',
  'تولید انواع آرد صنعتی و سبوس‌دار',
  '110',
  '05136512244',
  'کیلومتر ۱۸ جاده قوچان',
  'ابهامات قانونی در اضافه‌کاری، نوبت‌کاری و شیفت‌های شبانه',
  '+',
  NULL,
  '1405/06/12',
  '+',
  NULL,
  '1405/06/16',
  '✓',
  NULL,
  '1405/06/19',
  '',
  NULL,
  NULL,
  '✓ (جلسه حضوری ست شد)',
  'فرمولاسیون قانونی محاسبه نوبت‌کاری و رفع اختلاف کارگری',
  'جلسه با مدیرعامل و مدیر کارخانه روز سه‌شنبه ساعت ۱۰ صبح نهایی شد.',
  '2026-09-12T12:22:40.435Z',
  '2026-09-12T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c102-today-2',
  'rep-c102-today',
  3,
  'شرکت فرآورده‌های لبنی کوهستان توس',
  'تولید دوغ و پنیر پاستوریزه',
  '78',
  '05138469911',
  'شهرک صنعتی بینالود',
  'ریزش مداوم نیروی انسانی کلیدی و بحران انگیزش',
  '+',
  NULL,
  '1405/06/15',
  '+',
  NULL,
  '1405/06/19',
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '+ (موافقت با طرح سنجش انگیزش)',
  'طراحی نظام جامع پاداش و ارتقای شغلی جهت کاهش خروج پرسنل',
  'اطلاعات اولیه پرسنلی دریافت شد؛ جلسه پیگیری ۳ برای دوشنبه تنظیم گردید.',
  '2026-09-12T12:22:40.435Z',
  '2026-09-12T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c102-today-3',
  'rep-c102-today',
  4,
  'کشت و صنعت فردوس خاور',
  'سردخانه و سورتینگ میوه صادراتی',
  '42',
  '05135417722',
  'شهرک صنعتی توس، فاز ۱',
  'قراردادهای کار معین و فصلی کارگران',
  '-',
  NULL,
  '1405/06/19',
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '- (عدم تمایل به بازنگری فعلی)',
  '',
  'کارفرما اعلام کرد مشاور حقوقی مقیم دارند.',
  '2026-09-12T12:22:40.435Z',
  '2026-09-12T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c102-today-4',
  'rep-c102-today',
  5,
  'صنایع بسته‌بندی زعفران و خشکبار نگین',
  'بسته‌بندی صادراتی زعفران و زرشک',
  '35',
  '05138423300',
  'بلوار سجاد، بزرگمهر شمالی',
  'سفته و ضمانت‌نامه‌های بدون پشتوانه حقوقی مکفی',
  '+',
  NULL,
  '1405/06/19',
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '+ (درخواست پیش‌نویس فرم تعهد)',
  'نحوه دریافت قانونی سفته حسن انجام کار و اقرارنامه مالی',
  'کارفرما بسیار راغب بود؛ نمونه شرایط ضمانت پرسنلی ارسال گردید.',
  '2026-09-12T12:22:40.435Z',
  '2026-09-12T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c102-today-5',
  'rep-c102-today',
  6,
  'مجتمع داروسازی گیاهی کیمیا دارو',
  'عصاره‌گیری و اسانس‌های دارویی',
  '60',
  '05136516688',
  'شهرک صنعتی چناران',
  'عدم شفافیت در قراردادها و ابهام در تضامین پرسنلی',
  '.',
  NULL,
  '1405/06/19',
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '. (درخواست تماس ساعت ۱۸)',
  '',
  'مدیر اداری در جلسه ممیزی GMP بود؛ تماس مجدد عصر گرفته خواهد شد.',
  '2026-09-12T12:22:40.435Z',
  '2026-09-12T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c102-today-6',
  'rep-c102-today',
  7,
  'صنایع غذایی و کنسرو تبرک شرق',
  'تولید رب گوجه و انواع کنسرو گوشتی',
  '95',
  '05135423311',
  'شهرک صنعتی توس، تلاش شمالی ۶',
  'دعاوی و شکایات در اداره کار و هیئت‌های تشخیص/حل اختلاف',
  '+',
  NULL,
  '1405/06/14',
  '+',
  NULL,
  '1405/06/18',
  '✓',
  NULL,
  '1405/06/19',
  '',
  NULL,
  NULL,
  '✓ (جلسه حضوری هماهنگ گردید)',
  'بررسی پرونده حل اختلاف یکی از سرپرستان سابق تولید',
  'جلسه چهارشنبه ساعت ۹ صبح با حضور وکیل کارخانه تنظیم شد.',
  '2026-09-12T12:22:40.435Z',
  '2026-09-12T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.daily_reports (id, consultant_id, consultant_name, consultant_code, branch, date_shamsi, day_of_week_shamsi, submitted_at, guild, personal_opinion, manager_feedback, manager_rating, status, reviewed_at, created_at, updated_at)
VALUES (
  'rep-1788868003406',
  'user-c102',
  'مریم محمدی',
  'C-102',
  'دفتر مرکزی کارینو',
  '1405/06/17',
  'سه‌شنبه',
  '۱۵:۲۹',
  'اصناف و بنگاه‌های اقتصادی',
  'طرف نمیخواد',
  'شانگاریلیلا',
  2,
  'approved',
  '2026-09-08T12:06:28.491Z',
  '2026-09-08T11:46:43.406Z',
  '2026-09-09T09:34:35.123Z'
)
ON CONFLICT (id) DO UPDATE SET
  status = EXCLUDED.status,
  manager_feedback = EXCLUDED.manager_feedback,
  manager_rating = EXCLUDED.manager_rating,
  reviewed_at = EXCLUDED.reviewed_at,
  updated_at = EXCLUDED.updated_at;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-1788867608718-1',
  'rep-1788868003406',
  1,
  'سراجی',
  'سراج فروشی',
  '۱',
  '09154324567',
  'شهرک سراجیان',
  'ریزش مداوم نیروی انسانی و تعارضات درون‌سازمانی',
  '*',
  NULL,
  NULL,
  '+',
  NULL,
  NULL,
  '✓',
  NULL,
  NULL,
  '-',
  NULL,
  NULL,
  'مخشو زدم بلاخره',
  'شنبلیله فروشی',
  '',
  '2026-09-08T11:46:43.406Z',
  '2026-09-09T09:34:35.123Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.daily_reports (id, consultant_id, consultant_name, consultant_code, branch, date_shamsi, day_of_week_shamsi, submitted_at, guild, personal_opinion, manager_feedback, manager_rating, status, reviewed_at, created_at, updated_at)
VALUES (
  'rep-c104-today',
  'user-c104',
  'ندا کریمی',
  'C-104',
  'دفتر مرکزی کارینو',
  '1405/06/11',
  'چهارشنبه',
  '۱۵:۳۶',
  'ساختمانی، انبوه‌سازی و تأسیسات',
  'شرکت‌های پیمانکاری بیشترین حجم احضاریه‌های هیئت‌های تشخیص را دارند.',
  'حله پس',
  5,
  'approved',
  '2026-09-08T12:11:08.180Z',
  '2026-09-02T11:34:11.215Z',
  '2026-09-08T12:11:08.180Z'
)
ON CONFLICT (id) DO UPDATE SET
  status = EXCLUDED.status,
  manager_feedback = EXCLUDED.manager_feedback,
  manager_rating = EXCLUDED.manager_rating,
  reviewed_at = EXCLUDED.reviewed_at,
  updated_at = EXCLUDED.updated_at;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c104-1',
  'rep-c104-today',
  1,
  'کارفرما ابراهیمی (شرکت ابنیه عمران گستر)',
  'پیمانکاری پروژه‌های مسکونی و تجاری',
  '115',
  '05138447788',
  'مشهد، بلوار فلسطین، تقاطع خیام',
  'دعاوی و شکایات در اداره کار و هیئت‌های تشخیص/حل اختلاف',
  '+',
  NULL,
  NULL,
  '+',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  'حله دادا',
  'مشاوره دفاعیات پرونده‌های مطروحه در هیئت‌های حل اختلاف',
  'پیگیری معوق؛ تماس دوم باید فوری انجام شود.',
  '2026-09-02T11:34:11.215Z',
  '2026-09-08T12:11:08.180Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.daily_reports (id, consultant_id, consultant_name, consultant_code, branch, date_shamsi, day_of_week_shamsi, submitted_at, guild, personal_opinion, manager_feedback, manager_rating, status, reviewed_at, created_at, updated_at)
VALUES (
  'rep-seed-3',
  'user-c102',
  'مریم محمدی',
  'C-102',
  'دفتر مرکزی کارینو',
  '1405/06/16',
  'دوشنبه',
  '۱۵:۲۵',
  'صنایع غذایی و بسته‌بندی',
  'صنایع غذایی به دلیل شیفت‌های گردشی و سختی کار، ریسک بسیار بالایی در پرونده‌های بازنشستگی پیش‌ازموعد دارند.',
  'نکات درج شده در خصوص شرکت فرآورده‌های لبنی کوهستان فوق‌العاده است. پشتیبانی کامل حقوقی داده شود.',
  5,
  'approved',
  '2026-09-07T08:52:10.140Z',
  '2026-09-07T08:52:10.140Z',
  '2026-09-08T11:55:21.829Z'
)
ON CONFLICT (id) DO UPDATE SET
  status = EXCLUDED.status,
  manager_feedback = EXCLUDED.manager_feedback,
  manager_rating = EXCLUDED.manager_rating,
  reviewed_at = EXCLUDED.reviewed_at,
  updated_at = EXCLUDED.updated_at;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-seed-3-1',
  'rep-seed-3',
  1,
  'فرآورده‌های لبنی کوهستان مشهد',
  'تولید دوغ و ماست پاستوریزه',
  '92',
  '05135421100',
  'شهرک صنعتی چناران',
  'پرونده‌های سخت و زیان‌آور و بازنشستگی‌های زودرس پیش‌بینی نشده',
  '+',
  NULL,
  NULL,
  '✓',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '✓ (جلسه حضوری با مدیر اداری ست شد)',
  'تراز فیش حقوقی و بهینه‌سازی فرآیندهای بیمه تأمین اجتماعی',
  'مدیر اداری آقای رجبی بسیار پیگیر بودند؛ جلسه پنج‌شنبه ساعت ۱۱ صبح.',
  '2026-09-07T08:52:10.140Z',
  '2026-09-08T11:55:21.829Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-seed-3-2',
  'rep-seed-3',
  2,
  'صنایع بسته‌بندی ترنج سبز',
  'بسته‌بندی حبوبات و خشکبار صادراتی',
  '38',
  '05135413344',
  'شهرک صنعتی توس، فاز ۲',
  'فقدان آیین‌نامه انضباطی مصوب و رویه مشخص اخراج یا توبیخ',
  '+',
  NULL,
  NULL,
  '+',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  'در حال پیگیری',
  '',
  'مذاکره اولیه انجام شد؛ منتظر تماس مجدد در چرخه پیگیری هستند.',
  '2026-09-07T08:52:10.140Z',
  '2026-09-08T11:55:21.829Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-seed-3-3',
  'rep-seed-3',
  3,
  'تولیدی کیک و کلوچه پردیس',
  'شیرینی و بیسکویت صنعتی',
  '25',
  '05136517722',
  'شهرک صنعتی ماشین‌سازی',
  'چالش محاسبه اضافه کاری، شب‌کاری، نوبت‌کاری و تعطیل‌کاری',
  '.',
  NULL,
  NULL,
  '.',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  'شاپسیان',
  '',
  'مدیرعامل در جلسه بازرسی استاندارد بود.',
  '2026-09-07T08:52:10.140Z',
  '2026-09-08T11:55:21.829Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.daily_reports (id, consultant_id, consultant_name, consultant_code, branch, date_shamsi, day_of_week_shamsi, submitted_at, guild, personal_opinion, manager_feedback, manager_rating, status, reviewed_at, created_at, updated_at)
VALUES (
  'rep-c102-overdue',
  'user-c102',
  'مریم محمدی',
  'C-102',
  'دفتر مرکزی کارینو',
  '1405/06/11',
  'چهارشنبه',
  '۱۵:۱۴',
  'صنایع غذایی و کشاورزی',
  'صنایع غذایی ریسک بسیار بالایی در پرونده‌های بازنشستگی پیش‌ازموعد دارند.',
  'پشتیبانی کامل حقوقی داده شود.',
  4,
  'approved',
  '2026-09-02T11:34:11.215Z',
  '2026-09-02T11:34:11.215Z',
  '2026-09-08T11:52:51.515Z'
)
ON CONFLICT (id) DO UPDATE SET
  status = EXCLUDED.status,
  manager_feedback = EXCLUDED.manager_feedback,
  manager_rating = EXCLUDED.manager_rating,
  reviewed_at = EXCLUDED.reviewed_at,
  updated_at = EXCLUDED.updated_at;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c102-overdue-1',
  'rep-c102-overdue',
  1,
  'کارفرما کاظمی (صنایع بسته‌بندی ترنج سبز)',
  'بسته‌بندی حبوبات و خشکبار صادراتی',
  '38',
  '05135413344',
  'شهرک صنعتی توس، فاز ۲',
  'فقدان آیین‌نامه انضباطی مصوب و رویه مشخص اخراج یا توبیخ',
  '+',
  NULL,
  NULL,
  '*',
  NULL,
  NULL,
  '✓',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  'جوالدوز',
  'تنظیم آیین‌نامه انضباطی مصوب و الحاقیه‌های محرمانگی',
  'نیازمند تماس فوری پیگیری دوم (۲ روز معوق).',
  '2026-09-02T11:34:11.215Z',
  '2026-09-08T11:52:51.515Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.daily_reports (id, consultant_id, consultant_name, consultant_code, branch, date_shamsi, day_of_week_shamsi, submitted_at, guild, personal_opinion, manager_feedback, manager_rating, status, reviewed_at, created_at, updated_at)
VALUES (
  'rep-seed-2',
  'user-c102',
  'مریم محمدی',
  'C-102',
  'دفتر مرکزی کارینو',
  '1405/06/17',
  'سه‌شنبه',
  '۱۳:۱۵',
  'فناوری اطلاعات و تجارت الکترونیک',
  'شرکت‌های نرم‌افزاری به شدت نگران حفظ محرمانگی کدها و ترک ناگهانی برنامه‌نویسان ارشد هستند.',
  'آفرین مریم',
  5,
  'approved',
  '2026-09-08T11:43:25.885Z',
  '2026-09-08T08:52:10.140Z',
  '2026-09-08T11:43:25.885Z'
)
ON CONFLICT (id) DO UPDATE SET
  status = EXCLUDED.status,
  manager_feedback = EXCLUDED.manager_feedback,
  manager_rating = EXCLUDED.manager_rating,
  reviewed_at = EXCLUDED.reviewed_at,
  updated_at = EXCLUDED.updated_at;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-seed-2-1',
  'rep-seed-2',
  1,
  'شرکت دانش‌بنیان داده‌پردازان عصر نوین',
  'توسعه نرم‌افزارهای سازمانی و هوش مصنوعی',
  '36',
  '05138479900',
  'بلوار سجاد، خیابان بهار',
  'ترک کار ناگهانی پرسنل کلیدی و بردن اطلاعات/اسرار تجاری',
  '+',
  NULL,
  NULL,
  '+',
  NULL,
  NULL,
  '✓',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '✓ (جلسه آنلاین با هم‌بنیان‌گذار ست شد)',
  'تنظیم آیین‌نامه انضباطی مصوب و الحاقیه‌های محرمانگی',
  'جلسه تخصصی گوگل میت چهارشنبه ساعت ۱۴:۳۰ ست شد.',
  '2026-09-08T08:52:10.140Z',
  '2026-09-08T11:43:25.885Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-seed-2-2',
  'rep-seed-2',
  2,
  'پلتفرم خدمات ابری رایان‌سرویس',
  'ارائه زیرساخت و سرور ابری',
  '24',
  '05137614455',
  'بلوار دستغیب، مجتمع تک',
  'ریسک‌های مالیاتی و حسابداری مرتبط با حقوق و دستمزد',
  '+',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  'در حال پیگیری',
  '',
  'مدیر مالی شرکت استقبال کرد؛ مستندات مقایسه‌ای مالیات حقوق ارسال شد.',
  '2026-09-08T08:52:10.140Z',
  '2026-09-08T11:43:25.885Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-seed-2-3',
  'rep-seed-2',
  3,
  'آژانس دیجیتال مارکتینگ صبا',
  'سئو و تبلیغات دیجیتال',
  '16',
  '05138435566',
  'احمدآباد، خیابان عدالت',
  'ابهام در فرمول‌های پورسانت، پاداش و تارگت‌های فروش',
  '+',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  'در حال پیگیری',
  '',
  'درخواست راهنمایی در خصوص فرمول پورسانت پلکانی کارشناسان فروش.',
  '2026-09-08T08:52:10.140Z',
  '2026-09-08T11:43:25.885Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.daily_reports (id, consultant_id, consultant_name, consultant_code, branch, date_shamsi, day_of_week_shamsi, submitted_at, guild, personal_opinion, manager_feedback, manager_rating, status, reviewed_at, created_at, updated_at)
VALUES (
  'rep-seed-4',
  'user-c103',
  'سعید حسینی',
  'C-103',
  'دفتر مرکزی کارینو',
  '1405/06/13',
  'جمعه',
  '۱۳:۴۳',
  'بازرگانی و پخش مویرگی',
  'شرکت‌های پخش به دلیل مبالغ سنگین ضمانت‌نامه‌های ویزیتورها و رانندگان، دغدغه فوری تنظیم سفته و قرارداد ضمانت دارند.',
  'تو شنبلیله ای',
  4,
  'approved',
  '2026-09-08T11:41:45.450Z',
  '2026-09-04T08:52:10.140Z',
  '2026-09-11T10:13:41.416Z'
)
ON CONFLICT (id) DO UPDATE SET
  status = EXCLUDED.status,
  manager_feedback = EXCLUDED.manager_feedback,
  manager_rating = EXCLUDED.manager_rating,
  reviewed_at = EXCLUDED.reviewed_at,
  updated_at = EXCLUDED.updated_at;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-seed-4-1',
  'rep-seed-4',
  1,
  'شرکت بازرگانی پخش مویرگی کیان',
  'پخش سراسری مواد شوینده و بهداشتی',
  '65',
  '02188991122',
  'تهران، خیابان مطهری، پلاک ۱۱۴',
  'چالش‌های توزیع مویرگی، وصول مطالبات و کسری انبار',
  '+',
  NULL,
  '1405/06/13',
  '*',
  NULL,
  '1405/06/13',
  '-',
  NULL,
  '1405/06/13',
  '-',
  NULL,
  '1405/06/13',
  'کوفته',
  '',
  'امروز دقیقاً موعد تماس دوم در چرخه ۴ روزه است و سیستم آلارم پیگیری صادر کرده است.',
  '2026-09-04T08:52:10.140Z',
  '2026-09-11T10:13:41.416Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-seed-4-2',
  'rep-seed-4',
  2,
  'توزیع و پخش دارویی رازیان سلامت',
  'پخش اقلام دارویی و مکمل‌ها',
  '42',
  '02166554433',
  'تهران، خیابان آزادی، نبش شادمان',
  'عدم شفافیت قراردادهای کار، الحاقیه‌ها و تضامین پرسنلی',
  '+',
  NULL,
  '1405/06/13',
  '-',
  NULL,
  '1405/06/13',
  '-',
  NULL,
  '1405/06/13',
  '+',
  NULL,
  '1405/06/13',
  'شاپسین',
  '',
  'موعد تماس دوم فرارسیده؛ مدیر منابع انسانی تمایل به دریافت نمونه قرارداد امانی دارد.',
  '2026-09-04T08:52:10.140Z',
  '2026-09-11T10:13:41.416Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-seed-4-3',
  'rep-seed-4',
  3,
  'شرکت لجستیک سپهر ترابر',
  'خدمات انبارداری و ارسال مرسولات',
  '28',
  '02155443322',
  'تهران، جاده مخصوص کرج، کیلومتر ۱۱',
  'حوادث ناشی از کار، مسئولیت‌های مدنی و دیه کارفرمایی',
  '.',
  NULL,
  '1405/06/13',
  '+',
  NULL,
  '1405/06/13',
  '✓',
  '2026-09-11T10:13:41.415Z',
  '1405/06/20',
  '',
  NULL,
  NULL,
  'جلسه ردیف شد',
  '',
  'در چرخه پیگیری قرار دارد.',
  '2026-09-04T08:52:10.140Z',
  '2026-09-11T10:13:41.416Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.daily_reports (id, consultant_id, consultant_name, consultant_code, branch, date_shamsi, day_of_week_shamsi, submitted_at, guild, personal_opinion, manager_feedback, manager_rating, status, reviewed_at, created_at, updated_at)
VALUES (
  'rep-c103-today',
  'user-c103',
  'سعید حسینی',
  'C-103',
  'دفتر مرکزی کارینو',
  '1405/06/13',
  'جمعه',
  '۱۳:۵۰',
  'بازرگانی و پخش مویرگی',
  'شرکت‌های پخش دغدغه فوری تنظیم سفته و قرارداد ضمانت دارند.',
  'تمرک',
  2,
  'approved',
  '2026-09-08T11:38:23.061Z',
  '2026-09-04T11:34:11.215Z',
  '2026-09-11T10:20:25.644Z'
)
ON CONFLICT (id) DO UPDATE SET
  status = EXCLUDED.status,
  manager_feedback = EXCLUDED.manager_feedback,
  manager_rating = EXCLUDED.manager_rating,
  reviewed_at = EXCLUDED.reviewed_at,
  updated_at = EXCLUDED.updated_at;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c103-1',
  'rep-c103-today',
  1,
  'کارفرما شجاعی (شرکت بازرگانی پخش مویرگی کیان)',
  'پخش سراسری مواد شوینده و بهداشتی',
  '65',
  '02188991122',
  'تهران، خیابان مطهری، پلاک ۱۱۴',
  'چالش‌های توزیع مویرگی، وصول مطالبات و کسری انبار',
  '+',
  NULL,
  '1405/06/13',
  '.',
  NULL,
  '1405/06/13',
  '-',
  NULL,
  '1405/06/13',
  '✓',
  '2026-09-11T10:20:25.644Z',
  '1405/06/20',
  'جلسه دقیق رزرو شد و پول داد',
  'آنالیز ریسک حقوقی قراردادها و پیشگیری از شکایات اداره کار',
  'امروز موعد تماس دوم است.',
  '2026-09-04T11:34:11.215Z',
  '2026-09-11T10:20:25.644Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.daily_reports (id, consultant_id, consultant_name, consultant_code, branch, date_shamsi, day_of_week_shamsi, submitted_at, guild, personal_opinion, manager_feedback, manager_rating, status, reviewed_at, created_at, updated_at)
VALUES (
  'rep-seed-1',
  'user-c101',
  'علیرضا رضایی',
  'C-101',
  'دفتر مرکزی کارینو',
  '1405/06/17',
  'سه‌شنبه',
  '۱۴:۳۰',
  'تولیدی قطعات خودرو و ریخته‌گری',
  'به دلیل افزایش نظارت و بازرسی‌های تأمین اجتماعی، کارفرمایان این صنف استقبال چشمگیری از خدمات بازبینی قراردادها و تراز مالی دارند.',
  'عملکرد بسیار عالی در برقراری ارتباط با صنایع ریخته‌گری توس فولاد. جلسه حضوری هماهنگ شود.',
  5,
  'approved',
  '2026-09-08T08:52:10.140Z',
  '2026-09-08T08:52:10.140Z',
  '2026-09-08T08:52:10.147Z'
)
ON CONFLICT (id) DO UPDATE SET
  status = EXCLUDED.status,
  manager_feedback = EXCLUDED.manager_feedback,
  manager_rating = EXCLUDED.manager_rating,
  reviewed_at = EXCLUDED.reviewed_at,
  updated_at = EXCLUDED.updated_at;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-seed-1-1',
  'rep-seed-1',
  1,
  'صنایع ریخته‌گری توس فولاد',
  'تولید قطعات چدنی خودرو',
  '48',
  '05138401122',
  'شهرک صنعتی توس، فاز ۱، تلاش جنوبی',
  'دعاوی و شکایات در اداره کار و هیئت‌های تشخیص/حل اختلاف',
  '+',
  NULL,
  NULL,
  '+',
  NULL,
  NULL,
  '✓',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '✓ (جلسه حضوری ست شد)',
  'آنالیز ریسک حقوقی قراردادها و پیشگیری از شکایات اداره کار',
  'جلسه با مهندس صادقی (مدیرعامل) دوشنبه ساعت ۱۰:۰۰ در محل کارخانه تنظیم شد.',
  '2026-09-08T08:52:10.140Z',
  '2026-09-08T08:52:10.147Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-seed-1-2',
  'rep-seed-1',
  2,
  'صنعتی پارت سازان خاور',
  'ماشین‌کاری قطعات حساس',
  '22',
  '05135412233',
  'شهرک صنعتی فناوری‌های برتر',
  'عدم شفافیت قراردادهای کار، الحاقیه‌ها و تضامین پرسنلی',
  '+',
  NULL,
  NULL,
  '+',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  'در حال پیگیری',
  '',
  'تماس دوم انجام شد؛ پیش‌نویس چک‌لیست حقوقی ارسال گردید، منتظر بررسی هیئت‌مدیره هستند.',
  '2026-09-08T08:52:10.140Z',
  '2026-09-08T08:52:10.147Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-seed-1-3',
  'rep-seed-1',
  3,
  'کارگاه تراشکاری نوین صنعت',
  'تراشکاری قطعات برنجی',
  '14',
  '05132456677',
  'بزرگراه آسیایی، آزادی ۱۲۵',
  'جرایم بازرسی و مغایرت‌های حق بیمه تأمین اجتماعی',
  '.',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  'در حال پیگیری',
  '',
  'مدیر کارگاه در خط تولید بود؛ تماس مجدد در نوبت عصر هماهنگ خواهد شد.',
  '2026-09-08T08:52:10.140Z',
  '2026-09-08T08:52:10.147Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-seed-1-4',
  'rep-seed-1',
  4,
  'قالب‌سازی دقیق البرز',
  'طراحی قالب‌های سنبه ماتریس',
  '9',
  '05136518899',
  'شهرک صنعتی کلات',
  'افت شدید بهره‌وری و نبود نظام ارزیابی عملکرد (KPI)',
  '-',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '- (اعلام عدم نیاز فعلی)',
  '',
  'کارفرما عنوان کرد فعلاً به دلیل نوسانات بازار برنامه اصلاح ساختار ندارند.',
  '2026-09-08T08:52:10.140Z',
  '2026-09-08T08:52:10.147Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-seed-1-5',
  'rep-seed-1',
  5,
  'ریخته‌گری آلومینیوم خاوران',
  'ریخته‌گری تحت فشار دایکست',
  '30',
  '05138810011',
  'جاده قدیم نیشابور',
  'عدم تطابق فیش حقوقی، مزایای قانونی و تراز مالی با پرداختی واقعی',
  '*',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '* (شماره کارخانه تغییر یافته است)',
  '',
  'خط قطع بود؛ نیاز به اصلاح شماره در پایگاه داده داده‌کاوی.',
  '2026-09-08T08:52:10.140Z',
  '2026-09-08T08:52:10.147Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.daily_reports (id, consultant_id, consultant_name, consultant_code, branch, date_shamsi, day_of_week_shamsi, submitted_at, guild, personal_opinion, manager_feedback, manager_rating, status, reviewed_at, created_at, updated_at)
VALUES (
  'rep-seed-5',
  'user-c104',
  'ندا کریمی',
  'C-104',
  'دفتر مرکزی کارینو',
  '1405/06/10',
  'سه‌شنبه',
  '۱۴:۱۳',
  'ساختمانی، انبوه‌سازی و تأسیسات',
  'شرکت‌های پیمانکاری ساختمانی',
  'آفرین ',
  5,
  'approved',
  '2026-09-08T10:44:52.908Z',
  '2026-09-01T08:52:10.140Z',
  '2026-09-08T10:44:52.908Z'
)
ON CONFLICT (id) DO UPDATE SET
  status = EXCLUDED.status,
  manager_feedback = EXCLUDED.manager_feedback,
  manager_rating = EXCLUDED.manager_rating,
  reviewed_at = EXCLUDED.reviewed_at,
  updated_at = EXCLUDED.updated_at;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-seed-5-1',
  'rep-seed-5',
  1,
  'شرکت ساختمانی و ابنیه عمران گستر پارس',
  'پیمانکاری پروژه‌های مسکونی و تجاری',
  '115',
  '05138447788',
  'مشهد، بلوار فلسطین، تقاطع خیام',
  'دعاوی و شکایات در اداره کار و هیئت‌های تشخیص/حل اختلاف',
  '+',
  NULL,
  NULL,
  '✓',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  'جلسه در حال ست',
  'محرمانگی',
  'بیش از ۶ روز از تماس اول گذشته؛ نیازمند تماس فوری پیگیری دوم (معوق).',
  '2026-09-01T08:52:10.140Z',
  '2026-09-08T10:44:52.908Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-seed-5-2',
  'rep-seed-5',
  2,
  'تأسیسات سرمایش و گرمایش آریا سازه',
  'اجرای موتورخانه و تأسیسات برج‌ها',
  '29',
  '05137682211',
  'مشهد، بلوار پیروزی، نبش پیروزی ۳۴',
  'حوادث ناشی از کار، مسئولیت‌های مدنی و دیه کارفرمایی',
  '+',
  NULL,
  NULL,
  '✓',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  'جلسه تیک',
  '',
  'پیگیری معوق؛ در انتظار تماس بعدی.',
  '2026-09-01T08:52:10.140Z',
  '2026-09-08T10:44:52.908Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-seed-5-3',
  'rep-seed-5',
  3,
  'تولیدی سازه‌های بتنی پایدار',
  'تیرچه، بلوک و قطعات پیش‌ساخته بتنی',
  '18',
  '05132459900',
  'جاده سیمان، کیلومتر ۴',
  'عدم رعایت دوره‌های آزمایشی و بلاتکلیفی حقوقی قراردادهای موقت',
  '-',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '- (عدم تمایل به تغییر رویه فعلی)',
  '',
  'تماس اولیه منفی بود و خاتمه یافت.',
  '2026-09-01T08:52:10.140Z',
  '2026-09-08T10:44:52.908Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.daily_reports (id, consultant_id, consultant_name, consultant_code, branch, date_shamsi, day_of_week_shamsi, submitted_at, guild, personal_opinion, manager_feedback, manager_rating, status, reviewed_at, created_at, updated_at)
VALUES (
  'rep-c101-today-due-4d',
  'user-c101',
  'علیرضا رضایی',
  'C-101',
  'دفتر مرکزی کارینو',
  '1405/06/17',
  'سه‌شنبه',
  '۱۱:۴۰',
  'صنعتی و مهندسی دقیق',
  'استقبال مدیرعامل در جلسه نخست امیدوارکننده بود.',
  '',
  NULL,
  'submitted',
  NULL,
  '2026-09-08T12:22:40.435Z',
  '2026-09-08T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  status = EXCLUDED.status,
  manager_feedback = EXCLUDED.manager_feedback,
  manager_rating = EXCLUDED.manager_rating,
  reviewed_at = EXCLUDED.reviewed_at,
  updated_at = EXCLUDED.updated_at;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c101-hosseini-client',
  'rep-c101-today-due-4d',
  1,
  'کارفرما حسینی (صنعتی پارت سازان خاور)',
  'ماشین‌کاری قطعات حساس موتور',
  '22',
  '05135412233',
  'شهرک صنعتی فناوری‌های برتر',
  'ریسک‌های مالیاتی و حسابداری مرتبط با حقوق و دستمزد',
  '+',
  NULL,
  '1405/06/17',
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  'در حال پیگیری',
  'عارضه‌یابی منابع انسانی و طراحی نظام پاداش و ارزیابی عملکرد',
  'امروز دقیقاً موعد تماس دوم (روز چهارم) است.',
  '2026-09-08T12:22:40.435Z',
  '2026-09-08T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.daily_reports (id, consultant_id, consultant_name, consultant_code, branch, date_shamsi, day_of_week_shamsi, submitted_at, guild, personal_opinion, manager_feedback, manager_rating, status, reviewed_at, created_at, updated_at)
VALUES (
  'rep-c101-overdue-6d',
  'user-c101',
  'علیرضا رضایی',
  'C-101',
  'دفتر مرکزی کارینو',
  '1405/06/15',
  'یکشنبه',
  '۱۶:۱۵',
  'ماشین‌سازی و قطعه‌سازی خودرو',
  'کارفرمایان این گروه به دلیل چالش تضامین و قراردادهای کارگری نیازمند پیگیری منظم هستند.',
  'پرونده کارفرما احمدی را سریعاً تماس گرفته و تعیین تکلیف نمایید.',
  4,
  'approved',
  '2026-09-06T12:22:40.435Z',
  '2026-09-06T12:22:40.435Z',
  '2026-09-06T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  status = EXCLUDED.status,
  manager_feedback = EXCLUDED.manager_feedback,
  manager_rating = EXCLUDED.manager_rating,
  reviewed_at = EXCLUDED.reviewed_at,
  updated_at = EXCLUDED.updated_at;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c101-ahmadi',
  'rep-c101-overdue-6d',
  1,
  'کارفرما احمدی (گروه صنعتی پارت گستر)',
  'تولید قطعات پرسی بدنه خودرو',
  '35',
  '05138491122',
  'شهرک صنعتی توس، تلاش شمالی ۶',
  'عدم شفافیت قراردادهای کار، الحاقیه‌ها و تضامین پرسنلی',
  '+',
  NULL,
  '1405/06/15',
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  'در حال پیگیری',
  'تنظیم آیین‌نامه انضباطی مصوب و الحاقیه‌های محرمانگی',
  'در تماس اول بسیار مشتاق بودند؛ قرار شد بعد از ۴ روز برای ارسال پیش‌نویس تماس گرفته شود.',
  '2026-09-06T12:22:40.435Z',
  '2026-09-06T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.daily_reports (id, consultant_id, consultant_name, consultant_code, branch, date_shamsi, day_of_week_shamsi, submitted_at, guild, personal_opinion, manager_feedback, manager_rating, status, reviewed_at, created_at, updated_at)
VALUES (
  'rep-c101-today-due-8d',
  'user-c101',
  'علیرضا رضایی',
  'C-101',
  'دفتر مرکزی کارینو',
  '1405/06/13',
  'جمعه',
  '۱۷:۲۰',
  'تولید تجهیزات بالابری و صنعتی',
  'نیاز جدی به استقرار نظام ایمنی و مسئولیت مدنی کارفرما دارند.',
  'این پرونده شانس بالایی برای تبدیل به قرارداد سالانه دارد.',
  5,
  'approved',
  '2026-09-04T12:22:40.435Z',
  '2026-09-04T12:22:40.435Z',
  '2026-09-04T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  status = EXCLUDED.status,
  manager_feedback = EXCLUDED.manager_feedback,
  manager_rating = EXCLUDED.manager_rating,
  reviewed_at = EXCLUDED.reviewed_at,
  updated_at = EXCLUDED.updated_at;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c101-nouri-client',
  'rep-c101-today-due-8d',
  1,
  'کارفرما نوری (تولیدی قطعات آسانسور پارس نوری)',
  'تولید درب و کابین آسانسور',
  '31',
  '05136514455',
  'شهرک صنعتی کلات، خیابان تلاش ۳',
  'حوادث ناشی از کار، مسئولیت‌های مدنی و دیه کارفرمایی',
  '+',
  '2026-09-04T12:22:40.435Z',
  '1405/06/13',
  '+',
  '2026-09-08T12:22:40.435Z',
  '1405/06/17',
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  'در حال پیگیری',
  'آنالیز ریسک حقوقی قراردادها و پیشگیری از شکایات اداره کار',
  'پیگیری ۱ و ۲ با موفقیت انجام شده؛ امروز موعد تماس سوم برای ست کردن جلسه است.',
  '2026-09-04T12:22:40.435Z',
  '2026-09-04T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.daily_reports (id, consultant_id, consultant_name, consultant_code, branch, date_shamsi, day_of_week_shamsi, submitted_at, guild, personal_opinion, manager_feedback, manager_rating, status, reviewed_at, created_at, updated_at)
VALUES (
  'rep-c101-overdue-9d',
  'user-c101',
  'علیرضا رضایی',
  'C-101',
  'دفتر مرکزی کارینو',
  '1405/06/12',
  'پنج‌شنبه',
  '۱۵:۰۰',
  'صنایع چاپ و بسته‌بندی صادراتی',
  'چاپخانه‌ها با مسائل بیمه تأمین اجتماعی کارگران شیفت شب درگیرند.',
  'پیگیری سوم کارفرما رضایی برای نهایی‌سازی قرارداد مشاوره بسیار حساس است.',
  5,
  'approved',
  '2026-09-03T12:22:40.435Z',
  '2026-09-03T12:22:40.435Z',
  '2026-09-03T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  status = EXCLUDED.status,
  manager_feedback = EXCLUDED.manager_feedback,
  manager_rating = EXCLUDED.manager_rating,
  reviewed_at = EXCLUDED.reviewed_at,
  updated_at = EXCLUDED.updated_at;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c101-rezaei-client',
  'rep-c101-overdue-9d',
  1,
  'کارفرما رضایی (صنایع بسته‌بندی آرین نگین)',
  'تولید جعبه‌های دارویی و صادراتی',
  '52',
  '05135429988',
  'شهرک صنعتی فناوری‌های برتر، صنعت ۴',
  'چالش محاسبه اضافه کاری، شب‌کاری، نوبت‌کاری و تعطیل‌کاری',
  '+',
  '2026-09-03T12:22:40.435Z',
  '1405/06/12',
  '+',
  '2026-09-07T12:22:40.435Z',
  '1405/06/16',
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  'در حال پیگیری',
  'تراز فیش حقوقی و بهینه‌سازی فرآیندهای بیمه تأمین اجتماعی',
  'تماس دوم عالی بود؛ پیش‌فاکتور ارسال شده و برای نهایی‌سازی نیاز به پیگیری ۳ دارد.',
  '2026-09-03T12:22:40.435Z',
  '2026-09-03T12:22:40.435Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.daily_reports (id, consultant_id, consultant_name, consultant_code, branch, date_shamsi, day_of_week_shamsi, submitted_at, guild, personal_opinion, manager_feedback, manager_rating, status, reviewed_at, created_at, updated_at)
VALUES (
  'rep-1789044925942',
  'user-1788870728032',
  'علی زارع',
  '110',
  'دفتر مرکزی کارینو',
  '1405/06/19',
  'پنج‌شنبه',
  '۱۶:۲۵',
  'اصناف فلزی',
  'شامبالیسکی',
  'شامبالیسکی بخریم پس',
  4,
  'approved',
  '2026-09-10T13:00:25.165Z',
  '2026-09-10T12:55:25.943Z',
  '2026-09-10T13:00:25.165Z'
)
ON CONFLICT (id) DO UPDATE SET
  status = EXCLUDED.status,
  manager_feedback = EXCLUDED.manager_feedback,
  manager_rating = EXCLUDED.manager_rating,
  reviewed_at = EXCLUDED.reviewed_at,
  updated_at = EXCLUDED.updated_at;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-1789044816398-1',
  'rep-1789044925942',
  1,
  'دکتر شامبالیسکی',
  'شامبالیسکی فروش',
  '2',
  '09152252525',
  'شهرک شامبالیسکی',
  'سایر دغدغه‌ها (نیاز به عارضه‌یابی تخصصی و مشاوره حضوری)',
  '*',
  NULL,
  NULL,
  '+',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  'راضیش کردم شامبالیسکی بده بهمون',
  'شامبالیسکی ها',
  '',
  '2026-09-10T12:55:25.943Z',
  '2026-09-10T13:00:25.165Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c110-today-1',
  'rep-1789044925942',
  2,
  'صنایع نساجی و رنگرزی حریر توس',
  'بافت و رنگرزی پارچه‌های صنعتی و لباسی',
  '75',
  '05135419988',
  'شهرک صنعتی چرمشهر، خیابان نسترن',
  'بازنشستگی پیش از موعد در مشاغل سخت و زیان‌آور',
  '+',
  NULL,
  '1405/06/11',
  '+',
  NULL,
  '1405/06/15',
  '✓',
  NULL,
  '1405/06/19',
  '',
  NULL,
  NULL,
  '✓ (جلسه حضوری هماهنگ شد)',
  'مهندسی کاهش آلاینده‌های سالن بافندگی جهت لغو عناوین زیان‌آور تامین اجتماعی',
  'جلسه دوشنبه ساعت ۱۰:۳۰ با مدیر کارخانه در چرمشهر هماهنگ شد.',
  '2026-09-10T12:55:25.943Z',
  '2026-09-10T13:00:25.165Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c110-today-2',
  'rep-1789044925942',
  3,
  'تولیدی پوشاک صنعتی و بیمارستانی ایمن‌ساز',
  'دوخت لباس کار ضد برش و روپوش پزشکی',
  '38',
  '05137286655',
  'مشهد، میدان ابوطالب، اول هدایت',
  'فقدان آیین‌نامه انضباطی مصوب و رویه مشخص اخراج یا توبیخ',
  '+',
  NULL,
  '1405/06/15',
  '+',
  NULL,
  '1405/06/19',
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '+ (ارسال پیش‌نویس آیین‌نامه)',
  'مراحل ثبت و اخذ تاییدیه آیین‌نامه انضباطی از اداره کار مشهد',
  'کارفرما تایید کردند پس از مطالعه با ما تماس می‌گیرند.',
  '2026-09-10T12:55:25.943Z',
  '2026-09-10T13:00:25.165Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c110-today-3',
  'rep-1789044925942',
  4,
  'چرم مصنوعی و کفی کفش صبا',
  'تولید لایه‌های پلی‌یورتان و چرم مصنوعی',
  '24',
  '05136517744',
  'شهرک صنعتی توس، فاز ۱',
  'ابهامات قانونی در اضافه‌کاری، نوبت‌کاری و شیفت‌های شبانه',
  '.',
  NULL,
  '1405/06/19',
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '. (وقت جلسه فردا تعیین شد)',
  '',
  'مدیر اداری قول تماس فردا دادند.',
  '2026-09-10T12:55:25.943Z',
  '2026-09-10T13:00:25.165Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.report_rows (id, report_id, row_number, client_name, activity_field, personnel_count, phone, address, employer_concern, follow_up_1, follow_up_1_date, follow_up_1_date_shamsi, follow_up_2, follow_up_2_date, follow_up_2_date_shamsi, follow_up_3, follow_up_3_date, follow_up_3_date_shamsi, follow_up_4, follow_up_4_date, follow_up_4_date_shamsi, follow_up_result, meeting_topic, notes, created_at, updated_at)
VALUES (
  'row-c110-today-4',
  'rep-1789044925942',
  5,
  'کارگاه تولید ملزومات ایمنی رادین',
  'تولید دستکش صنعتی و گوشی محافظ',
  '16',
  '05138459900',
  'بلوار خرمشهر، کوشش ۱۰',
  'عدم توازن در حقوق، پاداش و ارزیابی عادلانه عملکرد',
  '-',
  NULL,
  '1405/06/19',
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '',
  NULL,
  NULL,
  '- (تمایل به همکاری نشان ندادند)',
  '',
  'پاسخ منفی قطعی دادند.',
  '2026-09-10T12:55:25.943Z',
  '2026-09-10T13:00:25.165Z'
)
ON CONFLICT (id) DO UPDATE SET
  client_name = EXCLUDED.client_name,
  phone = EXCLUDED.phone,
  follow_up_result = EXCLUDED.follow_up_result,
  notes = EXCLUDED.notes;

INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  'per-C-103-daily-14050621',
  'user-c103',
  'سعید حسینی',
  'C-103',
  'daily',
  '1405/06/21',
  '',
  '۱۷:۲۱',
  'گزارش روزانه شنبه ۲۱ شهریور',
  'karino2026',
  'karino2026',
  'karino2026',
  'karino2026',
  2,
  NULL,
  'pending',
  NULL
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;

INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  'per-110-daily-14050621',
  'user-1788870728032',
  'علی زارع',
  '110',
  'daily',
  '1405/06/21',
  '',
  '۱۷:۰۱',
  'گزارش روزانه شنبه ۲۱ شهریور',
  'شنبلیله 12',
  'شنبلیله 12',
  'شنبلیله 12',
  'شنبلیله 12',
  5,
  NULL,
  'pending',
  NULL
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;

INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  'per-C-103-weekly-14050619',
  'user-c103',
  'سعید حسینی',
  'C-103',
  'weekly',
  '1405/06/19',
  '',
  '۱۷:۱۹',
  'گزارش هفتگی هفته سوم شهریور پنج‌شنبه ۱۹ شهریور',
  'بد',
  'بد',
  'بد',
  'بد',
  1,
  'افتضاح',
  'warned',
  '2026-09-10T13:56:08.213Z'
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;

INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  'per-c101-daily-today',
  'user-c101',
  'علیرضا رضایی',
  'C-101',
  'daily',
  '1405/06/21',
  '',
  '۱۸:۵۹',
  'گزارش روزانه شنبه ۲۱ شهریور',
  'انجام ۷ تماس هدفمند با مدیران کارخانجات شهرک صنعتی طوس. استقبال صنایع دارویی و شیمیایی از خدمات حسابرسی بیمه بالا بود.',
  'تنظیم پیش‌نویس توافق با شرکت پارت‌سازان و ست شدن جلسه حضوری شنبه ساعت ۱۰ با مدیر مالی.',
  'برخی کارفرمایان خواستار نمونه قراردادهای استاندارد محرمانگی بودند که نیاز به فرم‌های حقوقی تکمیلی دارد.',
  'پیگیری مرحله سوم کارفرما رضایی و ارسال تاییدیه جلسه به کارفرما حسینی.',
  5,
  'عملکرد عالی و پیگیری‌های منضبط؛ جلسه حضوری شنبه پیگیری شود.',
  'approved',
  '2026-09-12T12:22:40.438Z'
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;

INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  'per-c102-daily-today',
  'user-c102',
  'سارا علیزاده',
  'C-102',
  'daily',
  '1405/06/21',
  '',
  '۱۷:۰۵',
  'گزارش روزانه شنبه ۲۱ شهریور',
  'مذاکره با ۵ مدیر ارشد هلدینگ‌های غذایی و دارویی در خصوص دعاوی ماده ۱۴۸ قانون کار و بازنشستگی پیش‌ازموعد.',
  'جلب نظر مساعد مدیر منابع انسانی شرکت بهنام‌شهد و هماهنگی جلسه معارفه.',
  'عدم حضور مستقیم تصمیم‌گیرنده نهایی در برخی کارخانجات و لزوم پیگیری از طریق سرپرستان.',
  'ارسال مدارک حقوقی کارینو و برقراری تماس دوم در چرخه ۴ روزه.',
  4,
  NULL,
  'pending',
  NULL
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;

INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  'per-c104-daily-today',
  'user-c104',
  'ندا کریمی',
  'C-104',
  'daily',
  '1405/06/21',
  '',
  '۱۶:۰۰',
  'گزارش روزانه شنبه ۲۱ شهریور',
  'تماس با ۶ شرکت نرم‌افزاری و شتاب‌دهنده پارک علم و فناوری خراسان. دغدغه اصلی قراردادهای عدم افشا (NDA) و تضامین پرسنلی است.',
  'هماهنگی جلسه آنلاین برای دوشنبه با شتاب‌دهنده پرشین و بررسی پکیج قراردادهای استارتاپی.',
  'نبود مدل تعرفه ساعتی مشخص برای استارتاپ‌های کوچک.',
  'آماده‌سازی پیش‌نویس پکیج ویژه دانش‌بنیان‌ها.',
  5,
  NULL,
  'approved',
  NULL
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;

INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  'per-c101-daily-yesterday',
  'user-c101',
  'علیرضا رضایی',
  'C-101',
  'daily',
  '1405/06/20',
  '',
  '۱۷:۱۰',
  'گزارش روزانه جمعه ۲۰ شهریور',
  'تمرکز بر پرونده‌های معوق و حل چالش‌های کارفرمایان چاپ و بسته‌بندی در خصوص جرایم تأمین اجتماعی.',
  'حل شبهات کارفرما عباسی درباره سفته حسن انجام کار و ارجاع پرونده به وکیل مجموعه.',
  'مشغله شدید مدیران عامل قبل از ظهر؛ زمان بهینه تماس‌ها به بعد از ساعت ۱۴ منتقل شد.',
  'شروع مذاکرات با صنف قطعات خودرو.',
  4,
  NULL,
  'approved',
  NULL
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;

INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  'per-c103-daily-yesterday',
  'user-c103',
  'علی اکبری',
  'C-103',
  'daily',
  '1405/06/18',
  '',
  '۱۹:۴۵',
  'گزارش روزانه چهارشنبه ۱۸ شهریور',
  'برقراری تماس با شرکت‌های پخش و توزیع در مشهد و حومه.',
  'ارسال معرفی‌نامه به ۲ شرکت پخش مواد شوینده.',
  'عدم هماهنگی به موقع با مسئول دفتر مدیران.',
  'تماس با صنف قطعه‌سازان خودرو.',
  3,
  'ارسال گزارش با تاخیر غیرموجه؛ دقت شود گزارشات روزانه حداکثر تا ساعت ۱۸ ارسال گردد.',
  'warned',
  NULL
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;

INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  'per-c101-weekly-last',
  'user-c101',
  'علیرضا رضایی',
  'C-101',
  'weekly',
  '1405/06/12',
  '',
  '۱۸:۰۰',
  'گزارش هفتگی هفته دوم شهریور پنج‌شنبه ۱۲ شهریور',
  'مجموع ۳۴ تماس موثر، ۴ جلسه ست‌شده و یک قرارداد قطعی با ارزش ۵۵ میلیون تومان در حوزه دعاوی کارگری.',
  'عقد قرارداد با شرکت تولیدی توس و جذب ۳ مشتری جدید در شهرک ماشین‌سازی.',
  'رقابت با شرکت‌های سنتی حسابداری که مشاوره‌های نادرست به کارفرمایان ارائه می‌دهند.',
  'نهایی‌سازی ۲ قرارداد جاری و تمرکز ویژه بر خدمات پیشگیرانه بازرسی اداره کار.',
  5,
  'بهترین عملکرد هفته در تیم مشاوره. پاداش انضباط و تحقق اهداف منظور شد.',
  'rewarded',
  NULL
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;

INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  'per-c102-weekly-last',
  'user-c102',
  'سارا علیزاده',
  'C-102',
  'weekly',
  '1405/06/12',
  '',
  '۱۶:۳۰',
  'گزارش هفتگی هفته دوم شهریور پنج‌شنبه ۱۲ شهریور',
  'انجام ۲۹ تماس اولیه، ۸ پیگیری مرحله دوم و ۴ پیگیری مرحله سوم در صنف چاپ و صنایع غذایی.',
  '۲ جلسه مشاوره حضوری برگزار شد و پیش‌نویس توافق‌نامه ایمنی کار ارسال گردید.',
  'عدم پاسخگویی کارفرمایان در روز چهارشنبه به دلیل سفر.',
  'تمرکز بر بستن قرارداد پرونده شرکت آرد خوشه طوس.',
  4,
  'گزارش دقیق و مستند؛ پیگیری پرونده آرد خوشه در اولویت قرار گیرد.',
  'approved',
  NULL
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;

INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  'per-c104-weekly-last',
  'user-c104',
  'ندا کریمی',
  'C-104',
  'weekly',
  '1405/06/12',
  '',
  '۱۷:۴۰',
  'گزارش هفتگی هفته دوم شهریور پنج‌شنبه ۱۲ شهریور',
  'تمرکز صددرصدی بر شرکت‌های فناور و پارک علم و فناوری. جذب ۲ پرونده تنظیم آیین‌نامه انضباطی کارگاهی.',
  'عقد قرارداد با شرکت راهکارهای ابری پایا به مبلغ ۶۰ میلیون تومان.',
  NULL,
  NULL,
  5,
  'ورود به بازار دانش‌بنیان بسیار هوشمندانه و با بازدهی عالی بود. تبریک.',
  'rewarded',
  NULL
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;

INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  'per-c101-monthly-mordad',
  'user-c101',
  'علیرضا رضایی',
  'C-101',
  'monthly',
  '1405/05/31',
  '',
  '۱۸:۴۵',
  'گزارش ماهانه مرداد ۱۴۰۵',
  'تحقق ۱۰۸ درصدی تارگت ماهانه با ثبت ۱۲۸ تماس و عقد ۴ قرارداد جامع سالانه بازبینی قراردادهای کار.',
  'رشد ۴۰ درصدی تعامل با صنف ریخته‌گری و ارتقای رضایت مراجعین به ۴.۹ از ۵.',
  'نیاز به کاتالوگ‌های اختصاصی‌تر برای صنایع با بیش از ۵۰ پرسنل.',
  NULL,
  5,
  'الگوی انضباط گزارش‌دهی و تعهد تیمی. مشمول پاداش ویژه ماهانه.',
  'rewarded',
  NULL
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;

INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  'per-c102-monthly-mordad',
  'user-c102',
  'سارا علیزاده',
  'C-102',
  'monthly',
  '1405/05/31',
  '',
  '۱۸:۱۵',
  'گزارش ماهانه مرداد ۱۴۰۵',
  'پوشش ۸۵ کارفرما در طول ماه با ثبت ۳ قرارداد نهایی و نرخ تبدیل ۱۲ درصدی.',
  'ورود موفق به صنف کارخانجات آرد و غلات شرق کشور.',
  NULL,
  NULL,
  4,
  NULL,
  'approved',
  NULL
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;

INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  'per-c103-monthly-mordad',
  'user-c103',
  'علی اکبری',
  'C-103',
  'monthly',
  '1405/05/31',
  '',
  '۲۱:۰۰',
  'گزارش ماهانه مرداد ۱۴۰۵',
  'مجموع تماس‌ها زیر سقف انتظار بود ولی در هفته پایانی جبران شد.',
  'عقد یک قرارداد مشاوره در صنف عمده‌فروشان ابزار.',
  NULL,
  NULL,
  3,
  'نیاز به افزایش نظم در ثبت مراحل پیگیری و تعهد به ساعات کاری.',
  'warned',
  NULL
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;

INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  'per-c101-monthly-shahrivar',
  'user-c101',
  'علیرضا رضایی',
  'C-101',
  'monthly',
  '1405/06/19',
  '',
  '۲۰:۱۵',
  'گزارش ماهانه شهریور ۱۴۰۵',
  'پیشرفت ۷۸ درصدی تارگت‌های ماهانه تا نیمه دوم شهریور؛ انجام ۸۶ تماس و ۹ جلسه هماهنگ شده.',
  'انعقاد تفاهم‌نامه اولیه با شهرک صنعتی توس برای ارائه خدمات مشاوره‌ای به واحدهای منتخب.',
  'کمبود زمان کارفرمایان در روزهای پایانی تابستان جهت جلسات حضوری.',
  'تمرکز بر بستن قراردادهای معوق تا ۳۱ شهریور ماه.',
  5,
  'پیش‌بینی عملکرد عالی برای پایان شهریور.',
  'approved',
  NULL
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;

INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  'per-c104-weekly-14050619',
  'user-c104',
  'ندا کریمی',
  'C-104',
  'weekly',
  '1405/06/19',
  '',
  '۱۹:۱۵',
  'گزارش هفتگی هفته سوم شهریور پنج‌شنبه ۱۹ شهریور',
  'تماس با ۲۲ شرکت پیمانکاری ساختمانی. ۳ جلسه در کارگاه پروژه‌ها و بررسی ۲ احضاریه هیئت حل اختلاف اداره کار.',
  'موفقیت در جلب رضایت کارفرمای پروژه ابنیه سازه پارس جهت بررسی تمامی قراردادهای اکیپ‌های اجرایی.',
  'عدم ثبت حضور و غیاب پرسنل در کارگاه‌های عمرانی که ریسک دعاوی را بالا برده است.',
  'ارائه سیستم ثبت حضور و غیاب ابری و فرم‌های تحویل کار به پیمانکاران جزء.',
  4,
  'عملکرد مناسب؛ روی بیمه مسئولیت مدنی کارگاهی تمرکز بیشتری شود.',
  'approved',
  NULL
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;

INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  'per-c103-weekly-14050619',
  'user-c103',
  'سعید حسینی',
  'C-103',
  'weekly',
  '1405/06/19',
  '',
  '۱۹:۰۰',
  'گزارش هفتگی هفته سوم شهریور پنج‌شنبه ۱۹ شهریور',
  'برقراری ۲۵ تماس با ناوگان پخش مویرگی در سطح تهران و مشهد. ایجاد ۲ جلسه حضوری و ۲ جلسه ویدیوکنفرانس تخصصی.',
  'طراحی سناریوی مذاکره ویژه سفته ویزیتورها و جذب اعتماد مدیران پخش مواد غذایی.',
  'تعدد شرکای تجاری در برخی شرکت‌های پخش که تصمیم‌گیری را زمان‌بر می‌کند.',
  'پیگیری قرارداد با پخش سراسری ماهان و انعقاد توافقنامه سه جانبه.',
  5,
  'رویکرد خلاقانه در مذاکره با شرکت‌های پخش تهران قابل تقدیر است.',
  'approved',
  NULL
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;

INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  'per-c102-weekly-14050619',
  'user-c102',
  'مریم محمدی',
  'C-102',
  'weekly',
  '1405/06/19',
  '',
  '۱۸:۴۵',
  'گزارش هفتگی هفته سوم شهریور پنج‌شنبه ۱۹ شهریور',
  'برقراری ۲۸ تماس در حوزه صنایع غذایی و فرآورده‌های دامی. ۴ جلسه حضوری قطعی و ۲ درخواست ممیزی ساختار دریافت شد.',
  'ورود موفق به ۳ کارخانه بزرگ صنایع آرد و لبنیات و دریافت مدارک مالی جهت دفاعیه نوبت‌کاری.',
  'همپوشانی زمان استراحت شیفت‌ها با ساعات تماس که با تنظیم جدول ساعات تماس رفع شد.',
  'تدوین پروپوزال جامع آیین‌نامه انضباطی برای شرکت‌های بالای ۵۰ نفر پرسنل غذایی.',
  5,
  'پیشرفت عالی و انضباط کامل در پیگیری‌ها.',
  'approved',
  NULL
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;

INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  'per-c101-weekly-14050619',
  'user-c101',
  'علیرضا رضایی',
  'C-101',
  'weekly',
  '1405/06/19',
  '',
  '۱۸:۳۰',
  'گزارش هفتگی هفته سوم شهریور پنج‌شنبه ۱۹ شهریور',
  'طی این هفته مجموعاً ۳۴ تماس کارفرمایی با نرخ تماس موثر ۷۶ درصد برقرار شد. ۵ جلسه حضوری با مدیران صنایع فلزی و خودرویی هماهنگ گردید.',
  'عقد قرارداد مشاوره بازبینی احکام با صنایع فولاد توس و ست شدن جلسات حیاتی با ۲ واحد قطعه‌ساز مطرح استان.',
  'نیاز مبرم کارفرمایان به فرم‌های استاندارد سفته و الحاقیه عدم افشای اسرار تجاری.',
  'تمرکز بر کارخانجات فاز ۲ و ۳ شهرک توس و پیگیری مرحله دوم ۶ تماس موثر هفتگی.',
  5,
  'رتبه برتر هفته؛ پاداش عملکرد و ثبت بالاترین نرخ تبدیل جلسات حضوری به ایشان تعلق گرفت.',
  'rewarded',
  NULL
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;

INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  'per-c110-daily-today',
  'user-1788870728032',
  'علی زارع',
  '110',
  'daily',
  '1405/06/19',
  '',
  '۱۸:۱۰',
  'گزارش روزانه پنج‌شنبه ۱۹ شهریور',
  'پیگیری ۴ کارخانه نساجی در شهرک چرمشهر و توس. هماهنگی جلسه در کارخانه نساجی حریر توس.',
  'تنظیم جلسه حضوری برای بررسی ۴ درصد مشاغل سخت و زیان‌آور.',
  'پیچیدگی پرونده‌های سخت و زیان‌آور با بیش از ۱۰ سال سابقه در تامین اجتماعی.',
  'جمع‌آوری مستندات کمیته استانی سخت و زیان‌آور جهت جلسه دوشنبه.',
  4,
  'آفرین قشنگم',
  'rewarded',
  '2026-09-11T10:37:50.140Z'
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;

INSERT INTO public.periodic_reports (id, consultant_id, consultant_name, consultant_code, period_type, date_shamsi, day_of_week_shamsi, submitted_at, period_label, summary, key_achievements, challenges_or_barriers, plans_or_priorities, self_rating, manager_feedback, manager_status, reviewed_at)
VALUES (
  'per-c103-daily-today',
  'user-c103',
  'سعید حسینی',
  'C-103',
  'daily',
  '1405/06/19',
  '',
  '۱۷:۴۰',
  'گزارش روزانه پنج‌شنبه ۱۹ شهریور',
  'پیگیری ۵ مجموعه توزیع و پخش سراسری در تهران و مشهد. تنظیم یک جلسه حضوری با پخش ماهان و یک جلسه آنلاین با رایا سلامت.',
  'ورود به زنجیره شرکت‌های پخش تندمصرف و استقبال از ساختار حقوقی سفته ویزیتورها.',
  'مسافت دفاتر مرکزی شرکت‌های تهران نیاز به جلسات آنلاین تصویری با کیفیت بالا دارد.',
  'تنظیم سناریوی دفاعیه آنلاین جلسه سه‌شنبه پخش رایا سلامت.',
  5,
  'تمرکز روی پکیج سفته ویزیتورها فرصت کم‌نظیری است؛ پیگیری جدی شود.',
  'approved',
  NULL
)
ON CONFLICT (id) DO UPDATE SET manager_status = EXCLUDED.manager_status, manager_feedback = EXCLUDED.manager_feedback;

INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  'arch-periodic_daily-14050621',
  'تحلیلی_روزانه_1405-06-21.xlsx',
  '1405/06/21',
  'شنبه',
  '2026-09-12T13:59:26.991Z',
  'periodic_daily',
  'تحلیلی روزانه عملکرد مشاورین',
  5,
  0,
  '[]'::jsonb,
  '[]'::jsonb,
  '[{"id":"per-c101-daily-today","consultantId":"user-c101","consultantName":"علیرضا رضایی","consultantCode":"C-101","periodType":"daily","dateShamsi":"1405/06/21","periodLabel":"گزارش روزانه شنبه ۲۱ شهریور","summary":"انجام ۷ تماس هدفمند با مدیران کارخانجات شهرک صنعتی طوس. استقبال صنایع دارویی و شیمیایی از خدمات حسابرسی بیمه بالا بود.","keyAchievements":"تنظیم پیش‌نویس توافق با شرکت پارت‌سازان و ست شدن جلسه حضوری شنبه ساعت ۱۰ با مدیر مالی.","challengesOrBarriers":"برخی کارفرمایان خواستار نمونه قراردادهای استاندارد محرمانگی بودند که نیاز به فرم‌های حقوقی تکمیلی دارد.","plansOrPriorities":"پیگیری مرحله سوم کارفرما رضایی و ارسال تاییدیه جلسه به کارفرما حسینی.","selfRating":5,"submittedAt":"۱۸:۵۹","createdAt":"2026-09-12T12:22:40.438Z","managerStatus":"approved","managerFeedback":"عملکرد عالی و پیگیری‌های منضبط؛ جلسه حضوری شنبه پیگیری شود.","managerRating":5,"managerReviewedAt":"2026-09-12T12:22:40.438Z"},{"id":"per-C-103-daily-14050621","consultantId":"user-c103","consultantName":"سعید حسینی","consultantCode":"C-103","periodType":"daily","dateShamsi":"1405/06/21","periodLabel":"گزارش روزانه شنبه ۲۱ شهریور","summary":"karino2026","keyAchievements":"karino2026","challengesOrBarriers":"karino2026","plansOrPriorities":"karino2026","hasSetMeeting":false,"autoFollowUpEnabled":true,"selfRating":2,"submittedAt":"۱۷:۲۱","createdAt":"2026-09-12T13:51:20.418Z","managerStatus":"pending","updatedAt":"2026-09-12T13:51:20.420Z"},{"id":"per-c102-daily-today","consultantId":"user-c102","consultantName":"سارا علیزاده","consultantCode":"C-102","periodType":"daily","dateShamsi":"1405/06/21","periodLabel":"گزارش روزانه شنبه ۲۱ شهریور","summary":"مذاکره با ۵ مدیر ارشد هلدینگ‌های غذایی و دارویی در خصوص دعاوی ماده ۱۴۸ قانون کار و بازنشستگی پیش‌ازموعد.","keyAchievements":"جلب نظر مساعد مدیر منابع انسانی شرکت بهنام‌شهد و هماهنگی جلسه معارفه.","challengesOrBarriers":"عدم حضور مستقیم تصمیم‌گیرنده نهایی در برخی کارخانجات و لزوم پیگیری از طریق سرپرستان.","plansOrPriorities":"ارسال مدارک حقوقی کارینو و برقراری تماس دوم در چرخه ۴ روزه.","selfRating":4,"submittedAt":"۱۷:۰۵","createdAt":"2026-09-12T11:22:40.438Z","managerStatus":"pending"},{"id":"per-110-daily-14050621","consultantId":"user-1788870728032","consultantName":"علی زارع","consultantCode":"110","periodType":"daily","dateShamsi":"1405/06/21","periodLabel":"گزارش روزانه شنبه ۲۱ شهریور","summary":"شنبلیله 12","keyAchievements":"شنبلیله 12","challengesOrBarriers":"شنبلیله 12","plansOrPriorities":"شنبلیله 12","hasSetMeeting":false,"autoFollowUpEnabled":true,"selfRating":5,"submittedAt":"۱۷:۰۱","createdAt":"2026-09-12T13:31:03.614Z","managerStatus":"pending","updatedAt":"2026-09-12T13:31:03.616Z"},{"id":"per-c104-daily-today","consultantId":"user-c104","consultantName":"ندا کریمی","consultantCode":"C-104","periodType":"daily","dateShamsi":"1405/06/21","periodLabel":"گزارش روزانه شنبه ۲۱ شهریور","summary":"تماس با ۶ شرکت نرم‌افزاری و شتاب‌دهنده پارک علم و فناوری خراسان. دغدغه اصلی قراردادهای عدم افشا (NDA) و تضامین پرسنلی است.","keyAchievements":"هماهنگی جلسه آنلاین برای دوشنبه با شتاب‌دهنده پرشین و بررسی پکیج قراردادهای استارتاپی.","challengesOrBarriers":"نبود مدل تعرفه ساعتی مشخص برای استارتاپ‌های کوچک.","plansOrPriorities":"آماده‌سازی پیش‌نویس پکیج ویژه دانش‌بنیان‌ها.","selfRating":5,"submittedAt":"۱۶:۰۰","createdAt":"2026-09-12T10:22:40.438Z","managerStatus":"approved","managerRating":5}]'::jsonb,
  true
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  'arch-calls-14050621',
  'تماس‌های_روزانه_1405-06-21.xlsx',
  '1405/06/21',
  'شنبه',
  '2026-09-12T12:22:40.452Z',
  'calls_daily',
  'بایگانی روزانه تماس‌ها و پیگیری‌ها',
  2,
  4,
  '[{"name":"دعاوی و شکایات در اداره کار و هیئت‌های تشخیص/حل اختلاف","count":1},{"name":"جرایم بازرسی و مغایرت‌های حق بیمه تأمین اجتماعی","count":1},{"name":"افت شدید بهره‌وری و نبود نظام ارزیابی عملکرد (KPI)","count":1},{"name":"ترک کار ناگهانی پرسنل کلیدی و بردن اطلاعات/اسرار تجاری","count":1}]'::jsonb,
  '[{"id":"rep-c101-today","consultantId":"user-c101","consultantName":"علیرضا رضایی","consultantCode":"C-101","dateShamsi":"1405/06/21","dayOfWeekShamsi":"شنبه","guild":"تولیدی قطعات خودرو و ریخته‌گری","status":"approved","managerFeedback":"عملکرد بسیار عالی در برقراری ارتباط با صنایع ریخته‌گری توس فولاد. جلسه حضوری به خوبی هماهنگ شد.","managerRating":5,"reviewedAt":"2026-09-12T12:22:40.435Z","updatedAt":"2026-09-12T12:22:40.435Z","createdAt":"2026-09-12T12:22:40.435Z","submittedAt":"۱۴:۳۰","personalOpinion":"به دلیل افزایش نظارت و بازرسی‌های تأمین اجتماعی، کارفرمایان این صنف استقبال چشمگیری از خدمات بازبینی قراردادها و تراز مالی دارند.","rows":[{"id":"row-c101-today-1","rowNumber":1,"clientName":"صنایع ریخته‌گری توس فولاد","activityField":"تولید قطعات چدنی خودرو","personnelCount":48,"phone":"05138401122","address":"شهرک صنعتی توس، فاز ۱، تلاش جنوبی","employerConcern":"دعاوی و شکایات در اداره کار و هیئت‌های تشخیص/حل اختلاف","followUp1":"+","followUp2":"+","followUp3":"✓","followUp4":"","followUpResult":"✓ (جلسه حضوری ست شد)","meetingTopic":"آنالیز ریسک حقوقی قراردادها و پیشگیری از شکایات اداره کار","notes":"جلسه با مهندس صادقی (مدیرعامل) دوشنبه ساعت ۱۰:۰۰ در محل کارخانه تنظیم شد.","followUp1DateShamsi":"1405/06/21","followUp2DateShamsi":"1405/06/21","followUp3DateShamsi":"1405/06/21"},{"id":"row-c101-today-2","rowNumber":2,"clientName":"کارگاه تراشکاری نوین صنعت","activityField":"تراشکاری قطعات برنجی","personnelCount":14,"phone":"05132456677","address":"بزرگراه آسیایی، آزادی ۱۲۵","employerConcern":"جرایم بازرسی و مغایرت‌های حق بیمه تأمین اجتماعی","followUp1":".","followUp2":"","followUp3":"","followUp4":"","followUpResult":"","meetingTopic":"","notes":"مدیر کارگاه در خط تولید بود؛ تماس مجدد هماهنگ خواهد شد.","followUp1DateShamsi":"1405/06/21"},{"id":"row-c101-today-3","rowNumber":3,"clientName":"قالب‌سازی دقیق البرز","activityField":"طراحی قالب‌های سنبه ماتریس","personnelCount":9,"phone":"05136518899","address":"شهرک صنعتی کلات","employerConcern":"افت شدید بهره‌وری و نبود نظام ارزیابی عملکرد (KPI)","followUp1":"-","followUp2":"","followUp3":"","followUp4":"","followUpResult":"- (اعلام عدم نیاز فعلی)","meetingTopic":"","notes":"کارفرما عنوان کرد فعلاً برنامه اصلاح ساختار ندارند.","followUp1DateShamsi":"1405/06/21"}]},{"id":"rep-c102-today","consultantId":"user-c102","consultantName":"مریم محمدی","consultantCode":"C-102","dateShamsi":"1405/06/21","dayOfWeekShamsi":"شنبه","guild":"فناوری اطلاعات و تجارت الکترونیک","status":"approved","managerFeedback":"جلسه شرکت فرآورده‌های لبنی کوهستان رو با بسته پیشنهادی سطح ۲ هماهنگ فرمایید.","managerRating":5,"reviewedAt":"2026-09-12T12:22:40.435Z","updatedAt":"2026-09-12T12:22:40.435Z","createdAt":"2026-09-12T12:22:40.435Z","submittedAt":"۱۳:۱۵","personalOpinion":"شرکت‌های نرم‌افزاری به شدت نگران حفظ محرمانگی کدها و ترک ناگهانی برنامه‌نویسان ارشد هستند.","rows":[{"id":"row-c102-1","rowNumber":1,"clientName":"شرکت دانش‌بنیان داده‌پردازان عصر نوین","activityField":"توسعه نرم‌افزارهای سازمانی و هوش مصنوعی","personnelCount":36,"phone":"05138479900","address":"بلوار سجاد، خیابان بهار","employerConcern":"ترک کار ناگهانی پرسنل کلیدی و بردن اطلاعات/اسرار تجاری","followUp1":"+","followUp2":"+","followUp3":"✓","followUp4":"","followUpResult":"✓ (جلسه آنلاین با هم‌بنیان‌گذار ست شد)","meetingTopic":"تنظیم آیین‌نامه انضباطی مصوب و الحاقیه‌های محرمانگی","notes":"جلسه گوگل میت چهارشنبه ساعت ۱۴:۳۰ ست شد.","followUp1DateShamsi":"1405/06/21","followUp2DateShamsi":"1405/06/21","followUp3DateShamsi":"1405/06/21"}]}]'::jsonb,
  '[]'::jsonb,
  true
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  'arch-periodic_daily-14050620',
  'بایگانی_گزارشات_تحلیلی_روزانه_جمعه_1405-06-20.xlsx',
  '1405/06/20',
  'جمعه',
  '2026-09-11T07:46:44.018Z',
  'periodic_daily',
  'بایگانی روزانه گزارشات تحلیلی مشاورین',
  0,
  0,
  '[]'::jsonb,
  '[]'::jsonb,
  '[]'::jsonb,
  false
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  'arch-periodic_daily-14050619',
  'تحلیلی_روزانه_1405-06-19.xlsx',
  '1405/06/19',
  'پنج‌شنبه',
  '2026-09-10T14:10:57.813Z',
  'periodic_daily',
  'تحلیلی روزانه عملکرد مشاورین',
  5,
  0,
  '[]'::jsonb,
  '[]'::jsonb,
  '[{"id":"per-c110-daily-today","consultantId":"user-1788870728032","consultantName":"علی زارع","consultantCode":"110","periodType":"daily","dateShamsi":"1405/06/19","periodLabel":"گزارش روزانه پنج‌شنبه ۱۹ شهریور","summary":"پیگیری ۴ کارخانه نساجی در شهرک چرمشهر و توس. هماهنگی جلسه در کارخانه نساجی حریر توس.","keyAchievements":"تنظیم جلسه حضوری برای بررسی ۴ درصد مشاغل سخت و زیان‌آور.","challengesOrBarriers":"پیچیدگی پرونده‌های سخت و زیان‌آور با بیش از ۱۰ سال سابقه در تامین اجتماعی.","plansOrPriorities":"جمع‌آوری مستندات کمیته استانی سخت و زیان‌آور جهت جلسه دوشنبه.","selfRating":4,"managerStatus":"approved","managerRating":4,"managerFeedback":"خوب؛ مستندات آلاینده‌سنجی کارخانه قبل از جلسه مطالعه شود.","submittedAt":"۱۸:۱۰"},{"id":"per-c103-daily-today","consultantId":"user-c103","consultantName":"سعید حسینی","consultantCode":"C-103","periodType":"daily","dateShamsi":"1405/06/19","periodLabel":"گزارش روزانه پنج‌شنبه ۱۹ شهریور","summary":"پیگیری ۵ مجموعه توزیع و پخش سراسری در تهران و مشهد. تنظیم یک جلسه حضوری با پخش ماهان و یک جلسه آنلاین با رایا سلامت.","keyAchievements":"ورود به زنجیره شرکت‌های پخش تندمصرف و استقبال از ساختار حقوقی سفته ویزیتورها.","challengesOrBarriers":"مسافت دفاتر مرکزی شرکت‌های تهران نیاز به جلسات آنلاین تصویری با کیفیت بالا دارد.","plansOrPriorities":"تنظیم سناریوی دفاعیه آنلاین جلسه سه‌شنبه پخش رایا سلامت.","selfRating":5,"managerStatus":"approved","managerRating":5,"managerFeedback":"تمرکز روی پکیج سفته ویزیتورها فرصت کم‌نظیری است؛ پیگیری جدی شود.","submittedAt":"۱۷:۴۰"},{"id":"per-c101-daily-today","consultantId":"user-c101","consultantName":"علیرضا رضایی","consultantCode":"C-101","periodType":"daily","dateShamsi":"1405/06/19","periodLabel":"گزارش روزانه پنج‌شنبه ۱۹ شهریور","summary":"برقراری ۸ تماس هدفمند با کارخانجات قطعه‌سازی و ریخته‌گری شهرک توس. تنظیم ۲ جلسه حضوری با صنایع ریخته‌گری توس فولاد و پترو فرایند پایا.","keyAchievements":"هماهنگی ۲ جلسه حضوری تایید شده با مدیران عامل و ارسال پروپوزال رسمی به ۳ شرکت.","challengesOrBarriers":"پرونده‌های ضرایب پیمانکاری تامین اجتماعی به دلیل تغییر رویه شعب مشهد نیازمند ترازنامه مالی دقیق است.","plansOrPriorities":"پیگیری جلسه روز دوشنبه کارخانه توس فولاد و هماهنگی با تیم حسابرسی بیمه کارینو.","selfRating":5,"managerStatus":"approved","managerRating":5,"managerFeedback":"عملکرد درخشان و انضباط کامل در گزارش‌دهی؛ جلسات ست شده پیگیری شود.","submittedAt":"۱۶:۴۵"},{"id":"per-c102-daily-today","consultantId":"user-c102","consultantName":"مریم محمدی","consultantCode":"C-102","periodType":"daily","dateShamsi":"1405/06/19","periodLabel":"گزارش روزانه پنج‌شنبه ۱۹ شهریور","summary":"انجام ۶ تماس متمرکز در صنف صنایع غذایی و بسته‌بندی. موفقیت در تعیین جلسه حضوری با کارخانجات آرد خوشه طوس و تبرک شرق.","keyAchievements":"۲ جلسه حضوری قطعی و دریافت موافقت اولیه شرکت لبنی کوهستان توس برای سیستم سنجش انگیزش.","challengesOrBarriers":"برخی کارخانجات درخواست استعلام نمونه قراردادهای محرمانگی و عدم رقابت را داشتند.","plansOrPriorities":"آماده‌سازی پکیج دفاعیات شیفت شبانه برای جلسه آرد خوشه طوس.","selfRating":5,"managerStatus":"approved","managerRating":5,"managerFeedback":"بسیار خوب. تمرکز روی صنایع بزرگ غذایی استان نتیجه‌بخش بوده است.","submittedAt":"۱۷:۰۵"},{"id":"per-c104-daily-today","consultantId":"user-c104","consultantName":"ندا کریمی","consultantCode":"C-104","periodType":"daily","dateShamsi":"1405/06/19","periodLabel":"گزارش روزانه پنج‌شنبه ۱۹ شهریور","summary":"ارتباط با ۴ شرکت انبوه‌سازی و مهندسی پروژه. قطعی شدن جلسه با ابنیه سازه پارس و بتن آماده هیراد.","keyAchievements":"ست شدن ۲ جلسه حضوری در محل کارگاه پروژه‌های بزرگ ساختمانی.","challengesOrBarriers":"کارفرمایان ساختمانی دغدغه حوادث کارگاهی و مسئولیت کیفری در مراجع قضایی دارند.","plansOrPriorities":"هماهنگی با مشاور ایمنی و HSE کارینو برای شرکت در جلسه پروژه ابنیه سازه پارس.","selfRating":4,"managerStatus":"approved","managerRating":5,"managerFeedback":"حضور مشاور ایمنی در جلسه تصویب شد؛ هماهنگی کامل انجام گیرد.","submittedAt":"۱۷:۵۵"}]'::jsonb,
  false
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  'arch-calls-14050619',
  'تماس‌های_روزانه_1405-06-19.xlsx',
  '1405/06/19',
  'پنج‌شنبه',
  '2026-09-12T14:07:21.473Z',
  'calls_daily',
  'بایگانی روزانه تماس‌ها و پیگیری‌ها',
  1,
  5,
  '[{"name":"سایر دغدغه‌ها (نیاز به عارضه‌یابی تخصصی و مشاوره حضوری)","count":1},{"name":"بازنشستگی پیش از موعد در مشاغل سخت و زیان‌آور","count":1},{"name":"فقدان آیین‌نامه انضباطی مصوب و رویه مشخص اخراج یا توبیخ","count":1},{"name":"ابهامات قانونی در اضافه‌کاری، نوبت‌کاری و شیفت‌های شبانه","count":1},{"name":"عدم توازن در حقوق، پاداش و ارزیابی عادلانه عملکرد","count":1}]'::jsonb,
  '[{"id":"rep-1789044925942","rows":[{"id":"row-1789044816398-1","notes":"","phone":"09152252525","address":"شهرک شامبالیسکی","followUp1":"*","followUp2":"+","followUp3":"","followUp4":"","rowNumber":1,"clientName":"دکتر شامبالیسکی","meetingTopic":"شامبالیسکی ها","activityField":"شامبالیسکی فروش","followUpResult":"راضیش کردم شامبالیسکی بده بهمون","personnelCount":"2","employerConcern":"سایر دغدغه‌ها (نیاز به عارضه‌یابی تخصصی و مشاوره حضوری)"},{"id":"row-c110-today-1","notes":"جلسه دوشنبه ساعت ۱۰:۳۰ با مدیر کارخانه در چرمشهر هماهنگ شد.","phone":"05135419988","address":"شهرک صنعتی چرمشهر، خیابان نسترن","followUp1":"+","followUp2":"+","followUp3":"✓","followUp4":"","rowNumber":1,"clientName":"صنایع نساجی و رنگرزی حریر توس","meetingTopic":"مهندسی کاهش آلاینده‌های سالن بافندگی جهت لغو عناوین زیان‌آور تامین اجتماعی","activityField":"بافت و رنگرزی پارچه‌های صنعتی و لباسی","followUpResult":"✓ (جلسه حضوری هماهنگ شد)","personnelCount":75,"employerConcern":"بازنشستگی پیش از موعد در مشاغل سخت و زیان‌آور","followUp1DateShamsi":"1405/06/11","followUp2DateShamsi":"1405/06/15","followUp3DateShamsi":"1405/06/19"},{"id":"row-c110-today-2","notes":"کارفرما تایید کردند پس از مطالعه با ما تماس می‌گیرند.","phone":"05137286655","address":"مشهد، میدان ابوطالب، اول هدایت","followUp1":"+","followUp2":"+","followUp3":"","followUp4":"","rowNumber":2,"clientName":"تولیدی پوشاک صنعتی و بیمارستانی ایمن‌ساز","meetingTopic":"مراحل ثبت و اخذ تاییدیه آیین‌نامه انضباطی از اداره کار مشهد","activityField":"دوخت لباس کار ضد برش و روپوش پزشکی","followUpResult":"+ (ارسال پیش‌نویس آیین‌نامه)","personnelCount":38,"employerConcern":"فقدان آیین‌نامه انضباطی مصوب و رویه مشخص اخراج یا توبیخ","followUp1DateShamsi":"1405/06/15","followUp2DateShamsi":"1405/06/19"},{"id":"row-c110-today-3","notes":"مدیر اداری قول تماس فردا دادند.","phone":"05136517744","address":"شهرک صنعتی توس، فاز ۱","followUp1":".","followUp2":"","followUp3":"","followUp4":"","rowNumber":3,"clientName":"چرم مصنوعی و کفی کفش صبا","meetingTopic":"","activityField":"تولید لایه‌های پلی‌یورتان و چرم مصنوعی","followUpResult":". (وقت جلسه فردا تعیین شد)","personnelCount":24,"employerConcern":"ابهامات قانونی در اضافه‌کاری، نوبت‌کاری و شیفت‌های شبانه","followUp1DateShamsi":"1405/06/19"},{"id":"row-c110-today-4","notes":"پاسخ منفی قطعی دادند.","phone":"05138459900","address":"بلوار خرمشهر، کوشش ۱۰","followUp1":"-","followUp2":"","followUp3":"","followUp4":"","rowNumber":4,"clientName":"کارگاه تولید ملزومات ایمنی رادین","meetingTopic":"","activityField":"تولید دستکش صنعتی و گوشی محافظ","followUpResult":"- (تمایل به همکاری نشان ندادند)","personnelCount":16,"employerConcern":"عدم توازن در حقوق، پاداش و ارزیابی عادلانه عملکرد","followUp1DateShamsi":"1405/06/19"}],"guild":"اصناف فلزی","status":"approved","createdAt":"2026-09-10T12:55:25.943Z","updatedAt":"2026-09-10T13:00:25.165Z","dateShamsi":"1405/06/19","reviewedAt":"2026-09-10T13:00:25.165Z","submittedAt":"۱۶:۲۵","consultantId":"user-1788870728032","managerRating":4,"consultantCode":"110","consultantName":"علی زارع","dayOfWeekShamsi":"پنج‌شنبه","managerFeedback":"شامبالیسکی بخریم پس","personalOpinion":"شامبالیسکی"}]'::jsonb,
  '[]'::jsonb,
  true
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  'arch-periodic_weekly-14050619',
  'تحلیلی_هفتگی_1405-06-19.xlsx',
  '1405/06/19',
  'پنج‌شنبه',
  '2026-09-10T14:10:57.813Z',
  'periodic_weekly',
  'تحلیلی هفتگی عملکرد مشاورین (پنج‌شنبه)',
  4,
  0,
  '[]'::jsonb,
  '[]'::jsonb,
  '[{"id":"per-c104-weekly-14050619","consultantId":"user-c104","consultantName":"ندا کریمی","consultantCode":"C-104","periodType":"weekly","dateShamsi":"1405/06/19","periodLabel":"گزارش تحلیلی هفتگی پنج‌شنبه ۱۹ شهریور ۱۴۰۵","summary":"تماس با ۲۲ شرکت پیمانکاری ساختمانی. ۳ جلسه در کارگاه پروژه‌ها و بررسی ۲ احضاریه هیئت حل اختلاف اداره کار.","keyAchievements":"موفقیت در جلب رضایت کارفرمای پروژه ابنیه سازه پارس جهت بررسی تمامی قراردادهای اکیپ‌های اجرایی.","challengesOrBarriers":"عدم ثبت حضور و غیاب پرسنل در کارگاه‌های عمرانی که ریسک دعاوی را بالا برده است.","plansOrPriorities":"ارائه سیستم ثبت حضور و غیاب ابری و فرم‌های تحویل کار به پیمانکاران جزء.","weeklyFocusGuilds":"انبوه‌سازی، پیمانکاری ابنیه و تأسیسات، قطعات بتنی پیش‌ساخته و راه و ترابری","selfRating":4,"managerStatus":"approved","managerRating":4,"managerFeedback":"عملکرد مناسب؛ روی بیمه مسئولیت مدنی کارگاهی تمرکز بیشتری شود.","submittedAt":"۱۹:۱۵"},{"id":"per-c103-weekly-14050619","consultantId":"user-c103","consultantName":"سعید حسینی","consultantCode":"C-103","periodType":"weekly","dateShamsi":"1405/06/19","periodLabel":"گزارش تحلیلی هفتگی پنج‌شنبه ۱۹ شهریور ۱۴۰۵","summary":"برقراری ۲۵ تماس با ناوگان پخش مویرگی در سطح تهران و مشهد. ایجاد ۲ جلسه حضوری و ۲ جلسه ویدیوکنفرانس تخصصی.","keyAchievements":"طراحی سناریوی مذاکره ویژه سفته ویزیتورها و جذب اعتماد مدیران پخش مواد غذایی.","challengesOrBarriers":"تعدد شرکای تجاری در برخی شرکت‌های پخش که تصمیم‌گیری را زمان‌بر می‌کند.","plansOrPriorities":"پیگیری قرارداد با پخش سراسری ماهان و انعقاد توافقنامه سه جانبه.","weeklyFocusGuilds":"پخش مویرگی دارویی، غذایی، آرایشی-بهداشتی و زنجیره‌های لجستیک کالا","selfRating":5,"managerStatus":"approved","managerRating":5,"managerFeedback":"رویکرد خلاقانه در مذاکره با شرکت‌های پخش تهران قابل تقدیر است.","submittedAt":"۱۹:۰۰"},{"id":"per-c102-weekly-14050619","consultantId":"user-c102","consultantName":"مریم محمدی","consultantCode":"C-102","periodType":"weekly","dateShamsi":"1405/06/19","periodLabel":"گزارش تحلیلی هفتگی پنج‌شنبه ۱۹ شهریور ۱۴۰۵","summary":"برقراری ۲۸ تماس در حوزه صنایع غذایی و فرآورده‌های دامی. ۴ جلسه حضوری قطعی و ۲ درخواست ممیزی ساختار دریافت شد.","keyAchievements":"ورود موفق به ۳ کارخانه بزرگ صنایع آرد و لبنیات و دریافت مدارک مالی جهت دفاعیه نوبت‌کاری.","challengesOrBarriers":"همپوشانی زمان استراحت شیفت‌ها با ساعات تماس که با تنظیم جدول ساعات تماس رفع شد.","plansOrPriorities":"تدوین پروپوزال جامع آیین‌نامه انضباطی برای شرکت‌های بالای ۵۰ نفر پرسنل غذایی.","weeklyFocusGuilds":"کارخانجات آرد، لبنیات، کنسرو، بسته‌بندی صادراتی و سردخانه‌های نگهداری","selfRating":5,"managerStatus":"approved","managerRating":5,"managerFeedback":"پیشرفت عالی و انضباط کامل در پیگیری‌ها.","submittedAt":"۱۸:۴۵"},{"id":"per-c101-weekly-14050619","consultantId":"user-c101","consultantName":"علیرضا رضایی","consultantCode":"C-101","periodType":"weekly","dateShamsi":"1405/06/19","periodLabel":"گزارش تحلیلی هفتگی پنج‌شنبه ۱۹ شهریور ۱۴۰۵","summary":"طی این هفته مجموعاً ۳۴ تماس کارفرمایی با نرخ تماس موثر ۷۶ درصد برقرار شد. ۵ جلسه حضوری با مدیران صنایع فلزی و خودرویی هماهنگ گردید.","keyAchievements":"عقد قرارداد مشاوره بازبینی احکام با صنایع فولاد توس و ست شدن جلسات حیاتی با ۲ واحد قطعه‌ساز مطرح استان.","challengesOrBarriers":"نیاز مبرم کارفرمایان به فرم‌های استاندارد سفته و الحاقیه عدم افشای اسرار تجاری.","plansOrPriorities":"تمرکز بر کارخانجات فاز ۲ و ۳ شهرک توس و پیگیری مرحله دوم ۶ تماس موثر هفتگی.","weeklyFocusGuilds":"صنایع ریخته‌گری، قطعه‌سازی خودرو، ماشین‌سازی و قالب‌سازی سنبه‌ماتریس","selfRating":5,"managerStatus":"rewarded","managerRating":5,"managerFeedback":"رتبه برتر هفته؛ پاداش عملکرد و ثبت بالاترین نرخ تبدیل جلسات حضوری به ایشان تعلق گرفت.","submittedAt":"۱۸:۳۰"},{"id":"per-C-103-weekly-14050619","consultantId":"user-c103","consultantName":"سعید حسینی","consultantCode":"C-103","periodType":"weekly","dateShamsi":"1405/06/19","periodLabel":"گزارش جامع هفتگی منتهی به پنج‌شنبه 19 شهریور","summary":"بد","keyAchievements":"بد","challengesOrBarriers":"بد","plansOrPriorities":"بد","weeklyFocusGuilds":"صنف بد","selfRating":1,"submittedAt":"۱۷:۱۹","createdAt":"2026-09-10T13:49:16.093Z","managerStatus":"warned","updatedAt":"2026-09-10T13:56:08.213Z","managerFeedback":"افتضاح","managerRating":1,"managerReviewedAt":"2026-09-10T13:56:08.213Z"}]'::jsonb,
  false
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  'arch-periodic_monthly-14050619',
  'بایگانی_ماهانه_پایان_ماه_استراتژیک_1405-06-19.xlsx',
  '1405/06/19',
  'پنج‌شنبه',
  '2026-09-10T14:10:57.813Z',
  'periodic_monthly',
  'بایگانی ماهانه پایان ماه گزارشات استراتژیک (شهریور ماه)',
  1,
  0,
  '[]'::jsonb,
  '[]'::jsonb,
  '[{"id":"per-c101-monthly-shahrivar","summary":"پیشرفت ۷۸ درصدی تارگت‌های ماهانه تا نیمه دوم شهریور؛ انجام ۸۶ تماس و ۹ جلسه هماهنگ شده.","dateShamsi":"1405/06/19","periodType":"monthly","selfRating":5,"periodLabel":"پیش‌بایگانی استراتژیک ماهانه شهریور ۱۴۰۵","submittedAt":"۲۰:۱۵","consultantId":"user-c101","managerRating":5,"managerStatus":"approved","consultantCode":"C-101","consultantName":"علیرضا رضایی","keyAchievements":"انعقاد تفاهم‌نامه اولیه با شهرک صنعتی توس برای ارائه خدمات مشاوره‌ای به واحدهای منتخب.","managerFeedback":"پیش‌بینی عملکرد عالی برای پایان شهریور.","plansOrPriorities":"تمرکز بر بستن قراردادهای معوق تا ۳۱ شهریور ماه.","challengesOrBarriers":"کمبود زمان کارفرمایان در روزهای پایانی تابستان جهت جلسات حضوری.","monthlyStrategicNotes":"راه‌اندازی سرویس پاسخگویی تلفنی اورژانسی برای احضاریه‌های ۲۴ ساعته اداره کار."}]'::jsonb,
  false
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  'arch-periodic_daily-14050618',
  'تحلیلی_روزانه_1405-06-18.xlsx',
  '1405/06/18',
  'چهارشنبه',
  '2026-09-10T14:18:14.713Z',
  'periodic_daily',
  'تحلیلی روزانه عملکرد مشاورین',
  2,
  0,
  '[]'::jsonb,
  '[]'::jsonb,
  '[{"id":"per-c101-daily-yesterday","summary":"تمرکز بر پرونده‌های معوق و حل چالش‌های کارفرمایان چاپ و بسته‌بندی در خصوص جرایم تأمین اجتماعی.","createdAt":"2026-09-09T13:44:15.374Z","dateShamsi":"1405/06/18","periodType":"daily","selfRating":4,"periodLabel":"گزارش روزانه روز قبل (1405/06/18)","submittedAt":"۱۷:۱۰","consultantId":"user-c101","managerRating":5,"managerStatus":"approved","consultantCode":"C-101","consultantName":"علیرضا رضایی","keyAchievements":"حل شبهات کارفرما عباسی درباره سفته حسن انجام کار و ارجاع پرونده به وکیل مجموعه.","plansOrPriorities":"شروع مذاکرات با صنف قطعات خودرو.","challengesOrBarriers":"مشغله شدید مدیران عامل قبل از ظهر؛ زمان بهینه تماس‌ها به بعد از ساعت ۱۴ منتقل شد."},{"id":"per-c103-daily-yesterday","summary":"برقراری تماس با شرکت‌های پخش و توزیع در مشهد و حومه.","createdAt":"2026-09-09T13:44:15.374Z","dateShamsi":"1405/06/18","periodType":"daily","selfRating":3,"periodLabel":"گزارش روزانه (1405/06/18)","submittedAt":"۱۹:۴۵","consultantId":"user-c103","managerRating":2,"managerStatus":"warned","consultantCode":"C-103","consultantName":"علی اکبری","keyAchievements":"ارسال معرفی‌نامه به ۲ شرکت پخش مواد شوینده.","managerFeedback":"ارسال گزارش با تاخیر غیرموجه؛ دقت شود گزارشات روزانه حداکثر تا ساعت ۱۸ ارسال گردد.","plansOrPriorities":"تماس با صنف قطعه‌سازان خودرو.","challengesOrBarriers":"عدم هماهنگی به موقع با مسئول دفتر مدیران."}]'::jsonb,
  true
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  'arch-14050618',
  'تماس‌های_روزانه_1405-06-18.xlsx',
  '1405/06/18',
  'چهارشنبه',
  '2026-09-09T10:05:47.560Z',
  'calls_daily',
  'بایگانی روزانه تماس‌ها و پیگیری‌ها',
  2,
  4,
  '[{"name":"دعاوی و شکایات در اداره کار و هیئت‌های تشخیص/حل اختلاف","count":1},{"name":"جرایم بازرسی و مغایرت‌های حق بیمه تأمین اجتماعی","count":1},{"name":"افت شدید بهره‌وری و نبود نظام ارزیابی عملکرد (KPI)","count":1},{"name":"ترک کار ناگهانی پرسنل کلیدی و بردن اطلاعات/اسرار تجاری","count":1}]'::jsonb,
  '[{"id":"rep-c101-today","rows":[{"id":"row-c101-today-1","notes":"جلسه با مهندس صادقی (مدیرعامل) دوشنبه ساعت ۱۰:۰۰ در محل کارخانه تنظیم شد.","phone":"05138401122","address":"شهرک صنعتی توس، فاز ۱، تلاش جنوبی","followUp1":"+","followUp2":"+","followUp3":"✓","followUp4":"","rowNumber":1,"clientName":"صنایع ریخته‌گری توس فولاد","meetingTopic":"آنالیز ریسک حقوقی قراردادها و پیشگیری از شکایات اداره کار","activityField":"تولید قطعات چدنی خودرو","followUpResult":"✓ (جلسه حضوری ست شد)","personnelCount":48,"employerConcern":"دعاوی و شکایات در اداره کار و هیئت‌های تشخیص/حل اختلاف"},{"id":"row-c101-today-2","notes":"مدیر کارگاه در خط تولید بود؛ تماس مجدد هماهنگ خواهد شد.","phone":"05132456677","address":"بزرگراه آسیایی، آزادی ۱۲۵","followUp1":".","followUp2":"","followUp3":"","followUp4":"","rowNumber":2,"clientName":"کارگاه تراشکاری نوین صنعت","meetingTopic":"","activityField":"تراشکاری قطعات برنجی","followUpResult":"","personnelCount":14,"employerConcern":"جرایم بازرسی و مغایرت‌های حق بیمه تأمین اجتماعی"},{"id":"row-c101-today-3","notes":"کارفرما عنوان کرد فعلاً برنامه اصلاح ساختار ندارند.","phone":"05136518899","address":"شهرک صنعتی کلات","followUp1":"-","followUp2":"","followUp3":"","followUp4":"","rowNumber":3,"clientName":"قالب‌سازی دقیق البرز","meetingTopic":"","activityField":"طراحی قالب‌های سنبه ماتریس","followUpResult":"- (اعلام عدم نیاز فعلی)","personnelCount":9,"employerConcern":"افت شدید بهره‌وری و نبود نظام ارزیابی عملکرد (KPI)"}],"guild":"تولیدی قطعات خودرو و ریخته‌گری","status":"approved","createdAt":"2026-09-09T10:05:47.491Z","updatedAt":"2026-09-09T10:05:47.491Z","dateShamsi":"1405/06/18","reviewedAt":"2026-09-09T10:05:47.491Z","submittedAt":"۱۴:۳۰","consultantId":"user-c101","managerRating":5,"consultantCode":"C-101","consultantName":"علیرضا رضایی","dayOfWeekShamsi":"چهارشنبه","managerFeedback":"عملکرد بسیار عالی در برقراری ارتباط با صنایع ریخته‌گری توس فولاد. جلسه حضوری به خوبی هماهنگ شد.","personalOpinion":"به دلیل افزایش نظارت و بازرسی‌های تأمین اجتماعی، کارفرمایان این صنف استقبال چشمگیری از خدمات بازبینی قراردادها و تراز مالی دارند."},{"id":"rep-c102-today","rows":[{"id":"row-c102-1","notes":"جلسه گوگل میت چهارشنبه ساعت ۱۴:۳۰ ست شد.","phone":"05138479900","address":"بلوار سجاد، خیابان بهار","followUp1":"+","followUp2":"+","followUp3":"✓","followUp4":"","rowNumber":1,"clientName":"شرکت دانش‌بنیان داده‌پردازان عصر نوین","meetingTopic":"تنظیم آیین‌نامه انضباطی مصوب و الحاقیه‌های محرمانگی","activityField":"توسعه نرم‌افزارهای سازمانی و هوش مصنوعی","followUpResult":"✓ (جلسه آنلاین با هم‌بنیان‌گذار ست شد)","personnelCount":36,"employerConcern":"ترک کار ناگهانی پرسنل کلیدی و بردن اطلاعات/اسرار تجاری"}],"guild":"فناوری اطلاعات و تجارت الکترونیک","status":"approved","createdAt":"2026-09-09T10:05:47.491Z","updatedAt":"2026-09-09T10:05:47.491Z","dateShamsi":"1405/06/18","reviewedAt":"2026-09-09T10:05:47.491Z","submittedAt":"۱۳:۱۵","consultantId":"user-c102","managerRating":5,"consultantCode":"C-102","consultantName":"مریم محمدی","dayOfWeekShamsi":"چهارشنبه","managerFeedback":"جلسه شرکت فرآورده‌های لبنی کوهستان رو با بسته پیشنهادی سطح ۲ هماهنگ فرمایید.","personalOpinion":"شرکت‌های نرم‌افزاری به شدت نگران حفظ محرمانگی کدها و ترک ناگهانی برنامه‌نویسان ارشد هستند."}]'::jsonb,
  '[]'::jsonb,
  true
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  'arch-calls-14050617',
  'تماس‌های_روزانه_1405-06-17.xlsx',
  '1405/06/17',
  'سه‌شنبه',
  '2026-09-12T14:07:21.531Z',
  'calls_daily',
  'بایگانی روزانه تماس‌ها و پیگیری‌ها',
  3,
  11,
  '[{"name":"افت شدید بهره‌وری و نبود نظام ارزیابی عملکرد (KPI)","count":2},{"name":"ریسک‌های مالیاتی و حسابداری مرتبط با حقوق و دستمزد","count":2},{"name":"ریزش مداوم نیروی انسانی و تعارضات درون‌سازمانی","count":1},{"name":"دعاوی و شکایات در اداره کار و هیئت‌های تشخیص/حل اختلاف","count":1},{"name":"عدم شفافیت قراردادهای کار، الحاقیه‌ها و تضامین پرسنلی","count":1}]'::jsonb,
  '[{"id":"rep-1788869621659","rows":[{"id":"row-1788869523910-2","notes":"","phone":"09995443211","address":"سیلیکون ولی","followUp1":"✓","followUp2":"✓","followUp3":"-","followUp4":"✓","rowNumber":1,"clientName":"مهندس زارع","meetingTopic":"بسیار خوش برخورد و متشخص میباشند این مهندس","activityField":"هوش مصنوعی","followUpResult":"میگن که بدرد من نمیخوره و زنگ نزنید دیگه","personnelCount":"۱۰۰۰","employerConcern":"افت شدید بهره‌وری و نبود نظام ارزیابی عملکرد (KPI)"}],"guild":"صنف سیستم","status":"approved","createdAt":"2026-09-08T12:13:41.659Z","updatedAt":"2026-09-10T13:30:39.484Z","dateShamsi":"1405/06/17","reviewedAt":"2026-09-10T13:30:39.484Z","submittedAt":"۱۵:۴۳","consultantId":"user-c103","managerRating":5,"consultantCode":"C-103","consultantName":"سعید حسینی","dayOfWeekShamsi":"سه‌شنبه","managerFeedback":"اذیت نکنید این دکتر عزیز رو","personalOpinion":"ایشان خفنه جهانن"},{"id":"rep-1788868003406","rows":[{"id":"row-1788867608718-1","notes":"","phone":"09154324567","address":"شهرک سراجیان","followUp1":"*","followUp2":"+","followUp3":"✓","followUp4":"-","rowNumber":1,"clientName":"سراجی","meetingTopic":"شنبلیله فروشی","activityField":"سراج فروشی","followUpResult":"مخشو زدم بلاخره","personnelCount":"۱","employerConcern":"ریزش مداوم نیروی انسانی و تعارضات درون‌سازمانی"}],"guild":"اصناف و بنگاه‌های اقتصادی","status":"approved","createdAt":"2026-09-08T11:46:43.406Z","updatedAt":"2026-09-09T09:34:35.123Z","dateShamsi":"1405/06/17","reviewedAt":"2026-09-08T12:06:28.491Z","submittedAt":"۱۵:۲۹","consultantId":"user-c102","managerRating":2,"consultantCode":"C-102","consultantName":"مریم محمدی","dayOfWeekShamsi":"سه‌شنبه","managerFeedback":"شانگاریلیلا","personalOpinion":"طرف نمیخواد"},{"id":"rep-seed-1","rows":[{"id":"row-seed-1-1","notes":"جلسه با مهندس صادقی (مدیرعامل) دوشنبه ساعت ۱۰:۰۰ در محل کارخانه تنظیم شد.","phone":"05138401122","address":"شهرک صنعتی توس، فاز ۱، تلاش جنوبی","followUp1":"+","followUp2":"+","followUp3":"✓","followUp4":"","rowNumber":1,"clientName":"صنایع ریخته‌گری توس فولاد","meetingTopic":"آنالیز ریسک حقوقی قراردادها و پیشگیری از شکایات اداره کار","activityField":"تولید قطعات چدنی خودرو","followUpResult":"✓ (جلسه حضوری ست شد)","personnelCount":48,"employerConcern":"دعاوی و شکایات در اداره کار و هیئت‌های تشخیص/حل اختلاف"},{"id":"row-seed-1-2","notes":"تماس دوم انجام شد؛ پیش‌نویس چک‌لیست حقوقی ارسال گردید، منتظر بررسی هیئت‌مدیره هستند.","phone":"05135412233","address":"شهرک صنعتی فناوری‌های برتر","followUp1":"+","followUp2":"+","followUp3":"","followUp4":"","rowNumber":2,"clientName":"صنعتی پارت سازان خاور","meetingTopic":"","activityField":"ماشین‌کاری قطعات حساس","followUpResult":"","personnelCount":22,"employerConcern":"عدم شفافیت قراردادهای کار، الحاقیه‌ها و تضامین پرسنلی"},{"id":"row-seed-1-3","notes":"مدیر کارگاه در خط تولید بود؛ تماس مجدد در نوبت عصر هماهنگ خواهد شد.","phone":"05132456677","address":"بزرگراه آسیایی، آزادی ۱۲۵","followUp1":".","followUp2":"","followUp3":"","followUp4":"","rowNumber":3,"clientName":"کارگاه تراشکاری نوین صنعت","meetingTopic":"","activityField":"تراشکاری قطعات برنجی","followUpResult":"","personnelCount":14,"employerConcern":"جرایم بازرسی و مغایرت‌های حق بیمه تأمین اجتماعی"},{"id":"row-seed-1-4","notes":"کارفرما عنوان کرد فعلاً به دلیل نوسانات بازار برنامه اصلاح ساختار ندارند.","phone":"05136518899","address":"شهرک صنعتی کلات","followUp1":"-","followUp2":"","followUp3":"","followUp4":"","rowNumber":4,"clientName":"قالب‌سازی دقیق البرز","meetingTopic":"","activityField":"طراحی قالب‌های سنبه ماتریس","followUpResult":"- (اعلام عدم نیاز فعلی)","personnelCount":9,"employerConcern":"افت شدید بهره‌وری و نبود نظام ارزیابی عملکرد (KPI)"},{"id":"row-seed-1-5","notes":"خط قطع بود؛ نیاز به اصلاح شماره در پایگاه داده داده‌کاوی.","phone":"05138810011","address":"جاده قدیم نیشابور","followUp1":"*","followUp2":"","followUp3":"","followUp4":"","rowNumber":5,"clientName":"ریخته‌گری آلومینیوم خاوران","meetingTopic":"","activityField":"ریخته‌گری تحت فشار دایکست","followUpResult":"* (شماره کارخانه تغییر یافته است)","personnelCount":30,"employerConcern":"عدم تطابق فیش حقوقی، مزایای قانونی و تراز مالی با پرداختی واقعی"}],"guild":"تولیدی قطعات خودرو و ریخته‌گری","status":"approved","createdAt":"2026-09-08T08:52:10.140Z","updatedAt":"2026-09-08T08:52:10.147Z","dateShamsi":"1405/06/17","reviewedAt":"2026-09-08T08:52:10.140Z","submittedAt":"۱۴:۳۰","consultantId":"user-c101","managerRating":5,"consultantCode":"C-101","consultantName":"علیرضا رضایی","dayOfWeekShamsi":"سه‌شنبه","managerFeedback":"عملکرد بسیار عالی در برقراری ارتباط با صنایع ریخته‌گری توس فولاد. جلسه حضوری هماهنگ شود.","personalOpinion":"به دلیل افزایش نظارت و بازرسی‌های تأمین اجتماعی، کارفرمایان این صنف استقبال چشمگیری از خدمات بازبینی قراردادها و تراز مالی دارند."},{"id":"rep-seed-2","rows":[{"id":"row-seed-2-1","notes":"جلسه تخصصی گوگل میت چهارشنبه ساعت ۱۴:۳۰ ست شد.","phone":"05138479900","address":"بلوار سجاد، خیابان بهار","followUp1":"+","followUp2":"+","followUp3":"✓","followUp4":"","rowNumber":1,"clientName":"شرکت دانش‌بنیان داده‌پردازان عصر نوین","meetingTopic":"تنظیم آیین‌نامه انضباطی مصوب و الحاقیه‌های محرمانگی","activityField":"توسعه نرم‌افزارهای سازمانی و هوش مصنوعی","followUpResult":"✓ (جلسه آنلاین با هم‌بنیان‌گذار ست شد)","personnelCount":36,"employerConcern":"ترک کار ناگهانی پرسنل کلیدی و بردن اطلاعات/اسرار تجاری"},{"id":"row-seed-2-2","notes":"مدیر مالی شرکت استقبال کرد؛ مستندات مقایسه‌ای مالیات حقوق ارسال شد.","phone":"05137614455","address":"بلوار دستغیب، مجتمع تک","followUp1":"+","followUp2":"","followUp3":"","followUp4":"","rowNumber":2,"clientName":"پلتفرم خدمات ابری رایان‌سرویس","meetingTopic":"","activityField":"ارائه زیرساخت و سرور ابری","followUpResult":"","personnelCount":24,"employerConcern":"ریسک‌های مالیاتی و حسابداری مرتبط با حقوق و دستمزد"},{"id":"row-seed-2-3","notes":"درخواست راهنمایی در خصوص فرمول پورسانت پلکانی کارشناسان فروش.","phone":"05138435566","address":"احمدآباد، خیابان عدالت","followUp1":"+","followUp2":"","followUp3":"","followUp4":"","rowNumber":3,"clientName":"آژانس دیجیتال مارکتینگ صبا","meetingTopic":"","activityField":"سئو و تبلیغات دیجیتال","followUpResult":"","personnelCount":16,"employerConcern":"ابهام در فرمول‌های پورسانت، پاداش و تارگت‌های فروش"}],"guild":"فناوری اطلاعات و تجارت الکترونیک","status":"approved","createdAt":"2026-09-08T08:52:10.140Z","updatedAt":"2026-09-08T11:43:25.885Z","dateShamsi":"1405/06/17","reviewedAt":"2026-09-08T11:43:25.885Z","submittedAt":"۱۳:۱۵","consultantId":"user-c102","managerRating":5,"consultantCode":"C-102","consultantName":"مریم محمدی","dayOfWeekShamsi":"سه‌شنبه","managerFeedback":"آفرین مریم","personalOpinion":"شرکت‌های نرم‌افزاری به شدت نگران حفظ محرمانگی کدها و ترک ناگهانی برنامه‌نویسان ارشد هستند."},{"id":"rep-c101-today-due-4d","rows":[{"id":"row-c101-hosseini-client","notes":"امروز دقیقاً موعد تماس دوم (روز چهارم) است.","phone":"05135412233","address":"شهرک صنعتی فناوری‌های برتر","followUp1":"+","followUp2":"","followUp3":"","followUp4":"","rowNumber":1,"clientName":"کارفرما حسینی (صنعتی پارت سازان خاور)","meetingTopic":"عارضه‌یابی منابع انسانی و طراحی نظام پاداش و ارزیابی عملکرد","activityField":"ماشین‌کاری قطعات حساس موتور","followUpResult":"","personnelCount":22,"employerConcern":"ریسک‌های مالیاتی و حسابداری مرتبط با حقوق و دستمزد","followUp1DateShamsi":"1405/06/17"}],"guild":"صنعتی و مهندسی دقیق","status":"submitted","createdAt":"2026-09-08T12:22:40.435Z","updatedAt":"2026-09-08T12:22:40.435Z","dateShamsi":"1405/06/17","submittedAt":"۱۱:۴۰","consultantId":"user-c101","consultantCode":"C-101","consultantName":"علیرضا رضایی","dayOfWeekShamsi":"سه‌شنبه","managerFeedback":"","personalOpinion":"استقبال مدیرعامل در جلسه نخست امیدوارکننده بود."}]'::jsonb,
  '[]'::jsonb,
  true
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  'arch-14050616',
  'تماس‌های_روزانه_1405-06-16.xlsx',
  '1405/06/16',
  'دوشنبه',
  '2026-09-10T12:51:59.946Z',
  'calls_daily',
  'بایگانی روزانه تماس‌ها و پیگیری‌ها',
  1,
  3,
  '[{"name":"پرونده‌های سخت و زیان‌آور و بازنشستگی‌های زودرس پیش‌بینی نشده","count":1},{"name":"فقدان آیین‌نامه انضباطی مصوب و رویه مشخص اخراج یا توبیخ","count":1},{"name":"چالش محاسبه اضافه کاری، شب‌کاری، نوبت‌کاری و تعطیل‌کاری","count":1}]'::jsonb,
  '[{"id":"rep-seed-3","rows":[{"id":"row-seed-3-1","notes":"مدیر اداری آقای رجبی بسیار پیگیر بودند؛ جلسه پنج‌شنبه ساعت ۱۱ صبح.","phone":"05135421100","address":"شهرک صنعتی چناران","followUp1":"+","followUp2":"✓","followUp3":"","followUp4":"","rowNumber":1,"clientName":"فرآورده‌های لبنی کوهستان مشهد","meetingTopic":"تراز فیش حقوقی و بهینه‌سازی فرآیندهای بیمه تأمین اجتماعی","activityField":"تولید دوغ و ماست پاستوریزه","followUpResult":"✓ (جلسه حضوری با مدیر اداری ست شد)","personnelCount":92,"employerConcern":"پرونده‌های سخت و زیان‌آور و بازنشستگی‌های زودرس پیش‌بینی نشده"},{"id":"row-seed-3-2","notes":"مذاکره اولیه انجام شد؛ منتظر تماس مجدد در چرخه پیگیری هستند.","phone":"05135413344","address":"شهرک صنعتی توس، فاز ۲","followUp1":"+","followUp2":"+","followUp3":"","followUp4":"","rowNumber":2,"clientName":"صنایع بسته‌بندی ترنج سبز","meetingTopic":"","activityField":"بسته‌بندی حبوبات و خشکبار صادراتی","followUpResult":"","personnelCount":38,"employerConcern":"فقدان آیین‌نامه انضباطی مصوب و رویه مشخص اخراج یا توبیخ"},{"id":"row-seed-3-3","notes":"مدیرعامل در جلسه بازرسی استاندارد بود.","phone":"05136517722","address":"شهرک صنعتی ماشین‌سازی","followUp1":".","followUp2":".","followUp3":"","followUp4":"","rowNumber":3,"clientName":"تولیدی کیک و کلوچه پردیس","meetingTopic":"","activityField":"شیرینی و بیسکویت صنعتی","followUpResult":"شاپسیان","personnelCount":25,"employerConcern":"چالش محاسبه اضافه کاری، شب‌کاری، نوبت‌کاری و تعطیل‌کاری"}],"guild":"صنایع غذایی و بسته‌بندی","status":"approved","createdAt":"2026-09-07T08:52:10.140Z","updatedAt":"2026-09-08T11:55:21.829Z","dateShamsi":"1405/06/16","reviewedAt":"2026-09-07T08:52:10.140Z","submittedAt":"۱۵:۲۵","consultantId":"user-c102","managerRating":5,"consultantCode":"C-102","consultantName":"مریم محمدی","dayOfWeekShamsi":"دوشنبه","managerFeedback":"نکات درج شده در خصوص شرکت فرآورده‌های لبنی کوهستان فوق‌العاده است. پشتیبانی کامل حقوقی داده شود.","personalOpinion":"صنایع غذایی به دلیل شیفت‌های گردشی و سختی کار، ریسک بسیار بالایی در پرونده‌های بازنشستگی پیش‌ازموعد دارند."}]'::jsonb,
  '[]'::jsonb,
  true
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  'arch-calls-14050615',
  'تماس‌های_روزانه_1405-06-15.xlsx',
  '1405/06/15',
  'یکشنبه',
  '2026-09-12T12:22:40.447Z',
  'calls_daily',
  'بایگانی روزانه تماس‌ها و پیگیری‌ها',
  3,
  3,
  '[{"name":"عدم شفافیت قراردادهای کار، الحاقیه‌ها و تضامین پرسنلی","count":1},{"name":"فقدان آیین‌نامه انضباطی مصوب و رویه مشخص اخراج یا توبیخ","count":1},{"name":"دعاوی و شکایات در اداره کار و هیئت‌های تشخیص/حل اختلاف","count":1}]'::jsonb,
  '[{"id":"rep-c101-overdue-6d","consultantId":"user-c101","consultantName":"علیرضا رضایی","consultantCode":"C-101","dateShamsi":"1405/06/15","dayOfWeekShamsi":"یکشنبه","guild":"ماشین‌سازی و قطعه‌سازی خودرو","status":"approved","managerFeedback":"پرونده کارفرما احمدی را سریعاً تماس گرفته و تعیین تکلیف نمایید.","managerRating":4,"reviewedAt":"2026-09-06T12:22:40.435Z","updatedAt":"2026-09-06T12:22:40.435Z","createdAt":"2026-09-06T12:22:40.435Z","submittedAt":"۱۶:۱۵","personalOpinion":"کارفرمایان این گروه به دلیل چالش تضامین و قراردادهای کارگری نیازمند پیگیری منظم هستند.","rows":[{"id":"row-c101-ahmadi","rowNumber":1,"clientName":"کارفرما احمدی (گروه صنعتی پارت گستر)","activityField":"تولید قطعات پرسی بدنه خودرو","personnelCount":35,"phone":"05138491122","address":"شهرک صنعتی توس، تلاش شمالی ۶","employerConcern":"عدم شفافیت قراردادهای کار، الحاقیه‌ها و تضامین پرسنلی","followUp1":"+","followUp2":"","followUp3":"","followUp4":"","followUpResult":"","meetingTopic":"تنظیم آیین‌نامه انضباطی مصوب و الحاقیه‌های محرمانگی","notes":"در تماس اول بسیار مشتاق بودند؛ قرار شد بعد از ۴ روز برای ارسال پیش‌نویس تماس گرفته شود.","followUp1DateShamsi":"1405/06/15"}]},{"id":"rep-c102-overdue","consultantId":"user-c102","consultantName":"مریم محمدی","consultantCode":"C-102","dateShamsi":"1405/06/15","dayOfWeekShamsi":"یکشنبه","guild":"صنایع غذایی و کشاورزی","status":"approved","managerFeedback":"پشتیبانی کامل حقوقی داده شود.","managerRating":4,"reviewedAt":"2026-09-06T12:22:40.435Z","updatedAt":"2026-09-06T12:22:40.435Z","createdAt":"2026-09-06T12:22:40.435Z","submittedAt":"۱۶:۰۰","personalOpinion":"صنایع غذایی ریسک بسیار بالایی در پرونده‌های بازنشستگی پیش‌ازموعد دارند.","rows":[{"id":"row-c102-overdue-1","rowNumber":1,"clientName":"کارفرما کاظمی (صنایع بسته‌بندی ترنج سبز)","activityField":"بسته‌بندی حبوبات و خشکبار صادراتی","personnelCount":38,"phone":"05135413344","address":"شهرک صنعتی توس، فاز ۲","employerConcern":"فقدان آیین‌نامه انضباطی مصوب و رویه مشخص اخراج یا توبیخ","followUp1":"+","followUp2":"","followUp3":"","followUp4":"","followUpResult":"","meetingTopic":"تنظیم آیین‌نامه انضباطی مصوب و الحاقیه‌های محرمانگی","notes":"نیازمند تماس فوری پیگیری دوم (۲ روز معوق).","followUp1DateShamsi":"1405/06/15"}]},{"id":"rep-c104-today","consultantId":"user-c104","consultantName":"ندا کریمی","consultantCode":"C-104","dateShamsi":"1405/06/15","dayOfWeekShamsi":"یکشنبه","guild":"ساختمانی، انبوه‌سازی و تأسیسات","status":"approved","managerFeedback":"پکیج مشاوره آیین‌نامه انضباطی برای کارگاه‌های بالای ۲۰ نفر معرفی شود.","managerRating":4,"reviewedAt":"2026-09-06T12:22:40.435Z","updatedAt":"2026-09-06T12:22:40.435Z","createdAt":"2026-09-06T12:22:40.435Z","submittedAt":"۱۲:۳۰","personalOpinion":"شرکت‌های پیمانکاری بیشترین حجم احضاریه‌های هیئت‌های تشخیص را دارند.","rows":[{"id":"row-c104-1","rowNumber":1,"clientName":"کارفرما ابراهیمی (شرکت ابنیه عمران گستر)","activityField":"پیمانکاری پروژه‌های مسکونی و تجاری","personnelCount":115,"phone":"05138447788","address":"مشهد، بلوار فلسطین، تقاطع خیام","employerConcern":"دعاوی و شکایات در اداره کار و هیئت‌های تشخیص/حل اختلاف","followUp1":"+","followUp2":"","followUp3":"","followUp4":"","followUpResult":"","meetingTopic":"مشاوره دفاعیات پرونده‌های مطروحه در هیئت‌های حل اختلاف","notes":"پیگیری معوق؛ تماس دوم باید فوری انجام شود.","followUp1DateShamsi":"1405/06/15"}]}]'::jsonb,
  '[]'::jsonb,
  true
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  'arch-14050614',
  'تماس‌های_روزانه_1405-06-14.xlsx',
  '1405/06/14',
  'شنبه',
  '2026-09-09T10:04:51.467Z',
  'calls_daily',
  'بایگانی روزانه تماس‌ها و پیگیری‌ها',
  2,
  2,
  '[{"name":"چالش‌های توزیع مویرگی، وصول مطالبات و کسری انبار","count":1},{"name":"ریسک‌های مالیاتی و حسابداری مرتبط با حقوق و دستمزد","count":1}]'::jsonb,
  '[{"id":"rep-c103-today","rows":[{"id":"row-c103-1","notes":"امروز موعد تماس دوم است.","phone":"02188991122","address":"تهران، خیابان مطهری، پلاک ۱۱۴","followUp1":"+","followUp2":"","followUp3":"","followUp4":"","rowNumber":1,"clientName":"کارفرما شجاعی (شرکت بازرگانی پخش مویرگی کیان)","meetingTopic":"آنالیز ریسک حقوقی قراردادها و پیشگیری از شکایات اداره کار","activityField":"پخش سراسری مواد شوینده و بهداشتی","followUpResult":"","personnelCount":65,"employerConcern":"چالش‌های توزیع مویرگی، وصول مطالبات و کسری انبار"}],"guild":"بازرگانی و پخش مویرگی","status":"approved","createdAt":"2026-09-05T10:04:51.406Z","updatedAt":"2026-09-05T10:04:51.406Z","dateShamsi":"1405/06/14","reviewedAt":"2026-09-05T10:04:51.406Z","submittedAt":"۱۵:۴۵","consultantId":"user-c103","managerRating":4,"consultantCode":"C-103","consultantName":"سعید حسینی","dayOfWeekShamsi":"شنبه","managerFeedback":"تمرکز بر روی مبالغ سفته و تضامین ویزیتورها باشد.","personalOpinion":"شرکت‌های پخش دغدغه فوری تنظیم سفته و قرارداد ضمانت دارند."},{"id":"rep-c101-today-due-4d","rows":[{"id":"row-c101-hosseini-client","notes":"امروز دقیقاً موعد تماس دوم (روز چهارم) است.","phone":"05135412233","address":"شهرک صنعتی فناوری‌های برتر","followUp1":"+","followUp2":"","followUp3":"","followUp4":"","rowNumber":1,"clientName":"کارفرما حسینی (صنعتی پارت سازان خاور)","meetingTopic":"عارضه‌یابی منابع انسانی و طراحی نظام پاداش و ارزیابی عملکرد","activityField":"ماشین‌کاری قطعات حساس موتور","followUpResult":"","personnelCount":22,"employerConcern":"ریسک‌های مالیاتی و حسابداری مرتبط با حقوق و دستمزد"}],"guild":"صنعتی و مهندسی دقیق","status":"submitted","createdAt":"2026-09-05T10:04:51.406Z","updatedAt":"2026-09-05T10:04:51.406Z","dateShamsi":"1405/06/14","submittedAt":"۱۱:۴۰","consultantId":"user-c101","consultantCode":"C-101","consultantName":"علیرضا رضایی","dayOfWeekShamsi":"شنبه","managerFeedback":"","personalOpinion":"استقبال مدیرعامل در جلسه نخست امیدوارکننده بود."}]'::jsonb,
  '[]'::jsonb,
  true
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  'arch-calls-14050613',
  'بایگانی_تماسها_و_پیگیری_روزانه_جمعه_1405-06-13.xlsx',
  '1405/06/13',
  'جمعه',
  '2026-09-11T07:57:18.918Z',
  'calls_daily',
  'بایگانی روزانه تماس‌ها و پیگیری‌ها',
  2,
  5,
  '[{"name":"چالش‌های توزیع مویرگی، وصول مطالبات و کسری انبار","count":2},{"name":"عدم شفافیت قراردادهای کار، الحاقیه‌ها و تضامین پرسنلی","count":2},{"name":"حوادث ناشی از کار، مسئولیت‌های مدنی و دیه کارفرمایی","count":1}]'::jsonb,
  '[{"id":"rep-c103-today","rows":[{"id":"row-c103-1","notes":"امروز موعد تماس دوم است.","phone":"02188991122","address":"تهران، خیابان مطهری، پلاک ۱۱۴","followUp1":"+","followUp2":".","followUp3":"-","followUp4":"","rowNumber":1,"clientName":"کارفرما شجاعی (شرکت بازرگانی پخش مویرگی کیان)","meetingTopic":"آنالیز ریسک حقوقی قراردادها و پیشگیری از شکایات اداره کار","activityField":"پخش سراسری مواد شوینده و بهداشتی","followUpResult":"نمیخواد اصن","personnelCount":65,"employerConcern":"چالش‌های توزیع مویرگی، وصول مطالبات و کسری انبار"}],"guild":"بازرگانی و پخش مویرگی","status":"approved","createdAt":"2026-09-04T11:34:11.215Z","updatedAt":"2026-09-10T11:47:58.738Z","dateShamsi":"1405/06/13","reviewedAt":"2026-09-08T11:38:23.061Z","submittedAt":"۱۵:۰۳","consultantId":"user-c103","managerRating":2,"consultantCode":"C-103","consultantName":"سعید حسینی","dayOfWeekShamsi":"جمعه","managerFeedback":"تمرک","personalOpinion":"شرکت‌های پخش دغدغه فوری تنظیم سفته و قرارداد ضمانت دارند."},{"id":"rep-seed-4","rows":[{"id":"row-seed-4-1","notes":"امروز دقیقاً موعد تماس دوم در چرخه ۴ روزه است و سیستم آلارم پیگیری صادر کرده است.","phone":"02188991122","address":"تهران، خیابان مطهری، پلاک ۱۱۴","followUp1":"+","followUp2":"*","followUp3":"-","followUp4":"-","rowNumber":1,"clientName":"شرکت بازرگانی پخش مویرگی کیان","meetingTopic":"","activityField":"پخش سراسری مواد شوینده و بهداشتی","followUpResult":"کوفته","personnelCount":65,"employerConcern":"چالش‌های توزیع مویرگی، وصول مطالبات و کسری انبار"},{"id":"row-seed-4-2","notes":"موعد تماس دوم فرارسیده؛ مدیر منابع انسانی تمایل به دریافت نمونه قرارداد امانی دارد.","phone":"02166554433","address":"تهران، خیابان آزادی، نبش شادمان","followUp1":"+","followUp2":"-","followUp3":"-","followUp4":"+","rowNumber":2,"clientName":"توزیع و پخش دارویی رازیان سلامت","meetingTopic":"","activityField":"پخش اقلام دارویی و مکمل‌ها","followUpResult":"شاپسین","personnelCount":42,"employerConcern":"عدم شفافیت قراردادهای کار، الحاقیه‌ها و تضامین پرسنلی"},{"id":"row-seed-4-3","notes":"در چرخه پیگیری قرار دارد.","phone":"02155443322","address":"تهران، جاده مخصوص کرج، کیلومتر ۱۱","followUp1":".","followUp2":"+","followUp3":"","followUp4":"","rowNumber":3,"clientName":"شرکت لجستیک سپهر ترابر","meetingTopic":"","activityField":"خدمات انبارداری و ارسال مرسولات","followUpResult":"مثبته","personnelCount":28,"employerConcern":"حوادث ناشی از کار، مسئولیت‌های مدنی و دیه کارفرمایی"}],"guild":"بازرگانی و پخش مویرگی","status":"approved","createdAt":"2026-09-04T08:52:10.140Z","updatedAt":"2026-09-10T11:34:26.309Z","dateShamsi":"1405/06/13","reviewedAt":"2026-09-08T11:41:45.450Z","submittedAt":"۱۵:۰۳","consultantId":"user-c103","managerRating":4,"consultantCode":"C-103","consultantName":"سعید حسینی","dayOfWeekShamsi":"جمعه","managerFeedback":"تو شنبلیله ای","personalOpinion":"شرکت‌های پخش به دلیل مبالغ سنگین ضمانت‌نامه‌های ویزیتورها و رانندگان، دغدغه فوری تنظیم سفته و قرارداد ضمانت دارند."},{"id":"rep-c101-overdue-6d","rows":[{"id":"row-c101-ahmadi","notes":"در تماس اول بسیار مشتاق بودند؛ قرار شد بعد از ۴ روز برای ارسال پیش‌نویس تماس گرفته شود.","phone":"05138491122","address":"شهرک صنعتی توس، تلاش شمالی ۶","followUp1":"+","followUp2":"","followUp3":"","followUp4":"","rowNumber":1,"clientName":"کارفرما احمدی (گروه صنعتی پارت گستر)","meetingTopic":"تنظیم آیین‌نامه انضباطی مصوب و الحاقیه‌های محرمانگی","activityField":"تولید قطعات پرسی بدنه خودرو","followUpResult":"","personnelCount":35,"employerConcern":"عدم شفافیت قراردادهای کار، الحاقیه‌ها و تضامین پرسنلی"}],"guild":"ماشین‌سازی و قطعه‌سازی خودرو","status":"approved","createdAt":"2026-09-04T12:50:32.294Z","updatedAt":"2026-09-04T12:50:32.294Z","dateShamsi":"1405/06/13","reviewedAt":"2026-09-04T12:50:32.294Z","submittedAt":"۱۶:۱۵","consultantId":"user-c101","managerRating":4,"consultantCode":"C-101","consultantName":"علیرضا رضایی","dayOfWeekShamsi":"جمعه","managerFeedback":"پرونده کارفرما احمدی را سریعاً تماس گرفته و تعیین تکلیف نمایید.","personalOpinion":"کارفرمایان این گروه به دلیل چالش تضامین و قراردادهای کارگری نیازمند پیگیری منظم هستند."}]'::jsonb,
  '[]'::jsonb,
  true
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  'arch-14050612',
  'تماس‌های_روزانه_1405-06-12.xlsx',
  '1405/06/12',
  'پنج‌شنبه',
  '2026-09-09T10:04:51.493Z',
  'calls_daily',
  'بایگانی روزانه تماس‌ها و پیگیری‌ها',
  3,
  3,
  '[{"name":"عدم شفافیت قراردادهای کار، الحاقیه‌ها و تضامین پرسنلی","count":1},{"name":"فقدان آیین‌نامه انضباطی مصوب و رویه مشخص اخراج یا توبیخ","count":1},{"name":"دعاوی و شکایات در اداره کار و هیئت‌های تشخیص/حل اختلاف","count":1}]'::jsonb,
  '[{"id":"rep-c101-overdue-6d","rows":[{"id":"row-c101-ahmadi","notes":"در تماس اول بسیار مشتاق بودند؛ قرار شد بعد از ۴ روز برای ارسال پیش‌نویس تماس گرفته شود.","phone":"05138491122","address":"شهرک صنعتی توس، تلاش شمالی ۶","followUp1":"+","followUp2":"","followUp3":"","followUp4":"","rowNumber":1,"clientName":"کارفرما احمدی (گروه صنعتی پارت گستر)","meetingTopic":"تنظیم آیین‌نامه انضباطی مصوب و الحاقیه‌های محرمانگی","activityField":"تولید قطعات پرسی بدنه خودرو","followUpResult":"","personnelCount":35,"employerConcern":"عدم شفافیت قراردادهای کار، الحاقیه‌ها و تضامین پرسنلی"}],"guild":"ماشین‌سازی و قطعه‌سازی خودرو","status":"approved","createdAt":"2026-09-03T10:04:51.406Z","updatedAt":"2026-09-03T10:04:51.406Z","dateShamsi":"1405/06/12","reviewedAt":"2026-09-03T10:04:51.406Z","submittedAt":"۱۶:۱۵","consultantId":"user-c101","managerRating":4,"consultantCode":"C-101","consultantName":"علیرضا رضایی","dayOfWeekShamsi":"پنج‌شنبه","managerFeedback":"پرونده کارفرما احمدی را سریعاً تماس گرفته و تعیین تکلیف نمایید.","personalOpinion":"کارفرمایان این گروه به دلیل چالش تضامین و قراردادهای کارگری نیازمند پیگیری منظم هستند."},{"id":"rep-c102-overdue","rows":[{"id":"row-c102-overdue-1","notes":"نیازمند تماس فوری پیگیری دوم (۲ روز معوق).","phone":"05135413344","address":"شهرک صنعتی توس، فاز ۲","followUp1":"+","followUp2":"","followUp3":"","followUp4":"","rowNumber":1,"clientName":"کارفرما کاظمی (صنایع بسته‌بندی ترنج سبز)","meetingTopic":"تنظیم آیین‌نامه انضباطی مصوب و الحاقیه‌های محرمانگی","activityField":"بسته‌بندی حبوبات و خشکبار صادراتی","followUpResult":"","personnelCount":38,"employerConcern":"فقدان آیین‌نامه انضباطی مصوب و رویه مشخص اخراج یا توبیخ"}],"guild":"صنایع غذایی و کشاورزی","status":"approved","createdAt":"2026-09-03T10:04:51.406Z","updatedAt":"2026-09-03T10:04:51.406Z","dateShamsi":"1405/06/12","reviewedAt":"2026-09-03T10:04:51.406Z","submittedAt":"۱۶:۰۰","consultantId":"user-c102","managerRating":4,"consultantCode":"C-102","consultantName":"مریم محمدی","dayOfWeekShamsi":"پنج‌شنبه","managerFeedback":"پشتیبانی کامل حقوقی داده شود.","personalOpinion":"صنایع غذایی ریسک بسیار بالایی در پرونده‌های بازنشستگی پیش‌ازموعد دارند."},{"id":"rep-c104-today","rows":[{"id":"row-c104-1","notes":"پیگیری معوق؛ تماس دوم باید فوری انجام شود.","phone":"05138447788","address":"مشهد، بلوار فلسطین، تقاطع خیام","followUp1":"+","followUp2":"","followUp3":"","followUp4":"","rowNumber":1,"clientName":"کارفرما ابراهیمی (شرکت ابنیه عمران گستر)","meetingTopic":"مشاوره دفاعیات پرونده‌های مطروحه در هیئت‌های حل اختلاف","activityField":"پیمانکاری پروژه‌های مسکونی و تجاری","followUpResult":"","personnelCount":115,"employerConcern":"دعاوی و شکایات در اداره کار و هیئت‌های تشخیص/حل اختلاف"}],"guild":"ساختمانی، انبوه‌سازی و تأسیسات","status":"approved","createdAt":"2026-09-03T10:04:51.406Z","updatedAt":"2026-09-03T10:04:51.406Z","dateShamsi":"1405/06/12","reviewedAt":"2026-09-03T10:04:51.406Z","submittedAt":"۱۲:۳۰","consultantId":"user-c104","managerRating":4,"consultantCode":"C-104","consultantName":"ندا کریمی","dayOfWeekShamsi":"پنج‌شنبه","managerFeedback":"پکیج مشاوره آیین‌نامه انضباطی برای کارگاه‌های بالای ۲۰ نفر معرفی شود.","personalOpinion":"شرکت‌های پیمانکاری بیشترین حجم احضاریه‌های هیئت‌های تشخیص را دارند."}]'::jsonb,
  '[]'::jsonb,
  true
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  'arch-periodic_weekly-14050612',
  'تحلیلی_هفتگی_1405-06-12.xlsx',
  '1405/06/12',
  'پنج‌شنبه',
  '2026-09-10T14:10:57.813Z',
  'periodic_weekly',
  'تحلیلی هفتگی عملکرد مشاورین (پنج‌شنبه)',
  3,
  0,
  '[]'::jsonb,
  '[]'::jsonb,
  '[{"id":"per-c101-weekly-last","consultantId":"user-c101","consultantName":"علیرضا رضایی","consultantCode":"C-101","periodType":"weekly","dateShamsi":"1405/06/12","periodLabel":"گزارش هفتگی هفته دوم شهریور ۱۴۰۵","summary":"مجموع ۳۴ تماس موثر، ۴ جلسه ست‌شده و یک قرارداد قطعی با ارزش ۵۵ میلیون تومان در حوزه دعاوی کارگری.","keyAchievements":"عقد قرارداد با شرکت تولیدی توس و جذب ۳ مشتری جدید در شهرک ماشین‌سازی.","challengesOrBarriers":"رقابت با شرکت‌های سنتی حسابداری که مشاوره‌های نادرست به کارفرمایان ارائه می‌دهند.","weeklyFocusGuilds":"تولید قطعات صنعتی، صنایع پلیمری، ریخته‌گری","plansOrPriorities":"نهایی‌سازی ۲ قرارداد جاری و تمرکز ویژه بر خدمات پیشگیرانه بازرسی اداره کار.","selfRating":5,"submittedAt":"۱۸:۰۰","createdAt":"2026-09-03T13:44:15.374Z","managerStatus":"rewarded","managerFeedback":"بهترین عملکرد هفته در تیم مشاوره. پاداش انضباط و تحقق اهداف منظور شد.","managerRating":5},{"id":"per-c102-weekly-last","consultantId":"user-c102","consultantName":"سارا علیزاده","consultantCode":"C-102","periodType":"weekly","dateShamsi":"1405/06/12","periodLabel":"گزارش هفتگی هفته دوم شهریور ۱۴۰۵","summary":"انجام ۲۹ تماس اولیه، ۸ پیگیری مرحله دوم و ۴ پیگیری مرحله سوم در صنف چاپ و صنایع غذایی.","keyAchievements":"۲ جلسه مشاوره حضوری برگزار شد و پیش‌نویس توافق‌نامه ایمنی کار ارسال گردید.","challengesOrBarriers":"عدم پاسخگویی کارفرمایان در روز چهارشنبه به دلیل سفر.","weeklyFocusGuilds":"صنایع غذایی، بسته‌بندی، دارویی","plansOrPriorities":"تمرکز بر بستن قرارداد پرونده شرکت آرد خوشه طوس.","selfRating":4,"submittedAt":"۱۶:۳۰","createdAt":"2026-09-03T13:44:15.374Z","managerStatus":"approved","managerFeedback":"گزارش دقیق و مستند؛ پیگیری پرونده آرد خوشه در اولویت قرار گیرد.","managerRating":4},{"id":"per-c104-weekly-last","consultantId":"user-c104","consultantName":"مریم حسینی","consultantCode":"C-104","periodType":"weekly","dateShamsi":"1405/06/12","periodLabel":"گزارش هفتگی هفته دوم شهریور ۱۴۰۵","summary":"تمرکز صددرصدی بر شرکت‌های فناور و پارک علم و فناوری. جذب ۲ پرونده تنظیم آیین‌نامه انضباطی کارگاهی.","keyAchievements":"عقد قرارداد با شرکت راهکارهای ابری پایا به مبلغ ۶۰ میلیون تومان.","weeklyFocusGuilds":"فناوری اطلاعات، فین‌تک، دانش‌بنیان","selfRating":5,"submittedAt":"۱۷:۴۰","createdAt":"2026-09-03T13:44:15.374Z","managerStatus":"rewarded","managerFeedback":"ورود به بازار دانش‌بنیان بسیار هوشمندانه و با بازدهی عالی بود. تبریک.","managerRating":5}]'::jsonb,
  false
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  'arch-14050611',
  'تماس‌های_روزانه_1405-06-11.xlsx',
  '1405/06/11',
  'چهارشنبه',
  '2026-09-10T12:52:00.110Z',
  'calls_daily',
  'بایگانی روزانه تماس‌ها و پیگیری‌ها',
  3,
  3,
  '[{"name":"دعاوی و شکایات در اداره کار و هیئت‌های تشخیص/حل اختلاف","count":1},{"name":"فقدان آیین‌نامه انضباطی مصوب و رویه مشخص اخراج یا توبیخ","count":1},{"name":"حوادث ناشی از کار، مسئولیت‌های مدنی و دیه کارفرمایی","count":1}]'::jsonb,
  '[{"id":"rep-c104-today","rows":[{"id":"row-c104-1","notes":"پیگیری معوق؛ تماس دوم باید فوری انجام شود.","phone":"05138447788","address":"مشهد، بلوار فلسطین، تقاطع خیام","followUp1":"+","followUp2":"+","followUp3":"","followUp4":"","rowNumber":1,"clientName":"کارفرما ابراهیمی (شرکت ابنیه عمران گستر)","meetingTopic":"مشاوره دفاعیات پرونده‌های مطروحه در هیئت‌های حل اختلاف","activityField":"پیمانکاری پروژه‌های مسکونی و تجاری","followUpResult":"حله دادا","personnelCount":115,"employerConcern":"دعاوی و شکایات در اداره کار و هیئت‌های تشخیص/حل اختلاف"}],"guild":"ساختمانی، انبوه‌سازی و تأسیسات","status":"approved","createdAt":"2026-09-02T11:34:11.215Z","updatedAt":"2026-09-08T12:11:08.180Z","dateShamsi":"1405/06/11","reviewedAt":"2026-09-08T12:11:08.180Z","submittedAt":"۱۵:۳۶","consultantId":"user-c104","managerRating":5,"consultantCode":"C-104","consultantName":"ندا کریمی","dayOfWeekShamsi":"چهارشنبه","managerFeedback":"حله پس","personalOpinion":"شرکت‌های پیمانکاری بیشترین حجم احضاریه‌های هیئت‌های تشخیص را دارند."},{"id":"rep-c102-overdue","rows":[{"id":"row-c102-overdue-1","notes":"نیازمند تماس فوری پیگیری دوم (۲ روز معوق).","phone":"05135413344","address":"شهرک صنعتی توس، فاز ۲","followUp1":"+","followUp2":"*","followUp3":"✓","followUp4":"","rowNumber":1,"clientName":"کارفرما کاظمی (صنایع بسته‌بندی ترنج سبز)","meetingTopic":"تنظیم آیین‌نامه انضباطی مصوب و الحاقیه‌های محرمانگی","activityField":"بسته‌بندی حبوبات و خشکبار صادراتی","followUpResult":"جوالدوز","personnelCount":38,"employerConcern":"فقدان آیین‌نامه انضباطی مصوب و رویه مشخص اخراج یا توبیخ"}],"guild":"صنایع غذایی و کشاورزی","status":"approved","createdAt":"2026-09-02T11:34:11.215Z","updatedAt":"2026-09-08T11:52:51.515Z","dateShamsi":"1405/06/11","reviewedAt":"2026-09-02T11:34:11.215Z","submittedAt":"۱۵:۱۴","consultantId":"user-c102","managerRating":4,"consultantCode":"C-102","consultantName":"مریم محمدی","dayOfWeekShamsi":"چهارشنبه","managerFeedback":"پشتیبانی کامل حقوقی داده شود.","personalOpinion":"صنایع غذایی ریسک بسیار بالایی در پرونده‌های بازنشستگی پیش‌ازموعد دارند."},{"id":"rep-c101-today-due-8d","rows":[{"id":"row-c101-nouri-client","notes":"پیگیری ۱ و ۲ با موفقیت انجام شده؛ امروز موعد تماس سوم برای ست کردن جلسه است.","phone":"05136514455","address":"شهرک صنعتی کلات، خیابان تلاش ۳","followUp1":"+","followUp2":"+","followUp3":"","followUp4":"","rowNumber":1,"clientName":"کارفرما نوری (تولیدی قطعات آسانسور پارس نوری)","meetingTopic":"آنالیز ریسک حقوقی قراردادها و پیشگیری از شکایات اداره کار","activityField":"تولید درب و کابین آسانسور","followUp1Date":"2026-09-02T12:50:32.294Z","followUp2Date":"2026-09-06T12:50:32.294Z","followUpResult":"","personnelCount":31,"employerConcern":"حوادث ناشی از کار، مسئولیت‌های مدنی و دیه کارفرمایی"}],"guild":"تولید تجهیزات بالابری و صنعتی","status":"approved","createdAt":"2026-09-02T12:50:32.294Z","updatedAt":"2026-09-02T12:50:32.294Z","dateShamsi":"1405/06/11","reviewedAt":"2026-09-02T12:50:32.294Z","submittedAt":"۱۷:۲۰","consultantId":"user-c101","managerRating":5,"consultantCode":"C-101","consultantName":"علیرضا رضایی","dayOfWeekShamsi":"چهارشنبه","managerFeedback":"این پرونده شانس بالایی برای تبدیل به قرارداد سالانه دارد.","personalOpinion":"نیاز جدی به استقرار نظام ایمنی و مسئولیت مدنی کارفرما دارند."}]'::jsonb,
  '[]'::jsonb,
  true
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  'arch-calls-14050610',
  'تماس‌های_روزانه_1405-06-10.xlsx',
  '1405/06/10',
  'سه‌شنبه',
  '2026-09-12T14:04:44.965Z',
  'calls_daily',
  'بایگانی روزانه تماس‌ها و پیگیری‌ها',
  2,
  4,
  '[{"name":"چالش محاسبه اضافه کاری، شب‌کاری، نوبت‌کاری و تعطیل‌کاری","count":1},{"name":"دعاوی و شکایات در اداره کار و هیئت‌های تشخیص/حل اختلاف","count":1},{"name":"حوادث ناشی از کار، مسئولیت‌های مدنی و دیه کارفرمایی","count":1},{"name":"عدم رعایت دوره‌های آزمایشی و بلاتکلیفی حقوقی قراردادهای موقت","count":1}]'::jsonb,
  '[{"id":"rep-c101-overdue-9d","rows":[{"id":"row-c101-rezaei-client","notes":"تماس دوم عالی بود؛ پیش‌فاکتور ارسال شده و برای نهایی‌سازی نیاز به پیگیری ۳ دارد.","phone":"05135429988","address":"شهرک صنعتی فناوری‌های برتر، صنعت ۴","followUp1":"+","followUp2":"+","followUp3":"","followUp4":"","rowNumber":1,"clientName":"کارفرما رضایی (صنایع بسته‌بندی آرین نگین)","meetingTopic":"تراز فیش حقوقی و بهینه‌سازی فرآیندهای بیمه تأمین اجتماعی","activityField":"تولید جعبه‌های دارویی و صادراتی","followUp1Date":"2026-09-01T12:50:32.294Z","followUp2Date":"2026-09-05T12:50:32.294Z","followUpResult":"","personnelCount":52,"employerConcern":"چالش محاسبه اضافه کاری، شب‌کاری، نوبت‌کاری و تعطیل‌کاری"}],"guild":"صنایع چاپ و بسته‌بندی صادراتی","status":"approved","createdAt":"2026-09-01T12:50:32.294Z","updatedAt":"2026-09-01T12:50:32.294Z","dateShamsi":"1405/06/10","reviewedAt":"2026-09-01T12:50:32.294Z","submittedAt":"۱۵:۰۰","consultantId":"user-c101","managerRating":5,"consultantCode":"C-101","consultantName":"علیرضا رضایی","dayOfWeekShamsi":"سه‌شنبه","managerFeedback":"پیگیری سوم کارفرما رضایی برای نهایی‌سازی قرارداد مشاوره بسیار حساس است.","personalOpinion":"چاپخانه‌ها با مسائل بیمه تأمین اجتماعی کارگران شیفت شب درگیرند."},{"id":"rep-seed-5","rows":[{"id":"row-seed-5-1","notes":"بیش از ۶ روز از تماس اول گذشته؛ نیازمند تماس فوری پیگیری دوم (معوق).","phone":"05138447788","address":"مشهد، بلوار فلسطین، تقاطع خیام","followUp1":"+","followUp2":"✓","followUp3":"","followUp4":"","rowNumber":1,"clientName":"شرکت ساختمانی و ابنیه عمران گستر پارس","meetingTopic":"محرمانگی","activityField":"پیمانکاری پروژه‌های مسکونی و تجاری","followUpResult":"جلسه در حال ست","personnelCount":115,"employerConcern":"دعاوی و شکایات در اداره کار و هیئت‌های تشخیص/حل اختلاف"},{"id":"row-seed-5-2","notes":"پیگیری معوق؛ در انتظار تماس بعدی.","phone":"05137682211","address":"مشهد، بلوار پیروزی، نبش پیروزی ۳۴","followUp1":"+","followUp2":"✓","followUp3":"","followUp4":"","rowNumber":2,"clientName":"تأسیسات سرمایش و گرمایش آریا سازه","meetingTopic":"","activityField":"اجرای موتورخانه و تأسیسات برج‌ها","followUpResult":"جلسه تیک","personnelCount":29,"employerConcern":"حوادث ناشی از کار، مسئولیت‌های مدنی و دیه کارفرمایی"},{"id":"row-seed-5-3","notes":"تماس اولیه منفی بود و خاتمه یافت.","phone":"05132459900","address":"جاده سیمان، کیلومتر ۴","followUp1":"-","followUp2":"","followUp3":"","followUp4":"","rowNumber":3,"clientName":"تولیدی سازه‌های بتنی پایدار","meetingTopic":"","activityField":"تیرچه، بلوک و قطعات پیش‌ساخته بتنی","followUpResult":"- (عدم تمایل به تغییر رویه فعلی)","personnelCount":18,"employerConcern":"عدم رعایت دوره‌های آزمایشی و بلاتکلیفی حقوقی قراردادهای موقت"}],"guild":"ساختمانی، انبوه‌سازی و تأسیسات","status":"approved","createdAt":"2026-09-01T08:52:10.140Z","updatedAt":"2026-09-08T10:44:52.908Z","dateShamsi":"1405/06/10","reviewedAt":"2026-09-08T10:44:52.908Z","submittedAt":"۱۴:۱۳","consultantId":"user-c104","managerRating":5,"consultantCode":"C-104","consultantName":"ندا کریمی","dayOfWeekShamsi":"سه‌شنبه","managerFeedback":"آفرین ","personalOpinion":"شرکت‌های پیمانکاری ساختمانی"}]'::jsonb,
  '[]'::jsonb,
  true
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  'arch-14050609',
  'تماس‌های_روزانه_1405-06-09.xlsx',
  '1405/06/09',
  'دوشنبه',
  '2026-09-09T10:05:47.573Z',
  'calls_daily',
  'بایگانی روزانه تماس‌ها و پیگیری‌ها',
  1,
  1,
  '[{"name":"چالش محاسبه اضافه کاری، شب‌کاری، نوبت‌کاری و تعطیل‌کاری","count":1}]'::jsonb,
  '[{"id":"rep-c101-overdue-9d","rows":[{"id":"row-c101-rezaei-client","notes":"تماس دوم عالی بود؛ پیش‌فاکتور ارسال شده و برای نهایی‌سازی نیاز به پیگیری ۳ دارد.","phone":"05135429988","address":"شهرک صنعتی فناوری‌های برتر، صنعت ۴","followUp1":"+","followUp2":"+","followUp3":"","followUp4":"","rowNumber":1,"clientName":"کارفرما رضایی (صنایع بسته‌بندی آرین نگین)","meetingTopic":"تراز فیش حقوقی و بهینه‌سازی فرآیندهای بیمه تأمین اجتماعی","activityField":"تولید جعبه‌های دارویی و صادراتی","followUpResult":"","personnelCount":52,"employerConcern":"چالش محاسبه اضافه کاری، شب‌کاری، نوبت‌کاری و تعطیل‌کاری"}],"guild":"صنایع چاپ و بسته‌بندی صادراتی","status":"approved","createdAt":"2026-08-31T10:05:47.491Z","updatedAt":"2026-08-31T10:05:47.491Z","dateShamsi":"1405/06/09","reviewedAt":"2026-08-31T10:05:47.491Z","submittedAt":"۱۵:۰۰","consultantId":"user-c101","managerRating":5,"consultantCode":"C-101","consultantName":"علیرضا رضایی","dayOfWeekShamsi":"دوشنبه","managerFeedback":"پیگیری سوم کارفرما رضایی برای نهایی‌سازی قرارداد مشاوره بسیار حساس است.","personalOpinion":"چاپخانه‌ها با مسائل بیمه تأمین اجتماعی کارگران شیفت شب درگیرند."}]'::jsonb,
  '[]'::jsonb,
  true
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  'arch-14050608',
  'تماس‌های_روزانه_1405-06-08.xlsx',
  '1405/06/08',
  'یکشنبه',
  '2026-09-08T11:34:11.255Z',
  'calls_daily',
  'بایگانی روزانه تماس‌ها و پیگیری‌ها',
  1,
  1,
  '[{"name":"چالش محاسبه اضافه کاری، شب‌کاری، نوبت‌کاری و تعطیل‌کاری","count":1}]'::jsonb,
  '[{"id":"rep-c101-overdue-9d","rows":[{"id":"row-c101-rezaei-client","notes":"تماس دوم عالی بود؛ پیش‌فاکتور ارسال شده و برای نهایی‌سازی نیاز به پیگیری ۳ دارد.","phone":"05135429988","address":"شهرک صنعتی فناوری‌های برتر، صنعت ۴","followUp1":"+","followUp2":"+","followUp3":"","followUp4":"","rowNumber":1,"clientName":"کارفرما رضایی (صنایع بسته‌بندی آرین نگین)","meetingTopic":"تراز فیش حقوقی و بهینه‌سازی فرآیندهای بیمه تأمین اجتماعی","activityField":"تولید جعبه‌های دارویی و صادراتی","followUpResult":"","personnelCount":52,"employerConcern":"چالش محاسبه اضافه کاری، شب‌کاری، نوبت‌کاری و تعطیل‌کاری"}],"guild":"صنایع چاپ و بسته‌بندی صادراتی","status":"approved","createdAt":"2026-08-30T11:34:11.215Z","updatedAt":"2026-08-30T11:34:11.215Z","dateShamsi":"1405/06/08","reviewedAt":"2026-08-30T11:34:11.215Z","submittedAt":"۱۵:۰۰","consultantId":"user-c101","managerRating":5,"consultantCode":"C-101","consultantName":"علیرضا رضایی","dayOfWeekShamsi":"یکشنبه","managerFeedback":"پیگیری سوم کارفرما رضایی برای نهایی‌سازی قرارداد مشاوره بسیار حساس است.","personalOpinion":"چاپخانه‌ها با مسائل بیمه تأمین اجتماعی کارگران شیفت شب درگیرند."}]'::jsonb,
  '[]'::jsonb,
  true
)
ON CONFLICT (id) DO NOTHING;

INSERT INTO public.archives (id, file_name, date_shamsi, day_of_week, timestamp, archive_type, period_title, total_consultants, total_clients_contacted, top_concerns, reports_snapshot, overall_reports_snapshot, auto_generated)
VALUES (
  'arch-periodic_monthly-14050531',
  'بایگانی_ماهانه_پایان_ماه_استراتژیک_1405-05-31.xlsx',
  '1405/05/31',
  'جمعه',
  '2026-09-10T14:10:57.813Z',
  'periodic_monthly',
  'بایگانی ماهانه پایان ماه گزارشات استراتژیک (مرداد ماه)',
  3,
  0,
  '[]'::jsonb,
  '[]'::jsonb,
  '[{"id":"per-c101-monthly-mordad","summary":"مجموع ۱۲۲ تماس هدفمند در طول ماه؛ تحقق ۱۸ جلسه حضوری و انعقاد ۷ قرارداد رسمی مشاوره مدیریت و حقوق کار.","dateShamsi":"1405/05/31","periodType":"monthly","selfRating":5,"periodLabel":"گزارش راهبردی عملکرد مرداد ماه ۱۴۰۵","submittedAt":"۱۹:۳۰","consultantId":"user-c101","managerRating":5,"managerStatus":"rewarded","consultantCode":"C-101","consultantName":"علیرضا رضایی","keyAchievements":"ثبت بالاترین حجم وصول درآمد مشاوره‌ای در تاریخ شعبه مشهد و بازنگری چارت سازمانی ۲ کارخانه بزرگ.","managerFeedback":"عملکرد استثنایی و الگوی سازمانی؛ پاداش مدیریتی ویژه مرداد ماه اعطا گردید.","plansOrPriorities":"راه‌اندازی کارگروه تخصصی ممیزی تامین اجتماعی و دفاع در هیئت‌های بدوی برای شهریور ماه.","challengesOrBarriers":"طولانی بودن فرآیند استعلام سوابق تامین اجتماعی کارگران در شعب ۳ و ۴ مشهد.","monthlyStrategicNotes":"پیشنهاد می‌شود یک بسته جامع اختصاصی شامل ۳ خدمت (آیین‌نامه انضباطی + آنالیز قرارداد + بررسی بیمه) با تخفیف ترکیبی برای صنایع مستقر در شهرک توس تعریف شود."},{"id":"per-c102-monthly-mordad","summary":"مجموع ۱۰۸ تماس با صنایع تبدیلی و کشاورزی استان خراسان؛ ۱۲ جلسه نهایی شده و ۴ قرارداد منعقد شده.","dateShamsi":"1405/05/31","periodType":"monthly","selfRating":5,"periodLabel":"گزارش راهبردی عملکرد مرداد ماه ۱۴۰۵","submittedAt":"۱۹:۴۵","consultantId":"user-c102","managerRating":5,"managerStatus":"approved","consultantCode":"C-102","consultantName":"مریم محمدی","keyAchievements":"برگزاری سمینار آموزشی درون‌سازمانی نحوه تعامل با بازرسان تامین اجتماعی برای ۳ واحد صنعتی.","managerFeedback":"تحلیل دقیق بازار و وفادارسازی مطلوب کارفرمایان.","plansOrPriorities":"گسترش بازاریابی در شهرک‌های صنعتی چناران و نیشابور.","challengesOrBarriers":"نوسانات فصلی تولید در صنایع غذایی که باعث نوسان تعداد پرسنل می‌شود.","monthlyStrategicNotes":"ایجاد میز تخصصی صنایع غذایی در پرتال کارینو می‌تواند اعتبار برند را به شکل تصاعدی افزایش دهد."},{"id":"per-c103-monthly-mordad","summary":"۹۸ تماس در حوزه لجستیک و توزیع کالا در تهران و مشهد؛ ۱۰ جلسه حضوری و ۳ قرارداد بلندمدت نظارت حقوقی.","dateShamsi":"1405/05/31","periodType":"monthly","selfRating":4,"periodLabel":"گزارش راهبردی عملکرد مرداد ماه ۱۴۰۵","submittedAt":"۲۰:۰۰","consultantId":"user-c103","managerRating":5,"managerStatus":"approved","consultantCode":"C-103","consultantName":"سعید حسینی","keyAchievements":"نفوذ موفق در شرکت‌های توزیع و پخش مویرگی شوینده و بهداشتی.","managerFeedback":"بسیار ارزشمند و آینده‌نگرانه.","plansOrPriorities":"توسعه خدمات ارزیابی ویزیتورها و استانداردسازی ضمانت‌نامه‌ها.","challengesOrBarriers":"نیاز به هماهنگی بیشتر با مشاوران مالیاتی در پرونده‌های توزیع.","monthlyStrategicNotes":"پیشنهاد می‌شود سمینار یک‌روزه مدیریت ریسک قراردادهای توزیع و فروش برای مدیران عامل شرکت‌های پخش برگزار شود."}]'::jsonb,
  false
)
ON CONFLICT (id) DO NOTHING;
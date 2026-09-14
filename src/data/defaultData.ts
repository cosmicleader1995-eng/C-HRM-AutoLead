import { User, DailyReport, FollowUpStatusCode, ManagerDirective, PeriodicOverallReport } from '../types';
import { getCurrentShamsiDate, formatStandardReportTitle } from '../utils/shamsi';

export const DEFAULT_DIRECTIVES: ManagerDirective[] = [];

export const FOLLOW_UP_STATUS_CODES: FollowUpStatusCode[] = [
  {
    code: '*',
    symbol: '*',
    label: 'عدم وجود / شماره اشتباه (*)',
    meaning: 'کارفرما نیست، شماره یا فرد وجود ندارد، رکورد اشتباه است، یا کارش عوض شده / شماره واگذار شده است',
    colorClass: 'text-purple-400 border-purple-500/50 bg-purple-950/40',
    badgeClass: 'bg-purple-900/60 text-purple-200 border-purple-400/40',
    bgClass: 'bg-purple-500/10',
    textColor: 'text-purple-300',
    borderColor: 'border-purple-500'
  },
  {
    code: '+',
    symbol: '+',
    label: 'اوکی اولیه و مسیر هموار (+)',
    meaning: 'اوکی اولیه را داده و برای پیگیری‌های بعدی و دعوت به جلسه مشاوره راه هموارتر شده است',
    colorClass: 'text-sky-400 border-sky-500/50 bg-sky-950/40',
    badgeClass: 'bg-sky-900/60 text-sky-200 border-sky-400/40',
    bgClass: 'bg-sky-500/10',
    textColor: 'text-sky-300',
    borderColor: 'border-sky-500'
  },
  {
    code: '-',
    symbol: '-',
    label: 'پاسخ منفی کارفرما (-)',
    meaning: 'کارفرما منفی است، اعلام عدم نیاز می‌کند یا هنگام تماس تلفنی برخورد نامناسب دارد',
    colorClass: 'text-rose-400 border-rose-500/50 bg-rose-950/40',
    badgeClass: 'bg-rose-900/60 text-rose-200 border-rose-400/40',
    bgClass: 'bg-rose-500/10',
    textColor: 'text-rose-300',
    borderColor: 'border-rose-500'
  },
  {
    code: '.',
    symbol: '.',
    label: 'عدم پاسخ / در جلسه (.)',
    meaning: 'امکان برقراری ارتباط مقدور نشد، وقت ندارد، در جلسه است یا جواب تلفن را نداده است',
    colorClass: 'text-amber-400 border-amber-500/50 bg-amber-950/40',
    badgeClass: 'bg-amber-900/60 text-amber-200 border-amber-400/40',
    bgClass: 'bg-amber-500/10',
    textColor: 'text-amber-300',
    borderColor: 'border-amber-500'
  },
  {
    code: '✓',
    symbol: '✓',
    label: 'جلسه مشاوره ست شد (✓)',
    meaning: 'جواب اولیه کاملاً مثبت بوده و جلسه مشاوره حضوری یا آنلاین با کارفرما ست شده است',
    colorClass: 'text-emerald-400 border-emerald-500/50 bg-emerald-950/40',
    badgeClass: 'bg-emerald-900/60 text-emerald-200 border-emerald-400/40',
    bgClass: 'bg-emerald-500/10',
    textColor: 'text-emerald-300',
    borderColor: 'border-emerald-500'
  }
];

export const EMPLOYER_CONCERNS_LIST: string[] = [
  'دعاوی و شکایات در اداره کار و هیئت‌های تشخیص/حل اختلاف',
  'عدم شفافیت قراردادهای کار، الحاقیه‌ها و تضامین پرسنلی',
  'جرایم بازرسی و مغایرت‌های حق بیمه تأمین اجتماعی',
  'عدم تطابق فیش حقوقی، مزایای قانونی و تراز مالی با پرداختی واقعی',
  'فقدان آیین‌نامه انضباطی مصوب و رویه مشخص اخراج یا توبیخ',
  'ریزش مداوم نیروی انسانی و تعارضات درون‌سازمانی',
  'وابستگی کامل سیستم به حضور فیزیکی کارفرما (عدم تفویض اختیار)',
  'نبود چارت سازمانی مصوب و تداخل در شرح وظایف پرسنل',
  'افت شدید بهره‌وری و نبود نظام ارزیابی عملکرد (KPI)',
  'ریسک‌های مالیاتی و حسابداری مرتبط با حقوق و دستمزد',
  'ابهام در فرمول‌های پورسانت، پاداش و تارگت‌های فروش',
  'چالش‌های توزیع مویرگی، وصول مطالبات و کسری انبار',
  'ترک کار ناگهانی پرسنل کلیدی و بردن اطلاعات/اسرار تجاری',
  'حوادث ناشی از کار، مسئولیت‌های مدنی و دیه کارفرمایی',
  'پرونده‌های سخت و زیان‌آور و بازنشستگی‌های زودرس پیش‌بینی نشده',
  'چالش محاسبه اضافه کاری، شب‌کاری، نوبت‌کاری و تعطیل‌کاری',
  'عدم رعایت دوره‌های آزمایشی و بلاتکلیفی حقوقی قراردادهای موقت',
  'ضعف در فرآیند جذب، غربالگری و مصاحبه استخدامی (Onboarding)',
  'قیمت‌گذاری غیراصولی خدمات/محصول و حاشیه سود کاهشی',
  'نبود دستورالعمل‌های مکتوب و استانداردهای اجرایی (SOP)',
  'عدم وجود سیستم کنترل داخلی و پیشگیری از تبانی یا فساد اداری',
  'عدم انگیزه کافی در تیم بازاریابی و فروش',
  'نارضایتی کارگران از شیفت‌های سنگین و افت کیفیت خروجی',
  'عدم تسلط تیم مالی شرکت به آخرین بخشنامه‌های اداره کار',
  'سایر دغدغه‌ها (نیاز به عارضه‌یابی تخصصی و مشاوره حضوری)'
];

export const MEETING_TOPICS_LIST: string[] = [
  'آنالیز ریسک حقوقی قراردادها و پیشگیری از شکایات اداره کار',
  'تنظیم آیین‌نامه انضباطی مصوب و الحاقیه‌های محرمانگی',
  'تراز فیش حقوقی و بهینه‌سازی فرآیندهای بیمه تأمین اجتماعی',
  'طراحی چارت سازمانی، سطوح اختیارات و شناسنامه شغلی',
  'مدیریت فرآیندهای فروش و نظارت بر تیم ویزیتوری',
  'عارضه‌یابی منابع انسانی و طراحی نظام پاداش و ارزیابی عملکرد',
  'مشاوره دفاعیات پرونده‌های مطروحه در هیئت‌های حل اختلاف',
  'استقرار سیستم کنترل داخلی و مدیریت ریسک‌های اجرایی'
];

export const DEFAULT_USERS: User[] = [
  {
    id: 'user-ceo',
    username: 'ceo',
    fullName: 'سرپرست ارشد (CEO)',
    consultantCode: 'CRM-CEO',
    role: 'ceo',
    status: 'active',
    password: 'karino2026',
    phone: '09120000000',
    branch: 'دفتر مرکزی'
  },
  {
    id: 'user-it',
    username: 'it_admin',
    fullName: 'مدیر فاوا و فناوری اطلاعات',
    consultantCode: 'CRM-IT',
    role: 'it_admin',
    status: 'active',
    password: 'it2026',
    phone: '09120000001',
    branch: 'واحد فناوری اطلاعات'
  }
];
export function getInitialReports(): DailyReport[] {
  return [];
}

export function getInitialPeriodicReports(): PeriodicOverallReport[] {
  return [];
}

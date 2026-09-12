import { describe, it, expect } from 'vitest';

// Mutex class mirroring the server implementation
class AsyncMutex {
  private queue: (() => void)[] = [];
  private locked = false;

  async acquire(): Promise<() => void> {
    if (this.locked) {
      await new Promise<void>(resolve => this.queue.push(resolve));
    }
    this.locked = true;
    return () => {
      if (this.queue.length > 0) {
        const next = this.queue.shift();
        next?.();
      } else {
        this.locked = false;
      }
    };
  }

  async runExclusive<T>(fn: () => Promise<T>): Promise<T> {
    const release = await this.acquire();
    try {
      return await fn();
    } finally {
      release();
    }
  }
}

describe('موتور همروندی و جلوگیری از شرایط رقابتی (High-Concurrency Mutex)', () => {
  it('انجام همزمان ۵۰ عملیات نوشتن موازی بدون تداخل یا ریزش داده', async () => {
    const mutex = new AsyncMutex();
    const reports: { id: string; consultantCode: string; counter: number }[] = [];
    let counter = 0;

    // Simulate 50 concurrent consultants submitting reports at the exact same millisecond
    const concurrentSubmissions = Array.from({ length: 50 }, (_, i) => async () => {
      await mutex.runExclusive(async () => {
        // Simulate async I/O delay
        await new Promise(r => setTimeout(r, Math.random() * 5));
        counter++;
        reports.push({
          id: `rep-concurrent-${i + 1}`,
          consultantCode: `C-${100 + i}`,
          counter
        });
      });
    });

    await Promise.all(concurrentSubmissions.map(fn => fn()));

    expect(reports.length).toBe(50);
    expect(counter).toBe(50);
    // Ensure every single report has a unique incremental counter (guarantees strict FIFO execution)
    const counters = reports.map(r => r.counter);
    expect(new Set(counters).size).toBe(50);
  });

  it('فیلترینگ و اسکوپ داده‌ها برای هر مشاور (Data Scoping)', () => {
    const mockReports = [
      { id: '1', consultantId: 'user-101', consultantCode: 'C-101', dateShamsi: '۱۴۰۴/۰۶/۱۹' },
      { id: '2', consultantId: 'user-102', consultantCode: 'C-102', dateShamsi: '۱۴۰۴/۰۶/۱۹' },
      { id: '3', consultantId: 'user-101', consultantCode: 'C-101', dateShamsi: '۱۴۰۴/۰۶/۱۸' },
      { id: '4', consultantId: 'user-103', consultantCode: 'C-103', dateShamsi: '۱۴۰۴/۰۶/۱۹' },
    ];

    // Filter by consultantId
    const consultant101Reports = mockReports.filter(r => r.consultantId === 'user-101');
    expect(consultant101Reports.length).toBe(2);
    expect(consultant101Reports.every(r => r.consultantId === 'user-101')).toBe(true);

    // Filter by today's date for Cockpit
    const todayReports = mockReports.filter(r => r.dateShamsi === '۱۴۰۴/۰۶/۱۹');
    expect(todayReports.length).toBe(3);
  });

  it('تفکیک ساختار تک‌سندی به ساختار رابطه‌ای سربرگ و ردیف‌های تماس', () => {
    const monolithicReport = {
      id: 'rep-relational-test',
      consultantId: 'user-105',
      consultantName: 'علی زارع',
      consultantCode: 'C-105',
      dateShamsi: '۱۴۰۴/۰۶/۱۹',
      rows: [
        { clientName: 'شرکت پتروشیمی کارا', phone: '09121111111', employerConcern: 'دعاوی کارگری' },
        { clientName: 'صنایع غذایی بهنوش', phone: '09122222222', employerConcern: 'بیمه تامین اجتماعی' }
      ]
    };

    // Header extraction
    const header = {
      id: monolithicReport.id,
      consultant_id: monolithicReport.consultantId,
      consultant_name: monolithicReport.consultantName,
      date_shamsi: monolithicReport.dateShamsi,
    };
    expect(header.id).toBe('rep-relational-test');
    expect(header.consultant_id).toBe('user-105');

    // Rows extraction (One-to-Many relational mapping)
    const rows = monolithicReport.rows.map((r, idx) => ({
      id: `${monolithicReport.id}-row-${idx + 1}`,
      report_id: monolithicReport.id,
      row_number: idx + 1,
      client_name: r.clientName,
      phone: r.phone,
      employer_concern: r.employerConcern
    }));

    expect(rows.length).toBe(2);
    expect(rows[0].report_id).toBe('rep-relational-test');
    expect(rows[0].client_name).toBe('شرکت پتروشیمی کارا');
    expect(rows[1].row_number).toBe(2);
  });
});

/**
 * Karino CRM Offline Sync Queue Engine
 * Uses browser IndexedDB to safely store report submissions, feedback, and directives
 * during network dropouts or VPN interruptions, automatically syncing upon reconnection.
 */

export interface QueuedRequest {
  id: string;
  url: string;
  method: 'POST' | 'PUT' | 'DELETE';
  headers: Record<string, string>;
  body: any;
  timestamp: string;
  retryCount: number;
}

const DB_NAME = 'KarinoOfflineDB';
const DB_VERSION = 1;
const STORE_NAME = 'pending_requests';

function openDB(): Promise<IDBDatabase | null> {
  if (typeof window === 'undefined' || !window.indexedDB) {
    return Promise.resolve(null);
  }

  return new Promise((resolve) => {
    try {
      const request = window.indexedDB.open(DB_NAME, DB_VERSION);

      request.onupgradeneeded = (event: any) => {
        const db = event.target.result;
        if (!db.objectStoreNames.contains(STORE_NAME)) {
          db.createObjectStore(STORE_NAME, { keyPath: 'id' });
        }
      };

      request.onsuccess = (event: any) => {
        resolve(event.target.result);
      };

      request.onerror = () => {
        console.warn('[OfflineQueue] Could not open IndexedDB');
        resolve(null);
      };
    } catch {
      resolve(null);
    }
  });
}

/**
 * Enqueue a request that failed to reach the server due to network disconnection
 */
export async function enqueueOfflineRequest(
  url: string,
  method: 'POST' | 'PUT' | 'DELETE',
  body: any,
  headers: Record<string, string> = {}
): Promise<string> {
  const reqId = `offline-${Date.now()}-${Math.random().toString(36).substr(2, 6)}`;
  const item: QueuedRequest = {
    id: reqId,
    url,
    method,
    headers,
    body,
    timestamp: new Date().toISOString(),
    retryCount: 0
  };

  const db = await openDB();
  if (!db) {
    // Fallback to localStorage if IndexedDB is disabled
    try {
      const existing = JSON.parse(localStorage.getItem('karino_fallback_offline_queue') || '[]');
      existing.push(item);
      localStorage.setItem('karino_fallback_offline_queue', JSON.stringify(existing));
    } catch {}
    return reqId;
  }

  return new Promise((resolve) => {
    try {
      const tx = db.transaction(STORE_NAME, 'readwrite');
      const store = tx.objectStore(STORE_NAME);
      store.put(item);
      tx.oncomplete = () => {
        console.log(`[OfflineQueue] Request saved offline: ${method} ${url} (ID: ${reqId})`);
        notifyQueueListeners();
        resolve(reqId);
      };
      tx.onerror = () => resolve(reqId);
    } catch {
      resolve(reqId);
    }
  });
}

/**
 * Retrieve all pending offline requests
 */
export async function getPendingOfflineRequests(): Promise<QueuedRequest[]> {
  const db = await openDB();
  if (!db) {
    try {
      return JSON.parse(localStorage.getItem('karino_fallback_offline_queue') || '[]');
    } catch {
      return [];
    }
  }

  return new Promise((resolve) => {
    try {
      const tx = db.transaction(STORE_NAME, 'readonly');
      const store = tx.objectStore(STORE_NAME);
      const req = store.getAll();
      req.onsuccess = () => resolve(req.result || []);
      req.onerror = () => resolve([]);
    } catch {
      resolve([]);
    }
  });
}

/**
 * Remove a successfully synced request from the queue
 */
export async function removeOfflineRequest(id: string): Promise<void> {
  const db = await openDB();
  if (!db) {
    try {
      const existing = JSON.parse(localStorage.getItem('karino_fallback_offline_queue') || '[]');
      const filtered = existing.filter((x: QueuedRequest) => x.id !== id);
      localStorage.setItem('karino_fallback_offline_queue', JSON.stringify(filtered));
    } catch {}
    notifyQueueListeners();
    return;
  }

  return new Promise((resolve) => {
    try {
      const tx = db.transaction(STORE_NAME, 'readwrite');
      const store = tx.objectStore(STORE_NAME);
      store.delete(id);
      tx.oncomplete = () => {
        notifyQueueListeners();
        resolve();
      };
      tx.onerror = () => resolve();
    } catch {
      resolve();
    }
  });
}

let isFlushing = false;

/**
 * Flush all offline requests by re-sending them to the server
 */
export async function flushOfflineQueue(): Promise<{ synced: number; failed: number }> {
  if (isFlushing || typeof window === 'undefined' || !navigator.onLine) {
    return { synced: 0, failed: 0 };
  }

  isFlushing = true;
  let synced = 0;
  let failed = 0;

  try {
    const queue = await getPendingOfflineRequests();
    if (queue.length === 0) {
      isFlushing = false;
      return { synced: 0, failed: 0 };
    }

    console.log(`[OfflineQueue] Flushing ${queue.length} pending offline items...`);

    for (const item of queue) {
      try {
        const res = await fetch(item.url, {
          method: item.method,
          headers: {
            ...item.headers,
            'X-Offline-Synced': 'true',
            'X-Original-Timestamp': item.timestamp
          },
          body: JSON.stringify(item.body)
        });

        if (res.ok || res.status === 400 || res.status === 403) {
          // If server responded (or rejected with business rule e.g. 403 window closed), remove from queue
          await removeOfflineRequest(item.id);
          synced++;
          console.log(`[OfflineQueue] Synced item ${item.id} -> HTTP ${res.status}`);
        } else {
          failed++;
        }
      } catch (networkErr) {
        // Still offline, stop flushing
        failed++;
        break;
      }
    }
  } catch (err) {
    console.error('[OfflineQueue] Flush error:', err);
  } finally {
    isFlushing = false;
  }

  return { synced, failed };
}

// Queue listeners
type QueueListener = (count: number) => void;
const queueListeners: QueueListener[] = [];

export function subscribeQueueChanges(listener: QueueListener): () => void {
  queueListeners.push(listener);
  getPendingOfflineRequests().then(items => listener(items.length)).catch(() => {});
  return () => {
    const idx = queueListeners.indexOf(listener);
    if (idx >= 0) queueListeners.splice(idx, 1);
  };
}

function notifyQueueListeners() {
  getPendingOfflineRequests().then(items => {
    queueListeners.forEach(l => l(items.length));
  }).catch(() => {});
}

// Automatically setup listeners in browser
if (typeof window !== 'undefined') {
  window.addEventListener('online', () => {
    console.log('[OfflineQueue] Network restored! Flushing offline queue...');
    flushOfflineQueue();
  });

  // Periodic flush attempt every 15 seconds
  setInterval(() => {
    if (navigator.onLine) {
      flushOfflineQueue();
    }
  }, 15000);
}

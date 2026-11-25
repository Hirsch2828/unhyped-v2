import { createClient } from '@supabase/supabase-js';

// One server-side client for all functions. Never import this in the browser.
export const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SECRET_KEY,
  { auth: { persistSession: false } }
);

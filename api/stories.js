import { supabase } from '../lib/supabase.js';

// Milestone 1: only ?topics=1 (list of active topics).
// ?topic= and ?id= are added in Milestone 2 and 3.
export default async function handler(req, res) {
  res.setHeader('Content-Type', 'application/json');

  if (req.method !== 'GET') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  if (req.query.topics) {
    const { data, error } = await supabase
      .from('topics')
      .select('slug, name_en, name_he, kind, ticker')
      .eq('active', true)
      .order('sort_order');

    if (error) {
      console.error('topics query failed', error);
      return res.status(500).json({ error: 'Could not load topics' });
    }
    return res.status(200).json({ topics: data });
  }

  return res.status(400).json({ error: 'Unknown request' });
}

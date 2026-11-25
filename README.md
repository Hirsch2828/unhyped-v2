# Unhyped v2

Personal news, no hype. Spec: see the numbered files in the parent folder (1–11).

## Milestone 1: Walking Skeleton
- Supabase project: `unhyped-v2` (eu-central-1). Migration: `supabase/migrations/001_init.sql`.
- Vercel env vars: `SUPABASE_URL` (Config), `SUPABASE_SECRET_KEY` (Secret, Production + Preview).
- n8n: import `n8n/hourly-update.json`, add a Supabase credential, run once by hand.

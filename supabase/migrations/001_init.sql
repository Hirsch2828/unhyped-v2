-- Unhyped v2: Milestone 1
-- 2 of the 3 tables (profiles comes in Milestone 5).
-- RLS on, no policies, no access for anon/authenticated. Only service_role (functions + n8n).

create table public.topics (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  name_en text not null,
  name_he text not null,
  kind text not null check (kind in ('public_company','sports_team','field')),
  ticker text,
  feeds jsonb not null default '[]'::jsonb,
  keywords jsonb not null default '[]'::jsonb,
  is_preset boolean not null default true,
  active boolean not null default true,
  sort_order int not null default 0,
  last_run_at timestamptz
);

create table public.stories (
  id uuid primary key default gen_random_uuid(),
  topic_id uuid not null references public.topics(id) on delete cascade,
  headline jsonb not null,
  sections jsonb not null,
  label text not null check (label in ('official','report','rumor')),
  sentiment text check (sentiment in ('positive','negative','neutral')),
  sentiment_strength int check (sentiment_strength between 1 and 3),
  importance int not null check (importance between 1 and 10),
  sources jsonb not null default '[]'::jsonb,
  hidden boolean not null default false,
  edited_by_admin boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index stories_topic_updated_idx on public.stories (topic_id, updated_at desc);

alter table public.topics enable row level security;
alter table public.stories enable row level security;

revoke all on public.topics from anon, authenticated;
revoke all on public.stories from anon, authenticated;

grant select, insert, update on public.topics to service_role;
grant select, insert, update on public.stories to service_role;

insert into public.topics (slug, name_en, name_he, kind, ticker, keywords, sort_order) values
  ('tesla',    'Tesla',    'טסלה',     'public_company', 'TSLA', '["Tesla","TSLA","Elon Musk","Cybertruck","Model Y","Robotaxi"]', 1),
  ('nvidia',   'NVIDIA',   'אנבידיה',  'public_company', 'NVDA', '["Nvidia","NVDA","Jensen Huang","Blackwell","GPU"]', 2),
  ('ai',       'AI',       'בינה מלאכותית', 'field',     null,   '["artificial intelligence","AI model","LLM","OpenAI","Anthropic","Google DeepMind"]', 3),
  ('arsenal',  'Arsenal',  'ארסנל',    'sports_team',    null,   '["Arsenal","Gunners","Arteta","Emirates Stadium"]', 4),
  ('robotics', 'Robotics', 'רובוטיקה', 'field',          null,   '["robot","robotics","humanoid","Optimus","Boston Dynamics","Figure AI"]', 5);

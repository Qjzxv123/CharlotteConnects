create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  name text not null,
  age smallint check (age >= 18),
  major text,
  year text,
  bio text,
  image_url text,
  interests text[] default '{}',
  created_at timestamptz not null default now()
);

create table public.likes (
  id bigint generated always as identity primary key,
  from_profile uuid not null references public.profiles(id) on delete cascade,
  to_profile uuid not null references public.profiles(id) on delete cascade,
  created_at timestamptz not null default now(),
  unique (from_profile, to_profile),
  check (from_profile <> to_profile)
);

alter table public.profiles enable row level security;
alter table public.likes enable row level security;

create policy "Signed-in students can view profiles"
  on public.profiles for select to authenticated using (true);

create policy "Students can manage their own profile"
  on public.profiles for all to authenticated
  using ((select auth.uid()) = id)
  with check ((select auth.uid()) = id);

create policy "Students can create their own likes"
  on public.likes for insert to authenticated
  with check ((select auth.uid()) = from_profile);

create policy "Students can view their own likes"
  on public.likes for select to authenticated
  using ((select auth.uid()) = from_profile or (select auth.uid()) = to_profile);

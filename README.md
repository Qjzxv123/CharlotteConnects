# Connects

A thoughtful dating and connection app for UNC Charlotte students. The client is built with Vite, vanilla HTML/CSS/JavaScript, Supabase Auth, and a Supabase-ready data model.

## Run locally

```bash
npm install
copy .env.example .env.local
npm run dev
```

Add your Supabase project URL and anon key to `.env.local`. Without credentials, the app still runs in demo mode, validates Charlotte student addresses locally, and requires a profile before discovery is available.

## Supabase setup

1. Create a Supabase project.
2. In Authentication > Providers, enable Email and configure the site URL.
3. Run `supabase/schema.sql` in the SQL editor.
4. Add `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY` to `.env.local`.

The app accepts only `@charlotte.edu` and `@uncc.edu` addresses in the UI. For production, also enforce that domain rule with a Supabase Auth hook or database-side profile creation function.

## Deploy to Vercel

Import this repository into Vercel. The default Vite settings work as-is:

- Build command: `npm run build`
- Output directory: `dist`

Add the same two `VITE_` environment variables in the Vercel project settings, then redeploy. Add the Vercel production URL to Supabase Authentication > URL Configuration.

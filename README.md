# Saim Enterprise - Gaming Peripherals Showcase

## Project Overview

A modern web showcase for Saim Enterprise, featuring premium gaming keyboards, mice, headsets, and accessories.

## Technologies

This project is built with:

- Vite
- TypeScript
- React
- shadcn-ui
- Tailwind CSS

## Getting Started

The only requirement is having Node.js & npm installed - [install with nvm](https://github.com/nvm-sh/nvm#installing-and-updating)

Follow these steps:

```sh
# Step 1: Clone the repository using the project's Git URL.
git clone <YOUR_GIT_URL>

# Step 2: Navigate to the project directory.
cd <YOUR_PROJECT_NAME>

# Step 3: Install the necessary dependencies.
npm i

# Step 4: Start the development server with auto-reloading and an instant preview.
npm run dev
```

## Development

- **Development server**: `npm run dev`
- **Build**: `npm run build`
- **Preview**: `npm run preview`
- **Lint**: `npm run lint`

## Deployment

**If you already use GitHub Pages** (see below), you do **not** need Vercel—one host is enough.

### Optional: Vercel

Alternative host if you prefer it (SPA routes like `/admin/login` work with [`vercel.json`](vercel.json)).

1. Push the repo to GitHub.
2. Sign in at [vercel.com](https://vercel.com) → **Add New** → **Project** → import the repo.
3. **Environment Variables** (Production, and Preview if you want):
   - `VITE_SUPABASE_URL` — Supabase **Project URL** (`https://<ref>.supabase.co`)
   - `VITE_SUPABASE_ANON_KEY` — Supabase **anon public** key (Project Settings → API)
4. Deploy (defaults: **Framework Preset Vite**, build `npm run build`, output `dist`).
5. In Supabase → **Authentication** → **URL configuration**: set **Site URL** and **Redirect URLs** to your Vercel URL (e.g. `https://your-app.vercel.app`).

[`vercel.json`](vercel.json) adds a SPA rewrite so deep links work.

### Alternative: Netlify

Connect the repo; [`netlify.toml`](netlify.toml) sets build and SPA fallback. Add the same `VITE_*` variables in Netlify **Site settings → Environment variables**.

### GitHub Pages

Uses [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml).

**Secrets** (Settings → Secrets and variables → **Actions**):

- `VITE_SUPABASE_URL`
- `VITE_SUPABASE_ANON_KEY`

**Variables** (optional, Settings → Secrets and variables → **Actions** → **Variables**):

- `VITE_BASE` — leave **unset** for default `https://<user>.github.io/<repo>/` (assets use `/repo/` prefix).
- Set to **`/`** if the site is served at the **domain root** (e.g. custom domain on Pages without a repo subpath).

**Pages setup:**

1. **Settings** → **Pages** → Source: **GitHub Actions**
2. Push to `main` or run the workflow manually under **Actions**

The workflow copies `index.html` to `404.html` for client-side routing on Pages.

### Connect Custom Domain (saimenterprise.com)

The project is already configured with a `CNAME` file for your custom domain.

**DNS Configuration on Hostinger:**

1. Log in to your Hostinger account
2. Go to **Domains** → **Manage** → **DNS / Name Servers**
3. Add the following DNS records:

   **For root domain (saimenterprise.com):**
   - Type: `A`
   - Name: `@` (or leave blank)
   - Value: `185.199.108.153`
   - TTL: `3600` (or default)

   - Type: `A`
   - Name: `@` (or leave blank)
   - Value: `185.199.109.153`
   - TTL: `3600` (or default)

   - Type: `A`
   - Name: `@` (or leave blank)
   - Value: `185.199.110.153`
   - TTL: `3600` (or default)

   - Type: `A`
   - Name: `@` (or leave blank)
   - Value: `185.199.111.153`
   - TTL: `3600` (or default)

   **For www subdomain (www.saienterprise.com):**
   - Type: `CNAME`
   - Name: `www`
   - Value: `your-username.github.io` (replace with your GitHub username)
   - TTL: `3600` (or default)

**GitHub Pages Settings:**

1. After DNS is configured, go to your repository **Settings** → **Pages**
2. Under **Custom domain**, enter: `saimenterprise.com`
3. Check **Enforce HTTPS** (this will be available after DNS propagation)
4. If you deploy with **GitHub Actions**, add repository **Variable** `VITE_BASE` = `/` so the built site matches a **root** custom domain (otherwise the default `/repo-name/` base is for `username.github.io/repo-name`).

**Note:** DNS changes can take 24-48 hours to propagate. You can verify DNS propagation using tools like [whatsmydns.net](https://www.whatsmydns.net/).

**Alternative: Using CNAME record for root domain**

Some DNS providers (like Hostinger) support CNAME flattening or ALIAS records for the root domain. If available, you can use:
- Type: `CNAME` or `ALIAS`
- Name: `@`
- Value: `your-username.github.io`

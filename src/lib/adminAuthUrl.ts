/** Full URL for Supabase auth redirects (respects Vite base on GitHub Pages). */
export function buildAdminAuthUrl(path: string): string {
  const normalizedPath = path.startsWith("/") ? path : `/${path}`;
  const base = import.meta.env.BASE_URL.replace(/\/$/, "");
  return `${window.location.origin}${base}${normalizedPath}`;
}

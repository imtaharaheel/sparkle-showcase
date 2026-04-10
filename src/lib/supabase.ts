import { createClient, SupabaseClient } from "@supabase/supabase-js";
import { CustomException } from "@/lib/errors";

const url = import.meta.env.VITE_SUPABASE_URL;
const anonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

let client: SupabaseClient | null = null;

export function isSupabaseConfigured(): boolean {
  return Boolean(url && anonKey);
}

export function getSupabase(): SupabaseClient {
  if (!isSupabaseConfigured()) {
    throw new CustomException(
      "Missing VITE_SUPABASE_URL or VITE_SUPABASE_ANON_KEY. Copy .env.example to .env and set your Supabase project values.",
    );
  }
  if (!client) {
    client = createClient(url!, anonKey!);
  }
  return client;
}

import { createContext, useCallback, useContext, useEffect, useMemo, useState } from "react";
import type { Session, User } from "@supabase/supabase-js";
import { getSupabase, isSupabaseConfigured } from "@/lib/supabase";
import { buildAdminAuthUrl } from "@/lib/adminAuthUrl";
import { CustomException, toCustomException } from "@/lib/errors";

type AdminAuthContextValue = {
  configured: boolean;
  session: Session | null;
  user: User | null;
  isAdmin: boolean;
  loading: boolean;
  authError: string | null;
  signIn: (email: string, password: string) => Promise<void>;
  signOut: () => Promise<void>;
  requestPasswordReset: (email: string) => Promise<void>;
  updatePassword: (password: string) => Promise<void>;
  refreshAdmin: () => Promise<void>;
};

const AdminAuthContext = createContext<AdminAuthContextValue | null>(null);

async function fetchIsAdmin(userId: string): Promise<boolean> {
  const supabase = getSupabase();
  const { data, error } = await supabase.from("profiles").select("is_admin").eq("id", userId).maybeSingle();
  if (error) {
    throw new CustomException(error.message, error);
  }
  return Boolean(data?.is_admin);
}

export function AdminAuthProvider({ children }: { children: React.ReactNode }) {
  const configured = isSupabaseConfigured();
  const [session, setSession] = useState<Session | null>(null);
  const [user, setUser] = useState<User | null>(null);
  const [isAdmin, setIsAdmin] = useState(false);
  const [loading, setLoading] = useState(configured);
  const [authError, setAuthError] = useState<string | null>(null);

  const refreshAdmin = useCallback(async () => {
    if (!configured || !user) {
      setIsAdmin(false);
      return;
    }
    setAuthError(null);
    try {
      const admin = await fetchIsAdmin(user.id);
      setIsAdmin(admin);
    } catch (e) {
      const ex = toCustomException(e, "Could not load admin profile");
      setAuthError(ex.message);
      setIsAdmin(false);
    }
  }, [configured, user]);

  useEffect(() => {
    if (!configured) {
      setLoading(false);
      setSession(null);
      setUser(null);
      setIsAdmin(false);
      return;
    }

    let cancelled = false;
    const supabase = getSupabase();

    const init = async () => {
      setLoading(true);
      setAuthError(null);
      let sessionUser: User | null = null;
      try {
        const { data, error } = await supabase.auth.getSession();
        if (error) {
          throw new CustomException(error.message, error);
        }
        sessionUser = data.session?.user ?? null;
        if (cancelled) return;
        setSession(data.session ?? null);
        setUser(sessionUser);
        if (!sessionUser) {
          setIsAdmin(false);
          setLoading(false);
        }
      } catch (e) {
        if (!cancelled) {
          const ex = toCustomException(e, "Session error");
          setAuthError(ex.message);
          setLoading(false);
        }
      }
    };

    void init();

    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange((_event, nextSession) => {
      const nextUser = nextSession?.user ?? null;
      setSession(nextSession);
      setUser(nextUser);
      if (!nextUser) {
        setIsAdmin(false);
        setLoading(false);
      }
    });

    return () => {
      cancelled = true;
      subscription.unsubscribe();
    };
  }, [configured]);

  useEffect(() => {
    if (!configured || !user) {
      return;
    }
    let cancelled = false;
    setLoading(true);
    setAuthError(null);
    void (async () => {
      try {
        const admin = await fetchIsAdmin(user.id);
        if (!cancelled) {
          setIsAdmin(admin);
        }
      } catch (e) {
        if (!cancelled) {
          const ex = toCustomException(e, "Could not load admin profile");
          setAuthError(ex.message);
          setIsAdmin(false);
        }
      } finally {
        if (!cancelled) {
          setLoading(false);
        }
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [configured, user]);

  const signIn = useCallback(async (email: string, password: string) => {
    if (!configured) {
      throw new CustomException("Supabase is not configured.");
    }
    const supabase = getSupabase();
    const { error } = await supabase.auth.signInWithPassword({ email, password });
    if (error) {
      throw new CustomException(error.message, error);
    }
  }, [configured]);

  const signOut = useCallback(async () => {
    if (!configured) return;
    const supabase = getSupabase();
    const { error } = await supabase.auth.signOut();
    if (error) {
      throw new CustomException(error.message, error);
    }
    setIsAdmin(false);
  }, [configured]);

  const requestPasswordReset = useCallback(async (email: string) => {
    if (!configured) {
      throw new CustomException("Supabase is not configured.");
    }
    const supabase = getSupabase();
    const { error } = await supabase.auth.resetPasswordForEmail(email.trim(), {
      redirectTo: buildAdminAuthUrl("/admin/reset-password"),
    });
    if (error) {
      throw new CustomException(error.message, error);
    }
  }, [configured]);

  const updatePassword = useCallback(async (password: string) => {
    if (!configured) {
      throw new CustomException("Supabase is not configured.");
    }
    const supabase = getSupabase();
    const { error } = await supabase.auth.updateUser({ password });
    if (error) {
      throw new CustomException(error.message, error);
    }
  }, [configured]);

  const value = useMemo<AdminAuthContextValue>(
    () => ({
      configured,
      session,
      user,
      isAdmin,
      loading,
      authError,
      signIn,
      signOut,
      requestPasswordReset,
      updatePassword,
      refreshAdmin,
    }),
    [
      configured,
      session,
      user,
      isAdmin,
      loading,
      authError,
      signIn,
      signOut,
      requestPasswordReset,
      updatePassword,
      refreshAdmin,
    ],
  );

  return <AdminAuthContext.Provider value={value}>{children}</AdminAuthContext.Provider>;
}

export function useAdminAuth(): AdminAuthContextValue {
  const ctx = useContext(AdminAuthContext);
  if (!ctx) {
    throw new CustomException("useAdminAuth must be used within AdminAuthProvider");
  }
  return ctx;
}

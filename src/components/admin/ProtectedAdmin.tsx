import { Navigate, Outlet } from "react-router-dom";
import { useAdminAuth } from "@/contexts/AdminAuthContext";
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert";
import { Skeleton } from "@/components/ui/skeleton";

export function ProtectedAdmin() {
  const { configured, user, isAdmin, loading, authError } = useAdminAuth();

  if (!configured) {
    return (
      <div className="flex min-h-svh items-center justify-center p-6">
        <Alert className="max-w-md">
          <AlertTitle>Supabase not configured</AlertTitle>
          <AlertDescription>
            Add <code className="text-xs">VITE_SUPABASE_URL</code> and{" "}
            <code className="text-xs">VITE_SUPABASE_ANON_KEY</code> to your <code className="text-xs">.env</code> file
            (see <code className="text-xs">.env.example</code>).
          </AlertDescription>
        </Alert>
      </div>
    );
  }

  if (loading) {
    return (
      <div className="flex min-h-svh flex-col gap-4 p-8">
        <Skeleton className="h-10 w-48" />
        <Skeleton className="h-[60vh] w-full max-w-4xl" />
      </div>
    );
  }

  if (!user) {
    return <Navigate to="/admin/login" replace />;
  }

  if (!isAdmin) {
    return (
      <div className="flex min-h-svh items-center justify-center p-6">
        <Alert variant="destructive" className="max-w-md">
          <AlertTitle>Access denied</AlertTitle>
          <AlertDescription>
            This account is not an admin. Ask a project owner to run{" "}
            <code className="text-xs">update public.profiles set is_admin = true where id = &apos;…&apos;;</code> in the
            Supabase SQL editor.
            {authError ? <span className="mt-2 block text-sm opacity-90">{authError}</span> : null}
          </AlertDescription>
        </Alert>
      </div>
    );
  }

  return <Outlet />;
}

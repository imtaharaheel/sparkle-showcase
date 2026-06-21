import { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { useAdminAuth } from "@/contexts/AdminAuthContext";
import { getSupabase } from "@/lib/supabase";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { CustomException, toCustomException } from "@/lib/errors";
import { toast } from "sonner";

export default function ResetPassword() {
  const navigate = useNavigate();
  const { configured, updatePassword, signOut } = useAdminAuth();
  const [ready, setReady] = useState(false);
  const [checking, setChecking] = useState(true);
  const [password, setPassword] = useState("");
  const [confirm, setConfirm] = useState("");
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (!configured) {
      setChecking(false);
      return;
    }

    const supabase = getSupabase();
    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange((event) => {
      if (event === "PASSWORD_RECOVERY") {
        setReady(true);
        setChecking(false);
      }
    });

    void supabase.auth.getSession().then(({ data }) => {
      if (data.session) {
        setReady(true);
      }
      setChecking(false);
    });

    return () => subscription.unsubscribe();
  }, [configured]);

  if (!configured) {
    return (
      <div className="flex min-h-svh items-center justify-center p-6">
        <Card className="w-full max-w-md">
          <CardHeader>
            <CardTitle>Set a new password</CardTitle>
            <CardDescription>Configure Supabase environment variables first.</CardDescription>
          </CardHeader>
        </Card>
      </div>
    );
  }

  if (checking) {
    return (
      <div className="flex min-h-svh items-center justify-center p-6">
        <p className="text-muted-foreground text-sm">Checking reset link…</p>
      </div>
    );
  }

  if (!ready) {
    return (
      <div className="bg-muted/30 flex min-h-svh items-center justify-center p-6">
        <Card className="w-full max-w-md shadow-sm">
          <CardHeader>
            <CardTitle>Reset link invalid or expired</CardTitle>
            <CardDescription>Request a new password reset email and try again.</CardDescription>
          </CardHeader>
          <CardContent className="space-y-3">
            <Button type="button" className="w-full" asChild>
              <Link to="/admin/forgot-password">Request new link</Link>
            </Button>
            <Button type="button" variant="outline" className="w-full" asChild>
              <Link to="/admin/login">Back to sign in</Link>
            </Button>
          </CardContent>
        </Card>
      </div>
    );
  }

  const onSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (password.length < 8) {
      toast.error("Password must be at least 8 characters");
      return;
    }
    if (password !== confirm) {
      toast.error("Passwords do not match");
      return;
    }
    setLoading(true);
    try {
      await updatePassword(password);
      toast.success("Password updated. Please sign in with your new password.");
      await signOut();
      navigate("/admin/login", { replace: true });
    } catch (err) {
      const ex = toCustomException(err, "Failed to update password");
      toast.error(ex.message);
      if (!(err instanceof CustomException)) {
        console.error(err);
      }
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="bg-muted/30 flex min-h-svh items-center justify-center p-6">
      <Card className="w-full max-w-md shadow-sm">
        <CardHeader>
          <CardTitle>Set a new password</CardTitle>
          <CardDescription>Choose a new password for your admin account.</CardDescription>
        </CardHeader>
        <CardContent>
          <form onSubmit={onSubmit} className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="password">New password</Label>
              <Input
                id="password"
                type="password"
                autoComplete="new-password"
                required
                value={password}
                onChange={(e) => setPassword(e.target.value)}
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="confirm">Confirm password</Label>
              <Input
                id="confirm"
                type="password"
                autoComplete="new-password"
                required
                value={confirm}
                onChange={(e) => setConfirm(e.target.value)}
              />
            </div>
            <Button type="submit" className="w-full" disabled={loading}>
              {loading ? "Updating…" : "Update password"}
            </Button>
          </form>
        </CardContent>
      </Card>
    </div>
  );
}

import { useState } from "react";
import { Link } from "react-router-dom";
import { useAdminAuth } from "@/contexts/AdminAuthContext";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { CustomException, toCustomException } from "@/lib/errors";
import { toast } from "sonner";

export default function ForgotPassword() {
  const { configured, requestPasswordReset } = useAdminAuth();
  const [email, setEmail] = useState("");
  const [loading, setLoading] = useState(false);
  const [sent, setSent] = useState(false);

  if (!configured) {
    return (
      <div className="flex min-h-svh items-center justify-center p-6">
        <Card className="w-full max-w-md">
          <CardHeader>
            <CardTitle>Forgot password</CardTitle>
            <CardDescription>Configure Supabase environment variables first.</CardDescription>
          </CardHeader>
        </Card>
      </div>
    );
  }

  const onSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      await requestPasswordReset(email);
      setSent(true);
      toast.success("If that email is registered, we sent a reset link.");
    } catch (err) {
      const ex = toCustomException(err, "Failed to send reset email");
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
          <CardTitle>Forgot password</CardTitle>
          <CardDescription>
            Enter your admin email and we&apos;ll send you a link to reset your password.
          </CardDescription>
        </CardHeader>
        <CardContent>
          {sent ? (
            <div className="space-y-4">
              <p className="text-muted-foreground text-sm">
                Check <strong>{email}</strong> for a reset link. It may take a minute to arrive.
              </p>
              <Button asChild variant="outline" className="w-full">
                <Link to="/admin/login">Back to sign in</Link>
              </Button>
            </div>
          ) : (
            <form onSubmit={onSubmit} className="space-y-4">
              <div className="space-y-2">
                <Label htmlFor="email">Email</Label>
                <Input
                  id="email"
                  type="email"
                  autoComplete="email"
                  required
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="you@example.com"
                />
              </div>
              <Button type="submit" className="w-full" disabled={loading}>
                {loading ? "Sending…" : "Send reset link"}
              </Button>
              <p className="text-muted-foreground text-center text-sm">
                <Link to="/admin/login" className="underline underline-offset-4 hover:text-foreground">
                  Back to sign in
                </Link>
              </p>
            </form>
          )}
        </CardContent>
      </Card>
    </div>
  );
}

export class CustomException extends Error {
  override readonly name = "CustomException";

  constructor(
    message: string,
    public readonly causeError?: unknown,
  ) {
    super(message);
    Object.setPrototypeOf(this, new.target.prototype);
  }
}

export function toCustomException(err: unknown, fallbackMessage: string): CustomException {
  if (err instanceof CustomException) return err;
  if (err && typeof err === "object" && "message" in err && typeof (err as { message: unknown }).message === "string") {
    return new CustomException((err as { message: string }).message, err);
  }
  return new CustomException(fallbackMessage, err);
}

/** Maps vague browser/Supabase network errors to actionable admin auth messages. */
export function toAuthCustomException(err: unknown, fallbackMessage: string): CustomException {
  const ex = err instanceof CustomException ? err : toCustomException(err, fallbackMessage);
  const msg = ex.message.toLowerCase();

  if (
    msg === "failed to fetch" ||
    msg.includes("fetch failed") ||
    msg.includes("networkerror") ||
    msg.includes("network request failed") ||
    msg.includes("load failed")
  ) {
    return new CustomException(
      "Cannot reach Supabase right now. Your database project may be paused — open supabase.com/dashboard, click Restore project, wait until it shows Active, then try again.",
      err,
    );
  }

  if (msg.includes("503") || msg.includes("authretryablefetcherror") || msg.includes("service unavailable")) {
    return new CustomException(
      "Supabase is temporarily unavailable. Restore your project from the Supabase dashboard if it is paused, then try again.",
      err,
    );
  }

  return ex;
}

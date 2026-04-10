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

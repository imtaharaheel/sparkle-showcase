import { useEffect, useMemo, useState } from "react";
import { motion } from "framer-motion";
import { MessageCircle, X } from "lucide-react";
import { z } from "zod";

import {
  Drawer,
  DrawerClose,
  DrawerContent,
  DrawerDescription,
  DrawerFooter,
  DrawerHeader,
  DrawerTitle,
} from "@/components/ui/drawer";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import type { Product } from "@/data/products";

const WHATSAPP_NUMBER = "923342914563";

const quickQuoteSchema = z.object({
  name: z
    .string()
    .trim()
    .max(60, { message: "Name must be 60 characters or less" })
    .optional()
    .or(z.literal("")),
  city: z
    .string()
    .trim()
    .max(60, { message: "City must be 60 characters or less" })
    .optional()
    .or(z.literal("")),
  notes: z
    .string()
    .trim()
    .max(500, { message: "Notes must be 500 characters or less" })
    .optional()
    .or(z.literal("")),
});

type QuickQuoteForm = z.infer<typeof quickQuoteSchema>;

function buildWhatsAppMessage(product: Product, form: QuickQuoteForm) {
  const lines: string[] = [];
  lines.push("Quick Quote Request");
  lines.push("");
  lines.push(`Product: ${product.name}`);
  lines.push(`Model: ${product.model}`);

  if (form.name?.trim()) lines.push(`Name: ${form.name.trim()}`);
  if (form.city?.trim()) lines.push(`City: ${form.city.trim()}`);
  if (form.notes?.trim()) {
    lines.push("");
    lines.push(`Notes: ${form.notes.trim()}`);
  }

  lines.push("");
  lines.push("Please share current availability and best price.");
  return lines.join("\n");
}

export function QuickQuoteDrawer({
  open,
  onOpenChange,
  product,
}: {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  product: Product | null;
}) {
  const [form, setForm] = useState<QuickQuoteForm>({ name: "", city: "", notes: "" });
  const [errors, setErrors] = useState<Partial<Record<keyof QuickQuoteForm, string>>>({});

  useEffect(() => {
    if (!open) {
      setForm({ name: "", city: "", notes: "" });
      setErrors({});
    }
  }, [open]);

  const title = useMemo(() => {
    if (!product) return "Quick Quote";
    return product.model ? `Quick Quote • ${product.model}` : "Quick Quote";
  }, [product]);

  const description = useMemo(() => {
    if (!product) return "Send a pre-filled quote request on WhatsApp.";
    return product.name;
  }, [product]);

  const handleSubmit = () => {
    if (!product) return;

    const parsed = quickQuoteSchema.safeParse(form);
    if (!parsed.success) {
      const fieldErrors: Partial<Record<keyof QuickQuoteForm, string>> = {};
      for (const issue of parsed.error.issues) {
        const key = issue.path[0] as keyof QuickQuoteForm;
        if (key) fieldErrors[key] = issue.message;
      }
      setErrors(fieldErrors);
      return;
    }

    setErrors({});
    const message = buildWhatsAppMessage(product, parsed.data);
    const url = `https://wa.me/${WHATSAPP_NUMBER}?text=${encodeURIComponent(message)}`;
    window.open(url, "_blank");
  };

  return (
    <Drawer open={open} onOpenChange={onOpenChange}>
      <DrawerContent className="border-white/10 bg-[#0a0a0f]">
        <DrawerHeader className="relative">
          <DrawerTitle className="font-display text-white">{title}</DrawerTitle>
          <DrawerDescription className="text-gray-400">{description}</DrawerDescription>

          <DrawerClose asChild>
            <button
              className="absolute right-4 top-4 inline-flex h-9 w-9 items-center justify-center rounded-full border border-white/10 bg-white/5 text-gray-300 transition-colors hover:bg-white/10 hover:text-white"
              aria-label="Close"
            >
              <X className="h-4 w-4" />
            </button>
          </DrawerClose>
        </DrawerHeader>

        <div className="px-4 pb-2">
          <div className="grid gap-4 rounded-2xl border border-white/10 bg-white/5 p-4">
            <div className="grid gap-2 sm:grid-cols-2">
              <div className="space-y-2">
                <label className="text-sm font-medium text-gray-300">Your name (optional)</label>
                <Input
                  value={form.name ?? ""}
                  onChange={(e) => setForm((p) => ({ ...p, name: e.target.value }))}
                  placeholder="e.g. Ali"
                  className="bg-white/5 border-white/10 text-white placeholder:text-gray-500 focus:border-primary/50"
                />
                {errors.name && <p className="text-xs text-destructive">{errors.name}</p>}
              </div>
              <div className="space-y-2">
                <label className="text-sm font-medium text-gray-300">City (optional)</label>
                <Input
                  value={form.city ?? ""}
                  onChange={(e) => setForm((p) => ({ ...p, city: e.target.value }))}
                  placeholder="e.g. Karachi"
                  className="bg-white/5 border-white/10 text-white placeholder:text-gray-500 focus:border-primary/50"
                />
                {errors.city && <p className="text-xs text-destructive">{errors.city}</p>}
              </div>
            </div>

            <div className="space-y-2">
              <label className="text-sm font-medium text-gray-300">Notes (optional)</label>
              <Textarea
                value={form.notes ?? ""}
                onChange={(e) => setForm((p) => ({ ...p, notes: e.target.value }))}
                placeholder="Color / storage / delivery time / budget..."
                rows={4}
                className="bg-white/5 border-white/10 text-white placeholder:text-gray-500 focus:border-primary/50 resize-none"
              />
              {errors.notes && <p className="text-xs text-destructive">{errors.notes}</p>}
            </div>
          </div>
        </div>

        <DrawerFooter className="gap-3">
          <motion.div whileTap={{ scale: 0.98 }}>
            <Button
              type="button"
              onClick={handleSubmit}
              disabled={!product}
              className="w-full gap-2 rounded-full bg-[#25D366] text-white hover:bg-[#128C7E]"
            >
              <MessageCircle className="h-5 w-5" />
              Send Quick Quote on WhatsApp
            </Button>
          </motion.div>
          <DrawerClose asChild>
            <Button
              type="button"
              variant="outline"
              className="w-full rounded-full border-white/15 bg-white/5 text-gray-200 hover:bg-white/10"
            >
              Continue Browsing
            </Button>
          </DrawerClose>
        </DrawerFooter>
      </DrawerContent>
    </Drawer>
  );
}

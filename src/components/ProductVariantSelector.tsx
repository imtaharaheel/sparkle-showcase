import { useEffect, useMemo, useState } from "react";
import {
  findVariantOption,
  getChoicesForDimension,
  getDefaultSelection,
  type ProductVariantOption,
  type ProductVariants,
  type VariantDimension,
  type VariantSelection,
} from "@/lib/product-variants";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";

interface ProductVariantSelectorProps {
  variants: ProductVariants;
  onSelectionChange: (price: number, option: ProductVariantOption | null) => void;
}

const DIMENSION_LABELS: Record<VariantDimension, string> = {
  size: "Screen size",
  storage: "Storage",
};

export function ProductVariantSelector({ variants, onSelectionChange }: ProductVariantSelectorProps) {
  const [selection, setSelection] = useState<VariantSelection>(() => getDefaultSelection(variants));

  const matched = useMemo(() => findVariantOption(variants, selection), [variants, selection]);

  useEffect(() => {
    if (matched) {
      onSelectionChange(matched.price, matched);
      return;
    }
    onSelectionChange(variants.options[0]?.price ?? 0, null);
  }, [matched, onSelectionChange, variants.options]);

  const updateDimension = (dimension: VariantDimension, value: string) => {
    setSelection((prev) => {
      const next = { ...prev, [dimension]: value };
      const option = findVariantOption(variants, next);
      if (!option) {
        const partial = { ...next };
        for (const dim of variants.dimensions) {
          if (dim === dimension) continue;
          delete partial[dim];
        }
        const fallback = findVariantOption(variants, { [dimension]: value });
        if (fallback) {
          const fixed: VariantSelection = { [dimension]: value };
          if (fallback.size) fixed.size = fallback.size;
          if (fallback.storage) fixed.storage = fallback.storage;
          return fixed;
        }
      }
      return next;
    });
  };

  return (
    <div className="mb-6 space-y-4">
      {variants.dimensions.map((dimension) => {
        const choices = getChoicesForDimension(variants, dimension, selection);
        const value = selection[dimension] ?? "";
        return (
          <div key={dimension} className="space-y-1.5">
            <Label className="text-sm font-medium">{DIMENSION_LABELS[dimension]}</Label>
            <Select value={value} onValueChange={(v) => updateDimension(dimension, v)}>
              <SelectTrigger className="w-full max-w-xs">
                <SelectValue placeholder={`Choose ${DIMENSION_LABELS[dimension].toLowerCase()}`} />
              </SelectTrigger>
              <SelectContent>
                {choices.map((choice) => (
                  <SelectItem key={choice} value={choice}>
                    {choice}
                    {dimension === "storage" || variants.dimensions.length === 1 ? " · Wi-Fi" : ""}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>
        );
      })}
      <p className="text-muted-foreground text-sm">All models are Wi-Fi only — no cellular versions.</p>
    </div>
  );
}

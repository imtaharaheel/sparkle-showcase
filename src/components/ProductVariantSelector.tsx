import { useEffect, useMemo, useState } from "react";
import {
  findVariantOption,
  getAllChoicesForDimension,
  getDefaultSelection,
  isChoiceAvailable,
  selectVariantValue,
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
  color: "Colour",
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

  return (
    <div className="mb-6 space-y-4">
      {variants.dimensions.map((dimension) => {
        const choices = getAllChoicesForDimension(variants, dimension);
        const value = selection[dimension] ?? "";
        return (
          <div key={dimension} className="space-y-1.5">
            <Label className="text-sm font-medium">{DIMENSION_LABELS[dimension]}</Label>
            <Select
              value={value}
              onValueChange={(v) => setSelection((prev) => selectVariantValue(variants, prev, dimension, v))}
            >
              <SelectTrigger className="w-full max-w-xs">
                <SelectValue placeholder={`Choose ${DIMENSION_LABELS[dimension].toLowerCase()}`} />
              </SelectTrigger>
              <SelectContent>
                {choices.map((choice) => {
                  // Still selectable: picking it switches the other pickers to a combination that exists.
                  const available = isChoiceAvailable(variants, dimension, choice, selection);
                  return (
                    <SelectItem key={choice} value={choice} className={available ? undefined : "text-muted-foreground"}>
                      {choice}
                      {available ? "" : " — other options will change"}
                    </SelectItem>
                  );
                })}
              </SelectContent>
            </Select>
          </div>
        );
      })}
    </div>
  );
}

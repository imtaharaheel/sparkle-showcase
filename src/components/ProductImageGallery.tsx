import { useState } from "react";
import { ScrollArea, ScrollBar } from "@/components/ui/scroll-area";
import { cn } from "@/lib/utils";

interface ProductImageGalleryProps {
  images: string[];
  alt: string;
  badge?: string;
}

function ThumbnailButton({
  src,
  index,
  total,
  selected,
  onSelect,
}: {
  src: string;
  index: number;
  total: number;
  selected: boolean;
  onSelect: () => void;
}) {
  return (
    <button
      type="button"
      onClick={onSelect}
      className={cn(
        "shrink-0 overflow-hidden rounded-lg border bg-white p-1 transition-colors",
        "h-16 w-16 sm:h-[4.5rem] sm:w-[4.5rem]",
        selected ? "border-primary ring-2 ring-primary/30" : "border-border hover:border-primary/50",
      )}
      aria-label={`View image ${index + 1} of ${total}`}
      aria-current={selected ? "true" : undefined}
    >
      <img
        src={src}
        alt=""
        loading="lazy"
        decoding="async"
        referrerPolicy="no-referrer"
        className="h-full w-full object-contain"
      />
    </button>
  );
}

export function ProductImageGallery({ images, alt, badge }: ProductImageGalleryProps) {
  const [selectedIndex, setSelectedIndex] = useState(0);
  const selectedImage = images[selectedIndex] ?? images[0];

  if (!selectedImage) {
    return null;
  }

  const showThumbs = images.length > 1;

  return (
    <div
      className={cn(
        "grid gap-3",
        showThumbs ? "sm:grid-cols-[4.5rem_1fr] sm:items-stretch sm:gap-4" : "grid-cols-1",
      )}
    >
      {showThumbs ? (
        <>
          {/* Mobile: horizontal scroll */}
          <ScrollArea className="w-full sm:hidden">
            <div className="flex gap-2 pb-2">
              {images.map((src, index) => (
                <ThumbnailButton
                  key={`mobile-${src}-${index}`}
                  src={src}
                  index={index}
                  total={images.length}
                  selected={index === selectedIndex}
                  onSelect={() => setSelectedIndex(index)}
                />
              ))}
            </div>
            <ScrollBar orientation="horizontal" />
          </ScrollArea>

          {/* Desktop: vertical scroll on the left, capped to main image height */}
          <ScrollArea className="hidden h-full min-h-0 sm:col-start-1 sm:row-start-1 sm:block">
            <div className="flex flex-col gap-2 pr-2">
              {images.map((src, index) => (
                <ThumbnailButton
                  key={`desktop-${src}-${index}`}
                  src={src}
                  index={index}
                  total={images.length}
                  selected={index === selectedIndex}
                  onSelect={() => setSelectedIndex(index)}
                />
              ))}
            </div>
            <ScrollBar orientation="vertical" />
          </ScrollArea>
        </>
      ) : null}

      <div className={cn("min-w-0", showThumbs && "sm:col-start-2 sm:row-start-1")}>
        <div className="relative overflow-hidden rounded-2xl border border-border bg-white shadow-lg">
          {badge ? (
            <div className="absolute top-4 left-4 z-10 rounded-full bg-primary px-3 py-1 text-sm font-semibold text-primary-foreground">
              {badge}
            </div>
          ) : null}
          <div className="flex aspect-square items-center justify-center p-6 sm:p-10">
            <img
              src={selectedImage}
              alt={alt}
              loading="eager"
              decoding="async"
              referrerPolicy="no-referrer"
              className="max-h-full max-w-full object-contain"
            />
          </div>
        </div>
      </div>
    </div>
  );
}

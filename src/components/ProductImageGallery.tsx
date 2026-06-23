import { useRef, useState } from "react";
import { ChevronDown, ChevronUp } from "lucide-react";
import { cn } from "@/lib/utils";
import { Button } from "@/components/ui/button";

interface ProductImageGalleryProps {
  images: string[];
  alt: string;
  badge?: string;
}

const THUMB_SIZE = "4.5rem";
const THUMB_GAP = "0.5rem";

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
        selected ? "border-primary ring-2 ring-inset ring-primary/30" : "border-border hover:border-primary/50",
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
  const thumbStripRef = useRef<HTMLDivElement>(null);
  const selectedImage = images[selectedIndex] ?? images[0];

  if (!selectedImage) {
    return null;
  }

  const showThumbs = images.length > 1;

  const scrollThumbs = (direction: "up" | "down") => {
    const el = thumbStripRef.current;
    if (!el) return;
    const step = parseFloat(THUMB_SIZE) * 16 + parseFloat(THUMB_GAP) * 16;
    el.scrollBy({ top: direction === "up" ? -step : step, behavior: "smooth" });
  };

  const showThumbArrows = images.length > 4;

  return (
    <div className="flex flex-col gap-3">
      {/* Mobile: horizontal scroll */}
      {showThumbs ? (
        <div className="flex gap-2 overflow-x-auto pb-1 sm:hidden [scrollbar-width:thin]">
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
      ) : null}

      {/* Desktop: thumbs pinned to main image height with scroll */}
      <div className="relative">
        {showThumbs ? (
          <div
            className="absolute top-0 bottom-0 left-0 z-10 hidden w-[4.5rem] flex-col sm:flex"
            aria-label="Product image thumbnails"
          >
            {showThumbArrows ? (
              <Button
                type="button"
                variant="outline"
                size="icon"
                className="mb-1 size-7 shrink-0 rounded-md bg-background/90 shadow-sm"
                onClick={() => scrollThumbs("up")}
                aria-label="Scroll thumbnails up"
              >
                <ChevronUp className="size-4" />
              </Button>
            ) : null}

            <div
              ref={thumbStripRef}
              className="min-h-0 flex-1 overflow-x-hidden overflow-y-auto overscroll-y-contain [scrollbar-width:thin] [scrollbar-color:hsl(var(--border))_transparent] [&::-webkit-scrollbar]:w-1.5 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-thumb]:bg-border"
            >
              <div className="flex w-full flex-col gap-2">
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
            </div>

            {showThumbArrows ? (
              <Button
                type="button"
                variant="outline"
                size="icon"
                className="mt-1 size-7 shrink-0 rounded-md bg-background/90 shadow-sm"
                onClick={() => scrollThumbs("down")}
                aria-label="Scroll thumbnails down"
              >
                <ChevronDown className="size-4" />
              </Button>
            ) : null}
          </div>
        ) : null}

        <div className={cn("min-w-0", showThumbs && "sm:pl-[5.25rem]")}>
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
    </div>
  );
}

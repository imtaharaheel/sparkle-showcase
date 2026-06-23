import { useState } from "react";
import { cn } from "@/lib/utils";

interface ProductImageGalleryProps {
  images: string[];
  alt: string;
  badge?: string;
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
        "gap-4",
        showThumbs ? "flex flex-col sm:flex-row" : "flex",
      )}
    >
      {showThumbs ? (
        <div className="order-2 flex gap-2 overflow-x-auto sm:order-1 sm:flex-col sm:overflow-y-auto sm:overflow-x-hidden">
          {images.map((src, index) => (
            <button
              key={`${src}-${index}`}
              type="button"
              onClick={() => setSelectedIndex(index)}
              className={cn(
                "shrink-0 overflow-hidden rounded-lg border bg-white p-1 transition-colors",
                "h-16 w-16 sm:h-20 sm:w-20",
                index === selectedIndex
                  ? "border-primary ring-2 ring-primary/30"
                  : "border-border hover:border-primary/50",
              )}
              aria-label={`View image ${index + 1} of ${images.length}`}
              aria-current={index === selectedIndex ? "true" : undefined}
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
          ))}
        </div>
      ) : null}

      <div className="relative min-w-0 flex-1 order-1 sm:order-2">
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

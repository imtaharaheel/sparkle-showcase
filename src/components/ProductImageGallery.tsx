import { useEffect, useRef, useState } from "react";
import { ChevronDown, ChevronUp, Play, ZoomIn } from "lucide-react";
import { cn } from "@/lib/utils";
import { Button } from "@/components/ui/button";
import { Dialog, DialogContent, DialogTitle } from "@/components/ui/dialog";

interface ProductImageGalleryProps {
  images: string[];
  alt: string;
  badge?: string;
  /** When set to one of `images`, the gallery switches to it (e.g. the photo of the picked colour). */
  activeImage?: string | null;
  /** Product videos (YouTube links or .mp4 files), listed after the photos with a play icon. */
  videos?: string[];
}

function youtubeId(url: string): string | undefined {
  return url.match(/(?:youtube\.com\/(?:embed\/|watch\?v=)|youtu\.be\/)([\w-]{11})/)?.[1];
}

const THUMB_SIZE = "5.625rem";
const THUMB_GAP = "0.5rem";
/** How much the main image enlarges under the mouse cursor. */
const HOVER_ZOOM = 1.8;

function ThumbnailButton({
  src,
  index,
  total,
  selected,
  onSelect,
  isVideo,
}: {
  src: string;
  index: number;
  total: number;
  selected: boolean;
  onSelect: () => void;
  isVideo?: boolean;
}) {
  return (
    <button
      type="button"
      onClick={onSelect}
      className={cn(
        "shrink-0 overflow-hidden rounded-lg border bg-white p-1 transition-colors",
        "h-20 w-16 sm:h-[5.625rem] sm:w-[4.5rem]",
        selected ? "border-primary ring-2 ring-inset ring-primary/30" : "border-border hover:border-primary/50",
      )}
      aria-label={isVideo ? "Play product video" : `View image ${index + 1} of ${total}`}
      aria-current={selected ? "true" : undefined}
    >
      {isVideo ? (
        <span className="flex h-full w-full flex-col items-center justify-center gap-1 rounded bg-neutral-900 text-white">
          <Play className="h-5 w-5 fill-current" />
          <span className="text-[10px] font-medium uppercase tracking-wide">Video</span>
        </span>
      ) : (
        <img
          src={src}
          alt=""
          loading="lazy"
          decoding="async"
          referrerPolicy="no-referrer"
          className="h-full w-full object-contain"
        />
      )}
    </button>
  );
}

export function ProductImageGallery({ images, alt, badge, activeImage, videos = [] }: ProductImageGalleryProps) {
  const [selectedIndex, setSelectedIndex] = useState(0);

  useEffect(() => {
    if (!activeImage) return;
    const index = images.indexOf(activeImage);
    if (index >= 0) setSelectedIndex(index);
  }, [activeImage, images]);
  const thumbStripRef = useRef<HTMLDivElement>(null);
  /** Cursor position over the main image as percentages, while hovering with a mouse. */
  const [hoverOrigin, setHoverOrigin] = useState<{ x: number; y: number } | null>(null);
  const [lightboxOpen, setLightboxOpen] = useState(false);
  const [lightboxZoomed, setLightboxZoomed] = useState(false);
  const selectedImage = images[selectedIndex] ?? images[0];
  // Photos first, then videos; the same index runs over both.
  const media = [...images.map((src) => ({ src, isVideo: false })), ...videos.map((src) => ({ src, isVideo: true }))];
  const selectedVideo = selectedIndex >= images.length ? videos[selectedIndex - images.length] : undefined;

  const handlePointerMove = (e: React.PointerEvent<HTMLDivElement>) => {
    if (e.pointerType !== "mouse") return;
    const rect = e.currentTarget.getBoundingClientRect();
    setHoverOrigin({
      x: ((e.clientX - rect.left) / rect.width) * 100,
      y: ((e.clientY - rect.top) / rect.height) * 100,
    });
  };

  const lightboxScrollRef = useRef<HTMLDivElement>(null);

  /** Toggle the enlarged view, keeping the clicked spot under the cursor when zooming in. */
  const toggleLightboxZoom = (e: React.MouseEvent<HTMLImageElement>) => {
    const rect = e.currentTarget.getBoundingClientRect();
    const fx = (e.clientX - rect.left) / rect.width;
    const fy = (e.clientY - rect.top) / rect.height;
    const zoomingIn = !lightboxZoomed;
    setLightboxZoomed(zoomingIn);
    if (!zoomingIn) return;
    requestAnimationFrame(() => {
      const box = lightboxScrollRef.current;
      if (!box) return;
      box.scrollLeft = fx * box.scrollWidth - box.clientWidth / 2;
      box.scrollTop = fy * box.scrollHeight - box.clientHeight / 2;
    });
  };

  const openLightbox = () => {
    setHoverOrigin(null);
    setLightboxZoomed(false);
    setLightboxOpen(true);
  };

  if (!selectedImage) {
    return null;
  }

  const showThumbs = media.length > 1;

  /** Arrows step to the previous / next picture and keep its thumbnail in view. */
  const scrollThumbs = (direction: "up" | "down") => {
    const next = Math.min(media.length - 1, Math.max(0, selectedIndex + (direction === "up" ? -1 : 1)));
    setSelectedIndex(next);
    const el = thumbStripRef.current;
    if (!el) return;
    const step = parseFloat(THUMB_SIZE) * 16 + parseFloat(THUMB_GAP) * 16;
    el.scrollTo({ top: Math.max(0, next * step - el.clientHeight / 2 + step / 2), behavior: "smooth" });
  };

  const showThumbArrows = media.length > 4;

  return (
    <div className="flex flex-col gap-3">
      {/* Mobile: horizontal scroll */}
      {showThumbs ? (
        <div className="flex gap-2 overflow-x-auto pb-1 sm:hidden [scrollbar-width:thin]">
          {media.map(({ src, isVideo }, index) => (
            <ThumbnailButton
              key={`mobile-${src}-${index}`}
              src={src}
              index={index}
              total={images.length}
                isVideo={isVideo}
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
                disabled={selectedIndex === 0}
                aria-label="Previous picture"
              >
                <ChevronUp className="size-4" />
              </Button>
            ) : null}

            <div
              ref={thumbStripRef}
              className="min-h-0 flex-1 overflow-x-hidden overflow-y-auto overscroll-y-contain [scrollbar-width:thin] [scrollbar-color:hsl(var(--border))_transparent] [&::-webkit-scrollbar]:w-1.5 [&::-webkit-scrollbar-thumb]:rounded-full [&::-webkit-scrollbar-thumb]:bg-border"
            >
              <div className="flex w-full flex-col gap-2">
                {media.map(({ src, isVideo }, index) => (
                  <ThumbnailButton
                    key={`desktop-${src}-${index}`}
                    src={src}
                    index={index}
                    total={images.length}
                    isVideo={isVideo}
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
                disabled={selectedIndex >= media.length - 1}
                aria-label="Next picture"
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
            {selectedVideo ? (
              <div className="flex aspect-[4/5] items-center justify-center overflow-hidden rounded-2xl bg-black">
                {youtubeId(selectedVideo) ? (
                  <iframe
                    src={`https://www.youtube-nocookie.com/embed/${youtubeId(selectedVideo)}`}
                    title={`${alt} video`}
                    className="aspect-video w-full"
                    allow="accelerometer; encrypted-media; gyroscope; picture-in-picture; fullscreen"
                    allowFullScreen
                  />
                ) : (
                  <video key={selectedVideo} src={selectedVideo} controls playsInline preload="metadata" className="max-h-full w-full" />
                )}
              </div>
            ) : (
              <>
              <div
                className="flex aspect-[4/5] cursor-zoom-in items-center justify-center overflow-hidden rounded-2xl"
                onPointerMove={handlePointerMove}
                onPointerLeave={() => setHoverOrigin(null)}
                onClick={openLightbox}
              >
                <img
                  src={selectedImage}
                  alt={alt}
                  loading="eager"
                  decoding="async"
                  referrerPolicy="no-referrer"
                  className="max-h-full max-w-full object-contain transition-transform duration-150 ease-out"
                  style={
                    hoverOrigin
                      ? { transform: `scale(${HOVER_ZOOM})`, transformOrigin: `${hoverOrigin.x}% ${hoverOrigin.y}%` }
                      : undefined
                  }
                />
              </div>
              <Button
                type="button"
                variant="secondary"
                size="icon"
                className="absolute bottom-3 right-3 z-10 h-9 w-9 rounded-full shadow-md"
                onClick={openLightbox}
                aria-label="Zoom image"
              >
                <ZoomIn className="h-4 w-4" />
              </Button>
              </>
            )}
          </div>
        </div>
      </div>

      <Dialog open={lightboxOpen} onOpenChange={setLightboxOpen}>
        <DialogContent className="w-max max-w-[96vw] border-0 bg-black p-2 sm:rounded-xl [&>button]:rounded-full [&>button]:bg-white [&>button]:p-1.5 [&>button]:opacity-100">
          <DialogTitle className="sr-only">{alt}</DialogTitle>
          <div
            ref={lightboxScrollRef}
            className={cn("rounded-lg", lightboxZoomed ? "h-[92vh] w-[94vw] overflow-auto" : "overflow-hidden")}
          >
            <img
              src={selectedImage}
              alt={alt}
              referrerPolicy="no-referrer"
              onClick={toggleLightboxZoom}
              className={cn(
                "block",
                lightboxZoomed
                  ? "w-[180vmin] max-w-none cursor-zoom-out"
                  : "max-h-[92vh] max-w-[92vw] cursor-zoom-in object-contain",
              )}
            />
          </div>
        </DialogContent>
      </Dialog>
    </div>
  );
}

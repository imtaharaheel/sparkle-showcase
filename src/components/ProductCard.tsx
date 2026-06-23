import { Link } from "react-router-dom";
import { motion } from "framer-motion";
import { ArrowRight, MessageCircle, Sparkles } from "lucide-react";
import type { StorefrontProduct } from "@/lib/catalog";
import { formatPrice } from "@/lib/formatPrice";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";

interface ProductCardProps {
  product: StorefrontProduct;
  index?: number;
  onQuickQuote?: (product: StorefrontProduct) => void;
}

export const ProductCard = ({ product, index = 0, onQuickQuote }: ProductCardProps) => {
  const handleWhatsApp = (e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();
    const message = `Hi! I'm interested in ${product.name} (${product.model}) - ${formatPrice(product.price)}`;
    window.open(`https://wa.me/923342914563?text=${encodeURIComponent(message)}`, "_blank");
  };

  const handleQuickQuote = (e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();
    if (onQuickQuote) onQuickQuote(product);
  };

  return (
    <motion.div
      initial={{ opacity: 0, y: 30 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true, margin: "-50px" }}
      transition={{ duration: 0.5, delay: index * 0.1 }}
    >
      <Link to={`/product/${product.id}`}>
        <article className="group relative flex h-full flex-col overflow-hidden rounded-xl border border-border bg-card shadow-sm transition-shadow duration-300 hover:shadow-md">
          {/* Badge */}
          {product.badge && (
            <div className="absolute top-3 left-3 z-10">
              <Badge className="gradient-brand text-primary-foreground font-semibold">
                {product.badge}
              </Badge>
            </div>
          )}

          {/* Image — flat white backdrop like Paklap for sharp product photos */}
          <div className="relative aspect-square overflow-hidden bg-white p-2 sm:p-3">
            {product.image ? (
              <img
                src={product.image}
                alt={product.name}
                loading="lazy"
                decoding="async"
                referrerPolicy="no-referrer"
                className="h-full w-full object-contain"
              />
            ) : (
              <div className="flex h-full w-full items-center justify-center rounded-lg bg-secondary/30">
                <span className="text-3xl font-display font-bold text-primary/20">
                  {product.model}
                </span>
              </div>
            )}
          </div>

          {/* Content */}
          <div className="flex flex-1 flex-col p-5">
            {product.description.trim() ? (
              <div className="mb-2 flex items-start justify-between gap-2">
                <span className="text-xs font-medium uppercase tracking-wider text-primary">
                  {product.model}
                </span>
              </div>
            ) : null}

            <h3 className="mb-2 font-display text-lg font-semibold leading-tight text-foreground line-clamp-3 group-hover:text-primary transition-colors">
              {product.name}
            </h3>

            {product.description.trim() ? (
              <p className="mb-4 text-sm text-muted-foreground line-clamp-2">{product.description}</p>
            ) : (
              <div className="mb-4" />
            )}

            <div className="mt-auto flex items-center justify-between gap-3">
              <span className="font-display text-xl font-bold text-primary">
                {formatPrice(product.price)}
              </span>
              
              <div className="flex gap-2">
                {onQuickQuote && (
                  <Button
                    size="sm"
                    variant="outline"
                    className="h-9 w-9 p-0 border-primary/30 text-primary hover:bg-primary/10"
                    onClick={handleQuickQuote}
                    aria-label="Quick Quote"
                  >
                    <Sparkles className="h-4 w-4" />
                  </Button>
                )}
                <Button
                  size="sm"
                  variant="outline"
                  className="h-9 w-9 p-0 border-[#25D366] text-[#25D366] hover:bg-[#25D366] hover:text-white"
                  onClick={handleWhatsApp}
                  aria-label="Chat on WhatsApp"
                >
                  <MessageCircle className="h-4 w-4" />
                </Button>
                <Button
                  size="sm"
                  variant="ghost"
                  className="h-9 px-3 text-muted-foreground group-hover:text-primary"
                >
                  View
                  <ArrowRight className="ml-1 h-3 w-3 transition-transform group-hover:translate-x-1" />
                </Button>
              </div>
            </div>
          </div>
        </article>
      </Link>
    </motion.div>
  );
};

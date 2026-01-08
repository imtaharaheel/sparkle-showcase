import { Link } from "react-router-dom";
import { motion } from "framer-motion";
import { ArrowRight, MessageCircle } from "lucide-react";
import { Product, formatPrice } from "@/data/products";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { useState } from "react";

interface ProductCardProps {
  product: Product;
  index?: number;
}

export const ProductCard = ({ product, index = 0 }: ProductCardProps) => {
  const [mousePos, setMousePos] = useState({ x: 0, y: 0 });
  const [isHovered, setIsHovered] = useState(false);

  const handleWhatsApp = (e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();
    const message = `Hi! I'm interested in ${product.name} (${product.model}) - ${formatPrice(product.price)}`;
    window.open(`https://wa.me/9233442914563?text=${encodeURIComponent(message)}`, "_blank");
  };

  const handleMouseMove = (e: React.MouseEvent<HTMLElement>) => {
    const rect = e.currentTarget.getBoundingClientRect();
    const x = (e.clientX - rect.left - rect.width / 2) / 20;
    const y = (e.clientY - rect.top - rect.height / 2) / 20;
    setMousePos({ x, y });
  };

  return (
    <motion.div
      initial={{ opacity: 0, y: 30 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true, margin: "-50px" }}
      transition={{ duration: 0.5, delay: index * 0.1 }}
      style={{ perspective: 1000 }}
    >
      <Link to={`/product/${product.id}`}>
        <motion.article
          className="group relative flex h-full flex-col overflow-hidden rounded-xl border border-border bg-card shadow-sm transition-all duration-300"
          onMouseMove={handleMouseMove}
          onMouseEnter={() => setIsHovered(true)}
          onMouseLeave={() => {
            setIsHovered(false);
            setMousePos({ x: 0, y: 0 });
          }}
          animate={{
            rotateX: isHovered ? -mousePos.y : 0,
            rotateY: isHovered ? mousePos.x : 0,
            scale: isHovered ? 1.02 : 1,
          }}
          transition={{ type: "spring", stiffness: 300, damping: 20 }}
          style={{
            transformStyle: "preserve-3d",
            boxShadow: isHovered 
              ? `${mousePos.x * 2}px ${mousePos.y * 2}px 30px hsl(var(--primary) / 0.15)` 
              : undefined,
          }}
        >
          {/* Badge */}
          {product.badge && (
            <div className="absolute top-3 left-3 z-10">
              <Badge className="gradient-brand text-primary-foreground font-semibold">
                {product.badge}
              </Badge>
            </div>
          )}

          {/* Image Container */}
          <div className="relative aspect-square overflow-hidden bg-gradient-to-br from-secondary to-accent/20 p-4">
            <div className="absolute inset-0 bg-gradient-to-t from-card/80 to-transparent opacity-0 transition-opacity duration-300 group-hover:opacity-100" />
            <motion.div
              className="flex h-full w-full items-center justify-center"
              style={{ transform: "translateZ(30px)" }}
            >
              {product.image && product.image !== `/products/${product.id}.png` ? (
                <img 
                  src={product.image} 
                  alt={product.name}
                  className="h-full w-full object-contain transition-transform duration-300 group-hover:scale-110"
                />
              ) : (
                <div className="flex h-full w-full items-center justify-center rounded-lg">
                  <span className="text-3xl font-display font-bold text-primary/20">
                    {product.model}
                  </span>
                </div>
              )}
            </motion.div>
          </div>

          {/* Content */}
          <div className="flex flex-1 flex-col p-5" style={{ transform: "translateZ(20px)" }}>
            <div className="mb-2 flex items-start justify-between gap-2">
              <span className="text-xs font-medium uppercase tracking-wider text-primary">
                {product.model}
              </span>
            </div>
            
            <h3 className="mb-2 font-display text-lg font-semibold leading-tight text-foreground line-clamp-2 group-hover:text-primary transition-colors">
              {product.name}
            </h3>
            
            <p className="mb-4 text-sm text-muted-foreground line-clamp-2">
              {product.description}
            </p>

            <div className="mt-auto flex items-center justify-between gap-3">
              <span className="font-display text-xl font-bold text-primary">
                {formatPrice(product.price)}
              </span>
              
              <div className="flex gap-2">
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

          {/* Hover Glow Effect */}
          <div className="pointer-events-none absolute inset-0 rounded-xl opacity-0 transition-opacity duration-300 group-hover:opacity-100">
            <div className="absolute inset-x-0 bottom-0 h-px bg-gradient-to-r from-transparent via-primary to-transparent" />
          </div>
        </motion.article>
      </Link>
    </motion.div>
  );
};

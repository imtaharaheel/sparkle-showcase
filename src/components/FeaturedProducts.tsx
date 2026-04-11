import { motion } from "framer-motion";
import { useQuery } from "@tanstack/react-query";
import { ArrowRight, Loader2 } from "lucide-react";
import { Link } from "react-router-dom";
import { fetchFeaturedCatalogProducts } from "@/lib/catalog";
import { ProductCard } from "@/components/ProductCard";
import { Button } from "@/components/ui/button";
import { AnimatedBackground } from "./AnimatedBackground";

const CATALOG_STALE_MS = 30_000;

export const FeaturedProducts = () => {
  const { data: featuredProducts = [], isLoading, isError } = useQuery({
    queryKey: ["catalog_featured"],
    queryFn: () => fetchFeaturedCatalogProducts(8),
    staleTime: CATALOG_STALE_MS,
  });

  return (
    <section className="relative py-20 md:py-32">
      <AnimatedBackground variant="featured" />

      <div className="container mx-auto px-4">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
          className="mb-12 text-center md:mb-16"
        >
          <span className="mb-3 inline-block text-sm font-medium uppercase tracking-wider text-primary">
            Top Picks
          </span>
          <h2 className="mb-4 font-display text-3xl font-bold text-foreground md:text-4xl lg:text-5xl">
            Featured <span className="gradient-brand-text">Products</span>
          </h2>
          <p className="mx-auto max-w-2xl text-muted-foreground">
            Discover our most popular gaming peripherals, trusted by gamers worldwide
          </p>
        </motion.div>

        {/* Products Grid */}
        {isLoading ? (
          <div className="flex min-h-[200px] items-center justify-center gap-2 text-muted-foreground">
            <Loader2 className="h-8 w-8 animate-spin text-primary" aria-hidden />
            <span>Loading featured products…</span>
          </div>
        ) : isError ? (
          <p className="text-center text-sm text-muted-foreground">
            Featured products couldn&apos;t load. Open the full catalog from the link below.
          </p>
        ) : featuredProducts.length === 0 ? (
          <p className="text-center text-sm text-muted-foreground">
            New arrivals are on the way. Browse the full catalog for what&apos;s in stock.
          </p>
        ) : (
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
            {featuredProducts.map((product, index) => (
              <ProductCard key={product.id} product={product} index={index} />
            ))}
          </div>
        )}

        {/* View All Button */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.5, delay: 0.3 }}
          className="mt-12 text-center"
        >
          <Button asChild size="lg" variant="outline" className="border-primary/50 hover:bg-primary/10">
            <Link to="/products">
              View All Products
              <ArrowRight className="ml-2 h-4 w-4" />
            </Link>
          </Button>
        </motion.div>
      </div>
    </section>
  );
};

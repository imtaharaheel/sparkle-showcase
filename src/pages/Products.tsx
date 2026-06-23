import { useState, useRef, useCallback } from "react";
import { useSearchParams } from "react-router-dom";
import { useQuery } from "@tanstack/react-query";
import { motion, useInView } from "framer-motion";
import { Loader2, Search, X, Sparkles } from "lucide-react";
import { Navbar } from "@/components/Navbar";
import { MinimalFooter } from "@/components/MinimalFooter";
import { ProductCard } from "@/components/ProductCard";
import { WhatsAppButton } from "@/components/WhatsAppButton";
import { StickyWhatsAppCTA } from "@/components/StickyWhatsAppCTA";
import { QuickQuoteDrawer } from "@/components/QuickQuoteDrawer";
import {
  fetchCatalogCategories,
  fetchCatalogProducts,
  type StorefrontProduct,
} from "@/lib/catalog";
import { toCustomException } from "@/lib/errors";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";

const CATALOG_STALE_MS = 30_000;

type CatalogSortKey = "newest" | "name" | "price_asc" | "price_desc" | "stock_asc" | "stock_desc";

function sortCatalogProducts(
  items: StorefrontProduct[],
  sortKey: CatalogSortKey,
  catalogOrder: Map<string, number>,
): StorefrontProduct[] {
  const list = [...items];
  switch (sortKey) {
    case "newest":
      list.sort((a, b) => (catalogOrder.get(a.id) ?? 0) - (catalogOrder.get(b.id) ?? 0));
      break;
    case "name":
      list.sort((a, b) => a.name.localeCompare(b.name));
      break;
    case "price_asc":
      list.sort((a, b) => a.price - b.price);
      break;
    case "price_desc":
      list.sort((a, b) => b.price - a.price);
      break;
    case "stock_asc":
      list.sort((a, b) => (a.stockQuantity ?? 0) - (b.stockQuantity ?? 0));
      break;
    case "stock_desc":
      list.sort((a, b) => (b.stockQuantity ?? 0) - (a.stockQuantity ?? 0));
      break;
  }
  return list;
}

const Products = () => {
  const [searchParams, setSearchParams] = useSearchParams();
  const [searchQuery, setSearchQuery] = useState("");
  const [sortKey, setSortKey] = useState<CatalogSortKey>("price_asc");
  const [quoteDrawerOpen, setQuoteDrawerOpen] = useState(false);
  const [selectedProduct, setSelectedProduct] = useState<StorefrontProduct | null>(null);
  const headerRef = useRef<HTMLDivElement>(null);
  const isHeaderInView = useInView(headerRef, { once: true });

  const {
    data: products,
    isPending: productsPending,
    isError: productsError,
    error: productsErr,
  } = useQuery({
    queryKey: ["catalog_products"],
    queryFn: fetchCatalogProducts,
    staleTime: CATALOG_STALE_MS,
  });

  const { data: categories, isPending: categoriesPending } = useQuery({
    queryKey: ["catalog_categories"],
    queryFn: fetchCatalogCategories,
    staleTime: CATALOG_STALE_MS,
  });

  const catalogError = productsError ? toCustomException(productsErr, "Could not load products") : null;
  const isLoading = productsPending || categoriesPending;
  const productList = products ?? [];
  const categoryList = categories ?? [];
  const catalogOrder = new Map(productList.map((p, index) => [p.id, index]));

  const selectedCategory = searchParams.get("category") || "all";

  let filteredProducts = productList;
  if (selectedCategory !== "all") {
    filteredProducts = filteredProducts.filter((p) => p.category === selectedCategory);
  }
  if (searchQuery) {
    const query = searchQuery.toLowerCase();
    filteredProducts = filteredProducts.filter(
      (p) =>
        p.name.toLowerCase().includes(query) ||
        p.model.toLowerCase().includes(query) ||
        p.description.toLowerCase().includes(query),
    );
  }

  const displayedProducts = sortCatalogProducts(filteredProducts, sortKey, catalogOrder);

  const handleCategoryChange = (category: string) => {
    if (category === "all") {
      searchParams.delete("category");
    } else {
      searchParams.set("category", category);
    }
    setSearchParams(searchParams);
  };

  const clearFilters = () => {
    setSearchQuery("");
    searchParams.delete("category");
    setSearchParams(searchParams);
  };

  const handleOpenQuote = useCallback((product: StorefrontProduct) => {
    setSelectedProduct(product);
    setQuoteDrawerOpen(true);
  }, []);

  return (
    <div className="min-h-screen bg-[#0a0a0f]">
      <Navbar variant="dark" />
      
      <main className="pt-20 md:pt-24">
        {/* Header */}
        <section ref={headerRef} className="relative border-b border-white/10 py-16 md:py-24 overflow-hidden">
          {/* Animated background gradient */}
          <div className="absolute inset-0 bg-gradient-to-b from-primary/10 via-[#0a0a0f] to-[#0a0a0f]" />
          <motion.div 
            className="absolute top-0 left-1/4 w-96 h-96 bg-primary/20 rounded-full blur-3xl"
            animate={{ 
              scale: [1, 1.2, 1],
              opacity: [0.3, 0.5, 0.3],
            }}
            transition={{ duration: 8, repeat: Infinity }}
          />
          
          <div className="container relative mx-auto px-4">
            <motion.div
              initial={{ opacity: 0, y: 30 }}
              animate={isHeaderInView ? { opacity: 1, y: 0 } : {}}
              transition={{ duration: 0.6 }}
              className="text-center"
            >
              <motion.div
                className="mb-4 inline-flex items-center gap-2 rounded-full border border-primary/30 bg-primary/10 px-4 py-2"
                initial={{ opacity: 0, scale: 0.9 }}
                animate={isHeaderInView ? { opacity: 1, scale: 1 } : {}}
                transition={{ delay: 0.2 }}
              >
                <Sparkles className="h-4 w-4 text-primary" />
                <span className="text-sm font-medium text-primary">Premium Collection</span>
              </motion.div>
              
              <h1 className="mb-4 font-display text-4xl font-bold text-white md:text-5xl lg:text-6xl">
                {selectedCategory === "all" 
                  ? <>All <span className="gradient-brand-text">Products</span></>
                  : <span className="gradient-brand-text">{categoryList.find(c => c.id === selectedCategory)?.name || "Products"}</span>
                }
              </h1>
              <p className="mx-auto max-w-2xl text-lg text-gray-400">
                Browse our complete collection of premium gaming peripherals
              </p>
            </motion.div>
          </div>
        </section>

        {/* Filters */}
        <section className="sticky top-16 z-30 border-b border-white/10 bg-[#0a0a0f]/95 backdrop-blur-lg md:top-20">
          <div className="container mx-auto space-y-4 px-4 py-4">
            {/* Search — full width, easy to spot */}
            <div className="relative w-full">
              <Search className="absolute left-4 top-1/2 h-5 w-5 -translate-y-1/2 text-primary/80" />
              <Input
                type="search"
                placeholder="Search products by name..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="h-12 w-full rounded-xl border-white/20 bg-white/10 pl-12 text-base text-white shadow-sm placeholder:text-gray-400 focus:border-primary focus:ring-2 focus:ring-primary/25 md:h-14 md:pl-14 md:text-lg"
              />
            </div>

            <div className="flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
              {/* Sort */}
              <Select value={sortKey} onValueChange={(v) => setSortKey(v as CatalogSortKey)}>
                <SelectTrigger className="h-11 w-full bg-white/5 border-white/10 text-white sm:w-56">
                  <SelectValue placeholder="Sort by" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="newest">Newest first</SelectItem>
                  <SelectItem value="name">Name (A–Z)</SelectItem>
                  <SelectItem value="price_asc">Price (low → high)</SelectItem>
                  <SelectItem value="price_desc">Price (high → low)</SelectItem>
                  <SelectItem value="stock_asc">Stock (low → high)</SelectItem>
                  <SelectItem value="stock_desc">Stock (high → low)</SelectItem>
                </SelectContent>
              </Select>

              {/* Category Filters */}
              <div className="flex flex-wrap items-center gap-2">
                <motion.button
                  onClick={() => handleCategoryChange("all")}
                  className={`rounded-full px-4 py-2 text-sm font-medium transition-all ${
                    selectedCategory === "all" 
                      ? "bg-primary text-white shadow-lg shadow-primary/25" 
                      : "bg-white/5 text-gray-300 border border-white/10 hover:bg-white/10"
                  }`}
                  whileHover={{ scale: 1.05 }}
                  whileTap={{ scale: 0.95 }}
                >
                  All
                </motion.button>
                {categoryList.map((category) => (
                  <motion.button
                    key={category.id}
                    onClick={() => handleCategoryChange(category.id)}
                    className={`rounded-full px-4 py-2 text-sm font-medium transition-all ${
                      selectedCategory === category.id 
                        ? "bg-primary text-white shadow-lg shadow-primary/25" 
                        : "bg-white/5 text-gray-300 border border-white/10 hover:bg-white/10"
                    }`}
                    whileHover={{ scale: 1.05 }}
                    whileTap={{ scale: 0.95 }}
                  >
                    {category.icon} {category.name}
                  </motion.button>
                ))}
              </div>
            </div>

            {/* Active Filters */}
            {(selectedCategory !== "all" || searchQuery) && (
              <motion.div
                initial={{ opacity: 0, height: 0 }}
                animate={{ opacity: 1, height: "auto" }}
                exit={{ opacity: 0, height: 0 }}
                className="mt-4 flex items-center gap-2"
              >
                <span className="text-sm text-gray-500">Filters:</span>
                {selectedCategory !== "all" && (
                  <Badge variant="secondary" className="gap-1 bg-white/10 text-gray-300 border-white/20">
                    {categoryList.find(c => c.id === selectedCategory)?.name}
                    <X 
                      className="h-3 w-3 cursor-pointer hover:text-white" 
                      onClick={() => handleCategoryChange("all")}
                    />
                  </Badge>
                )}
                {searchQuery && (
                  <Badge variant="secondary" className="gap-1 bg-white/10 text-gray-300 border-white/20">
                    "{searchQuery}"
                    <X 
                      className="h-3 w-3 cursor-pointer hover:text-white" 
                      onClick={() => setSearchQuery("")}
                    />
                  </Badge>
                )}
                <Button
                  variant="ghost"
                  size="sm"
                  onClick={clearFilters}
                  className="text-gray-400 hover:text-white hover:bg-white/10"
                >
                  Clear all
                </Button>
              </motion.div>
            )}
          </div>
        </section>

        {/* Products Grid */}
        <section className="py-12 md:py-16 bg-[#08080c]">
          <div className="container mx-auto px-4">
            {catalogError ? (
              <div className="py-20 text-center">
                <p className="text-destructive">{catalogError.message}</p>
                <p className="mt-2 text-sm text-gray-500">Check your connection and Supabase settings, then refresh.</p>
              </div>
            ) : isLoading ? (
              <div className="flex min-h-[40vh] items-center justify-center gap-2 text-gray-400">
                <Loader2 className="h-8 w-8 animate-spin text-primary" aria-hidden />
                <span>Loading products…</span>
              </div>
            ) : displayedProducts.length > 0 ? (
              <>
                <motion.p 
                  className="mb-6 text-sm text-gray-500"
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                >
                  Showing {displayedProducts.length} product{displayedProducts.length !== 1 ? 's' : ''}
                </motion.p>
                <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
                  {displayedProducts.map((product, index) => (
                    <ProductCard 
                      key={product.id} 
                      product={product} 
                      index={index}
                      onQuickQuote={handleOpenQuote}
                    />
                  ))}
                </div>
              </>
            ) : (
              <motion.div
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                className="py-20 text-center"
              >
                <motion.div 
                  className="mx-auto mb-4 flex h-20 w-20 items-center justify-center rounded-2xl bg-white/5 border border-white/10"
                  animate={{ 
                    boxShadow: ["0 0 20px rgba(192, 38, 73, 0)", "0 0 30px rgba(192, 38, 73, 0.3)", "0 0 20px rgba(192, 38, 73, 0)"]
                  }}
                  transition={{ duration: 2, repeat: Infinity }}
                >
                  <Search className="h-10 w-10 text-gray-500" />
                </motion.div>
                <h3 className="mb-2 font-display text-2xl font-semibold text-white">No products found</h3>
                <p className="mb-6 text-gray-400">
                  Try adjusting your search or filter criteria
                </p>
                <motion.button
                  onClick={clearFilters}
                  className="rounded-full border border-white/20 bg-white/5 px-6 py-3 font-medium text-white hover:bg-white/10 transition-colors"
                  whileHover={{ scale: 1.05 }}
                  whileTap={{ scale: 0.95 }}
                >
                  Clear Filters
                </motion.button>
              </motion.div>
            )}
          </div>
        </section>
      </main>

      <MinimalFooter />
      <WhatsAppButton />
      <StickyWhatsAppCTA />
      <QuickQuoteDrawer 
        open={quoteDrawerOpen} 
        onOpenChange={setQuoteDrawerOpen} 
        product={selectedProduct}
      />
    </div>
  );
};

export default Products;

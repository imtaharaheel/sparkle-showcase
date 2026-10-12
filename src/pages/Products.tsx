import { useState, useCallback } from "react";
import { useSearchParams } from "react-router-dom";
import { useQuery } from "@tanstack/react-query";
import { motion } from "framer-motion";
import { ChevronDown, ChevronRight, Loader2, Search, SlidersHorizontal, X } from "lucide-react";
import { Navbar } from "@/components/Navbar";
import { MinimalFooter } from "@/components/MinimalFooter";
import { ProductCard } from "@/components/ProductCard";
import { WhatsAppButton } from "@/components/WhatsAppButton";
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
  /** Phones: the category / brand panel is collapsed until the shopper opens it. */
  const [filtersOpen, setFiltersOpen] = useState(false);

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
  const selectedBrand = searchParams.get("brand") || "all";
  const selectedCategoryInfo = categoryList.find((c) => c.id === selectedCategory);
  const parentSlugByCategory = new Map(categoryList.map((c) => [c.id, c.parentId]));
  // Categories with nothing to show stay out of the shop until products are added to them.
  const stockedCategories = new Set<string>();
  for (const p of productList) {
    stockedCategories.add(p.category);
    const parent = parentSlugByCategory.get(p.category);
    if (parent) stockedCategories.add(parent);
  }
  // Empty categories are listed too, dimmed and tagged "Soon", so shoppers can see what is coming.
  const topLevelCategories = categoryList.filter((c) => !c.parentId);
  // The top-level category in play, whether it or one of its subcategories is selected.
  const activeParent = selectedCategoryInfo?.parentId ?? selectedCategory;
  const activeParentInfo = categoryList.find((c) => c.id === activeParent);
  const subcategories = categoryList.filter((c) => c.parentId === activeParent && stockedCategories.has(c.id));

  let filteredProducts = productList;
  if (selectedCategory !== "all") {
    filteredProducts = filteredProducts.filter(
      (p) => p.category === selectedCategory || parentSlugByCategory.get(p.category) === selectedCategory,
    );
  }
  // Brands available within the chosen category, offered as a second filter.
  const brandCounts = new Map<string, number>();
  for (const p of filteredProducts) {
    if (p.brand) brandCounts.set(p.brand, (brandCounts.get(p.brand) ?? 0) + 1);
  }
  if (selectedBrand !== "all" && !brandCounts.has(selectedBrand)) brandCounts.set(selectedBrand, 0);
  const brandOptions = [...brandCounts.keys()].sort((a, b) => a.localeCompare(b));
  const productsInCategory = filteredProducts.length;
  if (selectedBrand !== "all") {
    filteredProducts = filteredProducts.filter((p) => p.brand === selectedBrand);
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

  /** Products in a category, counting its subcategories too. */
  const brandScoped = selectedBrand === "all" ? productList : productList.filter((p) => p.brand === selectedBrand);
  const countIn = (categoryId: string) =>
    brandScoped.filter((p) => p.category === categoryId || parentSlugByCategory.get(p.category) === categoryId).length;
  const pageTitle = selectedCategoryInfo?.name ?? "All Products";

  const handleCategoryChange = (category: string) => {
    if (category === "all") {
      searchParams.delete("category");
    } else {
      searchParams.set("category", category);
    }
    setSearchParams(searchParams);
  };

  const handleBrandChange = (brand: string) => {
    if (brand === "all") {
      searchParams.delete("brand");
    } else {
      searchParams.set("brand", brand);
    }
    setSearchParams(searchParams);
  };

  const clearFilters = () => {
    setSearchQuery("");
    searchParams.delete("category");
    searchParams.delete("brand");
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
        {/* Header: where you are, in one line */}
        <section className="border-b border-white/10 bg-gradient-to-b from-primary/10 to-[#0a0a0f] py-8 md:py-10">
          <div className="container mx-auto px-4">
            <nav className="mb-2 flex flex-wrap items-center gap-1 text-sm text-gray-400" aria-label="Breadcrumb">
              <button type="button" className="hover:text-white" onClick={() => handleCategoryChange("all")}>
                All products
              </button>
              {activeParentInfo ? (
                <>
                  <ChevronRight className="h-3.5 w-3.5" />
                  <button type="button" className="hover:text-white" onClick={() => handleCategoryChange(activeParentInfo.id)}>
                    {activeParentInfo.name}
                  </button>
                </>
              ) : null}
              {selectedCategoryInfo?.parentId ? (
                <>
                  <ChevronRight className="h-3.5 w-3.5" />
                  <span className="text-gray-200">{selectedCategoryInfo.name}</span>
                </>
              ) : null}
            </nav>
            <h1 className="font-display text-3xl font-bold text-white md:text-4xl">
              {selectedCategory === "all" ? (
                <>
                  All <span className="gradient-brand-text">Products</span>
                </>
              ) : (
                <span className="gradient-brand-text">{pageTitle}</span>
              )}
            </h1>
            {selectedBrand !== "all" ? (
              <button
                type="button"
                onClick={() => handleBrandChange("all")}
                className="mt-3 inline-flex items-center gap-1.5 rounded-full border border-white/20 bg-white/10 px-3 py-1 text-sm text-gray-200 hover:bg-white/15"
              >
                Brand: <span className="font-semibold text-white">{selectedBrand}</span>
                <X className="h-3.5 w-3.5" />
              </button>
            ) : null}
          </div>
        </section>

        {/* Search and sort */}
        <section className="sticky top-16 z-30 border-b border-white/10 bg-[#0a0a0f]/95 backdrop-blur-lg md:top-20">
          <div className="container mx-auto flex flex-col gap-3 px-4 py-3 sm:flex-row sm:items-center">
            <div className="relative flex-1">
              <Search className="absolute left-4 top-1/2 h-4 w-4 -translate-y-1/2 text-primary" />
              <Input
                type="text"
                placeholder="Search products by name..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="h-11 border-white/10 bg-white/5 pl-11 pr-10 text-white placeholder:text-gray-500 focus:border-primary/50"
              />
              {searchQuery ? (
                <button
                  type="button"
                  aria-label="Clear search"
                  onClick={() => setSearchQuery("")}
                  className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-white"
                >
                  <X className="h-4 w-4" />
                </button>
              ) : null}
            </div>
            <div className="flex items-center gap-2">
              <Button
                type="button"
                variant="outline"
                className="h-11 flex-1 gap-2 border-white/10 bg-white/5 text-white hover:bg-white/10 hover:text-white lg:hidden"
                onClick={() => setFiltersOpen((open) => !open)}
                aria-expanded={filtersOpen}
              >
                <SlidersHorizontal className="h-4 w-4" />
                Categories
                <ChevronDown className={`h-4 w-4 transition-transform ${filtersOpen ? "rotate-180" : ""}`} />
              </Button>
              <Select value={sortKey} onValueChange={(value) => setSortKey(value as CatalogSortKey)}>
                <SelectTrigger className="h-11 w-full border-white/10 bg-white/5 text-white sm:w-52">
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
            </div>
          </div>
        </section>

        {/* Products Grid */}
        <section className="bg-[#08080c] py-8 md:py-10">
          <div className="container mx-auto gap-8 px-4 lg:grid lg:grid-cols-[240px_minmax(0,1fr)]">
            {/* Category tree and brand list: a sidebar on desktop, a collapsible panel on phones */}
            <aside className={`${filtersOpen ? "block" : "hidden"} mb-6 lg:mb-0 lg:block`}>
              <div className="space-y-6 rounded-xl border border-white/10 bg-white/[0.03] p-4 lg:sticky lg:top-40">
                <div>
                  <h2 className="mb-2 px-2 text-xs font-semibold uppercase tracking-wider text-gray-500">Categories</h2>
                  <ul className="space-y-0.5">
                    <li>
                      <button
                        type="button"
                        onClick={() => {
                          handleCategoryChange("all");
                          setFiltersOpen(false);
                        }}
                        className={`flex w-full items-center justify-between rounded-lg px-2 py-2 text-left text-sm ${
                          selectedCategory === "all" ? "bg-primary font-semibold text-white" : "text-gray-300 hover:bg-white/5"
                        }`}
                      >
                        <span>All products</span>
                        <span className="text-xs opacity-70">{brandScoped.length}</span>
                      </button>
                    </li>
                    {topLevelCategories.map((category) => {
                      const open = activeParent === category.id;
                      const children = categoryList.filter((c) => c.parentId === category.id);
                      const empty = !stockedCategories.has(category.id);
                      return (
                        <li key={category.id}>
                          <button
                            type="button"
                            onClick={() => {
                              handleCategoryChange(category.id);
                              if (children.length === 0) setFiltersOpen(false);
                            }}
                            className={`flex w-full items-center justify-between rounded-lg px-2 py-2 text-left text-sm ${
                              selectedCategory === category.id
                                ? "bg-primary font-semibold text-white"
                                : open
                                  ? "font-semibold text-white"
                                  : empty
                                    ? "text-gray-500 hover:bg-white/5"
                                    : "text-gray-300 hover:bg-white/5"
                            }`}
                          >
                            <span>
                              {category.icon} {category.name}
                            </span>
                            <span className="flex items-center gap-1 text-xs opacity-70">
                              {empty ? <span className="rounded bg-white/10 px-1.5 py-0.5 text-[10px] uppercase">Soon</span> : countIn(category.id)}
                              {children.length > 0 ? (
                                <ChevronDown className={`h-3.5 w-3.5 transition-transform ${open ? "rotate-180" : ""}`} />
                              ) : null}
                            </span>
                          </button>
                          {open && children.length > 0 ? (
                            <ul className="my-1 ml-4 space-y-0.5 border-l border-white/10 pl-2">
                              {children.map((sub) => (
                                <li key={sub.id}>
                                  <button
                                    type="button"
                                    onClick={() => {
                                      handleCategoryChange(sub.id);
                                      setFiltersOpen(false);
                                    }}
                                    className={`flex w-full items-center justify-between rounded-lg px-2 py-1.5 text-left text-sm ${
                                      selectedCategory === sub.id
                                        ? "bg-white font-semibold text-black"
                                        : "text-gray-400 hover:bg-white/5 hover:text-gray-200"
                                    }`}
                                  >
                                    <span>{sub.name}</span>
                                    <span className="text-xs opacity-70">
                                      {stockedCategories.has(sub.id) ? countIn(sub.id) : "Soon"}
                                    </span>
                                  </button>
                                </li>
                              ))}
                            </ul>
                          ) : null}
                        </li>
                      );
                    })}
                  </ul>
                </div>

                {brandOptions.length > 0 || selectedBrand !== "all" ? (
                  <div>
                    <h2 className="mb-2 px-2 text-xs font-semibold uppercase tracking-wider text-gray-500">Brand</h2>
                    <ul className="space-y-0.5">
                      {["all", ...brandOptions].map((brand) => (
                        <li key={brand}>
                          <button
                            type="button"
                            onClick={() => {
                              handleBrandChange(brand);
                              setFiltersOpen(false);
                            }}
                            className={`flex w-full items-center gap-2 rounded-lg px-2 py-1.5 text-left text-sm ${
                              selectedBrand === brand ? "font-semibold text-white" : "text-gray-400 hover:bg-white/5 hover:text-gray-200"
                            }`}
                          >
                            <span
                              className={`h-3.5 w-3.5 rounded-full border ${
                                selectedBrand === brand ? "border-primary bg-primary" : "border-white/30"
                              }`}
                            />
                            <span className="flex-1">{brand === "all" ? "All brands" : brand}</span>
                            <span className="text-xs opacity-70">
                              {brand === "all" ? productsInCategory : (brandCounts.get(brand) ?? 0)}
                            </span>
                          </button>
                        </li>
                      ))}
                    </ul>
                  </div>
                ) : null}
              </div>
            </aside>

            <div className="min-w-0">
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
                <div className="grid gap-5 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
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
                <h3 className="mb-2 font-display text-2xl font-semibold text-white">
                  {selectedCategory !== "all" && !stockedCategories.has(selectedCategory) && !searchQuery
                    ? "Coming soon"
                    : "No products found"}
                </h3>
                <p className="mb-6 text-gray-400">
                  {selectedCategory !== "all" && !stockedCategories.has(selectedCategory) && !searchQuery
                    ? "We are adding products to this category. Message us on WhatsApp for availability."
                    : "Try adjusting your search or filter criteria"}
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
          </div>
        </section>
      </main>

      <MinimalFooter />
      <WhatsAppButton />
      <QuickQuoteDrawer
        open={quoteDrawerOpen}
        onOpenChange={setQuoteDrawerOpen}
        product={selectedProduct}
      />
    </div>
  );
};

export default Products;

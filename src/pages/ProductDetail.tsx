import { useParams, Link, useNavigate } from "react-router-dom";
import { useEffect } from "react";
import { useQuery } from "@tanstack/react-query";
import { motion } from "framer-motion";
import { ArrowLeft, Loader2, MessageCircle, Check, ExternalLink } from "lucide-react";
import { Navbar } from "@/components/Navbar";
import { Footer } from "@/components/Footer";
import { WhatsAppButton } from "@/components/WhatsAppButton";
import { ProductCard } from "@/components/ProductCard";
import { ProductImageGallery } from "@/components/ProductImageGallery";
import { ProductSpecificationsTable } from "@/components/ProductSpecificationsTable";
import {
  fetchCatalogCategories,
  fetchCatalogProductById,
  fetchCatalogProducts,
} from "@/lib/catalog";
import { formatPrice } from "@/lib/formatPrice";
import { toCustomException } from "@/lib/errors";
import { Button } from "@/components/ui/button";
import { Separator } from "@/components/ui/separator";

const CATALOG_STALE_MS = 30_000;

const ProductDetail = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();

  const {
    data: product,
    isLoading,
    isError,
    error,
  } = useQuery({
    queryKey: ["catalog_product", id],
    queryFn: () => fetchCatalogProductById(id || ""),
    enabled: Boolean(id),
    staleTime: CATALOG_STALE_MS,
  });

  const { data: allProducts = [] } = useQuery({
    queryKey: ["catalog_products"],
    queryFn: fetchCatalogProducts,
    staleTime: CATALOG_STALE_MS,
  });

  const { data: categories = [] } = useQuery({
    queryKey: ["catalog_categories"],
    queryFn: fetchCatalogCategories,
    staleTime: CATALOG_STALE_MS,
  });

  useEffect(() => {
    window.scrollTo(0, 0);
  }, [id]);

  useEffect(() => {
    if (product) {
      window.scrollTo(0, 0);
    }
  }, [product?.id]);

  if (isLoading) {
    return (
      <div className="min-h-screen bg-background">
        <Navbar />
        <main className="flex min-h-[60vh] items-center justify-center gap-2 pt-20 text-muted-foreground">
          <Loader2 className="h-8 w-8 animate-spin text-primary" aria-hidden />
          <span>Loading product…</span>
        </main>
        <Footer />
      </div>
    );
  }

  if (isError) {
    const ex = toCustomException(error, "Could not load product");
    return (
      <div className="min-h-screen bg-background">
        <Navbar />
        <main className="flex min-h-[60vh] flex-col items-center justify-center gap-4 pt-20 px-4 text-center">
          <p className="text-destructive">{ex.message}</p>
          <Button asChild variant="outline">
            <Link to="/products">Browse all products</Link>
          </Button>
        </main>
        <Footer />
      </div>
    );
  }

  if (!product) {
    return (
      <div className="min-h-screen bg-background">
        <Navbar />
        <main className="flex min-h-[60vh] items-center justify-center pt-20">
          <div className="text-center">
            <h1 className="mb-4 font-display text-2xl font-bold">Product Not Found</h1>
            <p className="mb-6 text-muted-foreground">The product you&apos;re looking for doesn&apos;t exist.</p>
            <Button asChild>
              <Link to="/products">Browse All Products</Link>
            </Button>
          </div>
        </main>
        <Footer />
      </div>
    );
  }

  const handleWhatsApp = () => {
    const message = `Hi! I'm interested in ${product.name} (${product.model}) - ${formatPrice(product.price)}. Can you provide more details?`;
    window.open(`https://wa.me/923342914563?text=${encodeURIComponent(message)}`, "_blank");
  };

  const categoryInfo = categories.find((c) => c.id === product.category);

  const relatedProducts = allProducts
    .filter((p) => p.category === product.category && p.id !== product.id)
    .slice(0, 4);

  return (
    <div className="min-h-screen bg-background">
      <Navbar />

      <main className="pt-20 md:pt-24">
        {/* Breadcrumb */}
        <section className="border-b border-border bg-secondary/30">
          <div className="container mx-auto px-4 py-4">
            <nav className="flex items-center gap-2 text-sm text-muted-foreground">
              <Link to="/" className="transition-colors hover:text-foreground">
                Home
              </Link>
              <span>/</span>
              <Link to="/products" className="transition-colors hover:text-foreground">
                Products
              </Link>
              <span>/</span>
              <Link
                to={`/products?category=${product.category}`}
                className="transition-colors hover:text-foreground"
              >
                {categoryInfo?.name || product.category}
              </Link>
              <span>/</span>
              <span className="text-foreground">{product.model}</span>
            </nav>
          </div>
        </section>

        {/* Product Details */}
        <section className="py-12 md:py-16">
          <div className="container mx-auto px-4">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.5 }}
              className="grid gap-12 lg:grid-cols-2"
            >
              {/* Product Image Gallery */}
              <div className="relative lg:sticky lg:top-28 lg:self-start">
                <ProductImageGallery
                  images={product.images.length > 0 ? product.images : product.image ? [product.image] : []}
                  alt={product.name}
                  badge={product.badge}
                />
              </div>

              {/* Product Info */}
              <div>
                <motion.div
                  initial={{ opacity: 0, x: 20 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ duration: 0.5, delay: 0.2 }}
                >
                  <Link
                    to={`/products?category=${product.category}`}
                    className="mb-3 inline-flex items-center gap-2 text-sm font-medium uppercase tracking-wider text-primary hover:underline"
                  >
                    {categoryInfo?.icon} {categoryInfo?.name}
                  </Link>

                  {product.description.trim() ? (
                    <p className="mb-2 text-sm font-medium text-muted-foreground">Model: {product.model}</p>
                  ) : null}

                  <h1 className="mb-4 font-display text-3xl font-bold text-foreground md:text-4xl">{product.name}</h1>

                  <div className="mb-6">
                    <span className="font-display text-4xl font-bold text-primary md:text-5xl">
                      {formatPrice(product.price)}
                    </span>
                  </div>

                  {product.description.trim() ? (
                    <p className="mb-8 whitespace-pre-line text-lg text-muted-foreground">{product.description}</p>
                  ) : null}

                  <div className="mb-8 flex flex-wrap gap-4">
                    <Button
                      size="lg"
                      onClick={handleWhatsApp}
                      className="bg-[#25D366] text-white hover:bg-[#128C7E] gap-2"
                    >
                      <MessageCircle className="h-5 w-5" />
                      Inquire on WhatsApp
                    </Button>
                    {product.webLink && (
                      <Button size="lg" variant="outline" asChild>
                        <a
                          href={
                            product.webLink.startsWith("http://") || product.webLink.startsWith("https://")
                              ? product.webLink
                              : `https://${product.webLink}`
                          }
                          target="_blank"
                          rel="noopener noreferrer"
                          className="gap-2"
                        >
                          <ExternalLink className="h-4 w-4" />
                          Official Page
                        </a>
                      </Button>
                    )}
                  </div>

                  <Separator className="mb-8" />

                  {product.features.length > 0 ? (
                    <div>
                      <h3 className="mb-4 font-display text-lg font-semibold text-foreground">
                        Features
                      </h3>
                      <ul className="grid gap-3 sm:grid-cols-2">
                        {product.features.map((feature, index) => (
                          <motion.li
                            key={index}
                            initial={{ opacity: 0, x: -10 }}
                            animate={{ opacity: 1, x: 0 }}
                            transition={{ duration: 0.3, delay: 0.3 + index * 0.05 }}
                            className="flex items-start gap-2 text-sm text-muted-foreground"
                          >
                            <Check className="mt-0.5 h-4 w-4 shrink-0 text-primary" />
                            <span>{feature}</span>
                          </motion.li>
                        ))}
                      </ul>
                    </div>
                  ) : product.specifications.length === 0 ? (
                    <p className="text-sm text-muted-foreground">
                      For full specifications, message us on WhatsApp — we&apos;re happy to help.
                    </p>
                  ) : null}
                </motion.div>
              </div>
            </motion.div>

            {product.specifications.length > 0 ? (
              <motion.div
                initial={{ opacity: 0, y: 16 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.45, delay: 0.15 }}
                className="mt-12"
              >
                <h2 className="mb-4 font-display text-2xl font-bold text-foreground md:text-3xl">
                  Technical Specifications
                </h2>
                <ProductSpecificationsTable specifications={product.specifications} />
              </motion.div>
            ) : null}
          </div>
        </section>

        {relatedProducts.length > 0 && (
          <section className="border-t border-border bg-secondary/20 py-16 md:py-20">
            <div className="container mx-auto px-4">
              <motion.div
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.5 }}
              >
                <h2 className="mb-8 font-display text-2xl font-bold text-foreground md:text-3xl">
                  Related Products
                </h2>
                <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
                  {relatedProducts.map((relatedProduct, index) => (
                    <ProductCard key={relatedProduct.id} product={relatedProduct} index={index} />
                  ))}
                </div>
              </motion.div>
            </div>
          </section>
        )}

        <section className="py-8">
          <div className="container mx-auto px-4">
            <Button variant="ghost" onClick={() => navigate(-1)} className="gap-2">
              <ArrowLeft className="h-4 w-4" />
              Back to Products
            </Button>
          </div>
        </section>
      </main>

      <Footer />
      <WhatsAppButton />
    </div>
  );
};

export default ProductDetail;

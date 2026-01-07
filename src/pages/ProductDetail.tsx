import { useParams, Link, useNavigate } from "react-router-dom";
import { motion } from "framer-motion";
import { ArrowLeft, MessageCircle, Check, ExternalLink } from "lucide-react";
import { Navbar } from "@/components/Navbar";
import { Footer } from "@/components/Footer";
import { WhatsAppButton } from "@/components/WhatsAppButton";
import { ProductCard } from "@/components/ProductCard";
import { getProductById, products, formatPrice, categories } from "@/data/products";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { Separator } from "@/components/ui/separator";

const ProductDetail = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const product = getProductById(id || "");

  if (!product) {
    return (
      <div className="min-h-screen bg-background">
        <Navbar />
        <main className="flex min-h-[60vh] items-center justify-center pt-20">
          <div className="text-center">
            <h1 className="mb-4 font-display text-2xl font-bold">Product Not Found</h1>
            <p className="mb-6 text-muted-foreground">The product you're looking for doesn't exist.</p>
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
    window.open(`https://wa.me/9233442914563?text=${encodeURIComponent(message)}`, "_blank");
  };

  const categoryInfo = categories.find(c => c.id === product.category);
  
  // Get related products from the same category
  const relatedProducts = products
    .filter(p => p.category === product.category && p.id !== product.id)
    .slice(0, 4);

  return (
    <div className="min-h-screen bg-background">
      <Navbar />
      
      <main className="pt-20 md:pt-24">
        {/* Breadcrumb */}
        <section className="border-b border-border bg-card/50">
          <div className="container mx-auto px-4 py-4">
            <nav className="flex items-center gap-2 text-sm text-muted-foreground">
              <Link to="/" className="transition-colors hover:text-foreground">Home</Link>
              <span>/</span>
              <Link to="/products" className="transition-colors hover:text-foreground">Products</Link>
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
              {/* Product Image */}
              <div className="relative">
                <motion.div
                  initial={{ opacity: 0, scale: 0.95 }}
                  animate={{ opacity: 1, scale: 1 }}
                  transition={{ duration: 0.5, delay: 0.1 }}
                  className="sticky top-28 overflow-hidden rounded-2xl border border-border bg-gradient-to-br from-secondary to-muted"
                >
                  {product.badge && (
                    <div className="absolute top-4 left-4 z-10">
                      <Badge className="gradient-cyber text-primary-foreground font-semibold text-sm px-3 py-1">
                        {product.badge}
                      </Badge>
                    </div>
                  )}
                  <div className="flex aspect-square items-center justify-center p-12">
                    <motion.div
                      className="text-center"
                      animate={{ y: [0, -5, 0] }}
                      transition={{ duration: 3, repeat: Infinity, ease: "easeInOut" }}
                    >
                      <span className="font-display text-5xl font-bold text-muted-foreground/30 md:text-6xl">
                        {product.model}
                      </span>
                    </motion.div>
                  </div>
                </motion.div>
              </div>

              {/* Product Info */}
              <div>
                <motion.div
                  initial={{ opacity: 0, x: 20 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ duration: 0.5, delay: 0.2 }}
                >
                  {/* Category */}
                  <Link 
                    to={`/products?category=${product.category}`}
                    className="mb-3 inline-flex items-center gap-2 text-sm font-medium uppercase tracking-wider text-primary hover:underline"
                  >
                    {categoryInfo?.icon} {categoryInfo?.name}
                  </Link>

                  {/* Model */}
                  <p className="mb-2 text-sm font-medium text-muted-foreground">
                    Model: {product.model}
                  </p>

                  {/* Name */}
                  <h1 className="mb-4 font-display text-3xl font-bold md:text-4xl">
                    {product.name}
                  </h1>

                  {/* Price */}
                  <div className="mb-6">
                    <span className="font-display text-4xl font-bold text-primary md:text-5xl">
                      {formatPrice(product.price)}
                    </span>
                  </div>

                  {/* Description */}
                  <p className="mb-8 text-lg text-muted-foreground">
                    {product.description}
                  </p>

                  {/* CTA Buttons */}
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
                      <Button 
                        size="lg" 
                        variant="outline"
                        asChild
                      >
                        <a 
                          href={`https://${product.webLink}`} 
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

                  {/* Features */}
                  <div>
                    <h3 className="mb-4 font-display text-lg font-semibold">Features & Specifications</h3>
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
                </motion.div>
              </div>
            </motion.div>
          </div>
        </section>

        {/* Related Products */}
        {relatedProducts.length > 0 && (
          <section className="border-t border-border bg-card/50 py-16 md:py-20">
            <div className="container mx-auto px-4">
              <motion.div
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ duration: 0.5 }}
              >
                <h2 className="mb-8 font-display text-2xl font-bold md:text-3xl">
                  Related Products
                </h2>
                <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
                  {relatedProducts.map((relatedProduct, index) => (
                    <ProductCard 
                      key={relatedProduct.id} 
                      product={relatedProduct} 
                      index={index}
                    />
                  ))}
                </div>
              </motion.div>
            </div>
          </section>
        )}

        {/* Back Button */}
        <section className="py-8">
          <div className="container mx-auto px-4">
            <Button 
              variant="ghost" 
              onClick={() => navigate(-1)}
              className="gap-2"
            >
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

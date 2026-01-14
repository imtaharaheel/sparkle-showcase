import { Link } from "react-router-dom";
import { motion } from "framer-motion";
import { ArrowRight, Zap, Shield, Headphones } from "lucide-react";
import { Button } from "@/components/ui/button";
import { AnimatedBackground } from "./AnimatedBackground";

const features = [
  { icon: Zap, label: "High Performance" },
  { icon: Shield, label: "Quality Assured" },
  { icon: Headphones, label: "Premium Audio" },
];

export const HeroSection = () => {
  return (
    <section className="relative min-h-screen overflow-hidden pt-20">
      <AnimatedBackground variant="hero" />

      <div className="container mx-auto px-4 py-16 md:py-24 lg:py-32">
        <div className="flex flex-col items-center text-center">
          {/* Badge */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5 }}
            className="mb-6"
          >
            <span className="inline-flex items-center gap-2 rounded-full border border-primary/30 bg-primary/10 px-4 py-1.5 text-sm font-medium text-primary">
              <span className="relative flex h-2 w-2">
                <span className="absolute inline-flex h-full w-full animate-ping rounded-full bg-primary opacity-75" />
                <span className="relative inline-flex h-2 w-2 rounded-full bg-primary" />
              </span>
              New 2026 Collection Available
            </span>
          </motion.div>

          {/* Main Heading */}
          <motion.h1
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.1 }}
            className="mb-6 max-w-4xl font-display text-4xl font-bold leading-tight tracking-tight text-foreground md:text-5xl lg:text-6xl xl:text-7xl"
          >
            Elevate Your{" "}
            <span className="gradient-brand-text">Gaming</span>
            <br />
            Experience
          </motion.h1>

          {/* Subtitle */}
          <motion.p
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.2 }}
            className="mb-8 max-w-2xl text-lg text-muted-foreground md:text-xl"
          >
            Premium gaming peripherals engineered for victory. Discover our collection of 
            mechanical keyboards, precision mice, and immersive headsets.
          </motion.p>

          {/* CTA Buttons */}
          <motion.div
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.3 }}
            className="mb-12 flex flex-col gap-4 sm:flex-row"
          >
            <Button asChild size="lg" className="gradient-brand text-primary-foreground font-semibold px-8 glow-primary">
              <Link to="/products">
                Browse Products
                <ArrowRight className="ml-2 h-4 w-4" />
              </Link>
            </Button>
            <Button asChild variant="outline" size="lg" className="border-primary/50 hover:bg-primary/10">
              <a href="https://wa.me/9233442914563" target="_blank" rel="noopener noreferrer">
                Contact Us
              </a>
            </Button>
          </motion.div>

          {/* Features */}
          <motion.div
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.4 }}
            className="flex flex-wrap justify-center gap-6 md:gap-12"
          >
            {features.map((feature, index) => (
              <motion.div
                key={feature.label}
                initial={{ opacity: 0, scale: 0.8 }}
                animate={{ opacity: 1, scale: 1 }}
                transition={{ duration: 0.4, delay: 0.5 + index * 0.1 }}
                className="flex items-center gap-2 text-muted-foreground"
              >
                <feature.icon className="h-5 w-5 text-primary" />
                <span className="text-sm font-medium">{feature.label}</span>
              </motion.div>
            ))}
          </motion.div>
        </div>

        {/* Animated Product Showcase */}
        <motion.div
          initial={{ opacity: 0, y: 60 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, delay: 0.6 }}
          className="relative mt-16 md:mt-24"
        >
          <div className="relative mx-auto max-w-4xl overflow-hidden rounded-2xl border border-border bg-card/80 backdrop-blur-sm p-4 md:p-8 shadow-xl">
            <div className="absolute inset-0 bg-gradient-to-t from-card via-transparent to-transparent" />
            <div className="absolute inset-x-0 top-0 h-px bg-gradient-to-r from-transparent via-primary to-transparent" />
            
            {/* Mock Product Display */}
            <div className="relative flex aspect-video items-center justify-center rounded-xl bg-gradient-to-br from-secondary to-accent/30">
              <motion.div
                className="text-center"
                animate={{ y: [0, -10, 0] }}
                transition={{ duration: 3, repeat: Infinity, ease: "easeInOut" }}
              >
                <span className="font-display text-5xl font-bold gradient-brand-text md:text-7xl">
                  SAIM SAUDAFGAR
                </span>
                <p className="mt-2 text-lg text-muted-foreground">Enterprise • Premium Gaming Gear</p>
              </motion.div>
            </div>
          </div>
        </motion.div>
      </div>
    </section>
  );
};

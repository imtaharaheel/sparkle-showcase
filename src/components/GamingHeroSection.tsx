import { motion, useScroll, useTransform } from "framer-motion";
import { useRef } from "react";
import { MessageCircle, ArrowRight } from "lucide-react";
import heroImage from "@/assets/hero-gaming-pc.jpg";

const WHATSAPP_NUMBER = "9233442914563";
const WHATSAPP_MESSAGE = "Hi! I'm interested in your products.";

export const GamingHeroSection = () => {
  const containerRef = useRef<HTMLDivElement>(null);
  const { scrollYProgress } = useScroll({
    target: containerRef,
    offset: ["start start", "end start"]
  });

  const y = useTransform(scrollYProgress, [0, 1], ["0%", "30%"]);
  const opacity = useTransform(scrollYProgress, [0, 0.5], [1, 0]);

  const handleWhatsApp = (message: string) => {
    window.open(`https://wa.me/${WHATSAPP_NUMBER}?text=${encodeURIComponent(message)}`, "_blank");
  };

  return (
    <section 
      ref={containerRef}
      className="relative min-h-screen overflow-hidden bg-[#0a0a0f]"
    >
      {/* Animated Background with Parallax */}
      <motion.div 
        className="absolute inset-0 z-0"
        style={{ y }}
      >
        <img 
          src={heroImage}
          alt="Gaming Setup"
          className="h-full w-full object-cover opacity-50"
        />
        {/* Dark overlay gradient */}
        <div className="absolute inset-0 bg-gradient-to-t from-[#0a0a0f] via-[#0a0a0f]/80 to-[#0a0a0f]/40" />
        <div className="absolute inset-0 bg-gradient-to-r from-[#0a0a0f]/90 via-transparent to-[#0a0a0f]/90" />
      </motion.div>

      {/* Brand Color Glow Effects - Using primary maroon */}
      <div className="absolute inset-0 z-0 overflow-hidden">
        <motion.div
          className="absolute -top-1/4 -left-1/4 h-[600px] w-[600px] rounded-full bg-primary/20 blur-[120px]"
          animate={{
            x: [0, 100, 0],
            y: [0, 50, 0],
            scale: [1, 1.2, 1],
          }}
          transition={{ duration: 8, repeat: Infinity, ease: "easeInOut" }}
        />
        <motion.div
          className="absolute -bottom-1/4 -right-1/4 h-[500px] w-[500px] rounded-full bg-brand-rose/15 blur-[100px]"
          animate={{
            x: [0, -80, 0],
            y: [0, -60, 0],
            scale: [1, 1.3, 1],
          }}
          transition={{ duration: 10, repeat: Infinity, ease: "easeInOut" }}
        />
        <motion.div
          className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 h-[400px] w-[400px] rounded-full bg-brand-pink/10 blur-[80px]"
          animate={{
            scale: [1, 1.5, 1],
            opacity: [0.3, 0.5, 0.3],
          }}
          transition={{ duration: 6, repeat: Infinity, ease: "easeInOut" }}
        />
      </div>

      {/* Content */}
      <motion.div 
        className="relative z-10 flex min-h-screen flex-col items-center justify-center px-4 pt-20"
        style={{ opacity }}
      >
        <div className="container mx-auto text-center">
          {/* Animated Badge */}
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5 }}
            className="mb-6"
          >
            <span className="inline-flex items-center gap-2 rounded-full border border-primary/30 bg-primary/10 px-4 py-1.5 text-sm font-medium text-primary backdrop-blur-sm">
              <motion.span 
                className="h-2 w-2 rounded-full bg-primary"
                animate={{ scale: [1, 1.3, 1], opacity: [1, 0.7, 1] }}
                transition={{ duration: 1.5, repeat: Infinity }}
              />
              Order Now on WhatsApp
            </span>
          </motion.div>

          {/* Main Animated Headline */}
          <motion.h1
            initial={{ opacity: 0, y: 40 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8, delay: 0.2 }}
            className="mb-6 font-display text-4xl font-bold leading-tight tracking-tight text-white sm:text-5xl md:text-6xl lg:text-7xl xl:text-8xl"
          >
            <motion.span
              className="inline-block"
              animate={{ 
                textShadow: [
                  "0 0 20px hsl(348 83% 40% / 0.3)",
                  "0 0 40px hsl(348 83% 40% / 0.5)",
                  "0 0 20px hsl(348 83% 40% / 0.3)",
                ]
              }}
              transition={{ duration: 2, repeat: Infinity }}
            >
              Gaming & Tech.
            </motion.span>
            <br />
            <span className="gradient-brand-text">Done Right.</span>
          </motion.h1>

          {/* Supporting Text */}
          <motion.p
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.4 }}
            className="mb-10 text-base text-gray-400 sm:text-lg md:text-xl"
          >
            Custom PCs • Gaming Gear • Laptops • Apple Products
          </motion.p>

          {/* CTA Buttons - Using Brand Colors */}
          <motion.div
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6, delay: 0.6 }}
            className="flex flex-col items-center gap-4 sm:flex-row sm:justify-center"
          >
            {/* Primary CTA - Brand Color */}
            <motion.button
              onClick={() => handleWhatsApp(WHATSAPP_MESSAGE)}
              className="group relative flex items-center gap-3 rounded-full gradient-brand px-8 py-4 text-lg font-semibold text-white shadow-lg"
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
            >
              {/* Glow effect using brand color */}
              <motion.div
                className="absolute inset-0 rounded-full gradient-brand"
                animate={{
                  boxShadow: [
                    "0 0 20px hsl(348 83% 40% / 0.4)",
                    "0 0 40px hsl(348 83% 40% / 0.6)",
                    "0 0 20px hsl(348 83% 40% / 0.4)",
                  ]
                }}
                transition={{ duration: 2, repeat: Infinity }}
              />
              <span className="relative z-10 flex items-center gap-3">
                <MessageCircle className="h-5 w-5" />
                Chat on WhatsApp
              </span>
            </motion.button>

            {/* Secondary CTA */}
            <motion.button
              onClick={() => handleWhatsApp("Hi! I'd like to view your product catalog.")}
              className="flex items-center gap-2 rounded-full border border-primary/30 bg-primary/5 px-8 py-4 text-lg font-medium text-white backdrop-blur-sm transition-all hover:bg-primary/10 hover:border-primary/50"
              whileHover={{ scale: 1.02 }}
              whileTap={{ scale: 0.98 }}
            >
              View Products
              <ArrowRight className="h-4 w-4" />
            </motion.button>
          </motion.div>
        </div>

        {/* Scroll Indicator */}
        <motion.div
          className="absolute bottom-8 left-1/2 -translate-x-1/2"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 1.5 }}
        >
          <motion.div
            className="flex flex-col items-center gap-2 text-white/50"
            animate={{ y: [0, 10, 0] }}
            transition={{ duration: 2, repeat: Infinity }}
          >
            <span className="text-xs uppercase tracking-widest">Scroll</span>
            <div className="h-8 w-[1px] bg-gradient-to-b from-primary/50 to-transparent" />
          </motion.div>
        </motion.div>
      </motion.div>
    </section>
  );
};

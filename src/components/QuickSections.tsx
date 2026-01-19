import { motion, useInView } from "framer-motion";
import { useRef } from "react";
import { Cpu, Gamepad2, Apple, ArrowRight, MessageCircle } from "lucide-react";
import customPcImage from "@/assets/custom-pc.jpg";
import gamingAccessoriesImage from "@/assets/gaming-accessories.jpg";
import appleProductsImage from "@/assets/apple-products.jpg";

const WHATSAPP_NUMBER = "9233442914563";

interface SectionProps {
  title: string;
  subtitle: string;
  description: string;
  image: string;
  icon: React.ComponentType<{ className?: string }>;
  ctaText: string;
  whatsappMessage: string;
  reversed?: boolean;
  bgColor?: string;
}

const Section = ({ 
  title, 
  subtitle, 
  description, 
  image, 
  icon: Icon, 
  ctaText, 
  whatsappMessage,
  reversed = false,
  bgColor = "bg-[#0d0d12]"
}: SectionProps) => {
  const ref = useRef<HTMLDivElement>(null);
  const isInView = useInView(ref, { once: true, margin: "-100px" });

  const handleWhatsApp = () => {
    window.open(`https://wa.me/${WHATSAPP_NUMBER}?text=${encodeURIComponent(whatsappMessage)}`, "_blank");
  };

  return (
    <div ref={ref} className={`${bgColor} py-16 md:py-24`}>
      <div className="container mx-auto px-4">
        <div className={`flex flex-col gap-8 lg:flex-row lg:items-center lg:gap-16 ${reversed ? 'lg:flex-row-reverse' : ''}`}>
          {/* Image */}
          <motion.div
            className="relative flex-1"
            initial={{ opacity: 0, x: reversed ? 50 : -50 }}
            animate={isInView ? { opacity: 1, x: 0 } : {}}
            transition={{ duration: 0.8, ease: "easeOut" }}
          >
            <div className="relative overflow-hidden rounded-2xl">
              {/* Brand color border glow */}
              <motion.div
                className="absolute -inset-1 rounded-2xl bg-gradient-to-r from-primary via-brand-rose to-brand-pink opacity-40 blur-sm"
                animate={{
                  opacity: [0.3, 0.5, 0.3],
                }}
                transition={{ duration: 3, repeat: Infinity }}
              />
              <div className="relative overflow-hidden rounded-2xl">
                <motion.img
                  src={image}
                  alt={title}
                  className="h-full w-full object-cover"
                  whileHover={{ scale: 1.05 }}
                  transition={{ duration: 0.4 }}
                />
                <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent" />
              </div>
            </div>
          </motion.div>

          {/* Content */}
          <motion.div
            className="flex-1 text-center lg:text-left"
            initial={{ opacity: 0, x: reversed ? -50 : 50 }}
            animate={isInView ? { opacity: 1, x: 0 } : {}}
            transition={{ duration: 0.8, delay: 0.2, ease: "easeOut" }}
          >
            <motion.div
              className="mb-4 inline-flex items-center gap-2 rounded-full border border-primary/30 bg-primary/10 px-4 py-2"
              whileHover={{ scale: 1.05, borderColor: "hsl(348 83% 40% / 0.5)" }}
            >
              <Icon className="h-5 w-5 text-primary" />
              <span className="text-sm font-medium text-primary">{subtitle}</span>
            </motion.div>

            <h2 className="mb-4 font-display text-3xl font-bold text-white md:text-4xl lg:text-5xl">
              {title}
            </h2>

            <p className="mb-8 text-lg text-gray-400">
              {description}
            </p>

            <motion.button
              onClick={handleWhatsApp}
              className="group inline-flex items-center gap-3 rounded-full gradient-brand px-6 py-3 font-semibold text-white shadow-lg"
              whileHover={{ scale: 1.05, boxShadow: "0 0 30px hsl(348 83% 40% / 0.5)" }}
              whileTap={{ scale: 0.95 }}
            >
              <MessageCircle className="h-5 w-5" />
              {ctaText}
              <ArrowRight className="h-4 w-4 transition-transform group-hover:translate-x-1" />
            </motion.button>
          </motion.div>
        </div>
      </div>
    </div>
  );
};

export const QuickSections = () => {
  const sections: SectionProps[] = [
    {
      title: "Custom PC Builds",
      subtitle: "Performance Machines",
      description: "Built for performance. Designed for gamers. Get a custom-built gaming PC tailored to your exact specifications and budget.",
      image: customPcImage,
      icon: Cpu,
      ctaText: "Build Your PC on WhatsApp",
      whatsappMessage: "Hi! I'm interested in getting a custom PC build. Can you help me with the specifications?",
      bgColor: "bg-[#0d0d12]",
    },
    {
      title: "Gaming Accessories",
      subtitle: "Premium Peripherals",
      description: "Mechanical keyboards, precision mice, immersive headsets, and more. Everything you need to dominate the game.",
      image: gamingAccessoriesImage,
      icon: Gamepad2,
      ctaText: "Ask for Prices on WhatsApp",
      whatsappMessage: "Hi! I'd like to know the prices for your gaming accessories.",
      reversed: true,
      bgColor: "bg-[#08080c]",
    },
    {
      title: "Apple Products",
      subtitle: "Authorized Reseller",
      description: "MacBooks, iPads, iPhones, and accessories. Genuine Apple products with competitive pricing and local support.",
      image: appleProductsImage,
      icon: Apple,
      ctaText: "Check Availability on WhatsApp",
      whatsappMessage: "Hi! I'd like to check the availability and price of Apple products.",
      bgColor: "bg-[#0d0d12]",
    },
  ];

  return (
    <div>
      {sections.map((section, index) => (
        <Section key={index} {...section} />
      ))}
    </div>
  );
};

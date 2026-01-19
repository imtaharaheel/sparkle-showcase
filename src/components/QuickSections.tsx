import { motion, useInView } from "framer-motion";
import { useRef } from "react";
import { Cpu, Gamepad2, Apple, ArrowRight } from "lucide-react";
import customPcImage from "@/assets/custom-pc.jpg";
import gamingAccessoriesImage from "@/assets/gaming-accessories.jpg";
import appleProductsImage from "@/assets/apple-products.jpg";

const WHATSAPP_NUMBER = "9233442914563";

const WhatsAppIcon = ({ className = "h-5 w-5" }: { className?: string }) => (
  <svg viewBox="0 0 24 24" className={className} fill="currentColor">
    <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/>
  </svg>
);

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
              {/* RGB border glow */}
              <motion.div
                className="absolute -inset-1 rounded-2xl bg-gradient-to-r from-primary via-[#6366f1] to-[#00ff88] opacity-50 blur-sm"
                animate={{
                  backgroundPosition: ["0% 50%", "100% 50%", "0% 50%"],
                }}
                transition={{ duration: 5, repeat: Infinity }}
                style={{ backgroundSize: "200% 200%" }}
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
              whileHover={{ scale: 1.05 }}
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
              className="group inline-flex items-center gap-3 rounded-full bg-[#25D366] px-6 py-3 font-semibold text-white shadow-lg"
              whileHover={{ scale: 1.05, boxShadow: "0 0 30px rgba(37, 211, 102, 0.5)" }}
              whileTap={{ scale: 0.95 }}
            >
              <WhatsAppIcon />
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

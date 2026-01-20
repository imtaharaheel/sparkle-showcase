import { motion, useInView } from "framer-motion";
import { useRef } from "react";
import { Shield, Award, Zap, HeadphonesIcon } from "lucide-react";

const trustItems = [
  {
    icon: Shield,
    title: "Genuine Products",
    description: "100% authentic & original products",
  },
  {
    icon: Award,
    title: "Expert Builds",
    description: "Professional assembly & testing",
  },
  {
    icon: Zap,
    title: "Competitive Pricing",
    description: "Best prices in the market",
  },
  {
    icon: HeadphonesIcon,
    title: "Fast Support",
    description: "Quick response via WhatsApp",
  },
];

export const TrustSection = () => {
  const ref = useRef<HTMLDivElement>(null);
  const isInView = useInView(ref, { once: true, margin: "-100px" });

  return (
    <section ref={ref} className="bg-[#08080c] py-16 md:py-24">
      <div className="container mx-auto px-4">
        <motion.div
          className="mb-12 text-center"
          initial={{ opacity: 0, y: 30 }}
          animate={isInView ? { opacity: 1, y: 0 } : {}}
          transition={{ duration: 0.6 }}
        >
          <h2 className="mb-4 font-display text-3xl font-bold text-white md:text-4xl">
            Why Choose <span className="gradient-brand-text">SAIM Enterprise</span>?
          </h2>
          <p className="mx-auto max-w-2xl text-gray-400">
            Trusted by gamers and tech enthusiasts across Pakistan
          </p>
        </motion.div>

        <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
          {trustItems.map((item, index) => (
            <motion.div
              key={item.title}
              className="group relative overflow-hidden rounded-2xl border border-white/10 bg-white/5 p-6 backdrop-blur-sm"
              initial={{ opacity: 0, y: 30 }}
              animate={isInView ? { opacity: 1, y: 0 } : {}}
              transition={{ duration: 0.5, delay: index * 0.1 }}
              whileHover={{ 
                scale: 1.02,
                borderColor: "hsl(348 83% 40% / 0.5)",
              }}
            >
              {/* Hover glow effect */}
              <motion.div
                className="absolute inset-0 bg-gradient-to-br from-primary/10 to-transparent opacity-0 transition-opacity group-hover:opacity-100"
              />
              
              <div className="relative z-10">
                <motion.div
                  className="mb-4 inline-flex h-14 w-14 items-center justify-center rounded-xl bg-primary/10"
                  whileHover={{ rotate: 5, scale: 1.1 }}
                >
                  <item.icon className="h-7 w-7 text-primary" />
                </motion.div>

                <h3 className="mb-2 font-display text-xl font-semibold text-white">
                  {item.title}
                </h3>
                <p className="text-sm text-gray-400">
                  {item.description}
                </p>
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
};

import { motion, useScroll, useTransform } from "framer-motion";
import { MessageCircle } from "lucide-react";

const WHATSAPP_NUMBER = "9233442914563";
const WHATSAPP_MESSAGE = "Hi! I'm interested in your products.";

export const StickyWhatsAppCTA = () => {
  const { scrollYProgress } = useScroll();
  const opacity = useTransform(scrollYProgress, [0, 0.1], [0, 1]);

  const handleWhatsApp = () => {
    window.open(`https://wa.me/${WHATSAPP_NUMBER}?text=${encodeURIComponent(WHATSAPP_MESSAGE)}`, "_blank");
  };

  return (
    <motion.div
      className="fixed bottom-0 left-0 right-0 z-50 p-4 md:hidden"
      style={{ opacity }}
    >
      <motion.button
        onClick={handleWhatsApp}
        className="flex w-full items-center justify-center gap-3 rounded-full gradient-brand py-4 font-semibold text-white shadow-2xl"
        whileTap={{ scale: 0.98 }}
      >
        <MessageCircle className="h-5 w-5" />
        Chat on WhatsApp
      </motion.button>
    </motion.div>
  );
};

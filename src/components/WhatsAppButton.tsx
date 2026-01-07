import { motion } from "framer-motion";
import { MessageCircle } from "lucide-react";

const WHATSAPP_NUMBER = "9233442914563";
const WHATSAPP_MESSAGE = "Hi! I'm interested in your products.";

export const WhatsAppButton = () => {
  const handleClick = () => {
    const url = `https://wa.me/${WHATSAPP_NUMBER}?text=${encodeURIComponent(WHATSAPP_MESSAGE)}`;
    window.open(url, "_blank");
  };

  return (
    <motion.button
      onClick={handleClick}
      className="fixed bottom-6 right-6 z-50 flex h-14 w-14 items-center justify-center rounded-full bg-[#25D366] text-white shadow-lg transition-all hover:scale-110 hover:shadow-xl md:h-16 md:w-16"
      initial={{ scale: 0, opacity: 0 }}
      animate={{ scale: 1, opacity: 1 }}
      transition={{ delay: 1, type: "spring", stiffness: 200 }}
      whileHover={{ scale: 1.1 }}
      whileTap={{ scale: 0.95 }}
      aria-label="Chat on WhatsApp"
    >
      <MessageCircle className="h-7 w-7 md:h-8 md:w-8" fill="currentColor" />
      <motion.span
        className="absolute -top-1 -right-1 flex h-4 w-4 items-center justify-center rounded-full bg-red-500 text-[10px] font-bold"
        initial={{ scale: 0 }}
        animate={{ scale: 1 }}
        transition={{ delay: 1.5 }}
      >
        1
      </motion.span>
    </motion.button>
  );
};

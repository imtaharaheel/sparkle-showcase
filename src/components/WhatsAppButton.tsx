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
      className="fixed bottom-6 right-6 z-50 flex h-14 w-14 items-center justify-center rounded-full gradient-brand text-white shadow-lg md:h-16 md:w-16"
      initial={{ scale: 0, opacity: 0, rotate: -180 }}
      animate={{ 
        scale: 1, 
        opacity: 1, 
        rotate: 0,
      }}
      transition={{ 
        delay: 0.5, 
        type: "spring", 
        stiffness: 260,
        damping: 20 
      }}
      whileHover={{ 
        scale: 1.15,
        boxShadow: "0 0 30px hsl(348 83% 40% / 0.6)",
      }}
      whileTap={{ scale: 0.9 }}
      aria-label="Chat on WhatsApp"
    >
      <MessageCircle className="h-7 w-7 md:h-8 md:w-8" />
      
      {/* Animated ping effect - Brand Color */}
      <motion.span
        className="absolute inset-0 rounded-full gradient-brand"
        initial={{ scale: 1, opacity: 0.5 }}
        animate={{ 
          scale: [1, 1.5, 1.8],
          opacity: [0.5, 0.3, 0]
        }}
        transition={{
          duration: 2,
          repeat: Infinity,
          ease: "easeOut"
        }}
      />
      
      {/* Notification badge with pulse */}
      <motion.span
        className="absolute -top-1 -right-1 flex h-5 w-5 items-center justify-center rounded-full bg-white text-[10px] font-bold text-primary"
        initial={{ scale: 0 }}
        animate={{ scale: 1 }}
        transition={{ delay: 1.2, type: "spring", stiffness: 300 }}
      >
        <motion.span
          animate={{ scale: [1, 1.2, 1] }}
          transition={{ duration: 1.5, repeat: Infinity }}
        >
          1
        </motion.span>
      </motion.span>
      
      {/* Floating tooltip */}
      <motion.div
        className="absolute right-full mr-3 whitespace-nowrap rounded-lg bg-white px-3 py-2 text-sm font-medium text-gray-900 shadow-lg"
        initial={{ opacity: 0, x: 10 }}
        animate={{ opacity: [0, 1, 1, 0], x: [10, 0, 0, -10] }}
        transition={{ 
          duration: 4, 
          delay: 2,
          repeat: Infinity,
          repeatDelay: 5,
          times: [0, 0.1, 0.9, 1]
        }}
      >
        Chat with us!
        <span className="absolute right-0 top-1/2 -translate-y-1/2 translate-x-1 border-4 border-transparent border-l-white" />
      </motion.div>
    </motion.button>
  );
};

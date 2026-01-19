import { motion } from "framer-motion";
import { MessageCircle } from "lucide-react";
import { Logo } from "./Logo";

const WHATSAPP_NUMBER = "9233442914563";
const WHATSAPP_MESSAGE = "Hi! I'm interested in your products.";

export const MinimalFooter = () => {
  const handleWhatsApp = () => {
    window.open(`https://wa.me/${WHATSAPP_NUMBER}?text=${encodeURIComponent(WHATSAPP_MESSAGE)}`, "_blank");
  };

  return (
    <footer className="bg-[#050507] py-12 border-t border-primary/10">
      <div className="container mx-auto px-4">
        <div className="flex flex-col items-center gap-8">
          {/* Logo */}
          <Logo size="lg" />

          {/* WhatsApp CTA - Brand Colors */}
          <motion.button
            onClick={handleWhatsApp}
            className="group flex items-center gap-3 rounded-full gradient-brand px-8 py-4 font-semibold text-white shadow-lg"
            whileHover={{ scale: 1.05, boxShadow: "0 0 30px hsl(348 83% 40% / 0.5)" }}
            whileTap={{ scale: 0.95 }}
          >
            <MessageCircle className="h-5 w-5" />
            Start a Conversation
          </motion.button>

          {/* Social/Contact */}
          <div className="flex items-center gap-6">
            <motion.a
              href={`https://wa.me/${WHATSAPP_NUMBER}`}
              target="_blank"
              rel="noopener noreferrer"
              className="flex h-12 w-12 items-center justify-center rounded-full bg-primary/10 text-primary border border-primary/20 transition-colors hover:bg-primary/20"
              whileHover={{ scale: 1.1 }}
              whileTap={{ scale: 0.95 }}
            >
              <MessageCircle className="h-6 w-6" />
            </motion.a>
          </div>

          {/* Copyright */}
          <div className="text-center text-sm text-gray-500">
            <p>© {new Date().getFullYear()} Saim Enterprise. All rights reserved.</p>
            <p className="mt-1 text-gray-600">Premium Gaming & Tech Store</p>
          </div>
        </div>
      </div>
    </footer>
  );
};

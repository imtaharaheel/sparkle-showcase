import { useState } from "react";
import { Link, useLocation } from "react-router-dom";
import { motion, AnimatePresence } from "framer-motion";
import { Menu, X } from "lucide-react";
import { Logo } from "./Logo";

const navLinks = [
  { href: "/", label: "Home" },
  { href: "/products", label: "Products" },
  { href: "/corporate-orders", label: "Corporate Orders" },
  { href: "/about", label: "About Us" },
];

interface NavbarProps {
  variant?: "light" | "dark";
}

export const Navbar = ({ variant = "light" }: NavbarProps) => {
  const [isOpen, setIsOpen] = useState(false);
  const location = useLocation();

  const isDark = variant === "dark";

  return (
    <nav className={`fixed top-0 left-0 right-0 z-40 border-b ${
      isDark 
        ? "border-white/10 bg-black/80 backdrop-blur-xl" 
        : "glass-light border-border/50"
    }`}>
      <div className="container mx-auto px-4">
        <div className="flex h-16 items-center justify-between md:h-20">
          {/* Logo */}
          <Link to="/">
            <Logo size="md" />
          </Link>

          {/* Desktop Navigation */}
          <div className="hidden items-center gap-1 md:flex">
            {navLinks.map((link) => {
              const isActive = location.pathname === link.href || 
                (link.href.includes('?') && location.pathname + location.search === link.href);
              
              return (
                <Link
                  key={link.href}
                  to={link.href}
                  className={`group relative px-4 py-2 text-sm font-medium transition-colors ${
                    isActive 
                      ? "text-primary" 
                      : isDark 
                        ? "text-gray-400 hover:text-white" 
                        : "text-muted-foreground hover:text-foreground"
                  }`}
                >
                  {link.label}
                  <motion.span
                    className="absolute bottom-0 left-0 h-0.5 w-full origin-left bg-primary"
                    initial={{ scaleX: 0 }}
                    animate={{ scaleX: isActive ? 1 : 0 }}
                    whileHover={{ scaleX: 1 }}
                    transition={{ duration: 0.2 }}
                  />
                </Link>
              );
            })}
          </div>

          {/* Mobile Menu Button */}
          <button
            onClick={() => setIsOpen(!isOpen)}
            className={`flex h-10 w-10 items-center justify-center rounded-lg border md:hidden ${
              isDark 
                ? "border-white/20 bg-white/5 text-white" 
                : "border-border bg-card"
            }`}
            aria-label="Toggle menu"
          >
            {isOpen ? <X className="h-5 w-5" /> : <Menu className="h-5 w-5" />}
          </button>
        </div>
      </div>

      {/* Mobile Menu */}
      <AnimatePresence>
        {isOpen && (
          <motion.div
            className={`absolute top-full left-0 right-0 border-b md:hidden ${
              isDark 
                ? "border-white/10 bg-black/95 backdrop-blur-xl" 
                : "glass-light border-border"
            }`}
            initial={{ opacity: 0, height: 0 }}
            animate={{ opacity: 1, height: "auto" }}
            exit={{ opacity: 0, height: 0 }}
            transition={{ duration: 0.2 }}
          >
            <div className="container mx-auto px-4 py-4">
              <div className="flex flex-col gap-2">
                {navLinks.map((link, index) => (
                  <motion.div
                    key={link.href}
                    initial={{ opacity: 0, x: -20 }}
                    animate={{ opacity: 1, x: 0 }}
                    transition={{ delay: index * 0.05 }}
                  >
                    <Link
                      to={link.href}
                      onClick={() => setIsOpen(false)}
                      className={`flex items-center gap-3 rounded-lg px-4 py-3 text-sm font-medium transition-colors ${
                        isDark 
                          ? "text-gray-400 hover:bg-white/5 hover:text-white" 
                          : "text-muted-foreground hover:bg-secondary hover:text-foreground"
                      }`}
                    >
                      {link.label}
                    </Link>
                  </motion.div>
                ))}
              </div>
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </nav>
  );
};

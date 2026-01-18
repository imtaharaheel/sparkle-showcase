import { motion } from "framer-motion";
import logoImage from "@/assets/logo.png";

interface LogoProps {
  size?: "sm" | "md" | "lg";
  showText?: boolean;
}

export const Logo = ({ size = "md", showText = true }: LogoProps) => {
  const sizes = {
    sm: { icon: "h-10 w-10", text: "text-lg", subtext: "text-[8px]" },
    md: { icon: "h-12 w-12", text: "text-xl", subtext: "text-[10px]" },
    lg: { icon: "h-16 w-16", text: "text-2xl", subtext: "text-xs" },
  };

  return (
    <div className="flex items-center gap-3">
      <motion.div
        className={`relative ${sizes[size].icon} flex items-center justify-center overflow-hidden rounded-lg`}
        whileHover={{ scale: 1.05 }}
        whileTap={{ scale: 0.95 }}
      >
        <img 
          src={logoImage} 
          alt="SAIM Enterprise Logo" 
          className="h-full w-full object-contain"
        />
      </motion.div>
      
      {showText && (
        <div className="flex flex-col leading-none">
          <span className={`font-display ${sizes[size].text} font-bold tracking-tight`}>
            <span className="gradient-brand-text">SAIM</span>
          </span>
          <span className={`${sizes[size].subtext} font-semibold uppercase tracking-[0.2em] text-muted-foreground`}>
            Enterprise
          </span>
        </div>
      )}
    </div>
  );
};

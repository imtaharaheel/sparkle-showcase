import { motion } from "framer-motion";
import logoMark from "@/assets/logo.png";
import logoDark from "@/assets/logo-dark.png";
import logoLight from "@/assets/logo-light.png";

interface LogoProps {
  size?: "sm" | "md" | "lg";
  showText?: boolean;
  /** Background the logo sits on: "dark" uses the white wordmark, "light" the black one. */
  variant?: "dark" | "light";
}

export const Logo = ({ size = "md", showText = true, variant = "dark" }: LogoProps) => {
  const sizes = {
    sm: { icon: "h-10 w-10", full: "h-9" },
    md: { icon: "h-12 w-12", full: "h-10 md:h-12" },
    lg: { icon: "h-16 w-16", full: "h-16 md:h-20" },
  };

  return (
    <motion.div className="flex items-center" whileHover={{ scale: 1.05 }} whileTap={{ scale: 0.95 }}>
      {showText ? (
        <img
          src={variant === "light" ? logoLight : logoDark}
          alt="SAIM Enterprises"
          className={`${sizes[size].full} w-auto object-contain`}
        />
      ) : (
        <img src={logoMark} alt="SAIM Enterprises" className={`${sizes[size].icon} object-contain`} />
      )}
    </motion.div>
  );
};

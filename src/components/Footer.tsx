import { Link } from "react-router-dom";
import { MessageCircle, Phone } from "lucide-react";
import { Logo } from "./Logo";

export const Footer = () => {
  return (
    <footer className="border-t border-border bg-secondary/30">
      <div className="container mx-auto px-4 py-12">
        <div className="grid gap-8 md:grid-cols-2 lg:grid-cols-4">
          {/* Brand */}
          <div className="space-y-4">
            <Logo size="md" />
            <p className="text-sm text-muted-foreground">
              Premium gaming peripherals for the ultimate gaming experience. Quality products at competitive prices.
            </p>
          </div>

          {/* Quick Links */}
          <div>
            <h4 className="mb-4 font-display text-sm font-semibold uppercase tracking-wider text-foreground">
              Products
            </h4>
            <ul className="space-y-2 text-sm text-muted-foreground">
              <li>
                <Link to="/products?category=keyboard" className="transition-colors hover:text-primary">
                  Mechanical Keyboards
                </Link>
              </li>
              <li>
                <Link to="/products?category=mouse" className="transition-colors hover:text-primary">
                  Gaming Mice
                </Link>
              </li>
              <li>
                <Link to="/products?category=headset" className="transition-colors hover:text-primary">
                  Gaming Headsets
                </Link>
              </li>
              <li>
                <Link to="/products?category=combo" className="transition-colors hover:text-primary">
                  Gaming Combos
                </Link>
              </li>
            </ul>
          </div>

          {/* More Products */}
          <div>
            <h4 className="mb-4 font-display text-sm font-semibold uppercase tracking-wider text-foreground">
              Accessories
            </h4>
            <ul className="space-y-2 text-sm text-muted-foreground">
              <li>
                <Link to="/products?category=speaker" className="transition-colors hover:text-primary">
                  Speakers
                </Link>
              </li>
              <li>
                <Link to="/products?category=microphone" className="transition-colors hover:text-primary">
                  Microphones
                </Link>
              </li>
              <li>
                <Link to="/products" className="transition-colors hover:text-primary">
                  All Products
                </Link>
              </li>
            </ul>
          </div>

          {/* Contact */}
          <div>
            <h4 className="mb-4 font-display text-sm font-semibold uppercase tracking-wider text-foreground">
              Contact Us
            </h4>
            <ul className="space-y-3 text-sm text-muted-foreground">
              <li className="flex items-center gap-2">
                <MessageCircle className="h-4 w-4 text-[#25D366]" />
                <a 
                  href="https://wa.me/923342914563" 
                  target="_blank" 
                  rel="noopener noreferrer"
                  className="transition-colors hover:text-primary"
                >
                  +92 334 2914563
                </a>
              </li>
              <li className="flex items-center gap-2">
                <Phone className="h-4 w-4 text-primary" />
                <span>+92 334 2914563</span>
              </li>
            </ul>
          </div>
        </div>

        <div className="mt-12 border-t border-border pt-8 text-center text-sm text-muted-foreground">
          <p>© {new Date().getFullYear()} Saim Enterprise. All rights reserved. </p>
        </div>
      </div>
    </footer>
  );
};

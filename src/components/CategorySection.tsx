import { Link } from "react-router-dom";
import { motion } from "framer-motion";
import { Keyboard, Mouse, Headphones, Package, Speaker, Mic } from "lucide-react";

const categories = [
  { 
    id: "keyboard", 
    name: "Keyboards", 
    icon: Keyboard, 
    description: "Mechanical & Gaming",
    count: 12,
    gradient: "from-cyan-500/20 to-blue-500/20"
  },
  { 
    id: "mouse", 
    name: "Gaming Mice", 
    icon: Mouse, 
    description: "Precision & Speed",
    count: 15,
    gradient: "from-purple-500/20 to-pink-500/20"
  },
  { 
    id: "headset", 
    name: "Headsets", 
    icon: Headphones, 
    description: "Immersive Audio",
    count: 8,
    gradient: "from-green-500/20 to-teal-500/20"
  },
  { 
    id: "combo", 
    name: "Gaming Combos", 
    icon: Package, 
    description: "Complete Setups",
    count: 6,
    gradient: "from-orange-500/20 to-red-500/20"
  },
  { 
    id: "speaker", 
    name: "Speakers", 
    icon: Speaker, 
    description: "Desktop Audio",
    count: 3,
    gradient: "from-yellow-500/20 to-orange-500/20"
  },
  { 
    id: "microphone", 
    name: "Microphones", 
    icon: Mic, 
    description: "Streaming & Gaming",
    count: 2,
    gradient: "from-indigo-500/20 to-purple-500/20"
  },
];

export const CategorySection = () => {
  return (
    <section className="py-20 md:py-32">
      <div className="container mx-auto px-4">
        {/* Header */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.6 }}
          className="mb-12 text-center md:mb-16"
        >
          <span className="mb-3 inline-block text-sm font-medium uppercase tracking-wider text-primary">
            Browse By Category
          </span>
          <h2 className="mb-4 font-display text-3xl font-bold md:text-4xl lg:text-5xl">
            Find Your Perfect <span className="gradient-cyber-text">Gear</span>
          </h2>
          <p className="mx-auto max-w-2xl text-muted-foreground">
            Explore our wide range of gaming peripherals organized by category
          </p>
        </motion.div>

        {/* Category Grid */}
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {categories.map((category, index) => (
            <motion.div
              key={category.id}
              initial={{ opacity: 0, y: 30 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true, margin: "-50px" }}
              transition={{ duration: 0.5, delay: index * 0.1 }}
            >
              <Link to={`/products?category=${category.id}`}>
                <motion.div
                  className={`group relative overflow-hidden rounded-xl border border-border bg-gradient-to-br ${category.gradient} p-6 transition-all duration-300 hover:border-primary/50 hover:shadow-lg hover:shadow-primary/10`}
                  whileHover={{ y: -5, scale: 1.02 }}
                  whileTap={{ scale: 0.98 }}
                >
                  <div className="flex items-start justify-between">
                    <div>
                      <motion.div
                        className="mb-4 inline-flex h-12 w-12 items-center justify-center rounded-lg bg-primary/10 text-primary"
                        whileHover={{ rotate: 5, scale: 1.1 }}
                      >
                        <category.icon className="h-6 w-6" />
                      </motion.div>
                      <h3 className="mb-1 font-display text-xl font-semibold text-foreground">
                        {category.name}
                      </h3>
                      <p className="text-sm text-muted-foreground">
                        {category.description}
                      </p>
                    </div>
                    <span className="text-sm font-medium text-primary">
                      {category.count}+
                    </span>
                  </div>

                  {/* Hover Arrow */}
                  <motion.div
                    className="absolute bottom-4 right-4 opacity-0 transition-opacity group-hover:opacity-100"
                    initial={{ x: -10 }}
                    whileHover={{ x: 0 }}
                  >
                    <span className="text-primary">→</span>
                  </motion.div>

                  {/* Bottom Glow */}
                  <div className="absolute inset-x-0 bottom-0 h-px bg-gradient-to-r from-transparent via-primary/50 to-transparent opacity-0 transition-opacity group-hover:opacity-100" />
                </motion.div>
              </Link>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
};

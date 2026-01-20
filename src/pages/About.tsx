import { useRef } from "react";
import { motion, useInView } from "framer-motion";
import { Users, Award, Package, ShieldCheck, MapPin, Phone, Clock, Mail } from "lucide-react";
import { Navbar } from "@/components/Navbar";
import { MinimalFooter } from "@/components/MinimalFooter";
import { WhatsAppButton } from "@/components/WhatsAppButton";
import { StickyWhatsAppCTA } from "@/components/StickyWhatsAppCTA";
import { Logo } from "@/components/Logo";

const stats = [
  { icon: Clock, value: "10+", label: "Years Experience" },
  { icon: Users, value: "50K+", label: "Happy Customers" },
  { icon: Package, value: "5000+", label: "Products Delivered" },
  { icon: ShieldCheck, value: "100%", label: "Genuine Products" },
];

const team = [
  { 
    name: "Saim Saudagar", 
    role: "Founder & CEO", 
    description: "Passionate gamer and tech enthusiast leading the vision" 
  },
  { 
    name: "Tech Support Team", 
    role: "Customer Success", 
    description: "Dedicated experts ensuring your satisfaction" 
  },
  { 
    name: "Logistics Team", 
    role: "Delivery & Fulfillment", 
    description: "Swift and secure delivery across Pakistan" 
  },
];

const About = () => {
  const heroRef = useRef<HTMLDivElement>(null);
  const statsRef = useRef<HTMLDivElement>(null);
  const storyRef = useRef<HTMLDivElement>(null);
  const teamRef = useRef<HTMLDivElement>(null);
  const locationRef = useRef<HTMLDivElement>(null);
  
  const isHeroInView = useInView(heroRef, { once: true });
  const isStatsInView = useInView(statsRef, { once: true, margin: "-100px" });
  const isStoryInView = useInView(storyRef, { once: true, margin: "-100px" });
  const isTeamInView = useInView(teamRef, { once: true, margin: "-100px" });
  const isLocationInView = useInView(locationRef, { once: true, margin: "-100px" });

  return (
    <div className="min-h-screen bg-[#0a0a0f]">
      <Navbar variant="dark" />
      
      <main className="pt-20 md:pt-24">
        {/* Hero Section */}
        <section ref={heroRef} className="relative overflow-hidden py-20 md:py-32">
          {/* Animated background */}
          <div className="absolute inset-0 bg-gradient-to-b from-primary/10 via-[#0a0a0f] to-[#0a0a0f]" />
          <motion.div 
            className="absolute top-20 left-1/4 w-96 h-96 bg-primary/20 rounded-full blur-3xl"
            animate={{ 
              scale: [1, 1.3, 1],
              opacity: [0.2, 0.4, 0.2],
            }}
            transition={{ duration: 10, repeat: Infinity }}
          />
          <motion.div 
            className="absolute bottom-0 right-1/3 w-80 h-80 bg-[#00ff88]/10 rounded-full blur-3xl"
            animate={{ 
              scale: [1.2, 1, 1.2],
              opacity: [0.1, 0.3, 0.1],
            }}
            transition={{ duration: 12, repeat: Infinity }}
          />
          
          <div className="container relative mx-auto px-4">
            <motion.div
              initial={{ opacity: 0, y: 30 }}
              animate={isHeroInView ? { opacity: 1, y: 0 } : {}}
              transition={{ duration: 0.6 }}
              className="mx-auto max-w-3xl text-center"
            >
              <motion.div
                className="mb-4 inline-flex items-center gap-2 rounded-full border border-primary/30 bg-primary/10 px-4 py-2"
                initial={{ opacity: 0, scale: 0.9 }}
                animate={isHeroInView ? { opacity: 1, scale: 1 } : {}}
                transition={{ delay: 0.2 }}
              >
                <Award className="h-4 w-4 text-primary" />
                <span className="text-sm font-medium text-primary">About Us</span>
              </motion.div>
              
              <h1 className="mb-6 font-display text-4xl font-bold text-white md:text-5xl lg:text-6xl">
                Your Trusted Partner for{" "}
                <span className="gradient-brand-text">Premium Gaming Gear</span>
              </h1>
              <p className="text-lg text-gray-400">
                At SAIM Enterprise, we're passionate about bringing you the best gaming and tech products. 
                With years of experience and a commitment to quality, we've become Pakistan's go-to destination 
                for premium gaming gear.
              </p>
            </motion.div>
          </div>
        </section>

        {/* Stats Section */}
        <section ref={statsRef} className="py-16 md:py-24 bg-[#08080c]">
          <div className="container mx-auto px-4">
            <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
              {stats.map((stat, index) => (
                <motion.div
                  key={stat.label}
                  className="group relative overflow-hidden rounded-2xl border border-white/10 bg-white/5 p-8 text-center backdrop-blur-sm"
                  initial={{ opacity: 0, y: 30 }}
                  animate={isStatsInView ? { opacity: 1, y: 0 } : {}}
                  transition={{ duration: 0.5, delay: index * 0.1 }}
                  whileHover={{ 
                    scale: 1.02,
                    borderColor: "hsl(348 83% 40% / 0.5)",
                  }}
                >
                  <motion.div
                    className="absolute inset-0 bg-gradient-to-br from-primary/10 to-transparent opacity-0 transition-opacity group-hover:opacity-100"
                  />
                  
                  <div className="relative z-10">
                    <motion.div
                      className="mx-auto mb-4 flex h-16 w-16 items-center justify-center rounded-2xl bg-primary/10"
                      whileHover={{ rotate: 5, scale: 1.1 }}
                    >
                      <stat.icon className="h-8 w-8 text-primary" />
                    </motion.div>
                    
                    <motion.span 
                      className="block font-display text-4xl font-bold text-white"
                      initial={{ scale: 0.5 }}
                      animate={isStatsInView ? { scale: 1 } : {}}
                      transition={{ delay: 0.3 + index * 0.1, type: "spring" }}
                    >
                      {stat.value}
                    </motion.span>
                    <span className="text-sm text-gray-400">{stat.label}</span>
                  </div>
                </motion.div>
              ))}
            </div>
          </div>
        </section>

        {/* Our Story Section */}
        <section ref={storyRef} className="py-16 md:py-24 bg-[#0a0a0f]">
          <div className="container mx-auto px-4">
            <div className="mx-auto max-w-4xl">
              <motion.div
                className="text-center mb-12"
                initial={{ opacity: 0, y: 30 }}
                animate={isStoryInView ? { opacity: 1, y: 0 } : {}}
                transition={{ duration: 0.6 }}
              >
                <h2 className="mb-4 font-display text-3xl font-bold text-white md:text-4xl">
                  Our <span className="gradient-brand-text">Story</span>
                </h2>
              </motion.div>

              <motion.div
                className="relative overflow-hidden rounded-2xl border border-white/10 bg-white/5 p-8 md:p-12 backdrop-blur-sm"
                initial={{ opacity: 0, y: 30 }}
                animate={isStoryInView ? { opacity: 1, y: 0 } : {}}
                transition={{ duration: 0.6, delay: 0.2 }}
              >
                <div className="absolute inset-0 bg-gradient-to-br from-primary/5 to-transparent" />
                
                <div className="relative z-10 flex flex-col md:flex-row gap-8 items-center">
                  <motion.div
                    className="flex-shrink-0"
                    whileHover={{ scale: 1.05, rotate: 2 }}
                  >
                    <Logo size="lg" />
                  </motion.div>
                  
                  <div className="space-y-4 text-gray-300">
                    <p>
                      Founded with a simple mission: to provide gamers and tech enthusiasts in Pakistan with 
                      access to the best products at competitive prices. What started as a small venture has 
                      grown into a trusted name in the gaming community.
                    </p>
                    <p>
                      We believe every gamer deserves quality gear. That's why we carefully curate our collection, 
                      ensuring each product meets our high standards. From custom PC builds to the latest gaming 
                      peripherals, we've got you covered.
                    </p>
                    <p>
                      Our commitment goes beyond just selling products – we're here to support your gaming journey 
                      with expert advice, reliable after-sales service, and a community that shares your passion.
                    </p>
                  </div>
                </div>
              </motion.div>
            </div>
          </div>
        </section>

        {/* Team Section */}
        <section ref={teamRef} className="py-16 md:py-24 bg-[#08080c]">
          <div className="container mx-auto px-4">
            <motion.div
              className="text-center mb-12"
              initial={{ opacity: 0, y: 30 }}
              animate={isTeamInView ? { opacity: 1, y: 0 } : {}}
              transition={{ duration: 0.6 }}
            >
              <h2 className="mb-4 font-display text-3xl font-bold text-white md:text-4xl">
                Meet the <span className="gradient-brand-text">Team</span>
              </h2>
              <p className="mx-auto max-w-2xl text-gray-400">
                Dedicated professionals committed to your satisfaction
              </p>
            </motion.div>

            <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3 max-w-4xl mx-auto">
              {team.map((member, index) => (
                <motion.div
                  key={member.name}
                  className="group relative overflow-hidden rounded-2xl border border-white/10 bg-white/5 p-6 text-center backdrop-blur-sm"
                  initial={{ opacity: 0, y: 30 }}
                  animate={isTeamInView ? { opacity: 1, y: 0 } : {}}
                  transition={{ duration: 0.5, delay: index * 0.1 }}
                  whileHover={{ 
                    scale: 1.02,
                    borderColor: "hsl(348 83% 40% / 0.5)",
                  }}
                >
                  <motion.div
                    className="absolute inset-0 bg-gradient-to-br from-primary/10 to-transparent opacity-0 transition-opacity group-hover:opacity-100"
                  />
                  
                  <div className="relative z-10">
                    <motion.div 
                      className="mx-auto mb-4 h-20 w-20 rounded-full bg-gradient-to-br from-primary/20 to-primary/5 flex items-center justify-center"
                      whileHover={{ scale: 1.1 }}
                    >
                      <Users className="h-10 w-10 text-primary" />
                    </motion.div>
                    
                    <h3 className="font-display text-xl font-semibold text-white">
                      {member.name}
                    </h3>
                    <p className="text-sm text-primary font-medium mb-2">{member.role}</p>
                    <p className="text-sm text-gray-400">{member.description}</p>
                  </div>
                </motion.div>
              ))}
            </div>
          </div>
        </section>

        {/* Location Section */}
        <section ref={locationRef} className="py-16 md:py-24 bg-[#0a0a0f]">
          <div className="container mx-auto px-4">
            <motion.div
              className="text-center mb-12"
              initial={{ opacity: 0, y: 30 }}
              animate={isLocationInView ? { opacity: 1, y: 0 } : {}}
              transition={{ duration: 0.6 }}
            >
              <h2 className="mb-4 font-display text-3xl font-bold text-white md:text-4xl">
                Visit <span className="gradient-brand-text">Us</span>
              </h2>
              <p className="mx-auto max-w-2xl text-gray-400">
                Come check out our products in person
              </p>
            </motion.div>

            <div className="grid gap-8 lg:grid-cols-2 max-w-5xl mx-auto">
              {/* Contact Info */}
              <motion.div
                className="relative overflow-hidden rounded-2xl border border-white/10 bg-white/5 p-8 backdrop-blur-sm"
                initial={{ opacity: 0, x: -30 }}
                animate={isLocationInView ? { opacity: 1, x: 0 } : {}}
                transition={{ duration: 0.6, delay: 0.2 }}
              >
                <div className="absolute inset-0 bg-gradient-to-br from-primary/5 to-transparent" />
                
                <div className="relative z-10 space-y-6">
                  <div className="flex items-start gap-4">
                    <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-primary/10">
                      <MapPin className="h-6 w-6 text-primary" />
                    </div>
                    <div>
                      <h3 className="font-semibold text-white mb-1">Address</h3>
                      <p className="text-gray-400">
                        Saim Enterprise, Computer Zone<br />
                        Rainbow Centre, Saddar<br />
                        Karachi, Pakistan
                      </p>
                    </div>
                  </div>

                  <div className="flex items-start gap-4">
                    <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-primary/10">
                      <Phone className="h-6 w-6 text-primary" />
                    </div>
                    <div>
                      <h3 className="font-semibold text-white mb-1">Phone</h3>
                      <p className="text-gray-400">+92 334 2914563</p>
                    </div>
                  </div>

                  <div className="flex items-start gap-4">
                    <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-primary/10">
                      <Mail className="h-6 w-6 text-primary" />
                    </div>
                    <div>
                      <h3 className="font-semibold text-white mb-1">Email</h3>
                      <p className="text-gray-400">contact@saimenterprise.com</p>
                    </div>
                  </div>

                  <div className="flex items-start gap-4">
                    <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-primary/10">
                      <Clock className="h-6 w-6 text-primary" />
                    </div>
                    <div>
                      <h3 className="font-semibold text-white mb-1">Business Hours</h3>
                      <p className="text-gray-400">
                        Mon - Sat: 11:00 AM - 9:00 PM<br />
                        Sunday: Closed
                      </p>
                    </div>
                  </div>
                </div>
              </motion.div>

              {/* Map */}
              <motion.div
                className="relative overflow-hidden rounded-2xl border border-white/10 h-80 lg:h-auto"
                initial={{ opacity: 0, x: 30 }}
                animate={isLocationInView ? { opacity: 1, x: 0 } : {}}
                transition={{ duration: 0.6, delay: 0.3 }}
              >
                <iframe
                  src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3620.0682252736!2d67.0281!3d24.8607!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zMjTCsDUxJzM4LjUiTiA2N8KwMDEnNDEuMiJF!5e0!3m2!1sen!2s!4v1234567890"
                  width="100%"
                  height="100%"
                  style={{ border: 0, minHeight: "320px" }}
                  allowFullScreen
                  loading="lazy"
                  referrerPolicy="no-referrer-when-downgrade"
                  title="Saim Enterprise Location"
                  className="grayscale opacity-80 hover:grayscale-0 hover:opacity-100 transition-all duration-500"
                />
              </motion.div>
            </div>
          </div>
        </section>
      </main>

      <MinimalFooter />
      <WhatsAppButton />
      <StickyWhatsAppCTA />
    </div>
  );
};

export default About;

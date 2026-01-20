import { useState, useRef } from "react";
import { motion, useInView } from "framer-motion";
import { Building2, Package, Clock, Headphones, Shield, TrendingUp, User, Mail, Phone, Send, Briefcase, ArrowRight } from "lucide-react";
import { Navbar } from "@/components/Navbar";
import { MinimalFooter } from "@/components/MinimalFooter";
import { WhatsAppButton } from "@/components/WhatsAppButton";
import { StickyWhatsAppCTA } from "@/components/StickyWhatsAppCTA";
import { Logo } from "@/components/Logo";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { useToast } from "@/components/ui/use-toast";

const WHATSAPP_NUMBER = "9233442914563";

const CorporateOrders = () => {
  const { toast } = useToast();
  const heroRef = useRef<HTMLDivElement>(null);
  const benefitsRef = useRef<HTMLDivElement>(null);
  const formRef = useRef<HTMLDivElement>(null);
  
  const isHeroInView = useInView(heroRef, { once: true });
  const isBenefitsInView = useInView(benefitsRef, { once: true, margin: "-100px" });
  const isFormInView = useInView(formRef, { once: true, margin: "-100px" });
  
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [formData, setFormData] = useState({
    name: "",
    company: "",
    email: "",
    phone: "",
    requirements: ""
  });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    setFormData(prev => ({
      ...prev,
      [e.target.name]: e.target.value
    }));
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    
    setTimeout(() => {
      const message = `Corporate Inquiry\n\nName: ${formData.name}\nCompany: ${formData.company}\nEmail: ${formData.email}\nPhone: ${formData.phone}\n\nRequirements:\n${formData.requirements}`;
      window.open(`https://wa.me/${WHATSAPP_NUMBER}?text=${encodeURIComponent(message)}`, "_blank");
      
      toast({
        title: "Opening WhatsApp",
        description: "Your inquiry details have been prepared. Complete the conversation on WhatsApp.",
      });
      
      setIsSubmitting(false);
    }, 500);
  };

  const benefits = [
    { 
      icon: Package, 
      title: "Bulk Pricing", 
      description: "Get exclusive discounts on large orders" 
    },
    { 
      icon: Clock, 
      title: "Priority Delivery", 
      description: "Fast-tracked processing for business orders" 
    },
    { 
      icon: Headphones, 
      title: "Dedicated Support", 
      description: "Personal account manager for your business" 
    },
    { 
      icon: Shield, 
      title: "Extended Warranty", 
      description: "Enhanced warranty coverage for bulk purchases" 
    },
    { 
      icon: TrendingUp, 
      title: "Flexible Payment", 
      description: "Custom payment terms for qualified businesses" 
    },
    { 
      icon: Building2, 
      title: "Custom Solutions", 
      description: "Tailored tech solutions for your organization" 
    },
  ];

  return (
    <div className="min-h-screen bg-[#0a0a0f]">
      <Navbar variant="dark" />
      
      {/* Hero Section */}
      <section ref={heroRef} className="relative overflow-hidden pt-24 pb-16 md:pt-32 md:pb-24">
        {/* Animated background */}
        <div className="absolute inset-0 bg-gradient-to-b from-primary/10 via-[#0a0a0f] to-[#0a0a0f]" />
        <motion.div 
          className="absolute top-20 right-1/4 w-96 h-96 bg-primary/20 rounded-full blur-3xl"
          animate={{ 
            scale: [1, 1.2, 1],
            opacity: [0.2, 0.4, 0.2],
          }}
          transition={{ duration: 8, repeat: Infinity }}
        />
        <motion.div 
          className="absolute bottom-0 left-1/3 w-80 h-80 bg-[#6366f1]/20 rounded-full blur-3xl"
          animate={{ 
            scale: [1.2, 1, 1.2],
            opacity: [0.2, 0.3, 0.2],
          }}
          transition={{ duration: 10, repeat: Infinity }}
        />
        
        <div className="container relative mx-auto px-4">
          <motion.div
            initial={{ opacity: 0, y: 30 }}
            animate={isHeroInView ? { opacity: 1, y: 0 } : {}}
            transition={{ duration: 0.6 }}
            className="text-center"
          >
            <motion.div 
              className="flex justify-center mb-6"
              initial={{ opacity: 0, scale: 0.8 }}
              animate={isHeroInView ? { opacity: 1, scale: 1 } : {}}
              transition={{ delay: 0.2 }}
            >
              <Logo size="lg" />
            </motion.div>
            
            <motion.div
              className="mb-4 inline-flex items-center gap-2 rounded-full border border-primary/30 bg-primary/10 px-4 py-2"
              initial={{ opacity: 0, y: 20 }}
              animate={isHeroInView ? { opacity: 1, y: 0 } : {}}
              transition={{ delay: 0.3 }}
            >
              <Briefcase className="h-4 w-4 text-primary" />
              <span className="text-sm font-medium text-primary">For Businesses</span>
            </motion.div>
            
            <h1 className="mb-4 font-display text-4xl font-bold text-white md:text-5xl lg:text-6xl">
              Corporate <span className="gradient-brand-text">Orders</span>
            </h1>
            <p className="mx-auto max-w-2xl text-lg text-gray-400">
              Get premium tech products for your business with exclusive bulk pricing and dedicated support.
            </p>
          </motion.div>
        </div>
      </section>

      {/* Benefits Section */}
      <section ref={benefitsRef} className="py-16 md:py-24 bg-[#08080c]">
        <div className="container mx-auto px-4">
          <motion.div
            className="mb-12 text-center"
            initial={{ opacity: 0, y: 30 }}
            animate={isBenefitsInView ? { opacity: 1, y: 0 } : {}}
            transition={{ duration: 0.6 }}
          >
            <h2 className="mb-4 font-display text-3xl font-bold text-white md:text-4xl">
              Why Partner <span className="gradient-brand-text">With Us</span>?
            </h2>
            <p className="mx-auto max-w-2xl text-gray-400">
              We offer comprehensive solutions tailored for business needs
            </p>
          </motion.div>

          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
            {benefits.map((benefit, index) => (
              <motion.div
                key={benefit.title}
                className="group relative overflow-hidden rounded-2xl border border-white/10 bg-white/5 p-6 backdrop-blur-sm"
                initial={{ opacity: 0, y: 30 }}
                animate={isBenefitsInView ? { opacity: 1, y: 0 } : {}}
                transition={{ duration: 0.5, delay: index * 0.1 }}
                whileHover={{ 
                  scale: 1.02,
                  borderColor: "hsl(348 83% 40% / 0.5)",
                }}
              >
                {/* Hover glow */}
                <motion.div
                  className="absolute inset-0 bg-gradient-to-br from-primary/10 to-transparent opacity-0 transition-opacity group-hover:opacity-100"
                />
                
                <div className="relative z-10">
                  <motion.div
                    className="mb-4 inline-flex h-14 w-14 items-center justify-center rounded-xl bg-primary/10"
                    whileHover={{ rotate: 5, scale: 1.1 }}
                  >
                    <benefit.icon className="h-7 w-7 text-primary" />
                  </motion.div>
                  
                  <h3 className="mb-2 font-display text-xl font-semibold text-white">
                    {benefit.title}
                  </h3>
                  <p className="text-sm text-gray-400">
                    {benefit.description}
                  </p>
                </div>
              </motion.div>
            ))}
          </div>
        </div>
      </section>

      {/* Contact Form Section */}
      <section ref={formRef} className="py-16 md:py-24 bg-[#0a0a0f]">
        <div className="container mx-auto px-4">
          <div className="mx-auto max-w-2xl">
            <motion.div
              className="text-center mb-12"
              initial={{ opacity: 0, y: 30 }}
              animate={isFormInView ? { opacity: 1, y: 0 } : {}}
              transition={{ duration: 0.6 }}
            >
              <h2 className="mb-4 font-display text-3xl font-bold text-white md:text-4xl">
                Get a <span className="gradient-brand-text">Quote</span>
              </h2>
              <p className="text-gray-400">
                Fill out the form below and we'll get back to you via WhatsApp
              </p>
            </motion.div>

            <motion.form
              onSubmit={handleSubmit}
              className="relative overflow-hidden rounded-2xl border border-white/10 bg-white/5 p-8 backdrop-blur-sm"
              initial={{ opacity: 0, y: 30 }}
              animate={isFormInView ? { opacity: 1, y: 0 } : {}}
              transition={{ duration: 0.6, delay: 0.2 }}
            >
              {/* Form glow effect */}
              <div className="absolute inset-0 bg-gradient-to-br from-primary/5 to-transparent" />
              
              <div className="relative z-10 space-y-6">
                <div className="grid gap-6 sm:grid-cols-2">
                  <div className="space-y-2">
                    <label className="text-sm font-medium text-gray-300 flex items-center gap-2">
                      <User className="h-4 w-4 text-primary" />
                      Your Name
                    </label>
                    <Input
                      name="name"
                      value={formData.name}
                      onChange={handleChange}
                      placeholder="John Doe"
                      required
                      className="bg-white/5 border-white/10 text-white placeholder:text-gray-500 focus:border-primary/50"
                    />
                  </div>
                  
                  <div className="space-y-2">
                    <label className="text-sm font-medium text-gray-300 flex items-center gap-2">
                      <Building2 className="h-4 w-4 text-primary" />
                      Company Name
                    </label>
                    <Input
                      name="company"
                      value={formData.company}
                      onChange={handleChange}
                      placeholder="Company Ltd."
                      required
                      className="bg-white/5 border-white/10 text-white placeholder:text-gray-500 focus:border-primary/50"
                    />
                  </div>
                </div>

                <div className="grid gap-6 sm:grid-cols-2">
                  <div className="space-y-2">
                    <label className="text-sm font-medium text-gray-300 flex items-center gap-2">
                      <Mail className="h-4 w-4 text-primary" />
                      Email Address
                    </label>
                    <Input
                      type="email"
                      name="email"
                      value={formData.email}
                      onChange={handleChange}
                      placeholder="john@company.com"
                      required
                      className="bg-white/5 border-white/10 text-white placeholder:text-gray-500 focus:border-primary/50"
                    />
                  </div>
                  
                  <div className="space-y-2">
                    <label className="text-sm font-medium text-gray-300 flex items-center gap-2">
                      <Phone className="h-4 w-4 text-primary" />
                      Phone Number
                    </label>
                    <Input
                      type="tel"
                      name="phone"
                      value={formData.phone}
                      onChange={handleChange}
                      placeholder="+92 300 1234567"
                      required
                      className="bg-white/5 border-white/10 text-white placeholder:text-gray-500 focus:border-primary/50"
                    />
                  </div>
                </div>

                <div className="space-y-2">
                  <label className="text-sm font-medium text-gray-300 flex items-center gap-2">
                    <Package className="h-4 w-4 text-primary" />
                    Requirements
                  </label>
                  <Textarea
                    name="requirements"
                    value={formData.requirements}
                    onChange={handleChange}
                    placeholder="Tell us about your requirements, quantity, and any specific products you're interested in..."
                    rows={5}
                    required
                    className="bg-white/5 border-white/10 text-white placeholder:text-gray-500 focus:border-primary/50 resize-none"
                  />
                </div>

                <motion.button
                  type="submit"
                  disabled={isSubmitting}
                  className="w-full flex items-center justify-center gap-3 rounded-full bg-[#25D366] px-8 py-4 font-semibold text-white shadow-lg disabled:opacity-70"
                  whileHover={{ scale: 1.02, boxShadow: "0 0 30px rgba(37, 211, 102, 0.5)" }}
                  whileTap={{ scale: 0.98 }}
                >
                  {isSubmitting ? (
                    <motion.div
                      className="h-5 w-5 rounded-full border-2 border-white/30 border-t-white"
                      animate={{ rotate: 360 }}
                      transition={{ duration: 1, repeat: Infinity, ease: "linear" }}
                    />
                  ) : (
                    <>
                      <Send className="h-5 w-5" />
                      Submit via WhatsApp
                      <ArrowRight className="h-4 w-4" />
                    </>
                  )}
                </motion.button>
              </div>
            </motion.form>
          </div>
        </div>
      </section>

      <MinimalFooter />
      <WhatsAppButton />
      <StickyWhatsAppCTA />
    </div>
  );
};

export default CorporateOrders;

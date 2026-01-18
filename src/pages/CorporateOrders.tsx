import { useState } from "react";
import { motion } from "framer-motion";
import { Navbar } from "@/components/Navbar";
import { Footer } from "@/components/Footer";
import { WhatsAppButton } from "@/components/WhatsAppButton";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Button } from "@/components/ui/button";
import { Building2, Mail, Phone, User, Package, DollarSign, FileText, Send, CheckCircle2 } from "lucide-react";
import { useToast } from "@/hooks/use-toast";

const CorporateOrders = () => {
  const { toast } = useToast();
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    company: "",
    phone: "",
    quantity: "",
    targetPrice: "",
    requirement: "",
  });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    setFormData(prev => ({
      ...prev,
      [e.target.name]: e.target.value
    }));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    
    // Simulate form submission
    await new Promise(resolve => setTimeout(resolve, 1500));
    
    // Open WhatsApp with form data
    const message = `*Corporate Order Inquiry*
    
Name: ${formData.name}
Email: ${formData.email}
Company: ${formData.company}
Phone: ${formData.phone}
Quantity: ${formData.quantity}
Target Price: ${formData.targetPrice}
Requirement: ${formData.requirement}`;
    
    const whatsappUrl = `https://wa.me/9233442914563?text=${encodeURIComponent(message)}`;
    window.open(whatsappUrl, "_blank");
    
    toast({
      title: "Inquiry Sent!",
      description: "We'll get back to you shortly via WhatsApp.",
    });
    
    setIsSubmitting(false);
    setFormData({
      name: "",
      email: "",
      company: "",
      phone: "",
      quantity: "",
      targetPrice: "",
      requirement: "",
    });
  };

  const formFields = [
    { name: "name", label: "Your Name", icon: User, type: "text", placeholder: "John Doe" },
    { name: "email", label: "E-mail", icon: Mail, type: "email", placeholder: "john@company.com" },
    { name: "company", label: "Company", icon: Building2, type: "text", placeholder: "Your Company Name" },
    { name: "phone", label: "Phone", icon: Phone, type: "tel", placeholder: "+92 XXX XXXXXXX" },
    { name: "quantity", label: "Quantity", icon: Package, type: "text", placeholder: "e.g., 50 units" },
    { name: "targetPrice", label: "Procurement Target Price", icon: DollarSign, type: "text", placeholder: "Your budget range" },
  ];

  const benefits = [
    { icon: CheckCircle2, title: "Bulk Discounts", description: "Special pricing for large orders" },
    { icon: CheckCircle2, title: "Priority Support", description: "Dedicated account manager" },
    { icon: CheckCircle2, title: "Custom Solutions", description: "Tailored to your needs" },
    { icon: CheckCircle2, title: "Fast Delivery", description: "Express shipping available" },
  ];

  return (
    <div className="min-h-screen bg-background">
      <Navbar />
      
      {/* Hero Section */}
      <section className="relative overflow-hidden pt-24 pb-12 md:pt-32 md:pb-16">
        <div className="absolute inset-0 bg-gradient-to-br from-primary/5 via-transparent to-primary/10" />
        <div className="container relative mx-auto px-4">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.6 }}
            className="text-center"
          >
            <span className="mb-4 inline-block rounded-full bg-primary/10 px-4 py-1.5 text-sm font-medium text-primary">
              For Businesses
            </span>
            <h1 className="mb-4 font-display text-4xl font-bold tracking-tight md:text-5xl lg:text-6xl">
              Corporate <span className="gradient-brand-text">Orders</span>
            </h1>
            <p className="mx-auto max-w-2xl text-lg text-muted-foreground">
              Get premium tech products for your business with exclusive bulk pricing and dedicated support.
            </p>
          </motion.div>
        </div>
      </section>

      {/* Benefits Section */}
      <section className="py-8 md:py-12">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-2 gap-4 md:grid-cols-4 md:gap-6">
            {benefits.map((benefit, index) => (
              <motion.div
                key={benefit.title}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 0.4, delay: index * 0.1 }}
                className="rounded-xl border border-border bg-card p-4 text-center md:p-6"
              >
                <benefit.icon className="mx-auto mb-2 h-8 w-8 text-primary md:h-10 md:w-10" />
                <h3 className="mb-1 font-semibold text-foreground">{benefit.title}</h3>
                <p className="text-xs text-muted-foreground md:text-sm">{benefit.description}</p>
              </motion.div>
            ))}
          </div>
        </div>
      </section>

      {/* Form Section */}
      <section className="py-12 md:py-16">
        <div className="container mx-auto px-4">
          <div className="mx-auto max-w-2xl">
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ duration: 0.6, delay: 0.2 }}
              className="rounded-2xl border border-border bg-card p-6 shadow-xl md:p-8"
            >
              <div className="mb-6 text-center">
                <h2 className="mb-2 font-display text-2xl font-bold md:text-3xl">
                  Submit Your Inquiry
                </h2>
                <p className="text-muted-foreground">
                  Fill out the form below and we'll get back to you within 24 hours.
                </p>
              </div>

              <form onSubmit={handleSubmit} className="space-y-4">
                {formFields.map((field, index) => (
                  <motion.div
                    key={field.name}
                    initial={{ opacity: 0, x: -20 }}
                    animate={{ opacity: 1, x: 0 }}
                    transition={{ duration: 0.3, delay: 0.3 + index * 0.05 }}
                  >
                    <label className="mb-1.5 flex items-center gap-2 text-sm font-medium text-foreground">
                      <field.icon className="h-4 w-4 text-primary" />
                      {field.label}
                    </label>
                    <Input
                      type={field.type}
                      name={field.name}
                      value={formData[field.name as keyof typeof formData]}
                      onChange={handleChange}
                      placeholder={field.placeholder}
                      required
                      className="h-12 border-border bg-background transition-all focus:border-primary focus:ring-primary"
                    />
                  </motion.div>
                ))}

                <motion.div
                  initial={{ opacity: 0, x: -20 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ duration: 0.3, delay: 0.6 }}
                >
                  <label className="mb-1.5 flex items-center gap-2 text-sm font-medium text-foreground">
                    <FileText className="h-4 w-4 text-primary" />
                    Requirement
                  </label>
                  <Textarea
                    name="requirement"
                    value={formData.requirement}
                    onChange={handleChange}
                    placeholder="Describe your requirements in detail..."
                    required
                    rows={4}
                    className="resize-none border-border bg-background transition-all focus:border-primary focus:ring-primary"
                  />
                </motion.div>

                <motion.div
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ duration: 0.3, delay: 0.7 }}
                  className="pt-2"
                >
                  <Button
                    type="submit"
                    disabled={isSubmitting}
                    className="h-12 w-full gap-2 bg-primary text-lg font-semibold text-primary-foreground hover:bg-primary/90"
                  >
                    {isSubmitting ? (
                      <>
                        <motion.span
                          animate={{ rotate: 360 }}
                          transition={{ duration: 1, repeat: Infinity, ease: "linear" }}
                          className="h-5 w-5 rounded-full border-2 border-primary-foreground/30 border-t-primary-foreground"
                        />
                        Sending...
                      </>
                    ) : (
                      <>
                        <Send className="h-5 w-5" />
                        Submit Inquiry
                      </>
                    )}
                  </Button>
                </motion.div>
              </form>

              <p className="mt-4 text-center text-xs text-muted-foreground">
                By submitting, you'll be redirected to WhatsApp to confirm your inquiry.
              </p>
            </motion.div>
          </div>
        </div>
      </section>

      <Footer />
      <WhatsAppButton />
    </div>
  );
};

export default CorporateOrders;

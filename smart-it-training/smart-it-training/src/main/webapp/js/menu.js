// Wait for DOM to be fully loaded
document.addEventListener('DOMContentLoaded', function() {
    
    // Set current year in footer
    const yearElement = document.getElementById('currentYear');
    if (yearElement) {
        yearElement.innerText = new Date().getFullYear();
    }
    
    // Image fallback handler
    const images = document.querySelectorAll('img');
    images.forEach(function(img) {
        img.addEventListener('error', function() {
            if (!img.dataset.fallback && !img.src.includes('placeholder')) {
                img.dataset.fallback = 'true';
                img.src = 'https://via.placeholder.com/300x200?text=IT+Module';
            }
        });
    });
    
    // Module card click handlers
    const moduleCards = document.querySelectorAll('.module-card');
    moduleCards.forEach(function(card) {
        card.addEventListener('click', function(e) {
            const moduleName = this.getAttribute('data-module') || 'Module';
            showToast('📚 Opening ' + moduleName + ' module');
        });
    });
    
    // Button click handlers inside module cards (prevents double toast)
    const buttons = document.querySelectorAll('.butt-overlay');
    buttons.forEach(function(button) {
        button.addEventListener('click', function(e) {
            e.stopPropagation();
            const moduleName = this.getAttribute('data-module') || 'Module';
            showToast('🔧 ' + moduleName + ' feature coming soon!');
            
            // Add click animation
            this.style.transform = 'scale(0.95)';
            setTimeout(function() {
                button.style.transform = '';
            }, 200);
        });
    });
    
    // Social icon click handlers
    const socialIcons = document.querySelectorAll('.social-icon-enhanced');
    const socialMessages = {
        'Facebook': '📘 Follow us on Facebook: Smart IT Training Centre',
        'Twitter': '🐦 Follow us on Twitter: @SmartIT_Official',
        'LinkedIn': '🔗 Connect with us on LinkedIn: Smart IT Training Centre',
        'Instagram': '📸 Follow us on Instagram: @smart_training_centre',
        'YouTube': '▶️ Subscribe to our YouTube: Smart IT Tutorials',
        'WhatsApp': '💬 WhatsApp Support: +917420070217'
    };
    
    socialIcons.forEach(function(icon) {
        icon.addEventListener('click', function(e) {
            const socialType = this.getAttribute('data-social');
            const message = socialMessages[socialType] || 'Connect with us on social media!';
            showToast(message);
            
            // Add bounce effect
            this.style.transform = 'scale(1.2)';
            setTimeout(function() {
                icon.style.transform = '';
            }, 200);
        });
    });
    
    // Home link click handler
    const homeLinks = document.querySelectorAll('.home-link-modern');
    homeLinks.forEach(function(link) {
        link.addEventListener('click', function(e) {
            showToast('🏠 Returning to Home page...');
        });
    });
    
    // Toast notification function
    function showToast(message) {
        // Remove existing toast if any
        const existingToast = document.querySelector('.custom-toast');
        if (existingToast) {
            existingToast.remove();
        }
        
        // Create new toast
        const toast = document.createElement('div');
        toast.className = 'custom-toast';
        toast.innerText = message;
        toast.style.position = 'fixed';
        toast.style.bottom = '100px';
        toast.style.left = '50%';
        toast.style.transform = 'translateX(-50%)';
        toast.style.background = 'rgba(0, 20, 40, 0.95)';
        toast.style.backdropFilter = 'blur(16px)';
        toast.style.color = '#00ffcc';
        toast.style.padding = '12px 28px';
        toast.style.borderRadius = '50px';
        toast.style.fontSize = '0.9rem';
        toast.style.fontWeight = '600';
        toast.style.fontFamily = "'Poppins', 'Inter', sans-serif";
        toast.style.border = '1px solid #00ffcc';
        toast.style.boxShadow = '0 0 30px rgba(0, 255, 200, 0.3)';
        toast.style.zIndex = '10000';
        toast.style.whiteSpace = 'nowrap';
        toast.style.maxWidth = '90%';
        toast.style.whiteSpace = 'normal';
        toast.style.textAlign = 'center';
        toast.style.wordBreak = 'keep-all';
        
        document.body.appendChild(toast);
        
        // Auto remove after 2.5 seconds
        setTimeout(function() {
            toast.style.opacity = '0';
            toast.style.transition = 'opacity 0.3s ease';
            setTimeout(function() {
                if (toast.parentNode) {
                    toast.remove();
                }
            }, 300);
        }, 2500);
    }
    
    // Add hover effect for marquee pause/resume
    const marquee = document.querySelector('marquee');
    if (marquee) {
        marquee.addEventListener('mouseenter', function() {
            this.stop();
        });
        marquee.addEventListener('mouseleave', function() {
            this.start();
        });
    }
    
    // Add ripple effect to buttons
    function addRippleEffect(element, event) {
        const ripple = document.createElement('span');
        ripple.style.position = 'absolute';
        ripple.style.background = 'rgba(0, 255, 200, 0.6)';
        ripple.style.borderRadius = '50%';
        ripple.style.width = '40px';
        ripple.style.height = '40px';
        ripple.style.left = (event.clientX - element.getBoundingClientRect().left) + 'px';
        ripple.style.top = (event.clientY - element.getBoundingClientRect().top) + 'px';
        ripple.style.transform = 'translate(-50%, -50%) scale(0)';
        ripple.style.animation = 'rippleEffect 0.6s ease-out';
        ripple.style.pointerEvents = 'none';
        element.style.position = 'relative';
        element.style.overflow = 'hidden';
        element.appendChild(ripple);
        
        setTimeout(function() {
            ripple.remove();
        }, 600);
    }
    
    // Add ripple animation to stylesheet
    if (!document.querySelector('#rippleStyle')) {
        const style = document.createElement('style');
        style.id = 'rippleStyle';
        style.textContent = `
            @keyframes rippleEffect {
                0% { transform: translate(-50%, -50%) scale(0); opacity: 0.8; }
                100% { transform: translate(-50%, -50%) scale(15); opacity: 0; }
            }
        `;
        document.head.appendChild(style);
    }
    
    // Add keyboard navigation support
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            const toasts = document.querySelectorAll('.custom-toast');
            toasts.forEach(function(toast) {
                toast.remove();
            });
        }
    });
    
    console.log('%c✨ Smart IT Training Centre | Menu Loaded Successfully ✨', 'color: #00ffcc; font-size: 14px; font-weight: bold;');
});
// Wait for DOM to be fully loaded
document.addEventListener('DOMContentLoaded', function() {
    
    // ========= EXPLORE BUTTON - NOW WITH NAVIGATION =========
    const exploreBtn = document.getElementById('exploreBtn');
    if (exploreBtn) {
        exploreBtn.addEventListener('click', function(e) {
            // REMOVED e.preventDefault() - THIS WAS BLOCKING NAVIGATION
            
            // Ripple effect
            const ripple = document.createElement('span');
            ripple.style.position = 'absolute';
            ripple.style.background = 'radial-gradient(circle, rgba(0,255,240,0.9), rgba(0,200,255,0.4))';
            ripple.style.borderRadius = '50%';
            ripple.style.width = '120px';
            ripple.style.height = '120px';
            ripple.style.top = '50%';
            ripple.style.left = '50%';
            ripple.style.transform = 'translate(-50%, -50%) scale(0)';
            ripple.style.animation = 'rippleAnim 0.7s ease-out';
            ripple.style.pointerEvents = 'none';
            exploreBtn.style.position = 'relative';
            exploreBtn.appendChild(ripple);
            setTimeout(function() { ripple.remove(); }, 700);
            
            // Show toast message
            const toast = document.createElement('div');
            toast.innerText = '◈ Neural ignition — Loading Menu ◈';
            toast.style.position = 'fixed';
            toast.style.bottom = '90px';
            toast.style.left = '50%';
            toast.style.transform = 'translateX(-50%)';
            toast.style.background = '#071526ee';
            toast.style.color = '#CCFFFF';
            toast.style.padding = '12px 32px';
            toast.style.borderRadius = '60px';
            toast.style.fontWeight = '600';
            toast.style.backdropFilter = 'blur(20px)';
            toast.style.border = '1px solid #00FFCC';
            toast.style.zIndex = '9999';
            toast.style.fontFamily = 'Space Grotesk, monospace';
            toast.style.fontSize = '0.85rem';
            document.body.appendChild(toast);
            
            // Navigate to menu page after short delay
            setTimeout(function() { 
                toast.style.opacity = '0'; 
                setTimeout(function() { 
                    toast.remove();
                    // THIS IS THE KEY FIX - Navigate to menu page
                    window.location.href = '/menu';
                }, 300); 
            }, 1500);
        });
    }
    
    // Add ripple animation if not exists
    if (!document.querySelector('#rippleKeyframes')) {
        const styleTag = document.createElement('style');
        styleTag.id = 'rippleKeyframes';
        styleTag.textContent = `
            @keyframes rippleAnim {
                0% { transform: translate(-50%, -50%) scale(0); opacity: 0.9; }
                100% { transform: translate(-50%, -50%) scale(24); opacity: 0; }
            }
        `;
        document.head.appendChild(styleTag);
    }
    
    // ========= PARTICLE SYSTEM =========
    const canvas = document.getElementById('cosmicParticles');
    if (canvas) {
        let ctx = canvas.getContext('2d');
        let width = window.innerWidth;
        let height = window.innerHeight;
        let particles = [];
        
        function resizeCanvas() {
            width = window.innerWidth;
            height = window.innerHeight;
            canvas.width = width;
            canvas.height = height;
        }
        
        class StarParticle {
            constructor() {
                this.x = Math.random() * width;
                this.y = Math.random() * height;
                this.size = Math.random() * 3.2 + 0.8;
                this.speedX = (Math.random() - 0.5) * 0.4;
                this.speedY = (Math.random() - 0.5) * 0.3 - 0.3;
                this.opacity = Math.random() * 0.5 + 0.1;
                this.color = 'rgba(0, 255, 210, ' + this.opacity + ')';
            }
            
            update() {
                this.x += this.speedX;
                this.y += this.speedY;
                if (this.x < 0) this.x = width;
                if (this.x > width) this.x = 0;
                if (this.y < 0) this.y = height;
                if (this.y > height) this.y = 0;
            }
            
            draw() {
                ctx.beginPath();
                ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
                ctx.fillStyle = this.color;
                ctx.fill();
                ctx.shadowBlur = 8;
                ctx.shadowColor = "#0ff";
                ctx.fill();
                ctx.shadowBlur = 0;
            }
        }
        
        function initParticles() {
            particles = [];
            for (let i = 0; i < 180; i++) {
                particles.push(new StarParticle());
            }
        }
        
        function animateParticles() {
            if (!ctx) return;
            ctx.clearRect(0, 0, width, height);
            for (let i = 0; i < particles.length; i++) {
                particles[i].update();
                particles[i].draw();
            }
            requestAnimationFrame(animateParticles);
        }
        
        window.addEventListener('resize', function() {
            resizeCanvas();
            initParticles();
        });
        
        resizeCanvas();
        initParticles();
        animateParticles();
    }
    
    // ========= SLIDER SPEED CONTROL =========
    const sliderTrack = document.querySelector('.slider-track');
    const heroZone = document.querySelector('.hero-wrapper');
    if (sliderTrack && heroZone) {
        heroZone.addEventListener('mouseenter', function() {
            sliderTrack.style.animation = 'majesticFlow 72s cubic-bezier(0.45, 0.05, 0.2, 0.97) infinite';
        });
        heroZone.addEventListener('mouseleave', function() {
            sliderTrack.style.animation = 'majesticFlow 55s cubic-bezier(0.45, 0.05, 0.2, 0.97) infinite';
        });
    }
    
    // ========= TITLE PARALLAX =========
    const title = document.querySelector('h1');
    if (title) {
        document.addEventListener('mousemove', function(e) {
            const xShift = (window.innerWidth / 2 - e.clientX) / 80;
            const yShift = (window.innerHeight / 2 - e.clientY) / 80;
            title.style.transform = 'translate(' + (xShift * 0.2) + 'px, ' + (yShift * 0.15) + 'px)';
        });
        document.addEventListener('mouseleave', function() {
            title.style.transform = 'translate(0,0)';
        });
    }
    
    // ========= FIX SLIDER DIMENSIONS =========
    function fixSliderDimensions() {
        const slides = document.querySelectorAll('.slide');
        const track = document.querySelector('.slider-track');
        if (slides.length && track) {
            const winW = window.innerWidth;
            for (let i = 0; i < slides.length; i++) {
                slides[i].style.flex = '0 0 ' + winW + 'px';
            }
            track.style.width = (winW * slides.length) + 'px';
        }
    }
    
    window.addEventListener('resize', fixSliderDimensions);
    fixSliderDimensions();
    
    // ========= MOUSE FOLLOW AURA =========
    const auraLayer = document.querySelector('.nebulae-glow');
    if (auraLayer) {
        document.addEventListener('mousemove', function(e) {
            const percX = e.clientX / window.innerWidth;
            const percY = e.clientY / window.innerHeight;
            auraLayer.style.background = 'radial-gradient(circle at ' + (percX * 100) + '% ' + (percY * 100) + '%, rgba(0, 255, 210, 0.18), rgba(0, 30, 60, 0.5) 85%)';
        });
    }
    
    // ========= COURSE CARDS INTERACTION =========
    const courseCards = document.querySelectorAll('.course-card');
    for (let i = 0; i < courseCards.length; i++) {
        courseCards[i].addEventListener('click', function() {
            const courseNameElement = this.querySelector('h3');
            const courseName = courseNameElement ? courseNameElement.innerText : 'Course';
            
            const miniToast = document.createElement('div');
            miniToast.innerText = '📡 Accessing ' + courseName + ' — immersive curriculum ready';
            miniToast.style.position = 'fixed';
            miniToast.style.bottom = '130px';
            miniToast.style.left = '50%';
            miniToast.style.transform = 'translateX(-50%)';
            miniToast.style.background = '#071824dd';
            miniToast.style.color = '#aaffff';
            miniToast.style.padding = '8px 24px';
            miniToast.style.borderRadius = '40px';
            miniToast.style.fontSize = '0.75rem';
            miniToast.style.backdropFilter = 'blur(12px)';
            miniToast.style.border = '1px solid cyan';
            miniToast.style.zIndex = '9999';
            document.body.appendChild(miniToast);
            
            setTimeout(function() { 
                miniToast.style.opacity = '0'; 
                setTimeout(function() { miniToast.remove(); }, 500); 
            }, 1500);
        });
    }
    
    // ========= FEATURE CARDS INTERACTION =========
    const featureCards = document.querySelectorAll('.feature-card');
    for (let i = 0; i < featureCards.length; i++) {
        featureCards[i].addEventListener('click', function() {
            const titleElement = this.querySelector('h4');
            const titleEl = titleElement ? titleElement.innerText : 'Feature';
            
            const toastMsg = document.createElement('div');
            toastMsg.innerText = '✨ ' + titleEl + ' — premium industry excellence ✨';
            toastMsg.style.position = 'fixed';
            toastMsg.style.bottom = '170px';
            toastMsg.style.left = '50%';
            toastMsg.style.transform = 'translateX(-50%)';
            toastMsg.style.background = 'rgba(0, 20, 40, 0.95)';
            toastMsg.style.backdropFilter = 'blur(16px)';
            toastMsg.style.color = '#C0FFFF';
            toastMsg.style.padding = '10px 24px';
            toastMsg.style.borderRadius = '50px';
            toastMsg.style.fontSize = '0.8rem';
            toastMsg.style.border = '1px solid #0ff';
            toastMsg.style.zIndex = '10000';
            document.body.appendChild(toastMsg);
            
            setTimeout(function() { 
                toastMsg.style.opacity = '0'; 
                setTimeout(function() { toastMsg.remove(); }, 700); 
            }, 1800);
            
            this.style.boxShadow = '0 0 20px rgba(0,255,210,0.6)';
            setTimeout(function() { 
                featureCards[i].style.boxShadow = ''; 
            }, 300);
        });
    }
    
    // ========= PRELOAD IMAGES =========
    const imageUrls = [
        'https://images.pexels.com/photos/2582937/pexels-photo-2582937.jpeg?auto=compress&cs=tinysrgb&w=1600',
        'https://images.pexels.com/photos/325229/pexels-photo-325229.jpeg?auto=compress&cs=tinysrgb&w=1600',
        'https://images.pexels.com/photos/1181263/pexels-photo-1181263.jpeg?auto=compress&cs=tinysrgb&w=1600',
        'https://images.pexels.com/photos/270360/pexels-photo-270360.jpeg?auto=compress&cs=tinysrgb&w=1600',
        'https://images.pexels.com/photos/2710/closeup-photography-of-network-cables.jpg?auto=compress&cs=tinysrgb&w=1600',
        'https://images.pexels.com/photos/2166671/pexels-photo-2166671.jpeg?auto=compress&cs=tinysrgb&w=1600',
        'https://images.pexels.com/photos/1029757/pexels-photo-1029757.jpeg?auto=compress&cs=tinysrgb&w=1600',
        'https://images.pexels.com/photos/577585/pexels-photo-577585.jpeg?auto=compress&cs=tinysrgb&w=1600',
        'https://images.pexels.com/photos/8386440/pexels-photo-8386440.jpeg?auto=compress&cs=tinysrgb&w=1600',
        'https://images.pexels.com/photos/777001/pexels-photo-777001.jpeg?auto=compress&cs=tinysrgb&w=1600',
        'https://images.pexels.com/photos/669996/pexels-photo-669996.jpeg?auto=compress&cs=tinysrgb&w=1600',
        'https://images.pexels.com/photos/1148820/pexels-photo-1148820.jpeg?auto=compress&cs=tinysrgb&w=1600'
    ];
    
    for (let i = 0; i < imageUrls.length; i++) {
        const img = new Image();
        img.src = imageUrls[i];
    }
    
    console.log("%c✨ LUMINA//CORE | FULL IT ECOSYSTEM | READY ✨", "color: #0ff; font-size: 14px; font-weight: bold;");
    
}); // END OF DOMContentLoaded
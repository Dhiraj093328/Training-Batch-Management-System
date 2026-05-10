// DIGITAL RAIN MATRIX EFFECT
(function() {
    const canvas = document.getElementById('digital-rain');
    if (!canvas) return;
    
    const ctx = canvas.getContext('2d');
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
    
    const chars = "01アイウエオカキクケコABCDEFGHIJKLMNOPQRSTUVWXYZ@#$%^&*(){}[]<>/\\|~`";
    const fontSize = 14;
    let columns = canvas.width / fontSize;
    let drops = [];
    
    function initDrops() {
        columns = canvas.width / fontSize;
        drops = [];
        for(let x = 0; x < columns; x++) {
            drops[x] = Math.random() * -100;
        }
    }
    
    function drawRain() {
        ctx.fillStyle = "rgba(0, 0, 0, 0.05)";
        ctx.fillRect(0, 0, canvas.width, canvas.height);
        ctx.font = `bold ${fontSize}px 'Space Mono', monospace`;
        for(let i = 0; i < drops.length; i++) {
            const text = chars.charAt(Math.floor(Math.random() * chars.length));
            const x = i * fontSize;
            const y = drops[i] * fontSize;
            ctx.fillStyle = `rgba(0, 220, 255, ${Math.random() * 0.6 + 0.3})`;
            ctx.fillText(text, x, y);
            if(y > canvas.height && Math.random() > 0.975) {
                drops[i] = 0;
            }
            drops[i]++;
        }
    }
    
    function resizeCanvas() {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
        initDrops();
    }
    
    window.addEventListener('resize', resizeCanvas);
    initDrops();
    setInterval(drawRain, 50);
    resizeCanvas();
})();

// GSAP entrance animation for card
if (typeof gsap !== 'undefined') {
    gsap.fromTo(".login-container", 
        { opacity: 0, y: 60, scale: 0.95, rotationX: -15 },
        { opacity: 1, y: 0, scale: 1, rotationX: 0, duration: 1.2, ease: "back.out(0.6)", clearProps: "rotationX" }
    );
    
    // Animate floating orbs
    gsap.to(".orb1", {
        x: "3%",
        y: "4%",
        scale: 1.1,
        duration: 14,
        repeat: -1,
        yoyo: true,
        ease: "sine.inOut"
    });
    gsap.to(".orb2", {
        x: "-4%",
        y: "-3%",
        scale: 1.15,
        duration: 18,
        repeat: -1,
        yoyo: true,
        ease: "sine.inOut"
    });
}

// Button hover effects
const btn = document.getElementById('loginBtn');
if (btn && typeof gsap !== 'undefined') {
    btn.addEventListener('mouseenter', () => {
        gsap.to(btn, { scale: 1.02, duration: 0.2, boxShadow: "0 0 18px #00ffff" });
    });
    btn.addEventListener('mouseleave', () => {
        gsap.to(btn, { scale: 1, duration: 0.2, boxShadow: "none" });
    });
}

// Input field glow effects
const inputs = document.querySelectorAll('.form-group input');
inputs.forEach(input => {
    if (typeof gsap !== 'undefined') {
        input.addEventListener('focus', (e) => {
            gsap.to(e.target, { borderColor: "#0ff", boxShadow: "0 0 8px #0ff", duration: 0.2 });
        });
        input.addEventListener('blur', (e) => {
            gsap.to(e.target, { borderColor: "rgba(0, 255, 255, 0.4)", boxShadow: "none", duration: 0.2 });
        });
    }
});

// Form submit loading effect
const form = document.getElementById('loginForm');
if (form) {
    form.addEventListener('submit', function(e) {
        const submitBtn = document.getElementById('loginBtn');
        if (submitBtn) {
            submitBtn.innerHTML = '<span>AUTHENTICATING</span> <i class="fas fa-spinner fa-pulse"></i>';
            submitBtn.disabled = true;
            // Re-enable after timeout (prevents stuck state if redirect fails)
            setTimeout(() => {
                if (submitBtn.disabled) {
                    submitBtn.innerHTML = '<span>LAUNCH DASHBOARD</span> <i class="fas fa-arrow-right-to-bracket"></i>';
                    submitBtn.disabled = false;
                }
            }, 4000);
        }
    });
}

// Particle effect creator
function createParticleEffect(x, y) {
    const particle = document.createElement('div');
    particle.style.position = 'fixed';
    particle.style.width = '4px';
    particle.style.height = '4px';
    particle.style.background = '#0ff';
    particle.style.borderRadius = '50%';
    particle.style.pointerEvents = 'none';
    particle.style.zIndex = '9999';
    particle.style.left = x + 'px';
    particle.style.top = y + 'px';
    particle.style.boxShadow = '0 0 6px cyan';
    document.body.appendChild(particle);
    
    if (typeof gsap !== 'undefined') {
        gsap.to(particle, { opacity: 0, scale: 3, duration: 0.8, onComplete: () => particle.remove() });
    } else {
        // Fallback animation
        let opacity = 1;
        let scale = 1;
        const animate = () => {
            opacity -= 0.05;
            scale += 0.15;
            particle.style.opacity = opacity;
            particle.style.transform = `scale(${scale})`;
            if (opacity > 0) requestAnimationFrame(animate);
            else particle.remove();
        };
        requestAnimationFrame(animate);
    }
}

// Add particle effect on input clicks
document.querySelectorAll('.input-group input').forEach(inp => {
    inp.addEventListener('click', (e) => {
        const rect = inp.getBoundingClientRect();
        createParticleEffect(rect.left + 10, rect.top + rect.height / 2);
    });
});

// Glitch text effect
const glitchSpan = document.querySelector('.glitch-text');
if (glitchSpan) {
    setInterval(() => {
        if (Math.random() > 0.85) {
            glitchSpan.style.textShadow = "2px 0 red, -2px 0 blue";
            setTimeout(() => glitchSpan.style.textShadow = "0 0 3px cyan", 100);
        }
    }, 800);
}

// Add floating animation to action links
document.querySelectorAll('.action-link').forEach(link => {
    link.addEventListener('mouseenter', function() {
        if (typeof gsap !== 'undefined') {
            gsap.to(this, { y: -3, duration: 0.2 });
        }
    });
    link.addEventListener('mouseleave', function() {
        if (typeof gsap !== 'undefined') {
            gsap.to(this, { y: 0, duration: 0.2 });
        }
    });
});

// Console greeting
console.log("%c✨ Smart IT Training | Student Portal Ready ✨", "color: #6a5acd; font-size: 14px; font-weight: bold;");
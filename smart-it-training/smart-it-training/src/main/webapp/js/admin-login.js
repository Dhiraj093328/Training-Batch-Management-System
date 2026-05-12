/**
 * Admin Login Page - Interactive Features
 * Handles form validation, message animations, and UI enhancements
 */

// Wait for DOM to be fully loaded
document.addEventListener('DOMContentLoaded', function() {
    
    // DOM Elements - UPDATED: Changed userId to username
    const loginForm = document.getElementById('secureLoginForm');
    const usernameInput = document.getElementById('username');  // Changed from 'userId'
    const passwordInput = document.getElementById('password');
    const submitBtn = document.getElementById('submitBtn');
    const messageContainer = document.getElementById('messageContainer');
    
    // Auto-hide server error/success messages after 5 seconds
    const serverErrorMsg = document.getElementById('serverErrorMsg');
    const serverSuccessMsg = document.getElementById('serverSuccessMsg');
    
    if (serverErrorMsg) {
        setTimeout(function() {
            serverErrorMsg.style.transition = 'opacity 0.5s ease';
            serverErrorMsg.style.opacity = '0';
            setTimeout(function() {
                if (serverErrorMsg && serverErrorMsg.parentNode) {
                    serverErrorMsg.style.display = 'none';
                }
            }, 500);
        }, 5000);
    }
    
    if (serverSuccessMsg) {
        setTimeout(function() {
            serverSuccessMsg.style.transition = 'opacity 0.5s ease';
            serverSuccessMsg.style.opacity = '0';
            setTimeout(function() {
                if (serverSuccessMsg && serverSuccessMsg.parentNode) {
                    serverSuccessMsg.style.display = 'none';
                }
            }, 500);
        }, 5000);
    }
    
    /**
     * Display dynamic message (client-side)
     * @param {string} type - 'error' or 'success'
     * @param {string} text - Message text
     * @param {boolean} autoHide - Whether to auto-hide after delay
     */
    function showMessage(type, text, autoHide = true) {
        if (messageContainer) {
            // Clear any existing client messages
            const existingClientMsgs = messageContainer.querySelectorAll('.alert');
            existingClientMsgs.forEach(msg => msg.remove());
            
            const msgDiv = document.createElement('div');
            msgDiv.className = `alert alert-${type}`;
            const icon = type === 'error' ? '<i class="fas fa-exclamation-triangle"></i>' : '<i class="fas fa-check-circle"></i>';
            msgDiv.innerHTML = `${icon} <span>${text}</span>`;
            messageContainer.appendChild(msgDiv);
            
            // Scroll message into view
            msgDiv.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
            
            if (autoHide) {
                setTimeout(() => {
                    if (msgDiv) {
                        msgDiv.style.transition = 'opacity 0.4s ease, transform 0.4s ease';
                        msgDiv.style.opacity = '0';
                        msgDiv.style.transform = 'translateY(-10px)';
                        setTimeout(() => {
                            if (msgDiv.parentNode) msgDiv.remove();
                        }, 400);
                    }
                }, 4800);
            }
        }
    }
    
    /**
     * Clear all client-side messages
     */
    function clearClientMessages() {
        if (messageContainer) {
            const messages = messageContainer.querySelectorAll('.alert');
            messages.forEach(msg => msg.remove());
        }
    }
    
    /**
     * Apply shake effect to glass card
     */
    function shakeCard() {
        const card = document.querySelector('.glass-card');
        if (card) {
            card.classList.add('shake-effect');
            setTimeout(() => {
                card.classList.remove('shake-effect');
            }, 300);
        }
    }
    
    /**
     * Form Validation and Submission Handler
     * Provides client-side validation before sending to server
     */
    if (loginForm) {
        loginForm.addEventListener('submit', function(e) {
            // Clear previous client messages
            clearClientMessages();
            
            // Get values and trim - UPDATED to use usernameInput
            const username = usernameInput ? usernameInput.value.trim() : '';
            const password = passwordInput ? passwordInput.value.trim() : '';
            
            // Validation checks
            if (username === '') {
                e.preventDefault();
                showMessage('error', '❌ Please enter your Username or registered email address.', true);
                if (usernameInput) {
                    usernameInput.focus();
                    usernameInput.style.borderColor = '#f87171';
                    usernameInput.style.boxShadow = '0 0 0 3px rgba(248,113,113,0.2)';
                    setTimeout(() => {
                        if (usernameInput) {
                            usernameInput.style.borderColor = '';
                            usernameInput.style.boxShadow = '';
                        }
                    }, 2000);
                }
                shakeCard();
                return false;
            }
            
            if (password === '') {
                e.preventDefault();
                showMessage('error', '❌ Access password cannot be blank. Please enter your credentials.', true);
                if (passwordInput) {
                    passwordInput.focus();
                    passwordInput.style.borderColor = '#f87171';
                    passwordInput.style.boxShadow = '0 0 0 3px rgba(248,113,113,0.2)';
                    setTimeout(() => {
                        if (passwordInput) {
                            passwordInput.style.borderColor = '';
                            passwordInput.style.boxShadow = '';
                        }
                    }, 2000);
                }
                shakeCard();
                return false;
            }
            
            // Username length validation
            if (username.length < 3) {
                e.preventDefault();
                showMessage('error', '⚠️ Username must be at least 3 characters long.', true);
                if (usernameInput) {
                    usernameInput.focus();
                    usernameInput.style.borderColor = '#f87171';
                    setTimeout(() => {
                        if (usernameInput) usernameInput.style.borderColor = '';
                    }, 2000);
                }
                shakeCard();
                return false;
            }
            
            // Password length validation
            if (password.length < 4) {
                e.preventDefault();
                showMessage('error', '⚠️ Password must be at least 4 characters long.', true);
                if (passwordInput) {
                    passwordInput.focus();
                    passwordInput.style.borderColor = '#f87171';
                    setTimeout(() => {
                        if (passwordInput) passwordInput.style.borderColor = '';
                    }, 2000);
                }
                shakeCard();
                return false;
            }
            
            // If validation passes, show loading state on button
            if (submitBtn) {
                const originalBtnText = submitBtn.innerHTML;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-pulse"></i> Authenticating...';
                submitBtn.disabled = true;
                
                // Store original text to restore if needed
                submitBtn.dataset.originalText = originalBtnText;
            }
        });
    }
    
    /**
     * Input field enhancement - remove error border on focus
     */
    if (usernameInput) {
        usernameInput.addEventListener('focus', function() {
            this.style.borderColor = '';
            this.style.boxShadow = '';
        });
    }
    
    if (passwordInput) {
        passwordInput.addEventListener('focus', function() {
            this.style.borderColor = '';
            this.style.boxShadow = '';
        });
    }
    
    /**
     * Add floating label effect and micro-interactions
     */
    const inputGroups = document.querySelectorAll('.input-group');
    inputGroups.forEach(group => {
        const input = group.querySelector('.input-field');
        if (input) {
            input.addEventListener('focus', () => {
                group.style.transform = 'translateX(2px)';
                group.style.transition = 'transform 0.2s ease';
            });
            input.addEventListener('blur', () => {
                group.style.transform = 'translateX(0)';
            });
        }
    });
    
    /**
     * Password visibility toggle (optional feature)
     * Creates a toggle button inside password field
     */
    function addPasswordToggle() {
        if (passwordInput) {
            // Check if toggle already exists
            if (passwordInput.parentElement.querySelector('.password-toggle')) return;
            
            const toggleBtn = document.createElement('button');
            toggleBtn.type = 'button';
            toggleBtn.className = 'password-toggle';
            toggleBtn.innerHTML = '<i class="fas fa-eye"></i>';
            toggleBtn.style.position = 'absolute';
            toggleBtn.style.right = '15px';
            toggleBtn.style.top = '50%';
            toggleBtn.style.transform = 'translateY(-50%)';
            toggleBtn.style.background = 'transparent';
            toggleBtn.style.border = 'none';
            toggleBtn.style.color = '#a5b4fc';
            toggleBtn.style.cursor = 'pointer';
            toggleBtn.style.fontSize = '1rem';
            toggleBtn.style.zIndex = '2';
            toggleBtn.style.padding = '5px';
            toggleBtn.style.borderRadius = '50%';
            toggleBtn.style.transition = 'all 0.2s ease';
            
            toggleBtn.addEventListener('mouseenter', function() {
                this.style.color = '#fff';
                this.style.backgroundColor = 'rgba(165,180,252,0.2)';
            });
            
            toggleBtn.addEventListener('mouseleave', function() {
                this.style.color = '#a5b4fc';
                this.style.backgroundColor = 'transparent';
            });
            
            // Make sure parent has relative positioning
            const parent = passwordInput.parentElement;
            if (parent && getComputedStyle(parent).position !== 'relative') {
                parent.style.position = 'relative';
            }
            
            passwordInput.style.paddingRight = '45px';
            parent.appendChild(toggleBtn);
            
            let isVisible = false;
            toggleBtn.addEventListener('click', function(e) {
                e.preventDefault();
                isVisible = !isVisible;
                passwordInput.type = isVisible ? 'text' : 'password';
                toggleBtn.innerHTML = isVisible ? '<i class="fas fa-eye-slash"></i>' : '<i class="fas fa-eye"></i>';
                toggleBtn.style.transform = 'translateY(-50%) scale(0.95)';
                setTimeout(() => {
                    toggleBtn.style.transform = 'translateY(-50%)';
                }, 150);
            });
        }
    }
    
    // Initialize password toggle
    addPasswordToggle();
    
    /**
     * Add ripple effect to login button
     */
    if (submitBtn) {
        submitBtn.addEventListener('click', function(e) {
            const ripple = document.createElement('span');
            ripple.style.position = 'absolute';
            ripple.style.backgroundColor = 'rgba(255,255,255,0.4)';
            ripple.style.borderRadius = '50%';
            ripple.style.transform = 'scale(0)';
            ripple.style.animation = 'rippleEffect 0.6s linear';
            ripple.style.width = '100px';
            ripple.style.height = '100px';
            ripple.style.left = e.clientX - this.getBoundingClientRect().left - 50 + 'px';
            ripple.style.top = e.clientY - this.getBoundingClientRect().top - 50 + 'px';
            ripple.style.pointerEvents = 'none';
            ripple.style.zIndex = '1';
            
            this.style.position = 'relative';
            this.style.overflow = 'hidden';
            this.appendChild(ripple);
            
            setTimeout(() => {
                ripple.remove();
            }, 600);
        });
    }
    
    /**
     * Add ripple animation keyframes if not exists
     */
    if (!document.querySelector('#rippleKeyframes')) {
        const style = document.createElement('style');
        style.id = 'rippleKeyframes';
        style.textContent = `
            @keyframes rippleEffect {
                0% {
                    transform: scale(0);
                    opacity: 0.8;
                }
                100% {
                    transform: scale(4);
                    opacity: 0;
                }
            }
            
            .shake-effect {
                animation: shake 0.3s ease-in-out;
            }
            
            @keyframes shake {
                0%, 100% { transform: translateX(0); }
                25% { transform: translateX(-5px); }
                75% { transform: translateX(5px); }
            }
            
            .validation-error {
                display: block;
                color: #f87171;
                font-size: 0.75rem;
                margin-top: 5px;
                animation: fadeInUp 0.2s ease;
            }
            
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(-5px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            
            input.error {
                border-color: #f87171 !important;
                background-color: rgba(248,113,113,0.05) !important;
            }
        `;
        document.head.appendChild(style);
    }
    
    /**
     * Add floating glow animation
     */
    const floatingGlow = document.querySelector('.floating-glow');
    if (floatingGlow) {
        setInterval(() => {
            floatingGlow.style.transform = `translate(${Math.sin(Date.now() / 3000) * 10}px, ${Math.cos(Date.now() / 4000) * 10}px)`;
        }, 100);
    }
    
    /**
     * Console branding (for developers)
     */
    console.log('%c🏛️ Admin Nexus | Secure Login Interface Loaded', 
                'color: #a78bfa; font-size: 14px; font-weight: bold; background: #0f0f2c; padding: 4px 12px; border-radius: 20px;');
    
    /**
     * Handle form reset after error (if page doesn't reload)
     * This helps restore button state if there's an AJAX-style error
     */
    if (submitBtn && submitBtn.dataset) {
        // If form submission fails and stays on page, we can restore button
        window.addEventListener('pageshow', function() {
            if (submitBtn && submitBtn.disabled) {
                submitBtn.disabled = false;
                if (submitBtn.dataset.originalText) {
                    submitBtn.innerHTML = submitBtn.dataset.originalText;
                }
            }
        });
    }
    
    /**
     * Pre-fill demo credentials for development (optional)
     * Remove in production
     */
    const isDev = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1';
    if (isDev && usernameInput && passwordInput && !usernameInput.value && !passwordInput.value) {
        // Uncomment for testing - only in development
        // usernameInput.value = 'admin';
        // passwordInput.value = 'admin123';
    }
});
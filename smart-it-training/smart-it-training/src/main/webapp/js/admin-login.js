/**
 * Admin Login Page - Interactive Features
 * Handles form validation, message animations, and UI enhancements
 */

// Wait for DOM to be fully loaded
document.addEventListener('DOMContentLoaded', function() {
    
    // DOM Elements
    const loginForm = document.getElementById('secureLoginForm');
    const userIdInput = document.getElementById('userId');
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
            
            // Get values and trim
            const userId = userIdInput ? userIdInput.value.trim() : '';
            const password = passwordInput ? passwordInput.value.trim() : '';
            
            // Validation checks
            if (userId === '') {
                e.preventDefault();
                showMessage('error', '❌ Please enter your User ID or registered email address.', true);
                if (userIdInput) {
                    userIdInput.focus();
                    userIdInput.style.borderColor = '#f87171';
                    setTimeout(() => {
                        if (userIdInput) userIdInput.style.borderColor = '';
                    }, 2000);
                }
                return false;
            }
            
            if (password === '') {
                e.preventDefault();
                showMessage('error', '❌ Access password cannot be blank. Please enter your credentials.', true);
                if (passwordInput) {
                    passwordInput.focus();
                    passwordInput.style.borderColor = '#f87171';
                    setTimeout(() => {
                        if (passwordInput) passwordInput.style.borderColor = '';
                    }, 2000);
                }
                return false;
            }
            
            // Password length validation (minimum 3 characters for security)
            if (password.length < 3) {
                e.preventDefault();
                showMessage('error', '⚠️ Password must be at least 3 characters long.', true);
                if (passwordInput) {
                    passwordInput.focus();
                    passwordInput.style.borderColor = '#f87171';
                    setTimeout(() => {
                        if (passwordInput) passwordInput.style.borderColor = '';
                    }, 2000);
                }
                return false;
            }
            
            // If validation passes, show loading state on button
            if (submitBtn) {
                const originalBtnText = submitBtn.innerHTML;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-pulse"></i> Authenticating...';
                submitBtn.disabled = true;
                
                // Note: Form will submit to server normally
                // The loading state will be reset if there's an error response
                // For successful submission, page will redirect
                
                // Store original text to restore if needed (though page may reload)
                submitBtn.dataset.originalText = originalBtnText;
            }
        });
    }
    
    /**
     * Input field enhancement - remove error border on focus
     */
    if (userIdInput) {
        userIdInput.addEventListener('focus', function() {
            this.style.borderColor = '';
        });
    }
    
    if (passwordInput) {
        passwordInput.addEventListener('focus', function() {
            this.style.borderColor = '';
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
            const wrapper = document.createElement('div');
            wrapper.style.position = 'relative';
            wrapper.style.width = '100%';
            
            // Get parent and insert wrapper
            const parent = passwordInput.parentNode;
            parent.insertBefore(wrapper, passwordInput);
            wrapper.appendChild(passwordInput);
            
            const toggleBtn = document.createElement('button');
            toggleBtn.type = 'button';
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
            
            passwordInput.style.paddingRight = '45px';
            wrapper.appendChild(toggleBtn);
            
            let isVisible = false;
            toggleBtn.addEventListener('click', function() {
                isVisible = !isVisible;
                passwordInput.type = isVisible ? 'text' : 'password';
                toggleBtn.innerHTML = isVisible ? '<i class="fas fa-eye-slash"></i>' : '<i class="fas fa-eye"></i>';
            });
        }
    }
    
    // Initialize password toggle
    addPasswordToggle();
    
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
});
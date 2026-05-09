/**
 * Forgot Password Page JavaScript
 * Handles OTP verification, password reset, and form interactions
 */

let currentIdentifier = '';

// Get context path for AJAX requests
const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf('/', 1)) || '';

// Wait for DOM to be fully loaded
document.addEventListener('DOMContentLoaded', function() {
    
    // Get URL parameters
    const urlParams = new URLSearchParams(window.location.search);
    const step = urlParams.get('step');
    const identifier = urlParams.get('identifier');
    const error = urlParams.get('error');
    
    if (step === 'otp' && identifier) {
        showStep(2);
        document.getElementById('hiddenIdentifier').value = identifier;
        document.getElementById('resetIdentifier').value = identifier;
        currentIdentifier = identifier;
        
        if (error === 'invalid') {
            showMessage('Invalid OTP. Please try again.', 'error');
        } else if (error === 'expired') {
            showMessage('OTP has expired. Please request a new OTP.', 'error');
        }
    } else if (step === 'reset' && identifier) {
        showStep(3);
        document.getElementById('resetIdentifier').value = identifier;
        currentIdentifier = identifier;
        
        if (error === 'mismatch') {
            showMessage('Passwords do not match!', 'error');
        } else if (error === 'weak') {
            showMessage('Password must be at least 6 characters!', 'error');
        }
    }
    
    // Add form submit handlers for validation
    const resetForm = document.getElementById('resetForm');
    if (resetForm) {
        resetForm.addEventListener('submit', function(e) {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (newPassword !== confirmPassword) {
                e.preventDefault();
                showMessage('Passwords do not match!', 'error');
                addShakeEffect(document.getElementById('confirmPassword'));
            } else if (newPassword.length < 6) {
                e.preventDefault();
                showMessage('Password must be at least 6 characters long!', 'error');
                addShakeEffect(document.getElementById('newPassword'));
            }
        });
    }
    
    // Add input event listener for OTP field
    const otpInput = document.getElementById('otp');
    if (otpInput) {
        otpInput.addEventListener('input', function(e) {
            this.value = this.value.replace(/[^0-9]/g, '').slice(0, 6);
        });
    }
    
    // Auto-hide success/error messages after 5 seconds
    const autoHideMsg = setTimeout(function() {
        const msgs = document.querySelectorAll('.error-message, .success-message');
        msgs.forEach(msg => {
            msg.style.opacity = '0';
            setTimeout(() => msg.remove(), 300);
        });
    }, 5000);
});

/**
 * Show specific step in the forgot password process
 * @param {number} stepNumber - Step number to show (1, 2, or 3)
 */
function showStep(stepNumber) {
    const step1 = document.getElementById('step1');
    const step2 = document.getElementById('step2');
    const step3 = document.getElementById('step3');
    
    if (!step1 || !step2 || !step3) return;
    
    if (stepNumber === 1) {
        step1.style.display = 'block';
        step2.style.display = 'none';
        step3.style.display = 'none';
    } else if (stepNumber === 2) {
        step1.style.display = 'none';
        step2.style.display = 'block';
        step2.classList.add('visible');
        step3.style.display = 'none';
    } else if (stepNumber === 3) {
        step1.style.display = 'none';
        step2.style.display = 'none';
        step3.style.display = 'block';
        step3.classList.add('visible');
    }
}

/**
 * Display success or error message
 * @param {string} message - Message to display
 * @param {string} type - Type of message: 'error' or 'success'
 */
function showMessage(message, type) {
    // Remove existing message
    const existingMsg = document.querySelector('.error-message, .success-message');
    if (existingMsg) existingMsg.remove();
    
    // Create new message element
    const msgDiv = document.createElement('div');
    msgDiv.className = type === 'error' ? 'error-message' : 'success-message';
    const icon = type === 'error' ? 'exclamation-circle' : 'check-circle';
    msgDiv.innerHTML = '<i class="fas fa-' + icon + '"></i> ' + message;
    
    // Insert message at the top of the body
    const forgotBody = document.querySelector('.forgot-body');
    if (forgotBody) {
        forgotBody.insertBefore(msgDiv, forgotBody.firstChild);
    }
    
    // Auto-remove message after 5 seconds
    setTimeout(function() {
        msgDiv.style.opacity = '0';
        setTimeout(function() { 
            if (msgDiv.parentNode) msgDiv.remove(); 
        }, 300);
    }, 5000);
}

/**
 * Resend OTP to user's email
 */
function resendOtp() {
    const identifier = document.getElementById('hiddenIdentifier').value || currentIdentifier;
    
    if (!identifier) {
        showMessage('User identifier not found. Please restart the process.', 'error');
        return;
    }
    
    // Disable the resend link temporarily to prevent spam
    const resendLink = document.querySelector('.resend-otp a');
    if (resendLink) {
        resendLink.style.pointerEvents = 'none';
        resendLink.style.opacity = '0.5';
        
        setTimeout(() => {
            resendLink.style.pointerEvents = 'auto';
            resendLink.style.opacity = '1';
        }, 30000);
    }
    
    fetch(contextPath + '/admin/forgot-password/resend-otp', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'identifier=' + encodeURIComponent(identifier)
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            showMessage('OTP resent successfully! Please check your email.', 'success');
        } else {
            showMessage(data.message || 'Failed to resend OTP. Please try again.', 'error');
            if (resendLink) {
                resendLink.style.pointerEvents = 'auto';
                resendLink.style.opacity = '1';
            }
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showMessage('Something went wrong. Please try again.', 'error');
        if (resendLink) {
            resendLink.style.pointerEvents = 'auto';
            resendLink.style.opacity = '1';
        }
    });
}

/**
 * Add shake animation to an element
 * @param {HTMLElement} element - Element to shake
 */
function addShakeEffect(element) {
    if (!element) return;
    element.classList.add('shake-effect');
    setTimeout(() => {
        element.classList.remove('shake-effect');
    }, 300);
}

// Export functions for global use
window.showStep = showStep;
window.showMessage = showMessage;
window.resendOtp = resendOtp;
window.addShakeEffect = addShakeEffect;
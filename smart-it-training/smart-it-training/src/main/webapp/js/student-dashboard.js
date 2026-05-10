// Get DOM elements
const forgotForm = document.getElementById('forgotForm');
const resetBtn = document.getElementById('resetBtn');
const emailInput = document.getElementById('email');

// Show error message function
function showErrorAlert(message) {
    let existingAlert = document.querySelector('.alert-error');
    if (existingAlert) existingAlert.remove();
    
    const alertDiv = document.createElement('div');
    alertDiv.className = 'alert alert-error';
    alertDiv.innerHTML = '<i class="fas fa-exclamation-circle"></i><span>' + message + '</span>';
    const bodyDiv = document.querySelector('.forgot-body');
    const formElement = document.querySelector('form');
    bodyDiv.insertBefore(alertDiv, formElement);
    
    setTimeout(() => {
        alertDiv.style.opacity = '0';
        setTimeout(() => {
            if (alertDiv.parentNode) alertDiv.remove();
        }, 300);
    }, 4000);
}

// Show success message function
function showSuccessAlert(message) {
    let existingAlert = document.querySelector('.alert-success');
    if (existingAlert) existingAlert.remove();
    
    const alertDiv = document.createElement('div');
    alertDiv.className = 'alert alert-success';
    alertDiv.innerHTML = '<i class="fas fa-check-circle"></i><span>' + message + '</span>';
    const bodyDiv = document.querySelector('.forgot-body');
    const formElement = document.querySelector('form');
    bodyDiv.insertBefore(alertDiv, formElement);
    
    setTimeout(() => {
        alertDiv.style.opacity = '0';
        setTimeout(() => {
            if (alertDiv.parentNode) alertDiv.remove();
        }, 300);
    }, 4000);
}

// Form validation and submission
if (forgotForm) {
    forgotForm.addEventListener('submit', function(e) {
        const email = emailInput.value.trim();
        
        // Check if email is empty
        if (!email) {
            e.preventDefault();
            showErrorAlert('Please enter your email address');
            return false;
        }
        
        // Check if email is valid format
        if (!email.includes('@') || !email.includes('.')) {
            e.preventDefault();
            showErrorAlert('Please enter a valid email address');
            return false;
        }
        
        // Show loading state on button
        if (resetBtn) {
            resetBtn.innerHTML = '<span>Sending...</span> <i class="fas fa-spinner fa-pulse"></i>';
            resetBtn.disabled = true;
            
            // Reset button after 8 seconds if stuck
            setTimeout(() => {
                if (resetBtn.disabled) {
                    resetBtn.innerHTML = '<span>Send Reset Link</span> <i class="fas fa-paper-plane"></i>';
                    resetBtn.disabled = false;
                }
            }, 8000);
        }
    });
}

// Input focus effects
const allInputs = document.querySelectorAll('.form-group input');
allInputs.forEach(input => {
    input.addEventListener('focus', function() {
        this.style.transform = 'translateY(-2px)';
        const icon = this.parentElement.querySelector('.input-icon');
        if (icon) icon.style.color = '#3B82F6';
    });
    
    input.addEventListener('blur', function() {
        this.style.transform = 'translateY(0)';
        const icon = this.parentElement.querySelector('.input-icon');
        if (icon) icon.style.color = '#9CA3AF';
    });
    
    // Ripple effect on click
    input.addEventListener('click', function(e) {
        createRipple(e.clientX, e.clientY);
    });
});

// Ripple effect on button
if (resetBtn) {
    resetBtn.addEventListener('click', function(e) {
        createRipple(e.clientX, e.clientY);
    });
}

// Create ripple animation
function createRipple(x, y) {
    const ripple = document.createElement('div');
    ripple.style.position = 'fixed';
    ripple.style.width = '8px';
    ripple.style.height = '8px';
    ripple.style.backgroundColor = '#3B82F6';
    ripple.style.borderRadius = '50%';
    ripple.style.pointerEvents = 'none';
    ripple.style.zIndex = '9999';
    ripple.style.left = x + 'px';
    ripple.style.top = y + 'px';
    ripple.style.transform = 'translate(-50%, -50%)';
    ripple.style.animation = 'rippleAnim 0.6s ease-out forwards';
    document.body.appendChild(ripple);
    
    setTimeout(() => {
        if (ripple.parentNode) ripple.remove();
    }, 600);
}

// Add ripple animation keyframes
const styleSheet = document.createElement("style");
styleSheet.textContent = `
    @keyframes rippleAnim {
        0% {
            width: 0px;
            height: 0px;
            opacity: 0.8;
            background-color: #3B82F6;
        }
        100% {
            width: 100px;
            height: 100px;
            opacity: 0;
            background-color: transparent;
        }
    }
`;
document.head.appendChild(styleSheet);

// Auto-focus email field for better UX
setTimeout(() => {
    if (emailInput) emailInput.focus();
}, 300);

// Link hover animations
const links = document.querySelectorAll('.action-link a');
links.forEach(link => {
    link.addEventListener('mouseenter', function() {
        this.style.transform = 'translateX(3px)';
        this.style.transition = 'transform 0.2s ease';
    });
    link.addEventListener('mouseleave', function() {
        this.style.transform = 'translateX(0)';
    });
});

// Real-time email validation
if (emailInput) {
    emailInput.addEventListener('input', function() {
        const email = this.value.trim();
        const infoText = document.querySelector('.info-text');
        
        if (email && (!email.includes('@') || !email.includes('.'))) {
            infoText.style.color = '#DC2626';
            infoText.innerHTML = '<i class="fas fa-exclamation-triangle"></i> Please enter a valid email address';
        } else if (email && email.includes('@') && email.includes('.') && email.length > 5) {
            infoText.style.color = '#10B981';
            infoText.innerHTML = '<i class="fas fa-check-circle"></i> Valid email format';
        } else {
            infoText.style.color = '#6B7280';
            infoText.innerHTML = '<i class="fas fa-info-circle"></i> We\'ll send a password reset link to this email';
        }
    });
}

// Console greeting
console.log("%c🔐 Smart IT Training | Password Reset Portal Ready", "color: #3B82F6; font-size: 13px; font-weight: bold;");
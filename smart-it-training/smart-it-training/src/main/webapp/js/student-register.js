// Password match validation with visual feedback
const passwordField = document.getElementById('password');
const confirmField = document.getElementById('confirmPassword');
const regBtn = document.getElementById('registerBtn');
const regForm = document.getElementById('registerForm');

function validateMatch() {
    if (passwordField && confirmField) {
        if (passwordField.value && confirmField.value && passwordField.value !== confirmField.value) {
            confirmField.style.borderColor = '#DC2626';
            confirmField.style.backgroundColor = '#FEF2F2';
            confirmField.style.boxShadow = '0 0 0 3px rgba(220,38,38,0.1)';
            return false;
        } else if (confirmField.value && passwordField.value === confirmField.value) {
            confirmField.style.borderColor = '#10B981';
            confirmField.style.backgroundColor = '#FFFFFF';
            confirmField.style.boxShadow = '0 0 0 3px rgba(16,185,129,0.1)';
            return true;
        } else {
            confirmField.style.borderColor = '#E5E7EB';
            confirmField.style.backgroundColor = '#FFFFFF';
            confirmField.style.boxShadow = 'none';
            return passwordField.value === confirmField.value;
        }
    }
    return true;
}

if (passwordField && confirmField) {
    passwordField.addEventListener('input', validateMatch);
    confirmField.addEventListener('input', validateMatch);
}

// Form submit with validation and loading effect
if (regForm) {
    regForm.addEventListener('submit', function(e) {
        if (passwordField && confirmField && passwordField.value !== confirmField.value) {
            e.preventDefault();
            
            // Check if error alert already exists
            let existingAlert = document.querySelector('.alert-error');
            if (!existingAlert || !existingAlert.innerText.includes('Passwords do not match')) {
                const alertDiv = document.createElement('div');
                alertDiv.className = 'alert alert-error';
                alertDiv.innerHTML = '<i class="fas fa-exclamation-circle"></i><span>🔐 Passwords do not match. Please check and try again.</span>';
                const bodyDiv = document.querySelector('.register-body');
                const oldAlert = bodyDiv.querySelector('.alert');
                if (oldAlert) oldAlert.remove();
                bodyDiv.insertBefore(alertDiv, bodyDiv.firstChild);
                
                // Auto remove after 4 seconds
                setTimeout(() => {
                    alertDiv.style.opacity = '0';
                    setTimeout(() => {
                        if (alertDiv.parentNode) alertDiv.remove();
                    }, 300);
                }, 4000);
            }
            return false;
        }
        
        // Show loading animation on button
        const submitButton = document.getElementById('registerBtn');
        if (submitButton) {
            submitButton.innerHTML = '<span>Creating Account...</span> <i class="fas fa-spinner fa-pulse"></i>';
            submitButton.disabled = true;
            
            // Timeout to reset if something goes wrong (prevents stuck state)
            setTimeout(() => {
                if (submitButton.disabled) {
                    submitButton.innerHTML = '<span>Create Account</span> <i class="fas fa-arrow-right"></i>';
                    submitButton.disabled = false;
                }
            }, 8000);
        }
    });
}

// Interactive input effects - focus animation
const allInputs = document.querySelectorAll('.form-group input, .form-group select');
allInputs.forEach(input => {
    input.addEventListener('focus', function() {
        this.style.transform = 'translateY(-2px)';
    });
    input.addEventListener('blur', function() {
        this.style.transform = 'translateY(0)';
    });
    
    // Ripple effect on click
    input.addEventListener('click', function(e) {
        createRipple(e.clientX, e.clientY);
    });
});

// Button ripple effect
const btn = document.querySelector('.register-btn');
if (btn) {
    btn.addEventListener('click', function(e) {
        createRipple(e.clientX, e.clientY);
    });
}

// Ripple animation function
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

// Add keyframe for ripple animation dynamically
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

// Auto-focus first field for better UX
setTimeout(() => {
    const firstInput = document.querySelector('.form-group input');
    if (firstInput) firstInput.focus();
}, 300);

// Console greeting
console.log("%c✨ Smart IT Training | Registration Portal Ready ✨", "color: #3B82F6; font-size: 14px; font-weight: bold;");

// Password strength indicator (optional enhancement)
const passwordStrength = document.getElementById('password');
if (passwordStrength) {
    passwordStrength.addEventListener('input', function() {
        const val = this.value;
        const hintSpan = this.parentElement.querySelector('.password-hint');
        if (val.length > 0 && val.length < 6) {
            hintSpan.style.color = '#DC2626';
            hintSpan.innerHTML = '<i class="fas fa-exclamation-triangle"></i> Password too short (min 6 characters)';
        } else if (val.length >= 6) {
            hintSpan.style.color = '#10B981';
            hintSpan.innerHTML = '<i class="fas fa-check-circle"></i> Password strength: Good';
        } else {
            hintSpan.style.color = '#6B7280';
            hintSpan.innerHTML = '<i class="fas fa-shield-alt"></i> Minimum 6 characters';
        }
    });
}
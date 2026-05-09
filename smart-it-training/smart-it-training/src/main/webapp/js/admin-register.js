// Wait for DOM to be fully loaded
document.addEventListener('DOMContentLoaded', function() {
    // Get form elements
    const form = document.getElementById('registerForm');
    
    // Check if we're on the registration page
    if (!form) {
        console.log('Registration form not found');
        return;
    }
    
    // Get all form fields
    const nameInput = document.getElementById('name');
    const contactInput = document.getElementById('contact');
    const emailInput = document.getElementById('email');
    const officeNameInput = document.getElementById('officeName');
    const usernameInput = document.getElementById('username');
    const passwordInput = document.getElementById('password');
    const confirmPasswordInput = document.getElementById('confirmPassword');
    const termsCheckbox = document.getElementById('termsCheckbox');
    const submitBtn = document.getElementById('submitBtn');
    
    // Password strength meter elements
    const strengthBar = document.querySelector('.strength-bar');
    const strengthText = document.querySelector('.strength-text');
    
    // Toggle password visibility
    const toggleButtons = document.querySelectorAll('.toggle-password');
    
    toggleButtons.forEach(function(button) {
        button.addEventListener('click', function() {
            const targetId = this.getAttribute('data-target');
            const targetInput = document.getElementById(targetId);
            const icon = this.querySelector('i');
            
            if (targetInput && targetInput.type === 'password') {
                targetInput.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else if (targetInput) {
                targetInput.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        });
    });
    
    // Password strength checker function
    function checkPasswordStrength(password) {
        let strength = 0;
        let message = '';
        
        if (password.length >= 6) strength++;
        if (password.length >= 10) strength++;
        if (/[a-z]/.test(password)) strength++;
        if (/[A-Z]/.test(password)) strength++;
        if (/[0-9]/.test(password)) strength++;
        if (/[^a-zA-Z0-9]/.test(password)) strength++;
        
        if (password.length === 0) {
            message = '';
            strength = 0;
        } else if (strength <= 2) {
            message = 'Weak password';
            strength = 1;
        } else if (strength <= 4) {
            message = 'Medium password';
            strength = 2;
        } else {
            message = 'Strong password';
            strength = 3;
        }
        
        return { strength: strength, message: message };
    }
    
    // Update password strength meter
    function updateStrengthMeter() {
        if (!passwordInput || !strengthBar) return;
        
        const password = passwordInput.value;
        const result = checkPasswordStrength(password);
        
        let width = '0%';
        let color = '#e0e0e0';
        
        switch(result.strength) {
            case 1:
                width = '33%';
                color = '#f56565';
                break;
            case 2:
                width = '66%';
                color = '#fbbf24';
                break;
            case 3:
                width = '100%';
                color = '#48bb78';
                break;
            default:
                width = '0%';
                color = '#e0e0e0';
        }
        
        strengthBar.style.width = width;
        strengthBar.style.backgroundColor = color;
        
        if (strengthText) {
            strengthText.textContent = result.message;
            strengthText.style.color = color;
        }
    }
    
    // Helper function to show error message
    function showError(input, message) {
        if (!input) return;
        removeError(input);
        input.classList.add('error');
        
        const errorSpan = document.createElement('span');
        errorSpan.className = 'error-message';
        errorSpan.innerHTML = '<i class="fas fa-exclamation-circle"></i> ' + message;
        
        input.parentNode.insertBefore(errorSpan, input.nextSibling);
    }
    
    // Helper function to remove error
    function removeError(input) {
        if (!input) return;
        input.classList.remove('error');
        const existingError = input.parentNode.querySelector('.error-message');
        if (existingError) {
            existingError.remove();
        }
    }
    
    // Validation functions
    function validateContact(contact) {
        var phoneRegex = /^[0-9]{10}$/;
        return phoneRegex.test(contact);
    }
    
    function validateEmail(email) {
        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }
    
    function validateUsername(username) {
        var usernameRegex = /^[a-zA-Z0-9_]{3,20}$/;
        return usernameRegex.test(username);
    }
    
    function validatePassword(password) {
        return password.length >= 6;
    }
    
    // Real-time validation events
    if (contactInput) {
        contactInput.addEventListener('blur', function() {
            var contact = this.value.trim();
            if (contact && !validateContact(contact)) {
                showError(this, 'Please enter a valid 10-digit mobile number');
            } else {
                removeError(this);
            }
        });
    }
    
    if (emailInput) {
        emailInput.addEventListener('blur', function() {
            var email = this.value.trim();
            if (email && !validateEmail(email)) {
                showError(this, 'Please enter a valid email address');
            } else {
                removeError(this);
            }
        });
    }
    
    if (usernameInput) {
        usernameInput.addEventListener('blur', function() {
            var username = this.value.trim();
            if (username && !validateUsername(username)) {
                showError(this, 'Username must be 3-20 characters (letters, numbers, underscore only)');
            } else {
                removeError(this);
            }
        });
    }
    
    if (passwordInput) {
        passwordInput.addEventListener('input', function() {
            var password = this.value;
            updateStrengthMeter();
            
            if (password && !validatePassword(password)) {
                showError(this, 'Password must be at least 6 characters long');
            } else {
                removeError(this);
            }
            
            if (confirmPasswordInput && confirmPasswordInput.value) {
                triggerConfirmValidation();
            }
        });
    }
    
    function triggerConfirmValidation() {
        if (!passwordInput || !confirmPasswordInput) return;
        
        var password = passwordInput.value;
        var confirmPassword = confirmPasswordInput.value;
        
        if (confirmPassword) {
            if (password !== confirmPassword) {
                showError(confirmPasswordInput, 'Passwords do not match!');
            } else {
                removeError(confirmPasswordInput);
            }
        }
    }
    
    if (confirmPasswordInput) {
        confirmPasswordInput.addEventListener('input', triggerConfirmValidation);
    }
    
    // Form submission handler
    if (form) {
        form.addEventListener('submit', function(event) {
            var isValid = true;
            
            // Get all values
            var name = nameInput ? nameInput.value.trim() : '';
            var contact = contactInput ? contactInput.value.trim() : '';
            var email = emailInput ? emailInput.value.trim() : '';
            var officeName = officeNameInput ? officeNameInput.value.trim() : '';
            var username = usernameInput ? usernameInput.value.trim() : '';
            var password = passwordInput ? passwordInput.value : '';
            var confirmPassword = confirmPasswordInput ? confirmPasswordInput.value : '';
            
            // Remove all existing errors
            var allInputs = form.querySelectorAll('input:not([type="checkbox"])');
            for (var i = 0; i < allInputs.length; i++) {
                removeError(allInputs[i]);
            }
            
            // Validate name
            if (!name) {
                showError(nameInput, 'Full name is required');
                isValid = false;
            }
            
            // Validate contact
            if (!contact) {
                showError(contactInput, 'Contact number is required');
                isValid = false;
            } else if (!validateContact(contact)) {
                showError(contactInput, 'Please enter a valid 10-digit mobile number');
                isValid = false;
            }
            
            // Validate email
            if (!email) {
                showError(emailInput, 'Email address is required');
                isValid = false;
            } else if (!validateEmail(email)) {
                showError(emailInput, 'Please enter a valid email address');
                isValid = false;
            }
            
            // Validate office name
            if (!officeName) {
                showError(officeNameInput, 'Office name is required');
                isValid = false;
            }
            
            // Validate username
            if (!username) {
                showError(usernameInput, 'Username is required');
                isValid = false;
            } else if (!validateUsername(username)) {
                showError(usernameInput, 'Username must be 3-20 characters (letters, numbers, underscore only)');
                isValid = false;
            }
            
            // Validate password
            if (!password) {
                showError(passwordInput, 'Password is required');
                isValid = false;
            } else if (!validatePassword(password)) {
                showError(passwordInput, 'Password must be at least 6 characters');
                isValid = false;
            }
            
            // Validate confirm password
            if (!confirmPassword) {
                showError(confirmPasswordInput, 'Please confirm your password');
                isValid = false;
            } else if (password !== confirmPassword) {
                showError(confirmPasswordInput, 'Passwords do not match!');
                isValid = false;
            }
            
            // Validate terms checkbox
            if (termsCheckbox && !termsCheckbox.checked) {
                alert('Please agree to the Terms of Service and Privacy Policy');
                isValid = false;
            }
            
            // Prevent form submission if validation fails
            if (!isValid) {
                event.preventDefault();
                
                // Scroll to first error
                var firstError = form.querySelector('.error');
                if (firstError) {
                    firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            } else {
                // Show loading state on button
                if (submitBtn) {
                    var btnText = submitBtn.querySelector('.btn-text');
                    var btnLoader = submitBtn.querySelector('.btn-loader');
                    if (btnText && btnLoader) {
                        btnText.style.display = 'none';
                        btnLoader.style.display = 'inline';
                        submitBtn.disabled = true;
                    }
                }
            }
        });
    }
    
    // Remove error on input
    var allInputFields = document.querySelectorAll('input:not([type="checkbox"])');
    for (var i = 0; i < allInputFields.length; i++) {
        allInputFields[i].addEventListener('input', function() {
            removeError(this);
        });
    }
    
    // Create ripple effect for buttons
    var buttons = document.querySelectorAll('.register-btn');
    for (var i = 0; i < buttons.length; i++) {
        buttons[i].addEventListener('click', function(event) {
            if (!this.disabled) {
                var ripple = document.createElement('span');
                ripple.classList.add('ripple');
                this.appendChild(ripple);
                
                var rect = this.getBoundingClientRect();
                var x = event.clientX - rect.left;
                var y = event.clientY - rect.top;
                
                ripple.style.left = x + 'px';
                ripple.style.top = y + 'px';
                
                setTimeout(function() {
                    ripple.remove();
                }, 600);
            }
        });
    }
});
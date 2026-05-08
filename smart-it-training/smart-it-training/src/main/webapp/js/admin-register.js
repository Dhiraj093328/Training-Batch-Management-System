document.addEventListener('DOMContentLoaded', function() {
    
    // Auto-hide alerts
    var errorAlert = document.querySelector('.alert-error');
    if (errorAlert) {
        setTimeout(function() {
            errorAlert.style.opacity = '0';
            setTimeout(function() {
                if (errorAlert) errorAlert.style.display = 'none';
            }, 500);
        }, 5000);
    }
    
    // Password Strength Meter
    var passwordInput = document.getElementById('password');
    var strengthBars = document.querySelectorAll('.strength-bar');
    
    function checkPasswordStrength(password) {
        var strength = 0;
        if (password.length >= 6) strength++;
        if (password.length >= 8) strength++;
        if (/[0-9]/.test(password)) strength++;
        if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
        if (/[^a-zA-Z0-9]/.test(password)) strength++;
        return Math.min(strength, 3);
    }
    
    if (passwordInput) {
        passwordInput.addEventListener('input', function() {
            var strength = checkPasswordStrength(this.value);
            for (var i = 0; i < strengthBars.length; i++) {
                strengthBars[i].className = 'strength-bar';
                if (i < strength) {
                    if (strength === 1) strengthBars[i].classList.add('weak');
                    else if (strength === 2) strengthBars[i].classList.add('medium');
                    else if (strength === 3) strengthBars[i].classList.add('strong');
                }
            }
        });
    }
    
    // Phone number formatting
    var contactInput = document.getElementById('contactNo');
    if (contactInput) {
        contactInput.addEventListener('input', function(e) {
            this.value = this.value.replace(/[^0-9]/g, '').slice(0, 10);
        });
    }
    
    // Form validation
    var registerForm = document.getElementById('registerForm');
    
    function validatePhoneNumber(phone) {
        return /^[6-9][0-9]{9}$/.test(phone);
    }
    
    function validateEmail(email) {
        return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
    }
    
    function showFieldError(fieldId, message) {
        var field = document.getElementById(fieldId);
        field.style.borderColor = '#ff4444';
        
        var parentDiv = field.parentElement;
        var existingError = parentDiv.parentElement.querySelector('.field-error');
        if (existingError) existingError.remove();
        
        var errorSpan = document.createElement('span');
        errorSpan.className = 'field-error';
        errorSpan.innerHTML = '<i class="fas fa-exclamation-circle"></i> ' + message;
        parentDiv.parentElement.appendChild(errorSpan);
        
        field.addEventListener('input', function() {
            field.style.borderColor = '';
            var err = parentDiv.parentElement.querySelector('.field-error');
            if (err) err.remove();
        }, { once: true });
    }
    
    if (registerForm) {
        registerForm.addEventListener('submit', function(e) {
            var isValid = true;
            
            var adminOfficeName = document.getElementById('adminOfficeName').value.trim();
            if (adminOfficeName === '') {
                showFieldError('adminOfficeName', 'Please enter Admin Office Name');
                isValid = false;
            }
            
            var contactNo = document.getElementById('contactNo').value.trim();
            if (!validatePhoneNumber(contactNo)) {
                showFieldError('contactNo', 'Enter valid 10-digit mobile number starting with 6,7,8,9');
                isValid = false;
            }
            
            var email = document.getElementById('email').value.trim();
            if (!validateEmail(email)) {
                showFieldError('email', 'Enter valid email address');
                isValid = false;
            }
            
            var userId = document.getElementById('userId').value.trim();
            if (userId.length < 4) {
                showFieldError('userId', 'User ID must be at least 4 characters');
                isValid = false;
            }
            
            var password = document.getElementById('password').value;
            if (password.length < 6) {
                showFieldError('password', 'Password must be at least 6 characters');
                isValid = false;
            }
            
            var confirmPassword = document.getElementById('confirmPassword').value;
            if (password !== confirmPassword) {
                showFieldError('confirmPassword', 'Passwords do not match');
                isValid = false;
            }
            
            if (!isValid) {
                e.preventDefault();
            } else {
                var submitBtn = document.getElementById('registerBtn');
                submitBtn.innerHTML = '<span class="loading-spinner"></span> Registering...';
                submitBtn.disabled = true;
            }
        });
    }
});
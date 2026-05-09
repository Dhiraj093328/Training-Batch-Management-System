<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Registration | Smart IT Training</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-register.css">
</head>
<body>
    <!-- Animated Background Elements -->
    <div class="animated-bg">
        <div class="gradient-bg"></div>
        <div class="particles">
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
            <div class="particle"></div>
        </div>
        <div class="floating-shapes">
            <div class="shape shape-1"></div>
            <div class="shape shape-2"></div>
            <div class="shape shape-3"></div>
            <div class="shape shape-4"></div>
        </div>
    </div>

    <div class="register-container">
        <div class="register-card">
            <div class="register-header">
                <div class="icon-wrapper">
                    <i class="fas fa-user-shield"></i>
                </div>
                <h1>Admin Registration</h1>
                <p>Create your administrative account</p>
            </div>
            
            <div class="register-body">
                <!-- Error Messages -->
                <% if(request.getParameter("error") != null) { %>
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-circle"></i>
                        <% if(request.getParameter("error").equals("exists")) { %>
                            Username already exists! Please choose a different username.
                        <% } else if(request.getParameter("error").equals("email")) { %>
                            Email already registered! Please use a different email.
                        <% } else if(request.getParameter("error").equals("password")) { %>
                            Passwords do not match! Please try again.
                        <% } else if(request.getParameter("error").equals("weak")) { %>
                            Password must be at least 6 characters long.
                        <% } else { %>
                            Registration failed. Please try again.
                        <% } %>
                    </div>
                <% } %>
                
                <!-- Registration Form -->
                <form id="registerForm" action="${pageContext.request.contextPath}/admin/register" method="post">
                    <div class="form-row">
                        <div class="form-group">
                            <label><i class="fas fa-user"></i> Full Name</label>
                            <input type="text" name="name" id="name" required placeholder="Enter your full name">
                            <div class="input-focus-effect"></div>
                        </div>
                        
                        <div class="form-group">
                            <label><i class="fas fa-phone"></i> Contact Number</label>
                            <input type="tel" name="contact" id="contact" required placeholder="Enter 10-digit mobile number">
                            <div class="input-focus-effect"></div>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label><i class="fas fa-envelope"></i> Email Address</label>
                            <input type="email" name="email" id="email" required placeholder="admin@example.com">
                            <div class="input-focus-effect"></div>
                        </div>
                        
                        <div class="form-group">
                            <label><i class="fas fa-building"></i> Office Name</label>
                            <input type="text" name="officeName" id="officeName" required placeholder="e.g., Head Office">
                            <div class="input-focus-effect"></div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-user-circle"></i> Username</label>
                        <input type="text" name="username" id="username" required placeholder="Choose a username">
                        <span class="password-hint"><i class="fas fa-info-circle"></i> This will be used for login</span>
                        <div class="input-focus-effect"></div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label><i class="fas fa-lock"></i> Password</label>
                            <div class="password-wrapper">
                                <input type="password" name="password" id="password" required placeholder="Choose a strong password">
                                <button type="button" class="toggle-password" data-target="password">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                            <span class="password-hint"><i class="fas fa-info-circle"></i> Minimum 6 characters</span>
                            <div class="password-strength">
                                <div class="strength-bar"></div>
                                <div class="strength-text"></div>
                            </div>
                            <div class="input-focus-effect"></div>
                        </div>
                        
                        <div class="form-group">
                            <label><i class="fas fa-check-circle"></i> Confirm Password</label>
                            <div class="password-wrapper">
                                <input type="password" name="confirmPassword" id="confirmPassword" required placeholder="Re-enter your password">
                                <button type="button" class="toggle-password" data-target="confirmPassword">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                            <div class="input-focus-effect"></div>
                        </div>
                    </div>
                    
                    <div class="form-group checkbox-group">
                        <label class="checkbox-label">
                            <input type="checkbox" id="termsCheckbox" required>
                            <span class="checkmark"></span>
                            I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>
                        </label>
                    </div>
                    
                    <button type="submit" class="register-btn" id="submitBtn">
                        <span class="btn-text"><i class="fas fa-user-plus"></i> Register Admin Account</span>
                        <span class="btn-loader" style="display: none;">
                            <i class="fas fa-spinner fa-spin"></i> Registering...
                        </span>
                    </button>
                </form>
                
                <div class="login-link">
                    Already have an account? <a href="${pageContext.request.contextPath}/jsp/admin/admin-login.jsp"><i class="fas fa-sign-in-alt"></i> Login here</a>
                </div>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/js/admin-register.js"></script>
</body>
</html>
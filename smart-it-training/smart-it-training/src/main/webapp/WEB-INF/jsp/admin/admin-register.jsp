<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Registration | Smart IT Training</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-register.css">
</head>
<body>
    <div class="register-container">
        <div class="register-card">
            <div class="register-header">
                <i class="fas fa-user-shield"></i>
                <h1>Admin Registration</h1>
                <p>Create your administrative account</p>
            </div>
            
            <div class="register-body">
                <% if(request.getParameter("error") != null) { %>
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-circle"></i>
                        <% if(request.getParameter("error").equals("exists")) { %>
                            Username already exists! Please choose a different username.
                        <% } else if(request.getParameter("error").equals("email")) { %>
                            Email already registered! Please use a different email.
                        <% } else if(request.getParameter("error").equals("password")) { %>
                            Passwords do not match!
                        <% } else { %>
                            Registration failed. Please try again.
                        <% } %>
                    </div>
                <% } %>
                
                <form action="${pageContext.request.contextPath}/admin/register" method="post">
                    <div class="form-group">
                        <label><i class="fas fa-user"></i> Full Name</label>
                        <input type="text" name="name" required placeholder="Enter your full name">
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-phone"></i> Contact Number</label>
                        <input type="tel" name="contact" required placeholder="Enter 10-digit mobile number">
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-envelope"></i> Email Address</label>
                        <input type="email" name="email" required placeholder="Enter your email">
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-building"></i> Office Name</label>
                        <input type="text" name="officeName" required placeholder="e.g., Head Office, Branch Office">
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-user-circle"></i> Username</label>
                        <input type="text" name="username" required placeholder="Choose a username">
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-lock"></i> Password</label>
                        <input type="password" name="password" required placeholder="Choose a strong password">
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-check-circle"></i> Confirm Password</label>
                        <input type="password" name="confirmPassword" required placeholder="Re-enter password">
                    </div>
                    
                    <button type="submit" class="register-btn">
                        <i class="fas fa-user-plus"></i> Register Account
                    </button>
                </form>
                
                <div class="login-link">
                    Already have an account? <a href="${pageContext.request.contextPath}/admin/login">Login here</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
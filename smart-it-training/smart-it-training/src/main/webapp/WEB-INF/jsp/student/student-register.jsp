<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <title>Join Smart IT | Student Registration</title>
    
    <!-- External CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-register.css">
    
    <!-- Google Fonts + Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>

<!-- ATTRACTIVE BACKGROUND ANIMATION -->
<div class="bg-animation">
    <div class="gradient-orb orb-purple"></div>
    <div class="gradient-orb orb-blue"></div>
    <div class="gradient-orb orb-pink"></div>
    <div class="tech-grid"></div>
    <div class="glow-line" style="top: 15%; animation-delay: 0s;"></div>
    <div class="glow-line" style="top: 45%; animation-delay: 3s; width: 80%; left: 10%;"></div>
    <div class="glow-line" style="top: 75%; animation-delay: 6s; width: 60%; left: 20%;"></div>
    
    <!-- Floating tech cubes -->
    <div class="floating-cube" style="width: 60px; height: 60px; left: 5%; animation-duration: 18s;"></div>
    <div class="floating-cube" style="width: 40px; height: 40px; right: 8%; animation-duration: 22s; top: 30%;"></div>
    <div class="floating-cube" style="width: 80px; height: 80px; left: 80%; animation-duration: 25s; top: 60%;"></div>
    <div class="floating-cube" style="width: 30px; height: 30px; left: 15%; animation-duration: 16s; top: 70%;"></div>
</div>

<div class="register-container">
    <div class="register-header">
        <div class="header-icon">
            <i class="fas fa-user-plus"></i>
        </div>
        <h1>Start Your Journey</h1>
        <p>Student Register here</p>
    </div>
    
    <div class="register-body">
        <!-- Error / Success Messages -->
        <c:if test="${not empty error}">
            <c:choose>
                <c:when test="${error eq 'exists'}">
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>✏️ Username already taken. Please choose another one.</span>
                    </div>
                </c:when>
                <c:when test="${error eq 'email'}">
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>📧 Email is already registered. Try logging in instead.</span>
                    </div>
                </c:when>
                <c:when test="${error eq 'password'}">
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>🔐 Passwords do not match. Please check and try again.</span>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>⚠️ Registration failed. Please check your details.</span>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                <span>🎉 Registration successful! Please wait for admin approval.</span>
            </div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/student/register" method="post" id="registerForm">
            <!-- Row 1: Full Name + Contact -->
            <div class="form-row">
                <div class="form-group">
                    <label><i class="fas fa-user"></i> Full Name</label>
                    <input type="text" name="name" required placeholder="Enter your full name">
                </div>
                <div class="form-group">
                    <label><i class="fas fa-phone-alt"></i> Contact Number</label>
                    <input type="tel" name="contact" required placeholder="10-digit number">
                </div>
            </div>

            <!-- Row 2: Email + Admin Office -->
            <div class="form-row">
                <div class="form-group">
                    <label><i class="fas fa-envelope"></i> Email Address</label>
                    <input type="email" name="email" required placeholder="you@smartit.com">
                </div>
                <div class="form-group">
                    <label><i class="fas fa-building"></i> Admin Office</label>
                    <input type="text" name="adminOfficeName" required placeholder="e.g., Main Branch">
                </div>
            </div>

            <!-- Row 3: Batch + Username -->
            <div class="form-row">
                <div class="form-group">
                    <label><i class="fas fa-layer-group"></i> Batch / Course</label>
                    <select name="batchName" required>
                        <option value="" disabled selected>— Select your course —</option>
                        <option value="Java Full Stack">☕ Java Full Stack</option>
                        <option value="Python Full Stack">🐍 Python Full Stack</option>
                        <option value="MERN Stack">⚛️ MERN Stack</option>
                        <option value="Cloud Computing">☁️ Cloud Computing</option>
                        <option value="Data Science">📊 Data Science</option>
                        <option value="Cybersecurity">🛡️ Cybersecurity</option>
                        <option value="DevOps">🚀 DevOps Engineering</option>
                        <option value="AI & Machine Learning">🤖 AI & ML</option>
                    </select>
                </div>
                <div class="form-group">
                    <label><i class="fas fa-user-circle"></i> Username</label>
                    <input type="text" name="username" required placeholder="Choose username">
                </div>
            </div>

            <!-- Row 4: Password + Confirm -->
            <div class="form-row">
                <div class="form-group">
                    <label><i class="fas fa-lock"></i> Password</label>
                    <input type="password" name="password" id="password" required placeholder="Create password">
                    <span class="password-hint"><i class="fas fa-shield-alt"></i> Minimum 6 characters</span>
                </div>
                <div class="form-group">
                    <label><i class="fas fa-check-circle"></i> Confirm Password</label>
                    <input type="password" name="confirmPassword" id="confirmPassword" required placeholder="Retype password">
                </div>
            </div>

            <button type="submit" class="register-btn" id="registerBtn">
                <span>Create Account</span> <i class="fas fa-arrow-right"></i>
            </button>
            
            <div class="login-link">
                <a href="${pageContext.request.contextPath}/student/login">
                    <i class="fas fa-sign-in-alt"></i> Already have an account? Login
                </a>
            </div>
            
            <div class="security-badge">
                <span><i class="fas fa-shield-alt"></i> SSL Encrypted</span>
                <span><i class="fas fa-database"></i> Data Protected</span>
                <span><i class="fas fa-cloud-upload-alt"></i> 24/7 Support</span>
                <span><i class="fas fa-clock"></i> Instant Access</span>
            </div>
        </form>
    </div>
</div>

<!-- External JavaScript -->
<script src="${pageContext.request.contextPath}/js/student-register.js"></script>
</body>
</html>
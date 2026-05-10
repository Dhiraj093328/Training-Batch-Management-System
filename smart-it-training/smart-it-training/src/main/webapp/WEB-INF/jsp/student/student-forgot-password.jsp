<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <title>Reset Password | Student Portal</title>
    
    <!-- External CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-forgot-password.css">
    
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
    
    <!-- Floating cubes -->
    <div class="floating-cube" style="width: 60px; height: 60px; left: 5%; animation-duration: 18s;"></div>
    <div class="floating-cube" style="width: 40px; height: 40px; right: 8%; animation-duration: 22s; top: 30%;"></div>
    <div class="floating-cube" style="width: 80px; height: 80px; left: 80%; animation-duration: 25s; top: 60%;"></div>
    <div class="floating-cube" style="width: 30px; height: 30px; left: 15%; animation-duration: 16s; top: 70%;"></div>
</div>

<div class="forgot-container">
    <div class="forgot-header">
        <div class="header-icon">
            <i class="fas fa-key"></i>
        </div>
        <h1>Reset Password</h1>
        <p>We'll help you get back into your account</p>
    </div>
    
    <div class="forgot-body">
        <!-- Alert messages using JSTL -->
        <c:if test="${not empty error}">
            <c:choose>
                <c:when test="${error eq 'notfound'}">
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>❌ Email not found. Please check and try again.</span>
                    </div>
                </c:when>
                <c:when test="${error eq 'invalid'}">
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>❌ Something went wrong. Please try again.</span>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>❌ ${error}</span>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>
        
        <c:if test="${not empty success}">
            <c:choose>
                <c:when test="${success eq 'sent'}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i>
                        <span>✅ Reset link sent! Please check your email inbox.</span>
                    </div>
                </c:when>
                <c:when test="${success eq 'reset'}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i>
                        <span>✅ Password reset successful! Please login with your new password.</span>
                    </div>
                </c:when>
            </c:choose>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/student/forgot-password" method="post" id="forgotForm">
            <div class="form-group">
                <label><i class="fas fa-envelope"></i> Email Address</label>
                <div class="input-group">
                    <i class="fas fa-at input-icon"></i>
                    <input type="email" name="email" id="email" required placeholder="Enter your registered email">
                </div>
                <div class="info-text">
                    <i class="fas fa-info-circle"></i> We'll send a password reset link to this email
                </div>
            </div>
            
            <button type="submit" class="reset-btn" id="resetBtn">
                <span>Send Reset Link</span> <i class="fas fa-paper-plane"></i>
            </button>
            
            <div class="action-links">
                <div class="action-link">
                    <a href="${pageContext.request.contextPath}/student/login">
                        <i class="fas fa-arrow-left"></i> Back to Login
                    </a>
                </div>
                <div class="action-link">
                    <a href="${pageContext.request.contextPath}/student/register">
                        <i class="fas fa-user-plus"></i> Create New Account
                    </a>
                </div>
            </div>
            
            <div class="security-badge">
                <span><i class="fas fa-shield-alt"></i> Secure Encrypted</span>
                <span><i class="fas fa-clock"></i> Link expires in 24 hours</span>
                <span><i class="fas fa-envelope"></i> Check spam folder</span>
            </div>
        </form>
    </div>
</div>

<!-- External JavaScript -->
<script src="${pageContext.request.contextPath}/js/student-forgot-password.js"></script>
</body>
</html>
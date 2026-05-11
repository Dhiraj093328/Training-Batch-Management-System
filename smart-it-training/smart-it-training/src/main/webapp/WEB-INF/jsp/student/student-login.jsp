<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <title>⚡ NEO STUDENT | Smart IT Training Portal</title>
    
    <!-- External CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-login.css">
    
    <!-- Google Fonts + Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <!-- GSAP for smooth animations -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/gsap.min.js"></script>
</head>
<body>

<div class="cyber-grid"></div>
<div class="glow-orb orb1"></div>
<div class="glow-orb orb2"></div>
<div class="glow-orb orb3"></div>
<canvas id="digital-rain"></canvas>

<div class="login-container" id="loginCard">
    <div class="login-header">
        <div class="avatar-icon">
            <i class="fas fa-microchip"></i>
        </div>
        <h1>STUDENT <span style="color:#00ffff;">PORTAL</span></h1>
        <div class="glitch-text">// INTELLIGENCE. AI. FUTURE //</div>
    </div>
    
    <div class="login-body">
        <!-- ========== ALERT MESSAGES ========== -->
        
        <!-- Registration Success - Pending Approval -->
        <c:if test="${not empty param.registered}">
            <div class="alert alert-success" id="successAlert">
                <i class="fas fa-check-double"></i> 
                <span>🎉 REGISTRATION SUCCESSFUL! Your account is under review. You will receive an email once approved.</span>
            </div>
        </c:if>
        
        <!-- Account Approved Message -->
        <c:if test="${not empty param.approved}">
            <div class="alert alert-success" id="successAlert">
                <i class="fas fa-check-double"></i> 
                <span>✅ ACCOUNT APPROVED! You can now login with your credentials.</span>
            </div>
        </c:if>
        
        <!-- Account Rejected Message -->
        <c:if test="${not empty param.rejected}">
            <div class="alert alert-error" id="errorAlert">
                <i class="fas fa-times-circle"></i> 
                <span>❌ ACCOUNT REJECTED! Your registration request has been declined. Please contact admin for more details.</span>
            </div>
        </c:if>
        
        <!-- Password Reset Success -->
        <c:if test="${not empty param.reset}">
            <div class="alert alert-success" id="successAlert">
                <i class="fas fa-sync-alt fa-fw"></i> 
                <span>🔐 PASSWORD RESET SUCCESSFUL — Login with your new credentials.</span>
            </div>
        </c:if>
        
        <!-- Login Error - Invalid Credentials -->
        <c:if test="${not empty param.error}">
            <c:choose>
                <c:when test="${param.error eq 'pending'}">
                    <div class="alert alert-warning" id="warningAlert">
                        <i class="fas fa-hourglass-half fa-fw"></i> 
                        <span>⏳ PENDING APPROVAL — Your account is awaiting admin verification. You will receive an email once approved.</span>
                    </div>
                </c:when>
                <c:when test="${param.error eq 'rejected'}">
                    <div class="alert alert-error" id="errorAlert">
                        <i class="fas fa-times-circle"></i> 
                        <span>❌ ACCOUNT REJECTED! Your registration has been declined. Please contact admin.</span>
                    </div>
                </c:when>
                <c:when test="${param.error eq 'true'}">
                    <div class="alert alert-error" id="errorAlert">
                        <i class="fas fa-skull-crosswalk"></i> 
                        <span>⛔ ACCESS DENIED — Invalid username/email or password. Please try again.</span>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-error" id="errorAlert">
                        <i class="fas fa-skull-crosswalk"></i> 
                        <span>⛔ ACCESS DENIED — Invalid credentials or account mismatch.</span>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/student/login" method="post" id="loginForm">
            <div class="form-group">
                <label><i class="fas fa-fingerprint"></i> IDENTIFIER</label>
                <div class="input-group">
                    <i class="fas fa-envelope input-icon"></i>
                    <input type="text" name="username" required placeholder="student@smartit.com / username" autocomplete="username" value="${param.username != null ? param.username : ''}">
                </div>
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-shield-haltered"></i> SECRET KEY</label>
                <div class="input-group">
                    <i class="fas fa-lock input-icon"></i>
                    <input type="password" name="password" required placeholder="••••••••" autocomplete="current-password" id="passwordInput">
                </div>
            </div>
            
            <button type="submit" class="login-btn" id="loginBtn">
                <span>LAUNCH DASHBOARD</span> <i class="fas fa-arrow-right-to-bracket"></i>
            </button>
            
            <div class="action-links">
                <div class="action-link">
                    <a href="${pageContext.request.contextPath}/student/register">
                        <i class="fas fa-user-astronaut"></i> <span>CREATE ACCOUNT</span>
                    </a>
                </div>
                <div class="action-link">
                    <a href="${pageContext.request.contextPath}/student/forgot-password">
                        <i class="fas fa-key"></i> <span>RECOVER ACCESS</span>
                    </a>
                </div>
            </div>
            
            <div class="secure-badge">
                <span><i class="fas fa-lock"></i> 256-bit TLS</span>
                <span><i class="fas fa-shield-alt"></i> ZKP Auth</span>
                <span><i class="fas fa-cloud-upload-alt"></i> Smart IT Cloud</span>
            </div>
        </form>
    </div>
</div>

<!-- External JavaScript -->
<script src="${pageContext.request.contextPath}/js/student-login.js"></script>

<script>
    // Auto-hide alerts after 5 seconds
    document.addEventListener('DOMContentLoaded', function() {
        const successAlert = document.getElementById('successAlert');
        const errorAlert = document.getElementById('errorAlert');
        const warningAlert = document.getElementById('warningAlert');
        
        if (successAlert) {
            setTimeout(function() {
                successAlert.style.transition = 'opacity 0.5s ease';
                successAlert.style.opacity = '0';
                setTimeout(function() {
                    if (successAlert.parentNode) successAlert.remove();
                }, 500);
            }, 5000);
        }
        
        if (errorAlert) {
            setTimeout(function() {
                errorAlert.style.transition = 'opacity 0.5s ease';
                errorAlert.style.opacity = '0';
                setTimeout(function() {
                    if (errorAlert.parentNode) errorAlert.remove();
                }, 500);
            }, 5000);
        }
        
        if (warningAlert) {
            setTimeout(function() {
                warningAlert.style.transition = 'opacity 0.5s ease';
                warningAlert.style.opacity = '0';
                setTimeout(function() {
                    if (warningAlert.parentNode) warningAlert.remove();
                }, 500);
            }, 5000);
        }
    });
</script>
</body>
</html>
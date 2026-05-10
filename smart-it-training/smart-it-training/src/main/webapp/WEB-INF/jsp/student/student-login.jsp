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
        <!-- Alert messages -->
        <c:if test="${not empty error}">
            <c:choose>
                <c:when test="${error eq 'pending'}">
                    <div class="alert alert-warning">
                        <i class="fas fa-hourglass-half fa-fw"></i> 
                        <span>⏳ PENDING APPROVAL — Await admin verification to unlock full access.</span>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-error">
                        <i class="fas fa-skull-crosswalk"></i> 
                        <span>⛔ ACCESS DENIED — Invalid credentials or account mismatch.</span>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>
        
        <c:if test="${not empty registered}">
            <div class="alert alert-success">
                <i class="fas fa-check-double"></i> 
                <span>🎉 REGISTRATION SUCCESS! Your account is under review. We'll notify you soon.</span>
            </div>
        </c:if>
        
        <c:if test="${not empty reset}">
            <div class="alert alert-success">
                <i class="fas fa-sync-alt fa-fw"></i> 
                <span>🔐 PASSWORD RESET SUCCESSFUL — Login with your new credentials.</span>
            </div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/student/login" method="post" id="loginForm">
            <div class="form-group">
                <label><i class="fas fa-fingerprint"></i> IDENTIFIER</label>
                <div class="input-group">
                    <i class="fas fa-envelope input-icon"></i>
                    <input type="text" name="username" required placeholder="student@smartit.com / username" autocomplete="username" value="${username}">
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
</body>
</html>
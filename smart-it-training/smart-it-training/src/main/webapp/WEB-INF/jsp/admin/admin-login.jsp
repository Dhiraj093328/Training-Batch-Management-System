<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <title>Admin Nexus | Secure Login Portal | Smart IT Training</title>
    
    <!-- Google Fonts + Font Awesome Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <!-- External CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-login.css">
</head>
<body class="admin-login-body">
    <div class="floating-glow"></div>
    
    <div class="glass-card">
        <div class="brand-header">
            <div class="icon-logo">
                <i class="fas fa-building-shield"></i>
            </div>
            <h1>Administrative Nexus</h1>
            <p><i class="fas fa-lock"></i> Secure access · Enterprise dashboard</p>
        </div>

        <div class="form-container">
            <!-- Dynamic JSP error/success messages from backend -->
            <% if(request.getParameter("error") != null) { %>
                <div class="alert alert-error" id="serverErrorMsg">
                    <i class="fas fa-exclamation-triangle"></i>
                    <span>Invalid User ID or Password. Please try again.</span>
                </div>
            <% } %>
            
            <% if(request.getParameter("registered") != null) { %>
                <div class="alert alert-success" id="serverSuccessMsg">
                    <i class="fas fa-check-circle"></i>
                    <span>Registration successful! Please login with your credentials.</span>
                </div>
            <% } %>
            
            <% if(request.getParameter("reset") != null && request.getParameter("reset").equals("success")) { %>
                <div class="alert alert-success" id="serverSuccessMsg">
                    <i class="fas fa-check-circle"></i>
                    <span>Password reset successful! Please login with your new password.</span>
                </div>
            <% } %>
            
            <!-- Check if user is already logged in and redirect to dashboard -->
            <%
                if(session.getAttribute("adminId") != null) {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                    return;
                }
            %>
            
            <div id="messageContainer"></div>
            
            <!-- Login Form -->
            <form id="secureLoginForm" action="${pageContext.request.contextPath}/admin/login" method="post">
                <div class="input-group">
                    <label><i class="fas fa-user-circle"></i> User ID / Email</label>
                    <input type="text" class="input-field" id="userId" name="userId" placeholder="admin@smartit.edu or empID" autocomplete="username" required>
                </div>

                <div class="input-group">
                    <label><i class="fas fa-key"></i> Access Password</label>
                    <input type="password" class="input-field" id="password" name="password" placeholder="••••••••" autocomplete="current-password" required>
                </div>

                <button type="submit" class="login-btn" id="submitBtn">
                    <i class="fas fa-arrow-right-to-bracket"></i> Access Dashboard
                </button>

                <div class="action-links">
                    <a href="${pageContext.request.contextPath}/admin/register"><i class="fas fa-user-plus"></i> Create Admin Account</a>
                    <a href="${pageContext.request.contextPath}/admin/forgot-password"><i class="fas fa-question-circle"></i> Forgot Password?</a>
                </div>
            </form>
            
            <div class="security-badge">
                <i class="fas fa-shield-alt"></i> Protected by AES-256 & Smart IT Gateway
            </div>
        </div>
    </div>
    
    <!-- External JavaScript -->
    <script src="${pageContext.request.contextPath}/js/admin-login.js"></script>
</body>
</html>
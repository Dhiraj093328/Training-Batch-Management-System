<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <title>Faculty Portal | Smart IT Training</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 450px;
            overflow: hidden;
            animation: fadeInUp 0.5s ease;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .login-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            padding: 30px;
            text-align: center;
            color: white;
        }
        .login-header i { font-size: 50px; margin-bottom: 10px; }
        .login-header h1 { font-size: 1.8rem; margin-bottom: 5px; }
        .login-header p { opacity: 0.9; }
        .login-body { padding: 30px; }
        .form-group { margin-bottom: 20px; }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }
        .form-group label i { margin-right: 8px; color: #667eea; }
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 0.95rem;
        }
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
        }
        .login-btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .login-btn:hover { transform: translateY(-2px); box-shadow: 0 10px 25px rgba(102,126,234,0.4); }
        .action-links {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .action-links a {
            color: #667eea;
            text-decoration: none;
            font-size: 0.85rem;
        }
        .alert {
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
        }
        .alert-error { background: #fee; color: #c00; border-left: 4px solid #c00; }
        .alert-success { background: #efe; color: #0a0; border-left: 4px solid #0a0; }
        .alert-warning { background: #fff3cd; color: #856404; border-left: 4px solid #ffc107; }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <i class="fas fa-chalkboard-user"></i>
            <h1>Faculty Portal</h1>
            <p>Access your teaching dashboard</p>
        </div>
        
        <div class="login-body">
            <c:if test="${not empty param.error}">
                <c:choose>
                    <c:when test="${param.error eq 'pending'}">
                        <div class="alert alert-warning">⏳ Account pending approval. Please wait for admin approval.</div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-error">❌ Invalid username/email or password!</div>
                    </c:otherwise>
                </c:choose>
            </c:if>
            <c:if test="${not empty param.registered}">
                <div class="alert alert-success">🎉 Registration successful! Please wait for admin approval.</div>
            </c:if>
            <c:if test="${not empty param.reset}">
                <div class="alert alert-success">🔐 Password reset successful! Please login.</div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/faculty/login" method="post">
                <div class="form-group">
                    <label><i class="fas fa-user"></i> Username / Email</label>
                    <input type="text" name="username" required placeholder="Enter username or email">
                </div>
                <div class="form-group">
                    <label><i class="fas fa-lock"></i> Password</label>
                    <input type="password" name="password" required placeholder="Enter password">
                </div>
                <button type="submit" class="login-btn">Login</button>
                <div class="action-links">
                    <a href="${pageContext.request.contextPath}/faculty/register"><i class="fas fa-user-plus"></i> Create Account</a>
                    <a href="${pageContext.request.contextPath}/faculty/forgot-password"><i class="fas fa-question-circle"></i> Forgot Password?</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
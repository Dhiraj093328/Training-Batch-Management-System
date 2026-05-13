<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Training & Placement Portal | Student Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
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
        .login-header p { opacity: 0.9; font-size: 0.9rem; }
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
        .info-box {
            background: #e3f2fd;
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 0.85rem;
            color: #1976d2;
            border-left: 4px solid #1976d2;
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
        .alert {
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
        }
        .alert-error { background: #fee; color: #c00; border-left: 4px solid #c00; }
        .alert-warning { background: #fff3cd; color: #856404; border-left: 4px solid #ffc107; }
        .back-link { text-align: center; margin-top: 15px; }
        .back-link a { color: #667eea; text-decoration: none; font-size: 0.85rem; }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <i class="fas fa-briefcase"></i>
            <h1>Training & Placement</h1>
            <p>Student Login Portal</p>
        </div>
        
        <div class="login-body">
            <div class="info-box">
                <i class="fas fa-info-circle"></i> Use your Student Portal credentials to login
            </div>
            
            <c:if test="${not empty param.error}">
                <c:choose>
                    <c:when test="${param.error eq 'pending'}">
                        <div class="alert alert-warning">
                            <i class="fas fa-hourglass-half"></i> Your student account is pending approval.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-error">
                            <i class="fas fa-exclamation-circle"></i> Invalid username/email or password!
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/placement/login" method="post">
                <div class="form-group">
                    <label><i class="fas fa-user"></i> Username / Email</label>
                    <input type="text" name="username" required placeholder="Enter your student username or email">
                </div>
                <div class="form-group">
                    <label><i class="fas fa-lock"></i> Password</label>
                    <input type="password" name="password" required placeholder="Enter your student password">
                </div>
                <button type="submit" class="login-btn">Login to Placement Portal</button>
            </form>
            
            <div class="back-link">
                <a href="${pageContext.request.contextPath}/menu"><i class="fas fa-arrow-left"></i> Back to Menu</a>
            </div>
        </div>
    </div>
</body>
</html>
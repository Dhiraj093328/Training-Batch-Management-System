<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password | Faculty Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
            min-height: 100vh;
        }
        .forgot-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 450px;
            overflow: hidden;
        }
        .forgot-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            padding: 30px;
            text-align: center;
            color: white;
        }
        .forgot-header i { font-size: 50px; margin-bottom: 10px; }
        .forgot-header h1 { font-size: 1.6rem; margin-bottom: 5px; }
        .forgot-body { padding: 30px; }
        .form-group { margin-bottom: 20px; }
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 0.95rem;
        }
        .reset-btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
        }
        .back-link { text-align: center; margin-top: 20px; }
        .back-link a { color: #667eea; text-decoration: none; }
        .alert {
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
        }
        .alert-error { background: #fee; color: #c00; border-left: 4px solid #c00; }
        .alert-success { background: #efe; color: #0a0; border-left: 4px solid #0a0; }
    </style>
</head>
<body>
    <div class="forgot-container">
        <div class="forgot-header">
            <i class="fas fa-key"></i>
            <h1>Forgot Password?</h1>
            <p>We'll help you reset it</p>
        </div>
        
        <div class="forgot-body">
            <c:if test="${not empty param.error}">
                <div class="alert alert-error">
                    <c:choose>
                        <c:when test="${param.error eq 'notfound'}">Account not found!</c:when>
                        <c:otherwise>Something went wrong!</c:otherwise>
                    </c:choose>
                </div>
            </c:if>
            <c:if test="${not empty param.success}">
                <div class="alert alert-success">Reset link sent! Please check your email.</div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/faculty/forgot-password/send-otp" method="post">
                <div class="form-group">
                    <input type="email" name="identifier" required placeholder="Enter your registered email">
                </div>
                <button type="submit" class="reset-btn">Send Reset OTP</button>
            </form>
            
            <div class="back-link">
                <a href="${pageContext.request.contextPath}/faculty/login"><i class="fas fa-arrow-left"></i> Back to Login</a>
            </div>
        </div>
    </div>
</body>
</html>
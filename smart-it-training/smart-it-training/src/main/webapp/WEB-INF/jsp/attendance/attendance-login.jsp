<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Attendance Management | Faculty Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            /* IT-themed background image with circuit/network pattern */
            background-image: url('https://images.unsplash.com/photo-1518770660439-4636190af475?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1770&q=80');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        /* Dark overlay for better contrast and readability */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.65);
            backdrop-filter: blur(2px);
            z-index: 0;
        }

        .login-container {
            position: relative;
            z-index: 1;
            background: rgba(255, 255, 255, 0.98);
            border-radius: 24px;
            box-shadow: 0 30px 50px rgba(0, 0, 0, 0.25), 0 0 0 1px rgba(255, 255, 255, 0.1);
            width: 100%;
            max-width: 460px;
            overflow: hidden;
            animation: fadeInUp 0.6s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            backdrop-filter: blur(2px);
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(40px) scale(0.96);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .login-header {
            background: linear-gradient(135deg, #0a2540 0%, #1e4a76 50%, #2b6a9f 100%);
            padding: 32px 28px;
            text-align: center;
            color: white;
            position: relative;
            overflow: hidden;
        }

        .login-header::after {
            content: '';
            position: absolute;
            top: -30%;
            left: -20%;
            width: 140%;
            height: 140%;
            background: radial-gradient(circle, rgba(255,255,255,0.08) 0%, rgba(255,255,255,0) 70%);
            transform: rotate(15deg);
            pointer-events: none;
        }

        .login-header i {
            font-size: 52px;
            margin-bottom: 12px;
            filter: drop-shadow(0 4px 8px rgba(0,0,0,0.2));
            background: linear-gradient(135deg, #fff, #e0f0ff);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            text-shadow: none;
        }

        .login-header h1 {
            font-size: 1.9rem;
            margin-bottom: 6px;
            letter-spacing: -0.3px;
            font-weight: 700;
        }

        .login-header p {
            opacity: 0.9;
            font-size: 0.9rem;
            font-weight: 400;
        }

        .login-body {
            padding: 36px 32px 40px;
            background: white;
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #1e2a3a;
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-group label i {
            margin-right: 8px;
            color: #2b6a9f;
            width: 18px;
        }

        .form-group input {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e2e8f0;
            border-radius: 14px;
            font-size: 0.95rem;
            font-family: 'Poppins', sans-serif;
            transition: all 0.25s ease;
            background: #fafcff;
        }

        .form-group input:focus {
            outline: none;
            border-color: #2b6a9f;
            box-shadow: 0 0 0 4px rgba(43, 106, 159, 0.15);
            background: white;
        }

        .info-box {
            background: #ecf7ff;
            padding: 14px 16px;
            border-radius: 16px;
            margin-bottom: 28px;
            text-align: center;
            font-size: 0.85rem;
            font-weight: 500;
            color: #0c4e6e;
            border-left: 4px solid #2b6a9f;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .info-box i {
            font-size: 1.1rem;
            color: #2b6a9f;
        }

        .login-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(105deg, #0f2c3f 0%, #1f5e8c 100%);
            color: white;
            border: none;
            border-radius: 40px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 8px 18px rgba(0, 32, 64, 0.2);
            letter-spacing: 0.3px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .login-btn i {
            font-size: 1.1rem;
            transition: transform 0.2s;
        }

        .login-btn:hover {
            transform: translateY(-2px);
            background: linear-gradient(105deg, #1a405b, #2878ae);
            box-shadow: 0 14px 26px rgba(0, 32, 64, 0.3);
        }

        .login-btn:hover i {
            transform: translateX(4px);
        }

        .alert {
            padding: 14px 16px;
            border-radius: 16px;
            margin-bottom: 24px;
            text-align: center;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            backdrop-filter: blur(4px);
        }

        .alert-error {
            background: #ffe9e9;
            color: #bc1c2e;
            border-left: 4px solid #bc1c2e;
        }

        .alert-warning {
            background: #fff2df;
            color: #a86800;
            border-left: 4px solid #f5a623;
        }

        .back-link {
            text-align: center;
            margin-top: 24px;
        }

        .back-link a {
            color: #567d9a;
            text-decoration: none;
            font-size: 0.85rem;
            font-weight: 500;
            transition: color 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .back-link a:hover {
            color: #0f2c3f;
            text-decoration: underline;
        }

        @media (max-width: 520px) {
            .login-body {
                padding: 28px 22px;
            }
            .login-header h1 {
                font-size: 1.6rem;
            }
        }

        /* subtle tech pattern on header (optional) */
        .circuit-icon {
            position: absolute;
            right: 10px;
            bottom: 10px;
            opacity: 0.1;
            font-size: 70px;
            pointer-events: none;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <i class="fas fa-microchip"></i>
            <h1>Attendance Management</h1>
            <p>Faculty Authentication · Secure Portal</p>
            <div class="circuit-icon"><i class="fas fa-network-wired"></i></div>
        </div>
        
        <div class="login-body">
            <div class="info-box">
                <i class="fas fa-shield-alt"></i> 
                <span>Authorized faculty only · Enterprise credentials</span>
            </div>
            
            <c:if test="${not empty param.error}">
                <c:choose>
                    <c:when test="${param.error eq 'pending'}">
                        <div class="alert alert-warning">
                            <i class="fas fa-hourglass-half"></i> Your faculty account is pending approval.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-error">
                            <i class="fas fa-exclamation-triangle"></i> Invalid username/email or password!
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/attendance/login" method="post">
                <div class="form-group">
                    <label><i class="fas fa-id-card"></i> Username / Email</label>
                    <input type="text" name="username" required placeholder="faculty@institute.edu or username">
                </div>
                <div class="form-group">
                    <label><i class="fas fa-key"></i> Password</label>
                    <input type="password" name="password" required placeholder="••••••••">
                </div>
                <button type="submit" class="login-btn">
                    <span>Access Dashboard</span> <i class="fas fa-arrow-right"></i>
                </button>
            </form>
            
            <div class="back-link">
                <a href="${pageContext.request.contextPath}/menu"><i class="fas fa-chevron-left"></i> Return to Main Menu</a>
            </div>
        </div>
    </div>
</body>
</html>
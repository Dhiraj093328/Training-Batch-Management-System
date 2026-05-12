<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Registration | Smart IT Training</title>
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
        .register-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 600px;
            overflow: hidden;
        }
        .register-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            padding: 30px;
            text-align: center;
            color: white;
        }
        .register-header i { font-size: 50px; margin-bottom: 10px; }
        .register-header h1 { font-size: 1.8rem; margin-bottom: 5px; }
        .register-body { padding: 30px; }
        .form-row {
            display: flex;
            gap: 15px;
            margin-bottom: 15px;
        }
        .form-group { flex: 1; margin-bottom: 15px; }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }
        .form-group label i { margin-right: 8px; color: #667eea; }
        .form-group input, .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 0.95rem;
        }
        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: #667eea;
        }
        .register-btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            margin-top: 10px;
        }
        .login-link { text-align: center; margin-top: 20px; }
        .login-link a { color: #667eea; text-decoration: none; }
        .alert {
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
        }
        .alert-error { background: #fee; color: #c00; border-left: 4px solid #c00; }
        .password-hint { font-size: 0.7rem; color: #999; margin-top: 5px; display: block; }
        @media (max-width: 600px) { .form-row { flex-direction: column; gap: 0; } }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-header">
            <i class="fas fa-chalkboard-user"></i>
            <h1>Faculty Registration</h1>
            <p>Join as a faculty member</p>
        </div>
        
        <div class="register-body">
            <c:if test="${not empty param.error}">
                <div class="alert alert-error">
                    <c:choose>
                        <c:when test="${param.error eq 'exists'}">Username already exists!</c:when>
                        <c:when test="${param.error eq 'email'}">Email already registered!</c:when>
                        <c:when test="${param.error eq 'password'}">Passwords do not match!</c:when>
                        <c:otherwise>Registration failed!</c:otherwise>
                    </c:choose>
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/faculty/register" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-user"></i> Full Name</label>
                        <input type="text" name="name" required placeholder="Enter your full name">
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-phone"></i> Contact Number</label>
                        <input type="tel" name="contact" required placeholder="10-digit number">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-envelope"></i> Email Address</label>
                        <input type="email" name="email" required placeholder="your@email.com">
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-building"></i> Admin Office</label>
                        <input type="text" name="adminOfficeName" required placeholder="e.g., Head Office">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-layer-group"></i> Batch</label>
                        <select name="batchName" required>
                            <option value="">Select Batch</option>
                            <c:forEach items="${batches}" var="batch">
                                <option value="${batch.batchName}">${batch.batchName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-user-circle"></i> Username</label>
                        <input type="text" name="username" required placeholder="Choose username">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-graduation-cap"></i> Qualification</label>
                        <input type="text" name="qualification" placeholder="e.g., M.Tech, Ph.D">
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-briefcase"></i> Experience (Years)</label>
                        <input type="number" name="experienceYears" placeholder="0">
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-lock"></i> Password</label>
                        <input type="password" name="password" id="password" required>
                        <span class="password-hint">Minimum 6 characters</span>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-check-circle"></i> Confirm Password</label>
                        <input type="password" name="confirmPassword" required>
                    </div>
                </div>
                
                <button type="submit" class="register-btn">Register Faculty Account</button>
            </form>
            
            <div class="login-link">
                Already have an account? <a href="${pageContext.request.contextPath}/faculty/login">Login here</a>
            </div>
        </div>
    </div>
    
    <script>
        document.querySelector('form').addEventListener('submit', function(e) {
            const pwd = document.getElementById('password').value;
            const confirm = document.querySelector('input[name="confirmPassword"]').value;
            if (pwd !== confirm) { e.preventDefault(); alert('Passwords do not match!'); }
        });
    </script>
</body>
</html>
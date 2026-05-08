<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Forgot Password | Smart IT Training</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <!-- External CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/forgot-password.css">
</head>
<body>
    <div class="forgot-wrapper">
        <div class="forgot-card">
            <div class="forgot-header">
                <div class="icon">🔐</div>
                <h1>Forgot Password?</h1>
                <p>Don't worry! We'll help you reset it</p>
            </div>
            
            <div class="forgot-body">
                <!-- Step 1: Enter Email/User ID -->
                <div id="step1" class="step-content">
                    <div class="info-text">
                        <i class="fas fa-info-circle"></i>
                        <span>Enter your registered email address or User ID</span>
                    </div>
                    
                    <form id="forgotForm" action="${pageContext.request.contextPath}/admin/forgot-password/send-otp" method="post">
                        <div class="form-group">
                            <label><i class="fas fa-envelope"></i> Email Address or User ID</label>
                            <input type="text" name="identifier" id="identifier" required 
                                   placeholder="Enter your registered email or user ID">
                        </div>
                        <button type="submit" class="submit-btn" id="sendOtpBtn">
                            <i class="fas fa-paper-plane"></i> Send Reset OTP
                        </button>
                    </form>
                </div>

                <!-- Step 2: Enter OTP (Hidden initially) -->
                <div id="step2" class="step-content otp-section">
                    <div class="info-text">
                        <i class="fas fa-key"></i>
                        <span>Enter the 6-digit OTP sent to your email</span>
                    </div>
                    
                    <form id="otpForm" action="${pageContext.request.contextPath}/admin/forgot-password/verify-otp" method="post">
                        <input type="hidden" name="identifier" id="hiddenIdentifier">
                        <div class="form-group">
                            <label><i class="fas fa-shield-alt"></i> Enter OTP</label>
                            <input type="text" name="otp" id="otp" required maxlength="6" 
                                   placeholder="Enter 6-digit OTP">
                        </div>
                        <button type="submit" class="submit-btn">
                            <i class="fas fa-check-circle"></i> Verify OTP
                        </button>
                    </form>
                    
                    <div class="resend-otp">
                        <a onclick="resendOtp()"><i class="fas fa-redo-alt"></i> Resend OTP</a>
                    </div>
                </div>

                <!-- Step 3: Reset Password (Hidden initially) -->
                <div id="step3" class="step-content otp-section">
                    <div class="info-text">
                        <i class="fas fa-lock"></i>
                        <span>Create a new password for your account</span>
                    </div>
                    
                    <form id="resetForm" action="${pageContext.request.contextPath}/admin/forgot-password/reset" method="post">
                        <input type="hidden" name="identifier" id="resetIdentifier">
                        <div class="form-group">
                            <label><i class="fas fa-lock"></i> New Password</label>
                            <input type="password" name="newPassword" id="newPassword" required 
                                   placeholder="Enter new password">
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-check-circle"></i> Confirm Password</label>
                            <input type="password" name="confirmPassword" id="confirmPassword" required 
                                   placeholder="Confirm new password">
                        </div>
                        <button type="submit" class="submit-btn">
                            <i class="fas fa-save"></i> Reset Password
                        </button>
                    </form>
                </div>
                
                <div class="back-link">
                    <a href="${pageContext.request.contextPath}/admin/login">
                        <i class="fas fa-arrow-left"></i> Back to Login
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- External JavaScript -->
    <script src="${pageContext.request.contextPath}/js/forgot-password.js"></script>
</body>
</html>
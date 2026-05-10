package com.smartit.training.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import jakarta.mail.internet.MimeMessage;

@Service
public class EmailService {
    
    @Autowired
    private JavaMailSender mailSender;
    
    // =============================================
    // ADMIN EMAILS
    // =============================================
    
    // Send Admin Registration Success Email
    public void sendAdminRegistrationEmail(String to, String name, String username, String password) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            
            helper.setTo(to);
            helper.setSubject("Smart IT Training - Admin Registration Successful");
            
            String htmlContent = getAdminRegistrationTemplate(name, username, password);
            helper.setText(htmlContent, true);
            mailSender.send(message);
            
            System.out.println("Admin registration email sent to: " + to);
        } catch (Exception e) {
            System.err.println("Failed to send admin registration email: " + e.getMessage());
        }
    }
    
    // Send Admin OTP Email
    public void sendAdminOtpEmail(String to, String name, String otp) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            
            helper.setTo(to);
            helper.setSubject("Smart IT Training - Admin Password Reset OTP");
            
            String htmlContent = getAdminOtpTemplate(name, otp);
            helper.setText(htmlContent, true);
            mailSender.send(message);
            
            System.out.println("Admin OTP email sent to: " + to);
        } catch (Exception e) {
            System.err.println("Failed to send admin OTP email: " + e.getMessage());
        }
    }
    
    // Send Admin Password Reset Confirmation
    public void sendAdminPasswordResetConfirmation(String to, String name) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            
            helper.setTo(to);
            helper.setSubject("Smart IT Training - Admin Password Reset Successful");
            
            String htmlContent = getAdminPasswordResetTemplate(name);
            helper.setText(htmlContent, true);
            mailSender.send(message);
            
            System.out.println("Admin password reset confirmation sent to: " + to);
        } catch (Exception e) {
            System.err.println("Failed to send admin password reset confirmation: " + e.getMessage());
        }
    }
    
    // =============================================
    // STUDENT EMAILS
    // =============================================
    
    // Send Student Registration Email (Pending Approval)
    public void sendStudentRegistrationEmail(String to, String name, String username, String password) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            
            helper.setTo(to);
            helper.setSubject("Smart IT Training - Student Registration Submitted");
            
            String htmlContent = getStudentRegistrationTemplate(name, username, password);
            helper.setText(htmlContent, true);
            mailSender.send(message);
            
            System.out.println("Student registration email sent to: " + to);
        } catch (Exception e) {
            System.err.println("Failed to send student registration email: " + e.getMessage());
        }
    }
    
    // Send Student Approval Email
    public void sendStudentApprovalEmail(String to, String name, String username, String password) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            
            helper.setTo(to);
            helper.setSubject("Smart IT Training - Student Account Approved");
            
            String htmlContent = getStudentApprovalTemplate(name, username, password);
            helper.setText(htmlContent, true);
            mailSender.send(message);
            
            System.out.println("Student approval email sent to: " + to);
        } catch (Exception e) {
            System.err.println("Failed to send student approval email: " + e.getMessage());
        }
    }
    
    // Send Student Rejection Email
    public void sendStudentRejectionEmail(String to, String name, String reason) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            
            helper.setTo(to);
            helper.setSubject("Smart IT Training - Student Account Update");
            
            String htmlContent = getStudentRejectionTemplate(name, reason);
            helper.setText(htmlContent, true);
            mailSender.send(message);
            
            System.out.println("Student rejection email sent to: " + to);
        } catch (Exception e) {
            System.err.println("Failed to send student rejection email: " + e.getMessage());
        }
    }
    
    // Send Student OTP Email
    public void sendStudentOtpEmail(String to, String name, String otp) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            
            helper.setTo(to);
            helper.setSubject("Smart IT Training - Student Password Reset OTP");
            
            String htmlContent = getStudentOtpTemplate(name, otp);
            helper.setText(htmlContent, true);
            mailSender.send(message);
            
            System.out.println("Student OTP email sent to: " + to);
        } catch (Exception e) {
            System.err.println("Failed to send student OTP email: " + e.getMessage());
        }
    }
    
    // Send Student Password Reset Confirmation
    public void sendStudentPasswordResetConfirmation(String to, String name) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            
            helper.setTo(to);
            helper.setSubject("Smart IT Training - Student Password Reset Successful");
            
            String htmlContent = getStudentPasswordResetTemplate(name);
            helper.setText(htmlContent, true);
            mailSender.send(message);
            
            System.out.println("Student password reset confirmation sent to: " + to);
        } catch (Exception e) {
            System.err.println("Failed to send student password reset confirmation: " + e.getMessage());
        }
    }
    
    // =============================================
    // FACULTY EMAILS
    // =============================================
    
    // Send Faculty Registration Email (Pending Approval)
    public void sendFacultyRegistrationEmail(String to, String name, String username, String password) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            
            helper.setTo(to);
            helper.setSubject("Smart IT Training - Faculty Registration Submitted");
            
            String htmlContent = getFacultyRegistrationTemplate(name, username, password);
            helper.setText(htmlContent, true);
            mailSender.send(message);
            
            System.out.println("Faculty registration email sent to: " + to);
        } catch (Exception e) {
            System.err.println("Failed to send faculty registration email: " + e.getMessage());
        }
    }
    
    // Send Faculty Approval Email
    public void sendFacultyApprovalEmail(String to, String name, String username, String password) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            
            helper.setTo(to);
            helper.setSubject("Smart IT Training - Faculty Account Approved");
            
            String htmlContent = getFacultyApprovalTemplate(name, username, password);
            helper.setText(htmlContent, true);
            mailSender.send(message);
            
            System.out.println("Faculty approval email sent to: " + to);
        } catch (Exception e) {
            System.err.println("Failed to send faculty approval email: " + e.getMessage());
        }
    }
    
    // Send Faculty Rejection Email
    public void sendFacultyRejectionEmail(String to, String name, String reason) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            
            helper.setTo(to);
            helper.setSubject("Smart IT Training - Faculty Account Update");
            
            String htmlContent = getFacultyRejectionTemplate(name, reason);
            helper.setText(htmlContent, true);
            mailSender.send(message);
            
            System.out.println("Faculty rejection email sent to: " + to);
        } catch (Exception e) {
            System.err.println("Failed to send faculty rejection email: " + e.getMessage());
        }
    }
    
    // Send Faculty OTP Email
    public void sendFacultyOtpEmail(String to, String name, String otp) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            
            helper.setTo(to);
            helper.setSubject("Smart IT Training - Faculty Password Reset OTP");
            
            String htmlContent = getFacultyOtpTemplate(name, otp);
            helper.setText(htmlContent, true);
            mailSender.send(message);
            
            System.out.println("Faculty OTP email sent to: " + to);
        } catch (Exception e) {
            System.err.println("Failed to send faculty OTP email: " + e.getMessage());
        }
    }
    
    // Send Faculty Password Reset Confirmation
    public void sendFacultyPasswordResetConfirmation(String to, String name) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            
            helper.setTo(to);
            helper.setSubject("Smart IT Training - Faculty Password Reset Successful");
            
            String htmlContent = getFacultyPasswordResetTemplate(name);
            helper.setText(htmlContent, true);
            mailSender.send(message);
            
            System.out.println("Faculty password reset confirmation sent to: " + to);
        } catch (Exception e) {
            System.err.println("Failed to send faculty password reset confirmation: " + e.getMessage());
        }
    }
    
    // =============================================
    // COMMON/OTHER EMAILS
    // =============================================
    
    // Send Fee Receipt Email
    public void sendFeeReceiptEmail(String to, String name, String receiptNumber, String amount, String course) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            
            helper.setTo(to);
            helper.setSubject("Smart IT Training - Fee Receipt Generated");
            
            String htmlContent = getFeeReceiptTemplate(name, receiptNumber, amount, course);
            helper.setText(htmlContent, true);
            mailSender.send(message);
            
            System.out.println("Fee receipt email sent to: " + to);
        } catch (Exception e) {
            System.err.println("Failed to send fee receipt email: " + e.getMessage());
        }
    }
    
    // Send Placement Application Confirmation
    public void sendPlacementApplicationEmail(String to, String name, String companyName) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            
            helper.setTo(to);
            helper.setSubject("Smart IT Training - Placement Application Submitted");
            
            String htmlContent = getPlacementApplicationTemplate(name, companyName);
            helper.setText(htmlContent, true);
            mailSender.send(message);
            
            System.out.println("Placement application email sent to: " + to);
        } catch (Exception e) {
            System.err.println("Failed to send placement application email: " + e.getMessage());
        }
    }
    
    // Send Notice Email to All Students
    public void sendBulkEmail(String[] recipients, String subject, String content) {
        try {
            for (String to : recipients) {
                MimeMessage message = mailSender.createMimeMessage();
                MimeMessageHelper helper = new MimeMessageHelper(message, true);
                
                helper.setTo(to);
                helper.setSubject(subject);
                helper.setText(content, true);
                mailSender.send(message);
            }
            System.out.println("Bulk email sent to: " + recipients.length + " recipients");
        } catch (Exception e) {
            System.err.println("Failed to send bulk email: " + e.getMessage());
        }
    }
    
    // =============================================
    // HTML TEMPLATES
    // =============================================
    
    // Admin Registration Template
    private String getAdminRegistrationTemplate(String name, String username, String password) {
        return "<!DOCTYPE html>" +
            "<html><head><style>" +
            "body { font-family: 'Poppins', Arial, sans-serif; line-height: 1.6; }" +
            ".container { max-width: 550px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 30px; text-align: center; border-radius: 15px 15px 0 0; }" +
            ".content { background: #f9f9f9; padding: 30px; border-radius: 0 0 15px 15px; }" +
            ".credentials { background: #fff; padding: 15px; border-radius: 10px; margin: 20px 0; border-left: 4px solid #667eea; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }" +
            ".btn { display: inline-block; background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 12px 25px; text-decoration: none; border-radius: 8px; margin: 10px 0; }" +
            ".footer { text-align: center; padding: 20px; font-size: 12px; color: #999; }" +
            "</style></head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'><h2>🏛️ Smart IT Training Centre</h2><p>Admin Registration Successful</p></div>" +
            "<div class='content'>" +
            "<h3>Dear " + name + ",</h3>" +
            "<p>Your Admin account has been successfully created!</p>" +
            "<div class='credentials'>" +
            "<p><strong>🔑 Login Credentials:</strong></p>" +
            "<p><strong>Username:</strong> " + username + "</p>" +
            "<p><strong>Password:</strong> " + password + "</p>" +
            "</div>" +
            "<div style='text-align: center;'>" +
            "<a href='http://localhost:8080/admin/login' class='btn'>Login to Dashboard</a>" +
            "</div>" +
            "<p>For security reasons, please change your password after first login.</p>" +
            "</div>" +
            "<div class='footer'><p>© 2025 Smart IT Training Centre. All rights reserved.</p></div>" +
            "</div>" +
            "</body></html>";
    }
    
    // Admin OTP Template
    private String getAdminOtpTemplate(String name, String otp) {
        return "<!DOCTYPE html>" +
            "<html><head><style>" +
            "body { font-family: 'Poppins', Arial, sans-serif; }" +
            ".container { max-width: 500px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 25px; text-align: center; border-radius: 15px 15px 0 0; }" +
            ".content { background: #f9f9f9; padding: 30px; text-align: center; }" +
            ".otp-code { background: linear-gradient(135deg, #667eea, #764ba2); color: white; font-size: 36px; font-weight: bold; padding: 20px; border-radius: 12px; letter-spacing: 8px; margin: 20px 0; }" +
            ".warning { background: #fff3cd; padding: 12px; border-radius: 8px; color: #856404; font-size: 13px; }" +
            "</style></head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'><h2>🔐 Smart IT Training Centre</h2><p>Admin Password Reset OTP</p></div>" +
            "<div class='content'>" +
            "<h3>Dear " + name + ",</h3>" +
            "<p>Use the following OTP to reset your password:</p>" +
            "<div class='otp-code'>" + otp + "</div>" +
            "<div class='warning'><strong>⚠️ Note:</strong> This OTP is valid for 10 minutes. Do not share it with anyone.</div>" +
            "<p>If you didn't request this, please ignore this email.</p>" +
            "</div>" +
            "</div>" +
            "</body></html>";
    }
    
    // Admin Password Reset Confirmation Template
    private String getAdminPasswordResetTemplate(String name) {
        return "<!DOCTYPE html>" +
            "<html><head><style>" +
            "body { font-family: 'Poppins', Arial, sans-serif; }" +
            ".container { max-width: 500px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #28a745, #20c997); color: white; padding: 25px; text-align: center; border-radius: 15px; }" +
            ".content { background: #f9f9f9; padding: 30px; text-align: center; border-radius: 0 0 15px 15px; }" +
            ".btn { display: inline-block; background: #28a745; color: white; padding: 12px 25px; text-decoration: none; border-radius: 8px; margin: 15px 0; }" +
            "</style></head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'><h2>✅ Password Reset Successful</h2></div>" +
            "<div class='content'>" +
            "<h3>Dear " + name + ",</h3>" +
            "<p>Your admin account password has been successfully reset.</p>" +
            "<a href='http://localhost:8080/admin/login' class='btn'>Login Now</a>" +
            "<p>If you didn't perform this action, please contact support immediately.</p>" +
            "</div>" +
            "</div>" +
            "</body></html>";
    }
    
    // Student Registration Template
    private String getStudentRegistrationTemplate(String name, String username, String password) {
        return "<!DOCTYPE html>" +
            "<html><head><style>" +
            "body { font-family: 'Poppins', Arial, sans-serif; }" +
            ".container { max-width: 550px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 25px; text-align: center; border-radius: 15px 15px 0 0; }" +
            ".content { background: #f9f9f9; padding: 30px; border-radius: 0 0 15px 15px; }" +
            ".credentials { background: #fff; padding: 15px; border-left: 4px solid #ffc107; margin: 15px 0; }" +
            ".status-box { background: #fff3cd; padding: 12px; border-radius: 8px; color: #856404; margin: 15px 0; }" +
            "</style></head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'><h2>🎓 Smart IT Training Centre</h2><p>Student Registration Submitted</p></div>" +
            "<div class='content'>" +
            "<h3>Dear " + name + ",</h3>" +
            "<p>Your student registration has been submitted successfully!</p>" +
            "<div class='credentials'>" +
            "<p><strong>📝 Registration Details:</strong></p>" +
            "<p><strong>Username:</strong> " + username + "</p>" +
            "<p><strong>Password:</strong> " + password + "</p>" +
            "</div>" +
            "<div class='status-box'>" +
            "<strong>⏳ Status:</strong> PENDING APPROVAL<br>" +
            "You will receive an email once your account is approved by admin." +
            "</div>" +
            "</div>" +
            "</div>" +
            "</body></html>";
    }
    
    // Student Approval Template
    private String getStudentApprovalTemplate(String name, String username, String password) {
        return "<!DOCTYPE html>" +
            "<html><head><style>" +
            "body { font-family: 'Poppins', Arial, sans-serif; }" +
            ".container { max-width: 550px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #28a745, #20c997); color: white; padding: 25px; text-align: center; border-radius: 15px; }" +
            ".content { background: #f9f9f9; padding: 30px; border-radius: 0 0 15px 15px; }" +
            ".btn { display: inline-block; background: #28a745; color: white; padding: 12px 25px; text-decoration: none; border-radius: 8px; margin: 15px 0; }" +
            "</style></head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'><h2>✅ Student Account Approved!</h2></div>" +
            "<div class='content'>" +
            "<h3>Dear " + name + ",</h3>" +
            "<p>Congratulations! Your student account has been approved.</p>" +
            "<p>You can now login using your credentials:</p>" +
            "<p><strong>Username:</strong> " + username + "</p>" +
            "<p><strong>Password:</strong> " + password + "</p>" +
            "<a href='http://localhost:8080/student/login' class='btn'>Login to Dashboard</a>" +
            "</div>" +
            "</div>" +
            "</body></html>";
    }
    
    // Student Rejection Template
    private String getStudentRejectionTemplate(String name, String reason) {
        return "<!DOCTYPE html>" +
            "<html><head><style>" +
            "body { font-family: 'Poppins', Arial, sans-serif; }" +
            ".container { max-width: 550px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #dc3545, #c82333); color: white; padding: 25px; text-align: center; border-radius: 15px; }" +
            ".content { background: #f9f9f9; padding: 30px; }" +
            "</style></head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'><h2>Student Registration Update</h2></div>" +
            "<div class='content'>" +
            "<h3>Dear " + name + ",</h3>" +
            "<p>We regret to inform you that your student registration has been declined.</p>" +
            "<p><strong>Reason:</strong> " + reason + "</p>" +
            "<p>Please contact the admin office for more details.</p>" +
            "</div>" +
            "</div>" +
            "</body></html>";
    }
    
    // Student OTP Template
    private String getStudentOtpTemplate(String name, String otp) {
        return "<!DOCTYPE html>" +
            "<html><head><style>" +
            "body { font-family: 'Poppins', Arial, sans-serif; }" +
            ".container { max-width: 500px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 25px; text-align: center; border-radius: 15px 15px 0 0; }" +
            ".otp-code { background: linear-gradient(135deg, #667eea, #764ba2); color: white; font-size: 36px; font-weight: bold; padding: 20px; text-align: center; letter-spacing: 8px; margin: 20px 0; }" +
            "</style></head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'><h2>🔐 Student Password Reset OTP</h2></div>" +
            "<div class='content'>" +
            "<h3>Dear " + name + ",</h3>" +
            "<p>Your OTP for password reset is:</p>" +
            "<div class='otp-code'>" + otp + "</div>" +
            "<p>This OTP is valid for 10 minutes.</p>" +
            "</div>" +
            "</div>" +
            "</body></html>";
    }
    
    // Student Password Reset Confirmation Template
    private String getStudentPasswordResetTemplate(String name) {
        return "<!DOCTYPE html>" +
            "<html><head><style>" +
            "body { font-family: 'Poppins', Arial, sans-serif; }" +
            ".container { max-width: 500px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #28a745, #20c997); color: white; padding: 25px; text-align: center; border-radius: 15px; }" +
            ".btn { display: inline-block; background: #28a745; color: white; padding: 12px 25px; text-decoration: none; border-radius: 8px; margin: 15px 0; }" +
            "</style></head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'><h2>✅ Password Reset Successful</h2></div>" +
            "<div class='content'>" +
            "<h3>Dear " + name + ",</h3>" +
            "<p>Your student account password has been successfully reset.</p>" +
            "<a href='http://localhost:8080/student/login' class='btn'>Login Now</a>" +
            "</div>" +
            "</div>" +
            "</body></html>";
    }
    
    // Faculty Registration Template
    private String getFacultyRegistrationTemplate(String name, String username, String password) {
        return "<!DOCTYPE html>" +
            "<html><head><style>" +
            "body { font-family: 'Poppins', Arial, sans-serif; }" +
            ".container { max-width: 550px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 25px; text-align: center; }" +
            ".credentials { background: #fff; padding: 15px; border-left: 4px solid #ffc107; margin: 15px 0; }" +
            "</style></head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'><h2>👩‍🏫 Smart IT Training Centre</h2><p>Faculty Registration Submitted</p></div>" +
            "<div class='content'>" +
            "<h3>Dear " + name + ",</h3>" +
            "<p>Your faculty registration has been submitted for approval.</p>" +
            "<div class='credentials'>" +
            "<p><strong>Username:</strong> " + username + "</p>" +
            "<p><strong>Password:</strong> " + password + "</p>" +
            "</div>" +
            "<p>You will receive an email once your account is approved.</p>" +
            "</div>" +
            "</div>" +
            "</body></html>";
    }
    
    // Faculty Approval Template
    private String getFacultyApprovalTemplate(String name, String username, String password) {
        return "<!DOCTYPE html>" +
            "<html><head><style>" +
            "body { font-family: 'Poppins', Arial, sans-serif; }" +
            ".container { max-width: 550px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #28a745, #20c997); color: white; padding: 25px; text-align: center; border-radius: 15px; }" +
            ".btn { display: inline-block; background: #28a745; color: white; padding: 12px 25px; text-decoration: none; border-radius: 8px; }" +
            "</style></head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'><h2>✅ Faculty Account Approved!</h2></div>" +
            "<div class='content'>" +
            "<h3>Dear " + name + ",</h3>" +
            "<p>Your faculty account has been approved!</p>" +
            "<p><strong>Username:</strong> " + username + "</p>" +
            "<p><strong>Password:</strong> " + password + "</p>" +
            "<a href='http://localhost:8080/faculty/login' class='btn'>Login to Dashboard</a>" +
            "</div>" +
            "</div>" +
            "</body></html>";
    }
    
    // Faculty Rejection Template
    private String getFacultyRejectionTemplate(String name, String reason) {
        return "<!DOCTYPE html>" +
            "<html><head><style>" +
            "body { font-family: 'Poppins', Arial, sans-serif; }" +
            ".container { max-width: 550px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #dc3545, #c82333); color: white; padding: 25px; text-align: center; }" +
            "</style></head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'><h2>Faculty Registration Update</h2></div>" +
            "<div class='content'>" +
            "<h3>Dear " + name + ",</h3>" +
            "<p>Your faculty registration has been declined.</p>" +
            "<p><strong>Reason:</strong> " + reason + "</p>" +
            "<p>Please contact admin for more details.</p>" +
            "</div>" +
            "</div>" +
            "</body></html>";
    }
    
    // Faculty OTP Template
    private String getFacultyOtpTemplate(String name, String otp) {
        return "<!DOCTYPE html>" +
            "<html><head><style>" +
            "body { font-family: 'Poppins', Arial, sans-serif; }" +
            ".container { max-width: 500px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 25px; text-align: center; }" +
            ".otp-code { background: linear-gradient(135deg, #667eea, #764ba2); color: white; font-size: 36px; font-weight: bold; padding: 20px; text-align: center; letter-spacing: 8px; margin: 20px 0; }" +
            "</style></head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'><h2>🔐 Faculty Password Reset OTP</h2></div>" +
            "<div class='content'>" +
            "<h3>Dear " + name + ",</h3>" +
            "<p>Your OTP for password reset is:</p>" +
            "<div class='otp-code'>" + otp + "</div>" +
            "<p>This OTP is valid for 10 minutes.</p>" +
            "</div>" +
            "</div>" +
            "</body></html>";
    }
    
    // Faculty Password Reset Confirmation Template
    private String getFacultyPasswordResetTemplate(String name) {
        return "<!DOCTYPE html>" +
            "<html><head><style>" +
            "body { font-family: 'Poppins', Arial, sans-serif; }" +
            ".container { max-width: 500px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #28a745, #20c997); color: white; padding: 25px; text-align: center; border-radius: 15px; }" +
            ".btn { display: inline-block; background: #28a745; color: white; padding: 12px 25px; text-decoration: none; border-radius: 8px; }" +
            "</style></head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'><h2>✅ Password Reset Successful</h2></div>" +
            "<div class='content'>" +
            "<h3>Dear " + name + ",</h3>" +
            "<p>Your faculty account password has been successfully reset.</p>" +
            "<a href='http://localhost:8080/faculty/login' class='btn'>Login Now</a>" +
            "</div>" +
            "</div>" +
            "</body></html>";
    }
    
    // Fee Receipt Template
    private String getFeeReceiptTemplate(String name, String receiptNumber, String amount, String course) {
        return "<!DOCTYPE html>" +
            "<html><head><style>" +
            "body { font-family: 'Poppins', Arial, sans-serif; }" +
            ".container { max-width: 550px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 25px; text-align: center; }" +
            ".receipt-details { background: #f0f0f0; padding: 20px; border-radius: 10px; margin: 20px 0; }" +
            "</style></head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'><h2>💰 Fee Receipt Generated</h2></div>" +
            "<div class='content'>" +
            "<h3>Dear " + name + ",</h3>" +
            "<div class='receipt-details'>" +
            "<p><strong>Receipt Number:</strong> " + receiptNumber + "</p>" +
            "<p><strong>Course:</strong> " + course + "</p>" +
            "<p><strong>Amount Paid:</strong> ₹" + amount + "</p>" +
            "</div>" +
            "<p>Download your receipt from the student portal.</p>" +
            "</div>" +
            "</div>" +
            "</body></html>";
    }
    
    // Placement Application Template
    private String getPlacementApplicationTemplate(String name, String companyName) {
        return "<!DOCTYPE html>" +
            "<html><head><style>" +
            "body { font-family: 'Poppins', Arial, sans-serif; }" +
            ".container { max-width: 550px; margin: 0 auto; padding: 20px; }" +
            ".header { background: linear-gradient(135deg, #28a745, #20c997); color: white; padding: 25px; text-align: center; border-radius: 15px; }" +
            "</style></head>" +
            "<body>" +
            "<div class='container'>" +
            "<div class='header'><h2>📢 Placement Application Submitted</h2></div>" +
            "<div class='content'>" +
            "<h3>Dear " + name + ",</h3>" +
            "<p>Your application for <strong>" + companyName + "</strong> has been submitted successfully.</p>" +
            "<p>You will be notified once shortlisted.</p>" +
            "<p>Good luck!</p>" +
            "</div>" +
            "</div>" +
            "</body></html>";
    }
}
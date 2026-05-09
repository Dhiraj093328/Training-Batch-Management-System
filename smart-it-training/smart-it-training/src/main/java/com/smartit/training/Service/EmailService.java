package com.smartit.training.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import jakarta.mail.internet.MimeMessage;

@Service
public class EmailService {
    
    @Autowired
    private JavaMailSender mailSender;
    
    // Send OTP Email for Forgot Password
    public void sendOtpEmail(String to, String name, String otp) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            
            helper.setTo(to);
            helper.setSubject("Smart IT Training - Password Reset OTP");
            
            String htmlContent = "<!DOCTYPE html>" +
                "<html>" +
                "<head>" +
                "<style>" +
                "body { font-family: 'Poppins', Arial, sans-serif; line-height: 1.6; }" +
                ".container { max-width: 550px; margin: 0 auto; padding: 20px; }" +
                ".header { background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 25px; text-align: center; border-radius: 15px 15px 0 0; }" +
                ".content { background: #f9f9f9; padding: 30px; border-radius: 0 0 15px 15px; }" +
                ".otp-box { background: linear-gradient(135deg, #667eea, #764ba2); color: white; font-size: 32px; font-weight: bold; text-align: center; padding: 20px; border-radius: 12px; letter-spacing: 8px; margin: 20px 0; }" +
                ".footer { text-align: center; padding: 20px; font-size: 12px; color: #999; }" +
                ".warning { background: #fff3cd; padding: 12px; border-radius: 8px; margin: 15px 0; color: #856404; font-size: 13px; }" +
                "</style>" +
                "</head>" +
                "<body>" +
                "<div class='container'>" +
                "<div class='header'>" +
                "<h2>🔐 Smart IT Training Centre</h2>" +
                "<p>Password Reset OTP</p>" +
                "</div>" +
                "<div class='content'>" +
                "<h3>Dear " + name + ",</h3>" +
                "<p>We received a request to reset your password. Use the OTP below to verify your identity:</p>" +
                "<div class='otp-box'>" + otp + "</div>" +
                "<div class='warning'>" +
                "<strong>⚠️ Note:</strong> This OTP is valid for <strong>10 minutes</strong>. Do not share it with anyone." +
                "</div>" +
                "<p>If you didn't request this, please ignore this email.</p>" +
                "</div>" +
                "<div class='footer'>" +
                "<p>© 2024 Smart IT Training Centre. All rights reserved.</p>" +
                "</div>" +
                "</div>" +
                "</body>" +
                "</html>";
            
            helper.setText(htmlContent, true);
            mailSender.send(message);
            
            System.out.println("OTP email sent to: " + to);
            
        } catch (Exception e) {
            System.err.println("Failed to send OTP email: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    // Send Registration Success Email
    public void sendRegistrationSuccessEmail(String to, String name, String username, String password) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            
            helper.setTo(to);
            helper.setSubject("Welcome to Smart IT Training - Registration Successful");
            
            String htmlContent = "<!DOCTYPE html>" +
                "<html>" +
                "<head>" +
                "<style>" +
                "body { font-family: 'Poppins', Arial, sans-serif; }" +
                ".container { max-width: 550px; margin: 0 auto; padding: 20px; }" +
                ".header { background: linear-gradient(135deg, #667eea, #764ba2); color: white; padding: 25px; text-align: center; border-radius: 15px 15px 0 0; }" +
                ".content { background: #f9f9f9; padding: 30px; border-radius: 0 0 15px 15px; }" +
                ".credentials { background: #fff; padding: 15px; border-radius: 8px; margin: 15px 0; border-left: 4px solid #667eea; }" +
                "</style>" +
                "</head>" +
                "<body>" +
                "<div class='container'>" +
                "<div class='header'><h2>Smart IT Training Centre</h2></div>" +
                "<div class='content'>" +
                "<h3>Dear " + name + ",</h3>" +
                "<p>Your Admin account has been successfully created!</p>" +
                "<div class='credentials'>" +
                "<p><strong>Username:</strong> " + username + "</p>" +
                "<p><strong>Password:</strong> " + password + "</p>" +
                "</div>" +
                "<p>Login URL: http://localhost:8080/admin/login</p>" +
                "</div>" +
                "</div>" +
                "</body>" +
                "</html>";
            
            helper.setText(htmlContent, true);
            mailSender.send(message);
            
        } catch (Exception e) {
            System.err.println("Failed to send registration email: " + e.getMessage());
        }
    }
}
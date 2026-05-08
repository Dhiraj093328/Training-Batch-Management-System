package com.smartit.training.controller;

import com.smartit.training.model.Admin;
import com.smartit.training.repository.AdminRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.Random;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminRepository adminRepository;
    
    // Show Login Page
    @GetMapping("/login")
    public String showLoginPage(HttpSession session) {
        if (session.getAttribute("adminId") != null) {
            return "redirect:/admin/dashboard";
        }
        System.out.println("===== ADMIN LOGIN PAGE CALLED =====");
        return "admin/admin-login";
    }
    
    // Process Login - Using username from your database
    @PostMapping("/login")
    public String processLogin(@RequestParam String userId,
                               @RequestParam String password,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        System.out.println("===== LOGIN ATTEMPT =====");
        System.out.println("Username: " + userId);
        
        // Find admin by username (matches your database column)
        Optional<Admin> adminOpt = adminRepository.findByUsername(userId);
        
        if (adminOpt.isPresent()) {
            Admin admin = adminOpt.get();
            if (admin.getPassword().equals(password)) {
                // Set session attributes
                session.setAttribute("adminId", admin.getId());
                session.setAttribute("adminName", admin.getName());
                session.setAttribute("adminUsername", admin.getUsername());
                session.setAttribute("adminEmail", admin.getEmail());
                session.setAttribute("adminOffice", admin.getOfficeName());
                session.setAttribute("loginTime", LocalDateTime.now().toString());
                
                System.out.println("===== LOGIN SUCCESSFUL =====");
                System.out.println("Admin: " + admin.getName());
                System.out.println("Office: " + admin.getOfficeName());
                return "redirect:/admin/dashboard";
            } else {
                System.out.println("===== LOGIN FAILED - Wrong password =====");
            }
        } else {
            System.out.println("===== LOGIN FAILED - Username not found =====");
        }
        
        redirectAttributes.addAttribute("error", "true");
        return "redirect:/admin/login";
    }
    
    // Show Dashboard
    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session) {
        if (session.getAttribute("adminId") == null) {
            return "redirect:/admin/login";
        }
        return "admin/admin-dashboard";
    }
    
    // Show Registration Page
    @GetMapping("/register")
    public String showRegisterPage() {
        return "admin/admin-register";
    }
    
    // Process Registration - Matches your database schema
    @PostMapping("/register")
    public String processRegister(@RequestParam String name,
                                  @RequestParam String contact,
                                  @RequestParam String email,
                                  @RequestParam String officeName,
                                  @RequestParam String username,
                                  @RequestParam String password,
                                  @RequestParam String confirmPassword,
                                  RedirectAttributes redirectAttributes) {
        
        System.out.println("===== REGISTRATION ATTEMPT =====");
        System.out.println("Name: " + name);
        System.out.println("Email: " + email);
        System.out.println("Username: " + username);
        System.out.println("Office: " + officeName);
        
        // Validation
        if (!password.equals(confirmPassword)) {
            redirectAttributes.addAttribute("error", "password");
            return "redirect:/admin/register";
        }
        
        if (password.length() < 6) {
            redirectAttributes.addAttribute("error", "weak");
            return "redirect:/admin/register";
        }
        
        // Check if username already exists
        if (adminRepository.existsByUsername(username)) {
            System.out.println("===== REGISTRATION FAILED - Username exists =====");
            redirectAttributes.addAttribute("error", "exists");
            return "redirect:/admin/register";
        }
        
        // Check if email already exists
        if (adminRepository.existsByEmail(email)) {
            System.out.println("===== REGISTRATION FAILED - Email exists =====");
            redirectAttributes.addAttribute("error", "email");
            return "redirect:/admin/register";
        }
        
        // Create new Admin (matching your database columns)
        Admin newAdmin = new Admin();
        newAdmin.setName(name);
        newAdmin.setContact(contact);
        newAdmin.setEmail(email);
        newAdmin.setOfficeName(officeName);
        newAdmin.setUsername(username);
        newAdmin.setPassword(password); // In production, encode password
        newAdmin.setCreatedAt(LocalDateTime.now());
        
        adminRepository.save(newAdmin);
        
        System.out.println("===== REGISTRATION SUCCESSFUL =====");
        System.out.println("Admin saved with ID: " + newAdmin.getId());
        
        redirectAttributes.addAttribute("registered", "true");
        return "redirect:/admin/login";
    }
    
    // Forgot Password - Send OTP
    @PostMapping("/forgot-password/send-otp")
    public String sendOtp(@RequestParam String identifier, 
                          HttpSession session,
                          RedirectAttributes redirectAttributes) {
        
        Optional<Admin> adminOpt = adminRepository.findByUsername(identifier);
        if (adminOpt.isEmpty()) {
            adminOpt = adminRepository.findByEmail(identifier);
        }
        
        if (adminOpt.isEmpty()) {
            redirectAttributes.addAttribute("error", "notfound");
            return "redirect:/admin/forgot-password";
        }
        
        String otp = String.format("%06d", new Random().nextInt(999999));
        session.setAttribute("resetOtp", otp);
        session.setAttribute("resetIdentifier", identifier);
        session.setAttribute("resetAdminId", adminOpt.get().getId());
        
        System.out.println("========================================");
        System.out.println("OTP for " + identifier + ": " + otp);
        System.out.println("========================================");
        
        redirectAttributes.addAttribute("step", "otp");
        redirectAttributes.addAttribute("identifier", identifier);
        return "redirect:/admin/forgot-password";
    }
    
    // Verify OTP
    @PostMapping("/forgot-password/verify-otp")
    public String verifyOtp(@RequestParam String identifier,
                            @RequestParam String otp,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        
        String sessionOtp = (String) session.getAttribute("resetOtp");
        String sessionIdentifier = (String) session.getAttribute("resetIdentifier");
        
        if (sessionOtp != null && sessionOtp.equals(otp) && sessionIdentifier.equals(identifier)) {
            redirectAttributes.addAttribute("step", "reset");
            redirectAttributes.addAttribute("identifier", identifier);
        } else {
            redirectAttributes.addAttribute("step", "otp");
            redirectAttributes.addAttribute("identifier", identifier);
            redirectAttributes.addAttribute("error", "invalid");
        }
        return "redirect:/admin/forgot-password";
    }
    
    // Reset Password
    @PostMapping("/forgot-password/reset")
    public String resetPassword(@RequestParam String identifier,
                                @RequestParam String newPassword,
                                @RequestParam String confirmPassword,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        
        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addAttribute("step", "reset");
            redirectAttributes.addAttribute("identifier", identifier);
            redirectAttributes.addAttribute("error", "mismatch");
            return "redirect:/admin/forgot-password";
        }
        
        Optional<Admin> adminOpt = adminRepository.findByUsername(identifier);
        if (adminOpt.isEmpty()) {
            adminOpt = adminRepository.findByEmail(identifier);
        }
        
        if (adminOpt.isPresent()) {
            Admin admin = adminOpt.get();
            admin.setPassword(newPassword);
            adminRepository.save(admin);
            
            System.out.println("===== PASSWORD RESET SUCCESSFUL =====");
            System.out.println("Admin: " + admin.getName());
        }
        
        session.removeAttribute("resetOtp");
        session.removeAttribute("resetIdentifier");
        
        redirectAttributes.addAttribute("reset", "success");
        return "redirect:/admin/login";
    }
    
    // Resend OTP
    @PostMapping("/forgot-password/resend-otp")
    @ResponseBody
    public Map<String, Object> resendOtp(@RequestParam String identifier, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        String otp = String.format("%06d", new Random().nextInt(999999));
        session.setAttribute("resetOtp", otp);
        session.setAttribute("resetIdentifier", identifier);
        
        System.out.println("===== RESEND OTP: " + otp + " for " + identifier + " =====");
        
        response.put("success", true);
        response.put("message", "OTP resent successfully!");
        return response;
    }
    
    // Logout
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        System.out.println("===== ADMIN LOGGED OUT: " + session.getAttribute("adminName") + " =====");
        session.invalidate();
        return "redirect:/admin/login";
    }
}
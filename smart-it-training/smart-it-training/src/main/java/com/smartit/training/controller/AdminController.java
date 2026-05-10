package com.smartit.training.controller;

import com.smartit.training.model.Admin;
import com.smartit.training.model.Student;
import com.smartit.training.repository.AdminRepository;
import com.smartit.training.repository.StudentRepository;
import com.smartit.training.service.EmailService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Random;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminRepository adminRepository;
    
    @Autowired
    private StudentRepository studentRepository;
    
    @Autowired
    private EmailService emailService;
    
    // =============================================
    // REGISTRATION
    // =============================================
    
    @GetMapping("/register")
    public String showRegisterPage() {
        return "admin/admin-register";
    }
    
    @PostMapping("/register")
    public String processRegister(@RequestParam String name,
                                  @RequestParam String contact,
                                  @RequestParam String email,
                                  @RequestParam String officeName,
                                  @RequestParam String username,
                                  @RequestParam String password,
                                  @RequestParam String confirmPassword,
                                  RedirectAttributes redirectAttributes) {
        
        System.out.println("===== ADMIN REGISTRATION =====");
        System.out.println("Name: " + name);
        System.out.println("Email: " + email);
        System.out.println("Username: " + username);
        
        if (!password.equals(confirmPassword)) {
            redirectAttributes.addAttribute("error", "password");
            return "redirect:/admin/register";
        }
        
        if (password.length() < 6) {
            redirectAttributes.addAttribute("error", "weak");
            return "redirect:/admin/register";
        }
        
        if (adminRepository.existsByUsername(username)) {
            redirectAttributes.addAttribute("error", "exists");
            return "redirect:/admin/register";
        }
        
        if (adminRepository.existsByEmail(email)) {
            redirectAttributes.addAttribute("error", "email");
            return "redirect:/admin/register";
        }
        
        Admin newAdmin = new Admin();
        newAdmin.setName(name);
        newAdmin.setContact(contact);
        newAdmin.setEmail(email);
        newAdmin.setOfficeName(officeName);
        newAdmin.setUsername(username);
        newAdmin.setPassword(password);
        newAdmin.setIsActive(true);
        newAdmin.setCreatedAt(LocalDateTime.now());
        newAdmin.setUpdatedAt(LocalDateTime.now());
        
        adminRepository.save(newAdmin);
        
        System.out.println("Admin registered successfully with ID: " + newAdmin.getId());
        
        redirectAttributes.addAttribute("registered", "true");
        return "redirect:/admin/login";
    }
    
    // =============================================
    // LOGIN
    // =============================================
    
    @GetMapping("/login")
    public String showLoginPage(HttpSession session) {
        if (session.getAttribute("adminId") != null) {
            return "redirect:/admin/dashboard";
        }
        return "admin/admin-login";
    }
    
    @PostMapping("/login")
    public String processLogin(@RequestParam String userId,
                               @RequestParam String password,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        System.out.println("===== ADMIN LOGIN =====");
        System.out.println("User ID: " + userId);
        
        Optional<Admin> adminOpt = adminRepository.findByUsername(userId);
        
        if (adminOpt.isEmpty()) {
            adminOpt = adminRepository.findByEmail(userId);
        }
        
        if (adminOpt.isPresent()) {
            Admin admin = adminOpt.get();
            if (admin.getPassword().equals(password)) {
                session.setAttribute("adminId", admin.getId());
                session.setAttribute("adminName", admin.getName());
                session.setAttribute("adminUsername", admin.getUsername());
                session.setAttribute("adminEmail", admin.getEmail());
                session.setAttribute("adminOffice", admin.getOfficeName());
                session.setAttribute("loginTime", LocalDateTime.now().toString());
                
                System.out.println("Admin logged in: " + admin.getName());
                return "redirect:/admin/dashboard";
            } else {
                System.out.println("Login failed: Wrong password");
            }
        } else {
            System.out.println("Login failed: User not found");
        }
        
        redirectAttributes.addAttribute("error", "true");
        return "redirect:/admin/login";
    }
    
    // =============================================
    // DASHBOARD - MAIN DASHBOARD
    // =============================================
    
    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        if (session.getAttribute("adminId") == null) {
            return "redirect:/admin/login";
        }
        
        // Get student data for dashboard
        List<Student> pendingStudents = studentRepository.findByStatus(Student.Status.PENDING);
        List<Student> approvedStudents = studentRepository.findByStatus(Student.Status.APPROVED);
        List<Student> rejectedStudents = studentRepository.findByStatus(Student.Status.REJECTED);
        
        // Calculate counts
        long totalStudents = studentRepository.count();
        long pendingCount = pendingStudents.size();
        long approvedCount = approvedStudents.size();
        long rejectedCount = rejectedStudents.size();
        
        // Add attributes to model
        model.addAttribute("pendingStudents", pendingStudents);
        model.addAttribute("approvedStudents", approvedStudents);
        model.addAttribute("rejectedStudents", rejectedStudents);
        model.addAttribute("pendingStudentsCount", pendingCount);
        model.addAttribute("approvedStudentsCount", approvedCount);
        model.addAttribute("rejectedStudentsCount", rejectedCount);
        model.addAttribute("totalStudentsCount", totalStudents);
        model.addAttribute("pendingFacultyCount", 0); // TODO: Add faculty repository
        
        System.out.println("===== ADMIN DASHBOARD =====");
        System.out.println("Total Students: " + totalStudents);
        System.out.println("Pending Students: " + pendingCount);
        System.out.println("Approved Students: " + approvedCount);
        
        return "admin/admin-dashboard";
    }
    
    // =============================================
    // STUDENT MANAGEMENT - APPROVAL METHODS
    // =============================================
    
    // Approve Student Request
    @PostMapping("/approve-student")
    @ResponseBody
    public Map<String, Object> approveStudent(@RequestParam Integer studentId, 
                                               HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        Integer adminId = (Integer) session.getAttribute("adminId");
        String adminName = (String) session.getAttribute("adminName");
        
        System.out.println("===== APPROVE STUDENT =====");
        System.out.println("Student ID: " + studentId);
        System.out.println("Approved by: " + adminName);
        
        Optional<Student> studentOpt = studentRepository.findById(studentId);
        
        if (studentOpt.isPresent()) {
            Student student = studentOpt.get();
            
            // Update student status
            student.setStatus(Student.Status.APPROVED);
            student.setApprovedBy(adminId);
            student.setApprovedAt(LocalDateTime.now());
            student.setUpdatedAt(LocalDateTime.now());
            studentRepository.save(student);
            
            System.out.println("Student approved: " + student.getName());
            
            // Send approval email to student
            try {
                emailService.sendStudentApprovalEmail(
                    student.getEmail(), 
                    student.getName(), 
                    student.getUsername(), 
                    student.getPassword()
                );
                System.out.println("Approval email sent to: " + student.getEmail());
            } catch(Exception e) {
                System.out.println("Email sending failed: " + e.getMessage());
            }
            
            response.put("success", true);
            response.put("message", "Student approved successfully!");
            response.put("studentId", studentId);
        } else {
            response.put("success", false);
            response.put("message", "Student not found!");
        }
        
        return response;
    }
    
    // Reject Student Request
    @PostMapping("/reject-student")
    @ResponseBody
    public Map<String, Object> rejectStudent(@RequestParam Integer studentId,
                                              @RequestParam(required = false) String reason,
                                              HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        Integer adminId = (Integer) session.getAttribute("adminId");
        String adminName = (String) session.getAttribute("adminName");
        
        System.out.println("===== REJECT STUDENT =====");
        System.out.println("Student ID: " + studentId);
        System.out.println("Rejected by: " + adminName);
        System.out.println("Reason: " + (reason != null ? reason : "Not specified"));
        
        Optional<Student> studentOpt = studentRepository.findById(studentId);
        
        if (studentOpt.isPresent()) {
            Student student = studentOpt.get();
            
            // Update student status
            student.setStatus(Student.Status.REJECTED);
            student.setApprovedBy(adminId);
            student.setApprovedAt(LocalDateTime.now());
            student.setUpdatedAt(LocalDateTime.now());
            studentRepository.save(student);
            
            System.out.println("Student rejected: " + student.getName());
            
            // Send rejection email
            String rejectReason = (reason != null && !reason.isEmpty()) ? reason : "Not specified";
            try {
                emailService.sendStudentRejectionEmail(student.getEmail(), student.getName(), rejectReason);
                System.out.println("Rejection email sent to: " + student.getEmail());
            } catch(Exception e) {
                System.out.println("Email sending failed: " + e.getMessage());
            }
            
            response.put("success", true);
            response.put("message", "Student rejected!");
            response.put("studentId", studentId);
        } else {
            response.put("success", false);
            response.put("message", "Student not found!");
        }
        
        return response;
    }
    
    // =============================================
    // FORGOT PASSWORD - OTP BASED
    // =============================================
    
    // Store OTP in memory
    private Map<String, OtpData> otpStorage = new HashMap<>();
    
    class OtpData {
        String otp;
        LocalDateTime expiryTime;
        String identifier;
        
        OtpData(String otp, String identifier) {
            this.otp = otp;
            this.identifier = identifier;
            this.expiryTime = LocalDateTime.now().plusMinutes(10);
        }
        
        boolean isValid() {
            return LocalDateTime.now().isBefore(expiryTime);
        }
    }
    
    // Show Forgot Password Page
    @GetMapping("/forgot-password")
    public String showForgotPassword() {
        return "admin/admin-forgot-password";
    }
    
    // Send OTP to email
    @PostMapping("/forgot-password/send-otp")
    public String sendOtp(@RequestParam String identifier,
                          HttpSession session,
                          RedirectAttributes redirectAttributes) {
        
        System.out.println("===== SEND OTP REQUEST =====");
        System.out.println("Identifier: " + identifier);
        
        // Find admin by email or username
        Optional<Admin> adminOpt = adminRepository.findByEmail(identifier);
        if (adminOpt.isEmpty()) {
            adminOpt = adminRepository.findByUsername(identifier);
        }
        
        if (adminOpt.isEmpty()) {
            System.out.println("Identifier not found: " + identifier);
            redirectAttributes.addAttribute("error", "notfound");
            return "redirect:/admin/forgot-password";
        }
        
        Admin admin = adminOpt.get();
        
        // Generate 6-digit OTP
        String otp = String.format("%06d", new Random().nextInt(999999));
        
        // Store OTP
        otpStorage.put(admin.getEmail(), new OtpData(otp, admin.getEmail()));
        
        // Send OTP via email
        emailService.sendAdminOtpEmail(admin.getEmail(), admin.getName(), otp);
        
        System.out.println("OTP sent to: " + admin.getEmail());
        System.out.println("OTP: " + otp);
        
        // Store in session for verification
        session.setAttribute("resetIdentifier", admin.getEmail());
        
        redirectAttributes.addAttribute("step", "otp");
        redirectAttributes.addAttribute("identifier", admin.getEmail());
        return "redirect:/admin/forgot-password";
    }
    
    // Verify OTP
    @PostMapping("/forgot-password/verify-otp")
    public String verifyOtp(@RequestParam String identifier,
                            @RequestParam String otp,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        
        System.out.println("===== VERIFY OTP =====");
        System.out.println("Identifier: " + identifier);
        System.out.println("Entered OTP: " + otp);
        
        OtpData otpData = otpStorage.get(identifier);
        
        if (otpData == null) {
            System.out.println("No OTP found for: " + identifier);
            redirectAttributes.addAttribute("step", "otp");
            redirectAttributes.addAttribute("identifier", identifier);
            redirectAttributes.addAttribute("error", "invalid");
            return "redirect:/admin/forgot-password";
        }
        
        if (!otpData.isValid()) {
            System.out.println("OTP expired for: " + identifier);
            otpStorage.remove(identifier);
            redirectAttributes.addAttribute("step", "otp");
            redirectAttributes.addAttribute("identifier", identifier);
            redirectAttributes.addAttribute("error", "expired");
            return "redirect:/admin/forgot-password";
        }
        
        if (!otpData.otp.equals(otp)) {
            System.out.println("Invalid OTP for: " + identifier);
            redirectAttributes.addAttribute("step", "otp");
            redirectAttributes.addAttribute("identifier", identifier);
            redirectAttributes.addAttribute("error", "invalid");
            return "redirect:/admin/forgot-password";
        }
        
        // OTP verified successfully
        System.out.println("OTP verified successfully for: " + identifier);
        session.setAttribute("resetVerified", true);
        session.setAttribute("resetIdentifier", identifier);
        
        redirectAttributes.addAttribute("step", "reset");
        redirectAttributes.addAttribute("identifier", identifier);
        return "redirect:/admin/forgot-password";
    }
    
    // Reset Password
    @PostMapping("/forgot-password/reset")
    public String resetPassword(@RequestParam String identifier,
                                @RequestParam String newPassword,
                                @RequestParam String confirmPassword,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        
        System.out.println("===== RESET PASSWORD =====");
        System.out.println("Identifier: " + identifier);
        
        // Check if OTP was verified
        Boolean isVerified = (Boolean) session.getAttribute("resetVerified");
        String sessionIdentifier = (String) session.getAttribute("resetIdentifier");
        
        if (isVerified == null || !isVerified || sessionIdentifier == null || !sessionIdentifier.equals(identifier)) {
            System.out.println("Unauthorized reset attempt");
            redirectAttributes.addAttribute("error", "unauthorized");
            return "redirect:/admin/forgot-password";
        }
        
        // Validate passwords
        if (!newPassword.equals(confirmPassword)) {
            System.out.println("Passwords do not match");
            redirectAttributes.addAttribute("step", "reset");
            redirectAttributes.addAttribute("identifier", identifier);
            redirectAttributes.addAttribute("error", "mismatch");
            return "redirect:/admin/forgot-password";
        }
        
        if (newPassword.length() < 6) {
            System.out.println("Password too short");
            redirectAttributes.addAttribute("step", "reset");
            redirectAttributes.addAttribute("identifier", identifier);
            redirectAttributes.addAttribute("error", "weak");
            return "redirect:/admin/forgot-password";
        }
        
        // Find admin and update password
        Optional<Admin> adminOpt = adminRepository.findByEmail(identifier);
        if (adminOpt.isEmpty()) {
            adminOpt = adminRepository.findByUsername(identifier);
        }
        
        if (adminOpt.isEmpty()) {
            redirectAttributes.addAttribute("error", "notfound");
            return "redirect:/admin/forgot-password";
        }
        
        Admin admin = adminOpt.get();
        admin.setPassword(newPassword);
        admin.setUpdatedAt(LocalDateTime.now());
        adminRepository.save(admin);
        
        // Clear OTP and session
        otpStorage.remove(identifier);
        session.removeAttribute("resetVerified");
        session.removeAttribute("resetIdentifier");
        
        System.out.println("Password reset successful for: " + admin.getEmail());
        
        redirectAttributes.addAttribute("reset", "success");
        return "redirect:/admin/login";
    }
    
    // Resend OTP - AJAX endpoint
    @PostMapping("/forgot-password/resend-otp")
    @ResponseBody
    public Map<String, Object> resendOtp(@RequestParam String identifier, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        System.out.println("===== RESEND OTP =====");
        System.out.println("Identifier: " + identifier);
        
        Optional<Admin> adminOpt = adminRepository.findByEmail(identifier);
        if (adminOpt.isEmpty()) {
            adminOpt = adminRepository.findByUsername(identifier);
        }
        
        if (adminOpt.isEmpty()) {
            response.put("success", false);
            response.put("message", "Account not found!");
            return response;
        }
        
        Admin admin = adminOpt.get();
        
        // Generate new OTP
        String otp = String.format("%06d", new Random().nextInt(999999));
        
        // Update stored OTP
        otpStorage.put(admin.getEmail(), new OtpData(otp, admin.getEmail()));
        
        // Send OTP via email
        emailService.sendAdminOtpEmail(admin.getEmail(), admin.getName(), otp);
        
        System.out.println("New OTP sent to: " + admin.getEmail());
        System.out.println("New OTP: " + otp);
        
        response.put("success", true);
        response.put("message", "OTP resent successfully!");
        return response;
    }
    
    // =============================================
    // LOGOUT
    // =============================================
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        System.out.println("===== ADMIN LOGGED OUT =====");
        System.out.println("Admin: " + session.getAttribute("adminName"));
        session.invalidate();
        return "redirect:/admin/login";
    }
}
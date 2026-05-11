package com.smartit.training.controller;

import com.smartit.training.model.Batch;
import com.smartit.training.model.Student;
import com.smartit.training.repository.BatchRepository;
import com.smartit.training.repository.StudentRepository;
import com.smartit.training.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.*;

@Controller
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private StudentRepository studentRepository;
    
    @Autowired
    private BatchRepository batchRepository;
    
    @Autowired
    private EmailService emailService;
    
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
    
    // =============================================
    // REGISTRATION
    // =============================================
    
    @GetMapping("/register")
    public String showRegisterPage(Model model) {
        List<Batch> batches = batchRepository.findAll();
        model.addAttribute("batches", batches);
        return "student/student-register";
    }
    
    @PostMapping("/register")
    public String processRegister(@RequestParam String name,
                                  @RequestParam String contact,
                                  @RequestParam String email,
                                  @RequestParam String adminOfficeName,
                                  @RequestParam String batchName,
                                  @RequestParam String username,
                                  @RequestParam String password,
                                  @RequestParam String confirmPassword,
                                  RedirectAttributes redirectAttributes) {
        
        System.out.println("===== STUDENT REGISTRATION =====");
        System.out.println("Name: " + name);
        System.out.println("Email: " + email);
        System.out.println("Username: " + username);
        System.out.println("Batch: " + batchName);
        System.out.println("Admin Office: " + adminOfficeName);
        
        // Validation 1: Check passwords match
        if (!password.equals(confirmPassword)) {
            redirectAttributes.addAttribute("error", "password");
            return "redirect:/student/register";
        }
        
        // Validation 2: Check password length
        if (password.length() < 6) {
            redirectAttributes.addAttribute("error", "weak");
            return "redirect:/student/register";
        }
        
        // Validation 3: Check if username exists
        if (studentRepository.existsByUsername(username)) {
            redirectAttributes.addAttribute("error", "exists");
            return "redirect:/student/register";
        }
        
        // Validation 4: Check if email exists
        if (studentRepository.existsByEmail(email)) {
            redirectAttributes.addAttribute("error", "email");
            return "redirect:/student/register";
        }
        
        // Create new student with PENDING status
        Student student = new Student();
        student.setName(name);
        student.setContact(contact);
        student.setEmail(email);
        student.setAdminOfficeName(adminOfficeName);
        student.setBatchName(batchName);
        student.setUsername(username);
        student.setPassword(password);
        student.setStatus(Student.Status.PENDING);  // IMPORTANT: Status is PENDING
        student.setCreatedAt(LocalDateTime.now());
        student.setUpdatedAt(LocalDateTime.now());
        
        // Generate unique enrollment number
        String enrollmentNo = "SIT" + String.format("%06d", System.currentTimeMillis() % 1000000);
        student.setEnrollmentNo(enrollmentNo);
        
        // Save to database
        Student savedStudent = studentRepository.save(student);
        
        System.out.println("========================================");
        System.out.println("✅ STUDENT REGISTERED SUCCESSFULLY");
        System.out.println("Student ID: " + savedStudent.getId());
        System.out.println("Name: " + savedStudent.getName());
        System.out.println("Status: PENDING - Waiting for admin approval");
        System.out.println("========================================");
        
        // Send email notification to student
        try {
            emailService.sendStudentRegistrationEmail(email, name, username, password);
            System.out.println("Registration email sent to: " + email);
        } catch(Exception e) {
            System.out.println("Email sending failed: " + e.getMessage());
        }
        
        redirectAttributes.addAttribute("registered", "true");
        return "redirect:/student/login";
    }
    
    // =============================================
    // LOGIN
    // =============================================
    
    @GetMapping("/login")
    public String showLoginPage(HttpSession session) {
        if (session.getAttribute("studentId") != null) {
            return "redirect:/student/dashboard";
        }
        return "student/student-login";
    }
    
    @PostMapping("/login")
    public String processLogin(@RequestParam String userId,
                               @RequestParam String password,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        System.out.println("===== STUDENT LOGIN =====");
        System.out.println("User ID: " + userId);
        
        Optional<Student> studentOpt = studentRepository.findByUsername(userId);
        if (studentOpt.isEmpty()) {
            studentOpt = studentRepository.findByEmail(userId);
        }
        
        if (studentOpt.isPresent()) {
            Student student = studentOpt.get();
            
            System.out.println("Student found: " + student.getName());
            System.out.println("Current Status: " + student.getStatus());
            
            // Check if account is approved
            if (student.getStatus() != Student.Status.APPROVED) {
                System.out.println("Login failed: Account not approved yet");
                redirectAttributes.addAttribute("error", "pending");
                return "redirect:/student/login";
            }
            
            // Check password
            if (student.getPassword().equals(password)) {
                session.setAttribute("studentId", student.getId());
                session.setAttribute("studentName", student.getName());
                session.setAttribute("studentUsername", student.getUsername());
                session.setAttribute("studentEmail", student.getEmail());
                session.setAttribute("studentContact", student.getContact());
                session.setAttribute("studentBatch", student.getBatchName());
                session.setAttribute("studentEnrollmentNo", student.getEnrollmentNo());
                session.setAttribute("loginTime", LocalDateTime.now().toString());
                
                student.setUpdatedAt(LocalDateTime.now());
                studentRepository.save(student);
                
                System.out.println("✅ Student logged in: " + student.getName());
                return "redirect:/student/dashboard";
            }
        }
        
        redirectAttributes.addAttribute("error", "true");
        return "redirect:/student/login";
    }
    
    // =============================================
    // FORGOT PASSWORD
    // =============================================
    
    @GetMapping("/forgot-password")
    public String showForgotPassword() {
        return "student/student-forgot-password";
    }
    
    @PostMapping("/forgot-password/send-otp")
    public String sendOtp(@RequestParam String identifier,
                          HttpSession session,
                          RedirectAttributes redirectAttributes) {
        
        Optional<Student> studentOpt = studentRepository.findByEmail(identifier);
        if (studentOpt.isEmpty()) {
            studentOpt = studentRepository.findByUsername(identifier);
        }
        
        if (studentOpt.isEmpty()) {
            redirectAttributes.addAttribute("error", "notfound");
            return "redirect:/student/forgot-password";
        }
        
        Student student = studentOpt.get();
        
        if (student.getStatus() != Student.Status.APPROVED) {
            redirectAttributes.addAttribute("error", "pending");
            return "redirect:/student/forgot-password";
        }
        
        String otp = String.format("%06d", new Random().nextInt(999999));
        otpStorage.put(student.getEmail(), new OtpData(otp, student.getEmail()));
        
        emailService.sendStudentOtpEmail(student.getEmail(), student.getName(), otp);
        
        session.setAttribute("resetIdentifier", student.getEmail());
        
        redirectAttributes.addAttribute("step", "otp");
        redirectAttributes.addAttribute("identifier", student.getEmail());
        return "redirect:/student/forgot-password";
    }
    
    @PostMapping("/forgot-password/verify-otp")
    public String verifyOtp(@RequestParam String identifier,
                            @RequestParam String otp,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        
        OtpData otpData = otpStorage.get(identifier);
        
        if (otpData == null || !otpData.isValid() || !otpData.otp.equals(otp)) {
            redirectAttributes.addAttribute("step", "otp");
            redirectAttributes.addAttribute("identifier", identifier);
            redirectAttributes.addAttribute("error", "invalid");
            return "redirect:/student/forgot-password";
        }
        
        session.setAttribute("resetVerified", true);
        session.setAttribute("resetIdentifier", identifier);
        
        redirectAttributes.addAttribute("step", "reset");
        redirectAttributes.addAttribute("identifier", identifier);
        return "redirect:/student/forgot-password";
    }
    
    @PostMapping("/forgot-password/reset")
    public String resetPassword(@RequestParam String identifier,
                                @RequestParam String newPassword,
                                @RequestParam String confirmPassword,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        
        Boolean isVerified = (Boolean) session.getAttribute("resetVerified");
        String sessionIdentifier = (String) session.getAttribute("resetIdentifier");
        
        if (isVerified == null || !isVerified || !sessionIdentifier.equals(identifier)) {
            redirectAttributes.addAttribute("error", "unauthorized");
            return "redirect:/student/forgot-password";
        }
        
        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addAttribute("step", "reset");
            redirectAttributes.addAttribute("identifier", identifier);
            redirectAttributes.addAttribute("error", "mismatch");
            return "redirect:/student/forgot-password";
        }
        
        Optional<Student> studentOpt = studentRepository.findByEmail(identifier);
        if (studentOpt.isEmpty()) {
            studentOpt = studentRepository.findByUsername(identifier);
        }
        
        if (studentOpt.isPresent()) {
            Student student = studentOpt.get();
            student.setPassword(newPassword);
            studentRepository.save(student);
            
            otpStorage.remove(identifier);
            session.removeAttribute("resetVerified");
            session.removeAttribute("resetIdentifier");
            
            redirectAttributes.addAttribute("reset", "success");
            return "redirect:/student/login";
        }
        
        return "redirect:/student/forgot-password";
    }
    
    @PostMapping("/forgot-password/resend-otp")
    @ResponseBody
    public Map<String, Object> resendOtp(@RequestParam String identifier, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        Optional<Student> studentOpt = studentRepository.findByEmail(identifier);
        if (studentOpt.isEmpty()) {
            studentOpt = studentRepository.findByUsername(identifier);
        }
        
        if (studentOpt.isEmpty()) {
            response.put("success", false);
            response.put("message", "Account not found!");
            return response;
        }
        
        Student student = studentOpt.get();
        String otp = String.format("%06d", new Random().nextInt(999999));
        
        otpStorage.put(student.getEmail(), new OtpData(otp, student.getEmail()));
        emailService.sendStudentOtpEmail(student.getEmail(), student.getName(), otp);
        
        response.put("success", true);
        response.put("message", "OTP resent successfully!");
        return response;
    }
    
    // =============================================
    // DASHBOARD
    // =============================================
    
    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        if (session.getAttribute("studentId") == null) {
            return "redirect:/student/login";
        }
        
        model.addAttribute("studentName", session.getAttribute("studentName"));
        model.addAttribute("studentBatch", session.getAttribute("studentBatch"));
        model.addAttribute("studentEnrollmentNo", session.getAttribute("studentEnrollmentNo"));
        
        return "student/student-dashboard";
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        System.out.println("===== STUDENT LOGGED OUT =====");
        session.invalidate();
        return "redirect:/student/login";
    }
}
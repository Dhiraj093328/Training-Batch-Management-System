package com.smartit.training.controller;

import com.smartit.training.model.Batch;
import com.smartit.training.model.Faculty;
import com.smartit.training.repository.BatchRepository;
import com.smartit.training.repository.FacultyRepository;
import com.smartit.training.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;

@Controller
@RequestMapping("/faculty")
public class FacultyController {

    @Autowired
    private FacultyRepository facultyRepository;
    
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
        return "faculty/faculty-register";
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
                                  @RequestParam(required = false) String qualification,
                                  @RequestParam(required = false) Integer experienceYears,
                                  RedirectAttributes redirectAttributes) {
        
        System.out.println("===== FACULTY REGISTRATION =====");
        System.out.println("Name: " + name);
        System.out.println("Email: " + email);
        System.out.println("Username: " + username);
        System.out.println("Batch: " + batchName);
        System.out.println("Admin Office: " + adminOfficeName);
        
        if (!password.equals(confirmPassword)) {
            redirectAttributes.addAttribute("error", "password");
            return "redirect:/faculty/register";
        }
        
        if (password.length() < 6) {
            redirectAttributes.addAttribute("error", "weak");
            return "redirect:/faculty/register";
        }
        
        if (facultyRepository.existsByUsername(username)) {
            redirectAttributes.addAttribute("error", "exists");
            return "redirect:/faculty/register";
        }
        
        if (facultyRepository.existsByEmail(email)) {
            redirectAttributes.addAttribute("error", "email");
            return "redirect:/faculty/register";
        }
        
        Faculty faculty = new Faculty();
        faculty.setName(name);
        faculty.setContact(contact);
        faculty.setEmail(email);
        faculty.setAdminOfficeName(adminOfficeName);
        faculty.setBatchName(batchName);
        faculty.setUsername(username);
        faculty.setPassword(password);
        faculty.setQualification(qualification);
        faculty.setExperienceYears(experienceYears != null ? experienceYears : 0);
        faculty.setJoiningDate(LocalDate.now());
        faculty.setStatus(Faculty.Status.PENDING);
        faculty.setCreatedAt(LocalDateTime.now());
        faculty.setUpdatedAt(LocalDateTime.now());
        
        // Generate employee ID
        String employeeId = "FAC" + String.format("%06d", System.currentTimeMillis() % 1000000);
        faculty.setEmployeeId(employeeId);
        
        facultyRepository.save(faculty);
        
        System.out.println("✅ FACULTY REGISTERED SUCCESSFULLY");
        System.out.println("Employee ID: " + employeeId);
        System.out.println("Status: PENDING - Waiting for admin approval");
        
        try {
            emailService.sendFacultyRegistrationEmail(email, name, username, password);
            System.out.println("Registration email sent to: " + email);
        } catch(Exception e) {
            System.out.println("Email sending failed: " + e.getMessage());
        }
        
        redirectAttributes.addAttribute("registered", "true");
        return "redirect:/faculty/login";
    }
    
    // =============================================
    // LOGIN
    // =============================================
    
    @GetMapping("/login")
    public String showLoginPage(HttpSession session) {
        if (session.getAttribute("facultyId") != null) {
            return "redirect:/faculty/dashboard";
        }
        return "faculty/faculty-login";
    }
    
    @PostMapping("/login")
    public String processLogin(@RequestParam("username") String username,
                               @RequestParam("password") String password,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        System.out.println("===== FACULTY LOGIN =====");
        System.out.println("Username/Email: " + username);
        
        username = username.trim();
        
        Optional<Faculty> facultyOpt = facultyRepository.findByUsername(username);
        if (facultyOpt.isEmpty()) {
            facultyOpt = facultyRepository.findByEmail(username);
        }
        
        if (facultyOpt.isPresent()) {
            Faculty faculty = facultyOpt.get();
            
            System.out.println("Faculty found: " + faculty.getName());
            System.out.println("Current Status: " + faculty.getStatus());
            
            if (faculty.getStatus() != Faculty.Status.APPROVED) {
                System.out.println("Login failed: Account not approved yet");
                redirectAttributes.addAttribute("error", "pending");
                return "redirect:/faculty/login";
            }
            
            if (faculty.getPassword().equals(password)) {
                session.setAttribute("facultyId", faculty.getId());
                session.setAttribute("facultyName", faculty.getName());
                session.setAttribute("facultyUsername", faculty.getUsername());
                session.setAttribute("facultyEmail", faculty.getEmail());
                session.setAttribute("facultyContact", faculty.getContact());
                session.setAttribute("facultyBatch", faculty.getBatchName());
                session.setAttribute("facultyEmployeeId", faculty.getEmployeeId());
                session.setAttribute("loginTime", LocalDateTime.now().toString());
                
                System.out.println("✅ Faculty logged in: " + faculty.getName());
                return "redirect:/faculty/dashboard";
            } else {
                System.out.println("Login failed: Wrong password");
            }
        } else {
            System.out.println("Login failed: User not found - " + username);
        }
        
        redirectAttributes.addAttribute("error", "true");
        return "redirect:/faculty/login";
    }
    
    // =============================================
    // DASHBOARD
    // =============================================
    
    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        if (session.getAttribute("facultyId") == null) {
            return "redirect:/faculty/login";
        }
        
        System.out.println("===== FACULTY DASHBOARD =====");
        System.out.println("Faculty: " + session.getAttribute("facultyName"));
        
        model.addAttribute("facultyName", session.getAttribute("facultyName"));
        model.addAttribute("facultyBatch", session.getAttribute("facultyBatch"));
        model.addAttribute("facultyEmployeeId", session.getAttribute("facultyEmployeeId"));
        model.addAttribute("facultyEmail", session.getAttribute("facultyEmail"));
        
        return "faculty/faculty-dashboard";
    }
    
    // =============================================
    // FORGOT PASSWORD
    // =============================================
    
    @GetMapping("/forgot-password")
    public String showForgotPassword() {
        return "faculty/faculty-forgot-password";
    }
    
    @PostMapping("/forgot-password/send-otp")
    public String sendOtp(@RequestParam String identifier,
                          HttpSession session,
                          RedirectAttributes redirectAttributes) {
        
        Optional<Faculty> facultyOpt = facultyRepository.findByEmail(identifier);
        if (facultyOpt.isEmpty()) {
            facultyOpt = facultyRepository.findByUsername(identifier);
        }
        
        if (facultyOpt.isEmpty()) {
            redirectAttributes.addAttribute("error", "notfound");
            return "redirect:/faculty/forgot-password";
        }
        
        Faculty faculty = facultyOpt.get();
        
        if (faculty.getStatus() != Faculty.Status.APPROVED) {
            redirectAttributes.addAttribute("error", "pending");
            return "redirect:/faculty/forgot-password";
        }
        
        String otp = String.format("%06d", new Random().nextInt(999999));
        otpStorage.put(faculty.getEmail(), new OtpData(otp, faculty.getEmail()));
        
        emailService.sendFacultyOtpEmail(faculty.getEmail(), faculty.getName(), otp);
        
        session.setAttribute("resetIdentifier", faculty.getEmail());
        
        redirectAttributes.addAttribute("step", "otp");
        redirectAttributes.addAttribute("identifier", faculty.getEmail());
        return "redirect:/faculty/forgot-password";
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
            return "redirect:/faculty/forgot-password";
        }
        
        session.setAttribute("resetVerified", true);
        session.setAttribute("resetIdentifier", identifier);
        
        redirectAttributes.addAttribute("step", "reset");
        redirectAttributes.addAttribute("identifier", identifier);
        return "redirect:/faculty/forgot-password";
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
            return "redirect:/faculty/forgot-password";
        }
        
        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addAttribute("step", "reset");
            redirectAttributes.addAttribute("identifier", identifier);
            redirectAttributes.addAttribute("error", "mismatch");
            return "redirect:/faculty/forgot-password";
        }
        
        Optional<Faculty> facultyOpt = facultyRepository.findByEmail(identifier);
        if (facultyOpt.isEmpty()) {
            facultyOpt = facultyRepository.findByUsername(identifier);
        }
        
        if (facultyOpt.isPresent()) {
            Faculty faculty = facultyOpt.get();
            faculty.setPassword(newPassword);
            facultyRepository.save(faculty);
            
            otpStorage.remove(identifier);
            session.removeAttribute("resetVerified");
            session.removeAttribute("resetIdentifier");
            
            redirectAttributes.addAttribute("reset", "success");
            return "redirect:/faculty/login";
        }
        
        return "redirect:/faculty/forgot-password";
    }
    
    @PostMapping("/forgot-password/resend-otp")
    @ResponseBody
    public Map<String, Object> resendOtp(@RequestParam String identifier, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        Optional<Faculty> facultyOpt = facultyRepository.findByEmail(identifier);
        if (facultyOpt.isEmpty()) {
            facultyOpt = facultyRepository.findByUsername(identifier);
        }
        
        if (facultyOpt.isEmpty()) {
            response.put("success", false);
            response.put("message", "Account not found!");
            return response;
        }
        
        Faculty faculty = facultyOpt.get();
        String otp = String.format("%06d", new Random().nextInt(999999));
        
        otpStorage.put(faculty.getEmail(), new OtpData(otp, faculty.getEmail()));
        emailService.sendFacultyOtpEmail(faculty.getEmail(), faculty.getName(), otp);
        
        response.put("success", true);
        response.put("message", "OTP resent successfully!");
        return response;
    }
    
    // =============================================
    // LOGOUT
    // =============================================
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        System.out.println("===== FACULTY LOGGED OUT =====");
        System.out.println("Faculty: " + session.getAttribute("facultyName"));
        session.invalidate();
        return "redirect:/faculty/login";
    }
}
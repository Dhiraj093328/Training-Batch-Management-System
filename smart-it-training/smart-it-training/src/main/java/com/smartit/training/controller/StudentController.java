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
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.Random;

@Controller
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private StudentRepository studentRepository;
    
    @Autowired
    private BatchRepository batchRepository;
    
    @Autowired
    private EmailService emailService;
    
    // Store OTP in memory (in production, use Redis or database)
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
    // BATCH DATA FOR REGISTRATION PAGE
    // =============================================
    
    @ModelAttribute("batchList")
    public java.util.List<Batch> getBatchList() {
        return batchRepository.findAll();
    }
    
    // =============================================
    // REGISTRATION
    // =============================================
    
    @GetMapping("/register")
    public String showRegisterPage(Model model) {
        // Check if batches exist
        if (batchRepository.count() == 0) {
            model.addAttribute("batchError", "No batches available. Please contact admin.");
        }
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
        
        // Validation 5: Check if batch exists
        if (!batchRepository.existsByBatchName(batchName)) {
            System.out.println("Batch not found: " + batchName);
            redirectAttributes.addAttribute("error", "batch");
            return "redirect:/student/register";
        }
        
        // Create new student
        Student student = new Student();
        student.setName(name);
        student.setContact(contact);
        student.setEmail(email);
        student.setAdminOfficeName(adminOfficeName);
        student.setBatchName(batchName);
        student.setUsername(username);
        student.setPassword(password);
        student.setStatus(Student.Status.PENDING);
        student.setCreatedAt(LocalDateTime.now());
        student.setUpdatedAt(LocalDateTime.now());
        
        // Generate unique enrollment number
        String enrollmentNo = "SIT" + String.format("%06d", System.currentTimeMillis() % 1000000);
        student.setEnrollmentNo(enrollmentNo);
        
        // Save to database
        Student savedStudent = studentRepository.save(student);
        
        System.out.println("Student registered successfully with ID: " + savedStudent.getId());
        System.out.println("Enrollment No: " + enrollmentNo);
        
        // Send email notification
        emailService.sendStudentRegistrationEmail(email, name, username, password);
        
        redirectAttributes.addAttribute("registered", "true");
        return "redirect:/student/login";
    }
    
    // =============================================
    // LOGIN
    // =============================================
    
    @GetMapping("/login")
    public String showLoginPage(HttpSession session, Model model) {
        if (session.getAttribute("studentId") != null) {
            return "redirect:/student/dashboard";
        }
        
        // Check if any pending approval message exists
        if (session.getAttribute("pendingApproval") != null) {
            model.addAttribute("pendingApproval", session.getAttribute("pendingApproval"));
            session.removeAttribute("pendingApproval");
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
            
            // Check if account is approved
            if (student.getStatus() != Student.Status.APPROVED) {
                System.out.println("Login failed: Account pending approval for: " + student.getName());
                redirectAttributes.addAttribute("error", "pending");
                return "redirect:/student/login";
            }
            
            // Check password
            if (student.getPassword().equals(password)) {
                // Set session attributes
                session.setAttribute("studentId", student.getId());
                session.setAttribute("studentName", student.getName());
                session.setAttribute("studentUsername", student.getUsername());
                session.setAttribute("studentEmail", student.getEmail());
                session.setAttribute("studentContact", student.getContact());
                session.setAttribute("studentBatch", student.getBatchName());
                session.setAttribute("studentEnrollmentNo", student.getEnrollmentNo());
                session.setAttribute("loginTime", LocalDateTime.now().toString());
                
                // Update last login time (if you have this field)
                student.setUpdatedAt(LocalDateTime.now());
                studentRepository.save(student);
                
                System.out.println("Student logged in successfully: " + student.getName());
                return "redirect:/student/dashboard";
            } else {
                System.out.println("Login failed: Wrong password for user: " + userId);
            }
        } else {
            System.out.println("Login failed: User not found - " + userId);
        }
        
        redirectAttributes.addAttribute("error", "true");
        return "redirect:/student/login";
    }
    
    // =============================================
    // FORGOT PASSWORD - OTP BASED
    // =============================================
    
    @GetMapping("/forgot-password")
    public String showForgotPassword() {
        return "student/student-forgot-password";
    }
    
    @PostMapping("/forgot-password/send-otp")
    public String sendOtp(@RequestParam String identifier,
                          HttpSession session,
                          RedirectAttributes redirectAttributes) {
        
        System.out.println("===== STUDENT SEND OTP =====");
        System.out.println("Identifier: " + identifier);
        
        Optional<Student> studentOpt = studentRepository.findByEmail(identifier);
        if (studentOpt.isEmpty()) {
            studentOpt = studentRepository.findByUsername(identifier);
        }
        
        if (studentOpt.isEmpty()) {
            System.out.println("Identifier not found: " + identifier);
            redirectAttributes.addAttribute("error", "notfound");
            return "redirect:/student/forgot-password";
        }
        
        Student student = studentOpt.get();
        
        // Check if account is approved
        if (student.getStatus() != Student.Status.APPROVED) {
            System.out.println("Account not approved yet");
            redirectAttributes.addAttribute("error", "pending");
            return "redirect:/student/forgot-password";
        }
        
        // Generate 6-digit OTP
        String otp = String.format("%06d", new Random().nextInt(999999));
        
        // Store OTP
        otpStorage.put(student.getEmail(), new OtpData(otp, student.getEmail()));
        
        // Save OTP to database (optional)
        student.setResetOtp(otp);
        student.setResetOtpExpiry(LocalDateTime.now().plusMinutes(10));
        studentRepository.save(student);
        
        // Send OTP via email
        emailService.sendStudentOtpEmail(student.getEmail(), student.getName(), otp);
        
        System.out.println("OTP sent to: " + student.getEmail());
        System.out.println("OTP: " + otp);
        
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
        
        System.out.println("===== VERIFY STUDENT OTP =====");
        System.out.println("Identifier: " + identifier);
        System.out.println("Entered OTP: " + otp);
        
        // First check in-memory storage
        OtpData otpData = otpStorage.get(identifier);
        
        // If not found, check database
        if (otpData == null) {
            Optional<Student> studentOpt = studentRepository.findByEmail(identifier);
            if (studentOpt.isPresent()) {
                Student student = studentOpt.get();
                if (student.getResetOtp() != null && student.getResetOtp().equals(otp) &&
                    student.getResetOtpExpiry() != null && 
                    LocalDateTime.now().isBefore(student.getResetOtpExpiry())) {
                    // Valid OTP from database
                    System.out.println("OTP verified from database");
                    session.setAttribute("resetVerified", true);
                    session.setAttribute("resetIdentifier", identifier);
                    
                    redirectAttributes.addAttribute("step", "reset");
                    redirectAttributes.addAttribute("identifier", identifier);
                    return "redirect:/student/forgot-password";
                }
            }
            
            System.out.println("No OTP found for: " + identifier);
            redirectAttributes.addAttribute("step", "otp");
            redirectAttributes.addAttribute("identifier", identifier);
            redirectAttributes.addAttribute("error", "invalid");
            return "redirect:/student/forgot-password";
        }
        
        if (!otpData.isValid()) {
            System.out.println("OTP expired for: " + identifier);
            otpStorage.remove(identifier);
            redirectAttributes.addAttribute("step", "otp");
            redirectAttributes.addAttribute("identifier", identifier);
            redirectAttributes.addAttribute("error", "expired");
            return "redirect:/student/forgot-password";
        }
        
        if (!otpData.otp.equals(otp)) {
            System.out.println("Invalid OTP for: " + identifier);
            redirectAttributes.addAttribute("step", "otp");
            redirectAttributes.addAttribute("identifier", identifier);
            redirectAttributes.addAttribute("error", "invalid");
            return "redirect:/student/forgot-password";
        }
        
        System.out.println("OTP verified successfully for: " + identifier);
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
        
        System.out.println("===== RESET STUDENT PASSWORD =====");
        System.out.println("Identifier: " + identifier);
        
        Boolean isVerified = (Boolean) session.getAttribute("resetVerified");
        String sessionIdentifier = (String) session.getAttribute("resetIdentifier");
        
        if (isVerified == null || !isVerified || sessionIdentifier == null || !sessionIdentifier.equals(identifier)) {
            System.out.println("Unauthorized reset attempt");
            redirectAttributes.addAttribute("error", "unauthorized");
            return "redirect:/student/forgot-password";
        }
        
        if (!newPassword.equals(confirmPassword)) {
            System.out.println("Passwords do not match");
            redirectAttributes.addAttribute("step", "reset");
            redirectAttributes.addAttribute("identifier", identifier);
            redirectAttributes.addAttribute("error", "mismatch");
            return "redirect:/student/forgot-password";
        }
        
        if (newPassword.length() < 6) {
            System.out.println("Password too short");
            redirectAttributes.addAttribute("step", "reset");
            redirectAttributes.addAttribute("identifier", identifier);
            redirectAttributes.addAttribute("error", "weak");
            return "redirect:/student/forgot-password";
        }
        
        Optional<Student> studentOpt = studentRepository.findByEmail(identifier);
        if (studentOpt.isEmpty()) {
            studentOpt = studentRepository.findByUsername(identifier);
        }
        
        if (studentOpt.isEmpty()) {
            System.out.println("Student not found");
            return "redirect:/student/forgot-password";
        }
        
        Student student = studentOpt.get();
        student.setPassword(newPassword);
        student.setUpdatedAt(LocalDateTime.now());
        student.setResetOtp(null);
        student.setResetOtpExpiry(null);
        studentRepository.save(student);
        
        // Send password reset confirmation email
        emailService.sendStudentPasswordResetConfirmation(student.getEmail(), student.getName());
        
        // Clear OTP and session
        otpStorage.remove(identifier);
        session.removeAttribute("resetVerified");
        session.removeAttribute("resetIdentifier");
        
        System.out.println("Password reset successful for: " + student.getEmail());
        
        redirectAttributes.addAttribute("reset", "success");
        return "redirect:/student/login";
    }
    
    @PostMapping("/forgot-password/resend-otp")
    @ResponseBody
    public Map<String, Object> resendOtp(@RequestParam String identifier, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        System.out.println("===== RESEND STUDENT OTP =====");
        System.out.println("Identifier: " + identifier);
        
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
        
        // Generate new OTP
        String otp = String.format("%06d", new Random().nextInt(999999));
        
        // Update stored OTP
        otpStorage.put(student.getEmail(), new OtpData(otp, student.getEmail()));
        
        // Update database
        student.setResetOtp(otp);
        student.setResetOtpExpiry(LocalDateTime.now().plusMinutes(10));
        studentRepository.save(student);
        
        // Send OTP via email
        emailService.sendStudentOtpEmail(student.getEmail(), student.getName(), otp);
        
        System.out.println("New OTP sent to: " + student.getEmail());
        System.out.println("New OTP: " + otp);
        
        response.put("success", true);
        response.put("message", "OTP resent successfully!");
        return response;
    }
    
    // =============================================
    // DASHBOARD & PROFILE
    // =============================================
    
    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        if (session.getAttribute("studentId") == null) {
            return "redirect:/student/login";
        }
        
        Integer studentId = (Integer) session.getAttribute("studentId");
        Optional<Student> studentOpt = studentRepository.findById(studentId);
        
        if (studentOpt.isPresent()) {
            Student student = studentOpt.get();
            model.addAttribute("student", student);
            
            // Add additional data for dashboard
            model.addAttribute("attendancePercentage", calculateAttendancePercentage(studentId));
            model.addAttribute("examsCompleted", getExamsCompletedCount(studentId));
            model.addAttribute("averageScore", getAverageScore(studentId));
            model.addAttribute("syllabusProgress", getSyllabusProgress(student.getBatchName()));
            
            // Add monthly attendance data for chart
            model.addAttribute("monthlyAttendance", getMonthlyAttendance(studentId));
        } else {
            return "redirect:/student/login";
        }
        
        return "student/student-dashboard";
    }
    
    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model) {
        if (session.getAttribute("studentId") == null) {
            return "redirect:/student/login";
        }
        
        Integer studentId = (Integer) session.getAttribute("studentId");
        Optional<Student> studentOpt = studentRepository.findById(studentId);
        
        if (studentOpt.isPresent()) {
            model.addAttribute("student", studentOpt.get());
        }
        
        return "student/student-profile";
    }
    
    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam String name,
                                @RequestParam String contact,
                                @RequestParam String email,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        
        Integer studentId = (Integer) session.getAttribute("studentId");
        Optional<Student> studentOpt = studentRepository.findById(studentId);
        
        if (studentOpt.isPresent()) {
            Student student = studentOpt.get();
            
            // Check if email changed and if new email already exists
            if (!student.getEmail().equals(email) && studentRepository.existsByEmail(email)) {
                redirectAttributes.addAttribute("error", "email_exists");
                return "redirect:/student/profile";
            }
            
            student.setName(name);
            student.setContact(contact);
            student.setEmail(email);
            student.setUpdatedAt(LocalDateTime.now());
            studentRepository.save(student);
            
            // Update session attributes
            session.setAttribute("studentName", name);
            session.setAttribute("studentEmail", email);
            
            redirectAttributes.addAttribute("success", "true");
        }
        
        return "redirect:/student/profile";
    }
    
    // =============================================
    // HELPER METHODS (Replace with actual database implementations)
    // =============================================
    
    private int calculateAttendancePercentage(Integer studentId) {
        // TODO: Implement actual attendance calculation from database
        // Example: 
        // Optional<Student> student = studentRepository.findById(studentId);
        // if (student.isPresent()) {
        //     List<Attendance> attendance = attendanceRepository.findByStudentId(studentId);
        //     long present = attendance.stream().filter(a -> a.getStatus().equals("PRESENT")).count();
        //     return (int) ((present * 100) / attendance.size());
        // }
        return 85; // Sample data
    }
    
    private int getExamsCompletedCount(Integer studentId) {
        // TODO: Implement actual exam count from database
        // return resultRepository.countByStudentId(studentId);
        return 4; // Sample data
    }
    
    private int getAverageScore(Integer studentId) {
        // TODO: Implement actual average score calculation from database
        // Double avg = resultRepository.getAverageScoreByStudentId(studentId);
        // return avg != null ? avg.intValue() : 0;
        return 82; // Sample data
    }
    
    private int getSyllabusProgress(String batchName) {
        // TODO: Implement actual syllabus progress from database
        // List<Syllabus> syllabus = syllabusRepository.findByBatchName(batchName);
        // long completed = syllabus.stream().filter(Syllabus::isCompleted).count();
        // return (int) ((completed * 100) / syllabus.size());
        return 70; // Sample data
    }
    
    private Map<String, Integer> getMonthlyAttendance(Integer studentId) {
        // TODO: Implement actual monthly attendance from database
        Map<String, Integer> monthlyData = new HashMap<>();
        monthlyData.put("January", 92);
        monthlyData.put("February", 88);
        monthlyData.put("March", 95);
        monthlyData.put("April", 90);
        monthlyData.put("May", 85);
        return monthlyData;
    }
    
    // =============================================
    // LOGOUT
    // =============================================
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        System.out.println("===== STUDENT LOGGED OUT =====");
        System.out.println("Student: " + session.getAttribute("studentName"));
        session.invalidate();
        return "redirect:/student/login";
    }
}
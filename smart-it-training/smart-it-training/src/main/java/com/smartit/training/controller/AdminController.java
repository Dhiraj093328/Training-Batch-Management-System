package com.smartit.training.controller;

import com.smartit.training.model.Admin;
import com.smartit.training.model.Student;
import com.smartit.training.model.Faculty;
import com.smartit.training.model.Feedback;
import com.smartit.training.model.Notice;
import com.smartit.training.repository.AdminRepository;
import com.smartit.training.repository.StudentRepository;
import com.smartit.training.repository.FacultyRepository;
import com.smartit.training.repository.FeedbackRepository;
import com.smartit.training.repository.NoticeRepository;
import com.smartit.training.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.LocalDate;
import java.util.ArrayList;
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
    private FacultyRepository facultyRepository;
    
    @Autowired
    private FeedbackRepository feedbackRepository;
    
    @Autowired
    private NoticeRepository noticeRepository;
    
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
    public String processLogin(@RequestParam String username,
                               @RequestParam String password,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        System.out.println("===== ADMIN LOGIN =====");
        System.out.println("Username: " + username);
        
        Optional<Admin> adminOpt = adminRepository.findByUsername(username);
        if (adminOpt.isEmpty()) {
            adminOpt = adminRepository.findByEmail(username);
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
        
        System.out.println("===== ADMIN DASHBOARD =====");
        
        // Get student data
        List<Student> pendingStudents = studentRepository.findByStatus(Student.Status.PENDING);
        List<Student> approvedStudents = studentRepository.findByStatus(Student.Status.APPROVED);
        
        // Get faculty data
        List<Faculty> pendingFaculty = facultyRepository.findByStatus(Faculty.Status.PENDING);
        List<Faculty> approvedFaculty = facultyRepository.findByStatus(Faculty.Status.APPROVED);
        
        // Calculate counts
        long totalStudents = studentRepository.count();
        long pendingStudentsCount = pendingStudents.size();
        long approvedStudentsCount = approvedStudents.size();
        long pendingFacultyCount = pendingFaculty.size();
        long approvedFacultyCount = approvedFaculty.size();
        
        System.out.println("Total Students: " + totalStudents);
        System.out.println("Pending Students: " + pendingStudentsCount);
        System.out.println("Pending Faculty: " + pendingFacultyCount);
        
        model.addAttribute("pendingStudents", pendingStudents);
        model.addAttribute("pendingStudentsCount", pendingStudentsCount);
        model.addAttribute("approvedStudentsCount", approvedStudentsCount);
        model.addAttribute("totalStudentsCount", totalStudents);
        
        model.addAttribute("pendingFaculty", pendingFaculty);
        model.addAttribute("pendingFacultyCount", pendingFacultyCount);
        model.addAttribute("approvedFacultyCount", approvedFacultyCount);
        
        return "admin/admin-dashboard";
    }
    
    // =============================================
    // NOTICE MANAGEMENT (NEW)
    // =============================================
    
    // Get all notices (for admin dashboard)
    @GetMapping("/notices")
    @ResponseBody
    public Map<String, Object> getAllNotices() {
        Map<String, Object> response = new HashMap<>();
        List<Notice> notices = noticeRepository.findAllByOrderByCreatedAtDesc();
        List<Map<String, Object>> noticeList = new ArrayList<>();
        
        for (Notice notice : notices) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", notice.getId());
            map.put("title", notice.getTitle());
            map.put("content", notice.getContent());
            map.put("category", notice.getCategory());
            map.put("isUrgent", notice.getIsUrgent());
            map.put("isActive", notice.getIsActive());
            map.put("createdByName", notice.getCreatedByName());
            map.put("createdAt", notice.getCreatedAt().toString());
            map.put("expiryDate", notice.getExpiryDate() != null ? notice.getExpiryDate().toString() : null);
            noticeList.add(map);
        }
        
        response.put("success", true);
        response.put("notices", noticeList);
        return response;
    }
    
    // Publish new notice
    @PostMapping("/notice/publish")
    @ResponseBody
    public Map<String, Object> publishNotice(@RequestParam String title,
                                              @RequestParam String content,
                                              @RequestParam(required = false) String category,
                                              @RequestParam(required = false) Boolean isUrgent,
                                              @RequestParam(required = false) String expiryDate,
                                              HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        if (session.getAttribute("adminId") == null) {
            response.put("success", false);
            response.put("message", "Unauthorized!");
            return response;
        }
        
        Notice notice = new Notice();
        notice.setTitle(title);
        notice.setContent(content);
        notice.setCategory(category != null && !category.isEmpty() ? category : "General");
        notice.setIsUrgent(isUrgent != null && isUrgent);
        notice.setIsActive(true);
        notice.setCreatedBy((Integer) session.getAttribute("adminId"));
        notice.setCreatedByName((String) session.getAttribute("adminName"));
        notice.setCreatedAt(LocalDateTime.now());
        
        if (expiryDate != null && !expiryDate.isEmpty()) {
            notice.setExpiryDate(LocalDate.parse(expiryDate));
        }
        
        noticeRepository.save(notice);
        
        System.out.println("Notice published: " + title + " by " + session.getAttribute("adminName"));
        
        response.put("success", true);
        response.put("message", "Notice published successfully!");
        return response;
    }
    
    // Delete notice
    @PostMapping("/notice/delete")
    @ResponseBody
    public Map<String, Object> deleteNotice(@RequestParam Integer noticeId, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        if (session.getAttribute("adminId") == null) {
            response.put("success", false);
            response.put("message", "Unauthorized!");
            return response;
        }
        
        Optional<Notice> noticeOpt = noticeRepository.findById(noticeId);
        if (noticeOpt.isPresent()) {
            noticeRepository.deleteById(noticeId);
            response.put("success", true);
            response.put("message", "Notice deleted successfully!");
        } else {
            response.put("success", false);
            response.put("message", "Notice not found!");
        }
        
        return response;
    }
    
    // Toggle notice status (Active/Inactive)
    @PostMapping("/notice/toggle-status")
    @ResponseBody
    public Map<String, Object> toggleNoticeStatus(@RequestParam Integer noticeId, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        if (session.getAttribute("adminId") == null) {
            response.put("success", false);
            response.put("message", "Unauthorized!");
            return response;
        }
        
        Optional<Notice> noticeOpt = noticeRepository.findById(noticeId);
        if (noticeOpt.isPresent()) {
            Notice notice = noticeOpt.get();
            notice.setIsActive(!notice.getIsActive());
            noticeRepository.save(notice);
            response.put("success", true);
            response.put("isActive", notice.getIsActive());
            response.put("message", "Notice status updated!");
        } else {
            response.put("success", false);
            response.put("message", "Notice not found!");
        }
        
        return response;
    }
    
    // =============================================
    // STUDENT MANAGEMENT - APPROVAL METHODS
    // =============================================
    
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
            
            student.setStatus(Student.Status.APPROVED);
            student.setApprovedBy(adminId);
            student.setApprovedAt(LocalDateTime.now());
            student.setUpdatedAt(LocalDateTime.now());
            studentRepository.save(student);
            
            System.out.println("Student approved: " + student.getName());
            
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
        
        Optional<Student> studentOpt = studentRepository.findById(studentId);
        
        if (studentOpt.isPresent()) {
            Student student = studentOpt.get();
            
            student.setStatus(Student.Status.REJECTED);
            student.setApprovedBy(adminId);
            student.setApprovedAt(LocalDateTime.now());
            student.setUpdatedAt(LocalDateTime.now());
            studentRepository.save(student);
            
            System.out.println("Student rejected: " + student.getName());
            
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
    // FACULTY MANAGEMENT - APPROVAL METHODS
    // =============================================
    
    @PostMapping("/approve-faculty")
    @ResponseBody
    public Map<String, Object> approveFaculty(@RequestParam Integer facultyId, 
                                               HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        Integer adminId = (Integer) session.getAttribute("adminId");
        String adminName = (String) session.getAttribute("adminName");
        
        System.out.println("===== APPROVE FACULTY =====");
        System.out.println("Faculty ID: " + facultyId);
        System.out.println("Approved by: " + adminName);
        
        Optional<Faculty> facultyOpt = facultyRepository.findById(facultyId);
        
        if (facultyOpt.isPresent()) {
            Faculty faculty = facultyOpt.get();
            
            System.out.println("Faculty Name: " + faculty.getName());
            System.out.println("Previous Status: " + faculty.getStatus());
            
            faculty.setStatus(Faculty.Status.APPROVED);
            faculty.setApprovedBy(adminId);
            faculty.setApprovedAt(LocalDateTime.now());
            faculty.setUpdatedAt(LocalDateTime.now());
            facultyRepository.save(faculty);
            
            System.out.println("New Status: " + faculty.getStatus());
            System.out.println("Faculty approved: " + faculty.getName());
            
            try {
                emailService.sendFacultyApprovalEmail(
                    faculty.getEmail(), 
                    faculty.getName(), 
                    faculty.getUsername(), 
                    faculty.getPassword()
                );
                System.out.println("Approval email sent to: " + faculty.getEmail());
            } catch(Exception e) {
                System.out.println("Email sending failed: " + e.getMessage());
            }
            
            response.put("success", true);
            response.put("message", "Faculty approved successfully!");
            response.put("facultyId", facultyId);
        } else {
            response.put("success", false);
            response.put("message", "Faculty not found!");
        }
        
        return response;
    }
    
    @PostMapping("/reject-faculty")
    @ResponseBody
    public Map<String, Object> rejectFaculty(@RequestParam Integer facultyId,
                                              @RequestParam(required = false) String reason,
                                              HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        Integer adminId = (Integer) session.getAttribute("adminId");
        String adminName = (String) session.getAttribute("adminName");
        
        System.out.println("===== REJECT FACULTY =====");
        System.out.println("Faculty ID: " + facultyId);
        System.out.println("Rejected by: " + adminName);
        System.out.println("Reason: " + (reason != null ? reason : "Not specified"));
        
        Optional<Faculty> facultyOpt = facultyRepository.findById(facultyId);
        
        if (facultyOpt.isPresent()) {
            Faculty faculty = facultyOpt.get();
            
            System.out.println("Faculty Name: " + faculty.getName());
            System.out.println("Previous Status: " + faculty.getStatus());
            
            faculty.setStatus(Faculty.Status.REJECTED);
            faculty.setApprovedBy(adminId);
            faculty.setApprovedAt(LocalDateTime.now());
            faculty.setUpdatedAt(LocalDateTime.now());
            facultyRepository.save(faculty);
            
            System.out.println("New Status: " + faculty.getStatus());
            System.out.println("Faculty rejected: " + faculty.getName());
            
            String rejectReason = (reason != null && !reason.isEmpty()) ? reason : "Not specified";
            try {
                emailService.sendFacultyRejectionEmail(faculty.getEmail(), faculty.getName(), rejectReason);
                System.out.println("Rejection email sent to: " + faculty.getEmail());
            } catch(Exception e) {
                System.out.println("Email sending failed: " + e.getMessage());
            }
            
            response.put("success", true);
            response.put("message", "Faculty rejected!");
            response.put("facultyId", facultyId);
        } else {
            response.put("success", false);
            response.put("message", "Faculty not found!");
        }
        
        return response;
    }
    
    // =============================================
    // FEEDBACK MANAGEMENT
    // =============================================
    
    // Get Feedback Statistics
    @GetMapping("/feedback/stats")
    @ResponseBody
    public Map<String, Object> getFeedbackStats() {
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("total", feedbackRepository.count());
        response.put("unread", feedbackRepository.countByIsRead(false));
        Double avg = feedbackRepository.getAverageRating();
        response.put("avgRating", avg != null ? Math.round(avg * 10) / 10.0 : 0);
        return response;
    }
    
    // Get All Feedbacks
    @GetMapping("/feedback/all")
    @ResponseBody
    public Map<String, Object> getAllFeedbacks() {
        Map<String, Object> response = new HashMap<>();
        List<Feedback> feedbacks = feedbackRepository.findAllByOrderByCreatedAtDesc();
        List<Map<String, Object>> feedbackList = new ArrayList<>();
        for (Feedback f : feedbacks) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", f.getId());
            map.put("name", f.getName());
            map.put("email", f.getEmail());
            map.put("rating", f.getRating());
            map.put("message", f.getMessage());
            map.put("read", f.getIsRead());
            map.put("replyMessage", f.getReplyMessage());
            map.put("repliedAt", f.getRepliedAt() != null ? f.getRepliedAt().toString() : null);
            map.put("createdAt", f.getCreatedAt().toString());
            feedbackList.add(map);
        }
        response.put("success", true);
        response.put("feedbacks", feedbackList);
        return response;
    }
    
    // Get Unread Feedbacks
    @GetMapping("/feedback/unread")
    @ResponseBody
    public Map<String, Object> getUnreadFeedbacks() {
        Map<String, Object> response = new HashMap<>();
        List<Feedback> feedbacks = feedbackRepository.findByIsReadOrderByCreatedAtDesc(false);
        List<Map<String, Object>> feedbackList = new ArrayList<>();
        for (Feedback f : feedbacks) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", f.getId());
            map.put("name", f.getName());
            map.put("email", f.getEmail());
            map.put("rating", f.getRating());
            map.put("message", f.getMessage());
            map.put("createdAt", f.getCreatedAt().toString());
            feedbackList.add(map);
        }
        response.put("success", true);
        response.put("feedbacks", feedbackList);
        return response;
    }
    
    // Mark feedback as read
    @PostMapping("/feedback/mark-read")
    @ResponseBody
    public Map<String, Object> markFeedbackAsRead(@RequestParam Integer feedbackId) {
        Map<String, Object> response = new HashMap<>();
        
        Optional<Feedback> feedbackOpt = feedbackRepository.findById(feedbackId);
        if (feedbackOpt.isPresent()) {
            Feedback feedback = feedbackOpt.get();
            feedback.setIsRead(true);
            feedbackRepository.save(feedback);
            response.put("success", true);
            response.put("message", "Feedback marked as read");
        } else {
            response.put("success", false);
            response.put("message", "Feedback not found!");
        }
        
        return response;
    }
    
    // Delete feedback
    @PostMapping("/feedback/delete")
    @ResponseBody
    public Map<String, Object> deleteFeedback(@RequestParam Integer feedbackId) {
        Map<String, Object> response = new HashMap<>();
        
        Optional<Feedback> feedbackOpt = feedbackRepository.findById(feedbackId);
        if (feedbackOpt.isPresent()) {
            feedbackRepository.deleteById(feedbackId);
            response.put("success", true);
            response.put("message", "Feedback deleted successfully!");
        } else {
            response.put("success", false);
            response.put("message", "Feedback not found!");
        }
        
        return response;
    }
    
    // Reply to feedback
    @PostMapping("/feedback/reply")
    @ResponseBody
    public Map<String, Object> replyToFeedback(@RequestParam Integer feedbackId,
                                                @RequestParam String replyMessage,
                                                HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        Integer adminId = (Integer) session.getAttribute("adminId");
        
        Optional<Feedback> feedbackOpt = feedbackRepository.findById(feedbackId);
        if (feedbackOpt.isPresent()) {
            Feedback feedback = feedbackOpt.get();
            feedback.setRepliedBy(adminId);
            feedback.setReplyMessage(replyMessage);
            feedback.setRepliedAt(LocalDateTime.now());
            feedback.setIsRead(true);
            feedbackRepository.save(feedback);
            
            try {
                emailService.sendFeedbackReplyEmail(feedback.getEmail(), feedback.getName(), replyMessage);
                System.out.println("Reply email sent to: " + feedback.getEmail());
            } catch(Exception e) {
                System.out.println("Email failed: " + e.getMessage());
            }
            
            response.put("success", true);
            response.put("message", "Reply sent successfully!");
        } else {
            response.put("success", false);
            response.put("message", "Feedback not found!");
        }
        
        return response;
    }
    
    // =============================================
    // FORGOT PASSWORD - OTP BASED
    // =============================================
    
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
    
    @GetMapping("/forgot-password")
    public String showForgotPassword() {
        return "admin/admin-forgot-password";
    }
    
    @PostMapping("/forgot-password/send-otp")
    public String sendOtp(@RequestParam String identifier,
                          HttpSession session,
                          RedirectAttributes redirectAttributes) {
        
        System.out.println("===== SEND OTP REQUEST =====");
        System.out.println("Identifier: " + identifier);
        
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
        String otp = String.format("%06d", new Random().nextInt(999999));
        
        otpStorage.put(admin.getEmail(), new OtpData(otp, admin.getEmail()));
        emailService.sendAdminOtpEmail(admin.getEmail(), admin.getName(), otp);
        
        System.out.println("OTP sent to: " + admin.getEmail());
        System.out.println("OTP: " + otp);
        
        session.setAttribute("resetIdentifier", admin.getEmail());
        
        redirectAttributes.addAttribute("step", "otp");
        redirectAttributes.addAttribute("identifier", admin.getEmail());
        return "redirect:/admin/forgot-password";
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
            return "redirect:/admin/forgot-password";
        }
        
        session.setAttribute("resetVerified", true);
        session.setAttribute("resetIdentifier", identifier);
        
        redirectAttributes.addAttribute("step", "reset");
        redirectAttributes.addAttribute("identifier", identifier);
        return "redirect:/admin/forgot-password";
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
            return "redirect:/admin/forgot-password";
        }
        
        if (!newPassword.equals(confirmPassword)) {
            redirectAttributes.addAttribute("step", "reset");
            redirectAttributes.addAttribute("identifier", identifier);
            redirectAttributes.addAttribute("error", "mismatch");
            return "redirect:/admin/forgot-password";
        }
        
        if (newPassword.length() < 6) {
            redirectAttributes.addAttribute("step", "reset");
            redirectAttributes.addAttribute("identifier", identifier);
            redirectAttributes.addAttribute("error", "weak");
            return "redirect:/admin/forgot-password";
        }
        
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
        
        otpStorage.remove(identifier);
        session.removeAttribute("resetVerified");
        session.removeAttribute("resetIdentifier");
        
        System.out.println("Password reset successful for: " + admin.getEmail());
        
        redirectAttributes.addAttribute("reset", "success");
        return "redirect:/admin/login";
    }
    
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
        String otp = String.format("%06d", new Random().nextInt(999999));
        
        otpStorage.put(admin.getEmail(), new OtpData(otp, admin.getEmail()));
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
        session.invalidate();
        return "redirect:/admin/login";
    }
}
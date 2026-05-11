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
                session.setAttribute("loginTime", LocalDateTime.now().toString());
                
                return "redirect:/admin/dashboard";
            }
        }
        
        redirectAttributes.addAttribute("error", "true");
        return "redirect:/admin/login";
    }
    
    // =============================================
    // DASHBOARD - SHOW PENDING STUDENT REQUESTS
    // =============================================
    
    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        if (session.getAttribute("adminId") == null) {
            return "redirect:/admin/login";
        }
        
        System.out.println("===== ADMIN DASHBOARD =====");
        
        // Get all pending students
        List<Student> pendingStudents = studentRepository.findByStatus(Student.Status.PENDING);
        
        System.out.println("Total Pending Students Found: " + pendingStudents.size());
        for (Student s : pendingStudents) {
            System.out.println("  - " + s.getName() + " | " + s.getBatchName() + " | " + s.getUsername());
        }
        
        model.addAttribute("pendingStudents", pendingStudents);
        model.addAttribute("pendingStudentsCount", pendingStudents.size());
        model.addAttribute("totalStudentsCount", studentRepository.count());
        model.addAttribute("approvedStudentsCount", studentRepository.countByStatus(Student.Status.APPROVED));
        
        return "admin/admin-dashboard";
    }
    
    // =============================================
    // APPROVE STUDENT - When Admin clicks Accept
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
            
            System.out.println("Student Name: " + student.getName());
            System.out.println("Previous Status: " + student.getStatus());
            
            // Update student status to APPROVED
            student.setStatus(Student.Status.APPROVED);
            student.setApprovedBy(adminId);
            student.setApprovedAt(LocalDateTime.now());
            student.setUpdatedAt(LocalDateTime.now());
            studentRepository.save(student);
            
            System.out.println("New Status: " + student.getStatus());
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
    
    // =============================================
    // REJECT STUDENT - When Admin clicks Reject
    // =============================================
    
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
            
            System.out.println("Student Name: " + student.getName());
            System.out.println("Previous Status: " + student.getStatus());
            
            // Update student status to REJECTED
            student.setStatus(Student.Status.REJECTED);
            student.setApprovedBy(adminId);
            student.setApprovedAt(LocalDateTime.now());
            student.setUpdatedAt(LocalDateTime.now());
            studentRepository.save(student);
            
            System.out.println("New Status: " + student.getStatus());
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
    // LOGOUT
    // =============================================
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        System.out.println("===== ADMIN LOGGED OUT =====");
        session.invalidate();
        return "redirect:/admin/login";
        
        
    }
}
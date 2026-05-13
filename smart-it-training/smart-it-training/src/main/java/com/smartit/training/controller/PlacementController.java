package com.smartit.training.controller;

import com.smartit.training.model.Placement;
import com.smartit.training.model.PlacementApplication;
import com.smartit.training.model.Student;
import com.smartit.training.repository.PlacementApplicationRepository;
import com.smartit.training.repository.PlacementRepository;
import com.smartit.training.repository.StudentRepository;
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
@RequestMapping("/placement")
public class PlacementController {

    @Autowired
    private StudentRepository studentRepository;
    
    @Autowired
    private PlacementRepository placementRepository;
    
    @Autowired
    private PlacementApplicationRepository applicationRepository;
    
    @Autowired
    private EmailService emailService;
    
    // =============================================
    // LOGIN - Using Student Table Credentials
    // =============================================
    
    @GetMapping("/login")
    public String showLoginPage(HttpSession session) {
        if (session.getAttribute("studentId") != null) {
            return "redirect:/placement/dashboard";
        }
        return "placement/placement-login";
    }
    
    @PostMapping("/login")
    public String processLogin(@RequestParam String username,
                               @RequestParam String password,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        System.out.println("===== PLACEMENT LOGIN =====");
        System.out.println("Username: " + username);
        
        Optional<Student> studentOpt = studentRepository.findByUsername(username);
        if (studentOpt.isEmpty()) {
            studentOpt = studentRepository.findByEmail(username);
        }
        
        if (studentOpt.isPresent()) {
            Student student = studentOpt.get();
            
            if (student.getStatus() != Student.Status.APPROVED) {
                redirectAttributes.addAttribute("error", "pending");
                return "redirect:/placement/login";
            }
            
            if (student.getPassword().equals(password)) {
                session.setAttribute("studentId", student.getId());
                session.setAttribute("studentName", student.getName());
                session.setAttribute("studentEmail", student.getEmail());
                session.setAttribute("studentContact", student.getContact());
                session.setAttribute("studentBatch", student.getBatchName());
                session.setAttribute("studentEnrollmentNo", student.getEnrollmentNo());
                session.setAttribute("loginTime", LocalDateTime.now().toString());
                
                System.out.println("Student logged in: " + student.getName());
                return "redirect:/placement/dashboard";
            }
        }
        
        redirectAttributes.addAttribute("error", "true");
        return "redirect:/placement/login";
    }
    
    // =============================================
    // DASHBOARD - Show All Active Placements
    // =============================================
    
    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        if (session.getAttribute("studentId") == null) {
            return "redirect:/placement/login";
        }
        
        // Get all active placements where last date is today or future
        List<Placement> placements = placementRepository.findByIsActiveTrueAndLastDateToApplyAfterOrderByLastDateToApplyAsc(LocalDate.now().minusDays(1));
        
        // Get student's applied placements
        Integer studentId = (Integer) session.getAttribute("studentId");
        List<PlacementApplication> appliedPlacements = applicationRepository.findByStudentId(studentId);
        Set<Integer> appliedPlacementIds = new HashSet<>();
        for (PlacementApplication app : appliedPlacements) {
            appliedPlacementIds.add(app.getPlacementId());
        }
        
        model.addAttribute("studentName", session.getAttribute("studentName"));
        model.addAttribute("placements", placements);
        model.addAttribute("appliedPlacementIds", appliedPlacementIds);
        model.addAttribute("today", LocalDate.now());
        
        return "placement/placement-dashboard";
    }
    
    // =============================================
    // APPLY FOR PLACEMENT
    // =============================================
    
    @PostMapping("/apply")
    @ResponseBody
    public Map<String, Object> applyForPlacement(@RequestParam Integer placementId,
                                                  HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        Integer studentId = (Integer) session.getAttribute("studentId");
        String studentName = (String) session.getAttribute("studentName");
        String studentEmail = (String) session.getAttribute("studentEmail");
        String studentContact = (String) session.getAttribute("studentContact");
        String studentBatch = (String) session.getAttribute("studentBatch");
        
        // Check if already applied
        if (applicationRepository.existsByPlacementIdAndStudentId(placementId, studentId)) {
            response.put("success", false);
            response.put("message", "You have already applied for this position!");
            return response;
        }
        
        Optional<Placement> placementOpt = placementRepository.findById(placementId);
        if (placementOpt.isEmpty()) {
            response.put("success", false);
            response.put("message", "Placement not found!");
            return response;
        }
        
        Placement placement = placementOpt.get();
        
        // Check if last date has passed
        if (placement.getLastDateToApply().isBefore(LocalDate.now())) {
            response.put("success", false);
            response.put("message", "Application deadline has passed!");
            return response;
        }
        
        // Create application
        PlacementApplication application = new PlacementApplication();
        application.setPlacementId(placementId);
        application.setStudentId(studentId);
        application.setStudentName(studentName);
        application.setStudentEmail(studentEmail);
        application.setStudentContact(studentContact);
        application.setStudentBatch(studentBatch);
        application.setStatus(PlacementApplication.ApplicationStatus.PENDING);
        application.setAppliedAt(LocalDateTime.now());
        
        applicationRepository.save(application);
        
        // Send email confirmation
        try {
            emailService.sendPlacementApplicationEmail(studentEmail, studentName, placement.getCompanyName());
            System.out.println("Application email sent to: " + studentEmail);
        } catch(Exception e) {
            System.out.println("Email failed: " + e.getMessage());
        }
        
        response.put("success", true);
        response.put("message", "Application submitted successfully!");
        return response;
    }
    
    // =============================================
    // MY APPLICATIONS
    // =============================================
    
    @GetMapping("/my-applications")
    @ResponseBody
    public Map<String, Object> getMyApplications(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        Integer studentId = (Integer) session.getAttribute("studentId");
        List<PlacementApplication> applications = applicationRepository.findByStudentId(studentId);
        
        List<Map<String, Object>> applicationList = new ArrayList<>();
        for (PlacementApplication app : applications) {
            Optional<Placement> placementOpt = placementRepository.findById(app.getPlacementId());
            if (placementOpt.isPresent()) {
                Placement placement = placementOpt.get();
                Map<String, Object> appData = new HashMap<>();
                appData.put("id", app.getId());
                appData.put("companyName", placement.getCompanyName());
                appData.put("jobRole", placement.getJobRole());
                appData.put("status", app.getStatus().toString());
                appData.put("appliedAt", app.getAppliedAt());
                appData.put("lastDate", placement.getLastDateToApply());
                applicationList.add(appData);
            }
        }
        
        response.put("success", true);
        response.put("applications", applicationList);
        return response;
    }
    
    // =============================================
    // LOGOUT
    // =============================================
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        System.out.println("===== STUDENT LOGGED OUT FROM PLACEMENT =====");
        session.invalidate();
        return "redirect:/placement/login";
    }
}
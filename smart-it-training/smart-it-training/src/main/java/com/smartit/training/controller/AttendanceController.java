package com.smartit.training.controller;

import com.smartit.training.model.Attendance;
import com.smartit.training.model.Faculty;
import com.smartit.training.model.Student;
import com.smartit.training.repository.AttendanceRepository;
import com.smartit.training.repository.FacultyRepository;
import com.smartit.training.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
@RequestMapping("/attendance")
public class AttendanceController {

    @Autowired
    private FacultyRepository facultyRepository;
    
    @Autowired
    private StudentRepository studentRepository;
    
    @Autowired
    private AttendanceRepository attendanceRepository;
    
    // =============================================
    // LOGIN - Using Faculty Table Credentials
    // =============================================
    
    @GetMapping("/login")
    public String showLoginPage(HttpSession session) {
        if (session.getAttribute("facultyId") != null) {
            return "redirect:/attendance/dashboard";
        }
        return "attendance/attendance-login";
    }
    
    @PostMapping("/login")
    public String processLogin(@RequestParam String username,
                               @RequestParam String password,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        
        System.out.println("===== ATTENDANCE LOGIN =====");
        System.out.println("Username: " + username);
        
        Optional<Faculty> facultyOpt = facultyRepository.findByUsername(username);
        if (facultyOpt.isEmpty()) {
            facultyOpt = facultyRepository.findByEmail(username);
        }
        
        if (facultyOpt.isPresent()) {
            Faculty faculty = facultyOpt.get();
            
            if (faculty.getStatus() != Faculty.Status.APPROVED) {
                redirectAttributes.addAttribute("error", "pending");
                return "redirect:/attendance/login";
            }
            
            if (faculty.getPassword().equals(password)) {
                session.setAttribute("facultyId", faculty.getId());
                session.setAttribute("facultyName", faculty.getName());
                session.setAttribute("facultyBatch", faculty.getBatchName());
                session.setAttribute("loginTime", LocalDateTime.now().toString());
                
                System.out.println("Faculty logged in: " + faculty.getName());
                return "redirect:/attendance/dashboard";
            }
        }
        
        redirectAttributes.addAttribute("error", "true");
        return "redirect:/attendance/login";
    }
    
    // =============================================
    // DASHBOARD
    // =============================================
    
    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        if (session.getAttribute("facultyId") == null) {
            return "redirect:/attendance/login";
        }
        
        String facultyBatch = (String) session.getAttribute("facultyBatch");
        
        // Get list of all batches
        List<String> batches = Arrays.asList("Java", "Python", "MERN", "Cloud", "Data Science", "AWS");
        
        model.addAttribute("facultyName", session.getAttribute("facultyName"));
        model.addAttribute("facultyBatch", facultyBatch);
        model.addAttribute("batches", batches);
        
        return "attendance/attendance-dashboard";
    }
    
    // =============================================
    // GET STUDENTS FOR A BATCH
    // =============================================
    
    @GetMapping("/get-students")
    @ResponseBody
    public Map<String, Object> getStudentsByBatch(@RequestParam String batchName) {
        Map<String, Object> response = new HashMap<>();
        
        List<Student> students = studentRepository.findByBatchName(batchName);
        List<Map<String, Object>> studentList = new ArrayList<>();
        
        for (Student student : students) {
            Map<String, Object> studentData = new HashMap<>();
            studentData.put("id", student.getId());
            studentData.put("name", student.getName());
            studentData.put("enrollmentNo", student.getEnrollmentNo());
            studentList.add(studentData);
        }
        
        response.put("success", true);
        response.put("students", studentList);
        return response;
    }
    
    // =============================================
    // GET EXISTING ATTENDANCE FOR A DATE
    // =============================================
    
    @GetMapping("/get-attendance")
    @ResponseBody
    public Map<String, Object> getAttendance(@RequestParam String batchName, 
                                              @RequestParam String date) {
        Map<String, Object> response = new HashMap<>();
        
        LocalDate attendanceDate = LocalDate.parse(date);
        List<Attendance> attendanceList = attendanceRepository.findByBatchNameAndAttendanceDate(batchName, attendanceDate);
        
        Map<Integer, String> statusMap = new HashMap<>();
        for (Attendance att : attendanceList) {
            statusMap.put(att.getStudentId(), att.getStatus().toString());
        }
        
        response.put("success", true);
        response.put("attendance", statusMap);
        return response;
    }
    
    // =============================================
    // SAVE ATTENDANCE
    // =============================================
    
    @PostMapping("/save-attendance")
    @ResponseBody
    public Map<String, Object> saveAttendance(@RequestParam String batchName,
                                               @RequestParam String date,
                                               @RequestParam Map<String, String> allParams,
                                               HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        Integer facultyId = (Integer) session.getAttribute("facultyId");
        String facultyName = (String) session.getAttribute("facultyName");
        LocalDate attendanceDate = LocalDate.parse(date);
        
        // Delete existing attendance for this batch and date
        attendanceRepository.deleteByBatchNameAndAttendanceDate(batchName, attendanceDate);
        
        // Save new attendance records
        int savedCount = 0;
        for (Map.Entry<String, String> entry : allParams.entrySet()) {
            if (entry.getKey().startsWith("student_")) {
                String studentIdStr = entry.getKey().substring(8);
                Integer studentId = Integer.parseInt(studentIdStr);
                String status = entry.getValue();
                
                Optional<Student> studentOpt = studentRepository.findById(studentId);
                if (studentOpt.isPresent()) {
                    Student student = studentOpt.get();
                    
                    Attendance attendance = new Attendance();
                    attendance.setStudentId(studentId);
                    attendance.setStudentName(student.getName());
                    attendance.setBatchName(batchName);
                    attendance.setAttendanceDate(attendanceDate);
                    attendance.setStatus(Attendance.AttendanceStatus.valueOf(status));
                    attendance.setMarkedByFacultyId(facultyId);
                    attendance.setMarkedByFacultyName(facultyName);
                    
                    attendanceRepository.save(attendance);
                    savedCount++;
                }
            }
        }
        
        response.put("success", true);
        response.put("message", "Attendance saved for " + savedCount + " students");
        return response;
    }
    
    // =============================================
    // GET STUDENT ATTENDANCE PERCENTAGE (For Student Portal)
    // =============================================
    
    @GetMapping("/student-percentage")
    @ResponseBody
    public Map<String, Object> getStudentAttendancePercentage(@RequestParam Integer studentId) {
        Map<String, Object> response = new HashMap<>();
        
        long present = attendanceRepository.countPresentByStudentId(studentId);
        long total = attendanceRepository.countTotalByStudentId(studentId);
        int percentage = total > 0 ? (int) ((present * 100) / total) : 0;
        
        response.put("present", present);
        response.put("total", total);
        response.put("percentage", percentage);
        
        return response;
    }
    
    // =============================================
    // GET MONTHLY ATTENDANCE REPORT (For Admin Portal)
    // =============================================
    
    @GetMapping("/monthly-report")
    @ResponseBody
    public Map<String, Object> getMonthlyAttendanceReport(@RequestParam String batchName, 
                                                           @RequestParam Integer month) {
        Map<String, Object> response = new HashMap<>();
        
        List<Object[]> results = attendanceRepository.getMonthlyAttendanceByBatch(batchName, month);
        List<Map<String, Object>> reportList = new ArrayList<>();
        
        for (Object[] row : results) {
            Map<String, Object> studentReport = new HashMap<>();
            studentReport.put("studentId", row[0]);
            studentReport.put("studentName", row[1]);
            studentReport.put("present", row[2]);
            studentReport.put("total", row[3]);
            long present = (Long) row[2];
            long total = (Long) row[3];
            int percentage = total > 0 ? (int) ((present * 100) / total) : 0;
            studentReport.put("percentage", percentage);
            reportList.add(studentReport);
        }
        
        response.put("success", true);
        response.put("report", reportList);
        return response;
    }
    
    // =============================================
    // LOGOUT
    // =============================================
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/attendance/login";
    }
}
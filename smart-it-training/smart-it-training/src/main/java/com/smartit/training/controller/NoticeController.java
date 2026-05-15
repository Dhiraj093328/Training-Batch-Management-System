package com.smartit.training.controller;

import com.smartit.training.model.Notice;
import com.smartit.training.repository.NoticeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
@RequestMapping("/notice")
public class NoticeController {

    @Autowired
    private NoticeRepository noticeRepository;
    
    // =============================================
    // PUBLIC VIEW - Everyone can view notices
    // =============================================
    
    @GetMapping("/view")
    public String viewNotices(Model model) {
        try {
            // Get current date
            LocalDate currentDate = LocalDate.now();
            
            // Get active notices that are not expired
            List<Notice> notices = noticeRepository.findByIsActiveTrueAndExpiryDateIsNullOrExpiryDateAfterOrderByIsUrgentDescCreatedAtDesc(currentDate);
            
            // If no notices found with expiry check, try without expiry filter for debugging
            if (notices.isEmpty()) {
                System.out.println("No notices found with expiry filter, checking all active notices...");
                notices = noticeRepository.findAllActiveNotices();
                System.out.println("Found " + notices.size() + " active notices total");
            }
            
            // Format dates for display
            List<Map<String, Object>> noticeList = new ArrayList<>();
            DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd MMM yyyy");
            
            for (Notice notice : notices) {
                Map<String, Object> noticeMap = new HashMap<>();
                noticeMap.put("id", notice.getId());
                noticeMap.put("title", notice.getTitle());
                noticeMap.put("content", notice.getContent());
                noticeMap.put("category", notice.getCategory());
                noticeMap.put("isUrgent", notice.getIsUrgent());
                noticeMap.put("isActive", notice.getIsActive());
                
                // DO NOT include createdByName in public view
                // noticeMap.put("createdByName", notice.getCreatedByName()); // REMOVED
                
                // Add formatted dates for display
                if (notice.getCreatedAt() != null) {
                    noticeMap.put("formattedDate", notice.getCreatedAt().format(dateTimeFormatter));
                    noticeMap.put("createdAt", notice.getCreatedAt());
                }
                
                if (notice.getExpiryDate() != null) {
                    noticeMap.put("expiryDateFormatted", notice.getExpiryDate().format(dateFormatter));
                    noticeMap.put("expiryDate", notice.getExpiryDate());
                }
                
                noticeList.add(noticeMap);
            }
            
            model.addAttribute("notices", noticeList);
            model.addAttribute("totalNotices", noticeList.size());
            
            // Calculate urgent count
            long urgentCount = noticeList.stream().filter(n -> (Boolean) n.get("isUrgent")).count();
            model.addAttribute("urgentCount", urgentCount);
            
        } catch (Exception e) {
            System.err.println("Error loading notices: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Error loading notices: " + e.getMessage());
            model.addAttribute("notices", new ArrayList<>());
            model.addAttribute("totalNotices", 0);
            model.addAttribute("urgentCount", 0);
        }
        
        return "public/notices";
    }
    
    // =============================================
    // PUBLIC VIEW - JSON endpoint for AJAX (without sender name)
    // =============================================
    
    @GetMapping("/api/notices")
    @ResponseBody
    public Map<String, Object> getNoticesApi() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            LocalDate currentDate = LocalDate.now();
            List<Notice> notices = noticeRepository.findByIsActiveTrueAndExpiryDateIsNullOrExpiryDateAfterOrderByIsUrgentDescCreatedAtDesc(currentDate);
            
            // If no notices found, try all active notices
            if (notices.isEmpty()) {
                notices = noticeRepository.findAllActiveNotices();
            }
            
            List<Map<String, Object>> noticeList = new ArrayList<>();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");
            
            for (Notice notice : notices) {
                Map<String, Object> n = new HashMap<>();
                n.put("id", notice.getId());
                n.put("title", notice.getTitle());
                n.put("content", notice.getContent());
                n.put("category", notice.getCategory());
                n.put("isUrgent", notice.getIsUrgent());
                n.put("isActive", notice.getIsActive());
                // DO NOT include createdByName in API response
                // n.put("createdByName", notice.getCreatedByName()); // REMOVED
                n.put("formattedDate", notice.getCreatedAt() != null ? notice.getCreatedAt().format(formatter) : "");
                n.put("createdAt", notice.getCreatedAt() != null ? notice.getCreatedAt().toString() : "");
                
                if (notice.getExpiryDate() != null) {
                    n.put("expiryDate", notice.getExpiryDate().toString());
                }
                
                noticeList.add(n);
            }
            
            response.put("success", true);
            response.put("notices", noticeList);
            response.put("count", noticeList.size());
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            response.put("notices", new ArrayList<>());
            response.put("count", 0);
        }
        
        return response;
    }
    
    // =============================================
    // ADMIN SIDE - Show Add Notice Page
    // =============================================
    
    @GetMapping("/admin/add-page")
    public String showAddNoticePage(Model model, HttpSession session) {
        if (session.getAttribute("adminId") == null) {
            return "redirect:/admin/login";
        }
        return "admin/add-notice";
    }
    
    // =============================================
    // ADMIN SIDE - Add Notice
    // =============================================
    
    @PostMapping("/admin/add")
    @ResponseBody
    public Map<String, Object> addNotice(@RequestParam String title,
                                          @RequestParam String content,
                                          @RequestParam(required = false, defaultValue = "General") String category,
                                          @RequestParam(required = false, defaultValue = "false") boolean isUrgent,
                                          @RequestParam(required = false) String expiryDate,
                                          HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        // Check if admin is logged in
        if (session.getAttribute("adminId") == null) {
            response.put("success", false);
            response.put("message", "Unauthorized! Please login as admin.");
            return response;
        }
        
        // Validate input
        if (title == null || title.trim().isEmpty()) {
            response.put("success", false);
            response.put("message", "Notice title is required!");
            return response;
        }
        
        if (content == null || content.trim().isEmpty()) {
            response.put("success", false);
            response.put("message", "Notice content is required!");
            return response;
        }
        
        try {
            Notice notice = new Notice();
            notice.setTitle(title.trim());
            notice.setContent(content.trim());
            notice.setCategory(category != null && !category.isEmpty() ? category : "General");
            notice.setIsUrgent(isUrgent);
            notice.setIsActive(true);  // Important: Set to true for public view
            notice.setCreatedBy((Integer) session.getAttribute("adminId"));
            notice.setCreatedByName((String) session.getAttribute("adminName"));
            notice.setCreatedAt(LocalDateTime.now());
            
            // Set expiry date if provided
            if (expiryDate != null && !expiryDate.isEmpty()) {
                try {
                    notice.setExpiryDate(LocalDate.parse(expiryDate));
                } catch (Exception e) {
                    System.out.println("Invalid expiry date format: " + expiryDate);
                }
            }
            
            Notice savedNotice = noticeRepository.save(notice);
            
            response.put("success", true);
            response.put("message", "Notice published successfully!");
            response.put("noticeId", savedNotice.getId());
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error publishing notice: " + e.getMessage());
            e.printStackTrace();
        }
        
        return response;
    }
    
    // =============================================
    // ADMIN SIDE - Get All Notices (includes sender name for admin)
    // =============================================
    
    @GetMapping("/admin/list")
    @ResponseBody
    public Map<String, Object> getNotices(HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        if (session.getAttribute("adminId") == null) {
            response.put("success", false);
            response.put("message", "Unauthorized!");
            return response;
        }
        
        try {
            List<Notice> notices = noticeRepository.findAllByOrderByCreatedAtDesc();
            List<Map<String, Object>> noticeList = new ArrayList<>();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");
            
            for (Notice notice : notices) {
                Map<String, Object> n = new HashMap<>();
                n.put("id", notice.getId());
                n.put("title", notice.getTitle());
                n.put("content", notice.getContent());
                n.put("category", notice.getCategory());
                n.put("isUrgent", notice.getIsUrgent());
                n.put("isActive", notice.getIsActive());
                n.put("createdByName", notice.getCreatedByName()); // Keep for admin view
                n.put("formattedDate", notice.getCreatedAt() != null ? notice.getCreatedAt().format(formatter) : "");
                n.put("createdAt", notice.getCreatedAt() != null ? notice.getCreatedAt().toString() : "");
                n.put("expiryDate", notice.getExpiryDate() != null ? notice.getExpiryDate().toString() : null);
                noticeList.add(n);
            }
            
            response.put("success", true);
            response.put("notices", noticeList);
            response.put("count", noticeList.size());
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error loading notices: " + e.getMessage());
            e.printStackTrace();
        }
        
        return response;
    }
    
    // =============================================
    // ADMIN SIDE - Delete Notice
    // =============================================
    
    @PostMapping("/admin/delete")
    @ResponseBody
    public Map<String, Object> deleteNotice(@RequestParam Integer id, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        if (session.getAttribute("adminId") == null) {
            response.put("success", false);
            response.put("message", "Unauthorized!");
            return response;
        }
        
        try {
            if (noticeRepository.existsById(id)) {
                noticeRepository.deleteById(id);
                response.put("success", true);
                response.put("message", "Notice deleted successfully!");
            } else {
                response.put("success", false);
                response.put("message", "Notice not found!");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error deleting notice: " + e.getMessage());
            e.printStackTrace();
        }
        
        return response;
    }
    
    // =============================================
    // ADMIN SIDE - Toggle Notice Status (Active/Inactive)
    // =============================================
    
    @PostMapping("/admin/toggle-status")
    @ResponseBody
    public Map<String, Object> toggleNoticeStatus(@RequestParam Integer id, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        if (session.getAttribute("adminId") == null) {
            response.put("success", false);
            response.put("message", "Unauthorized!");
            return response;
        }
        
        try {
            Optional<Notice> noticeOpt = noticeRepository.findById(id);
            if (noticeOpt.isPresent()) {
                Notice notice = noticeOpt.get();
                notice.setIsActive(!notice.getIsActive());
                noticeRepository.save(notice);
                response.put("success", true);
                response.put("message", "Notice status updated successfully!");
                response.put("isActive", notice.getIsActive());
            } else {
                response.put("success", false);
                response.put("message", "Notice not found!");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error updating status: " + e.getMessage());
            e.printStackTrace();
        }
        
        return response;
    }
    
    // =============================================
    // ADMIN SIDE - Update Notice
    // =============================================
    
    @PostMapping("/admin/update")
    @ResponseBody
    public Map<String, Object> updateNotice(@RequestParam Integer id,
                                             @RequestParam String title,
                                             @RequestParam String content,
                                             @RequestParam(required = false, defaultValue = "General") String category,
                                             @RequestParam(required = false, defaultValue = "false") boolean isUrgent,
                                             @RequestParam(required = false) String expiryDate,
                                             HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        if (session.getAttribute("adminId") == null) {
            response.put("success", false);
            response.put("message", "Unauthorized!");
            return response;
        }
        
        try {
            Optional<Notice> noticeOpt = noticeRepository.findById(id);
            if (noticeOpt.isPresent()) {
                Notice notice = noticeOpt.get();
                notice.setTitle(title.trim());
                notice.setContent(content.trim());
                notice.setCategory(category);
                notice.setIsUrgent(isUrgent);
                
                if (expiryDate != null && !expiryDate.isEmpty()) {
                    notice.setExpiryDate(LocalDate.parse(expiryDate));
                } else {
                    notice.setExpiryDate(null);
                }
                
                noticeRepository.save(notice);
                
                response.put("success", true);
                response.put("message", "Notice updated successfully!");
            } else {
                response.put("success", false);
                response.put("message", "Notice not found!");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error updating notice: " + e.getMessage());
            e.printStackTrace();
        }
        
        return response;
    }
    
    // =============================================
    // ADMIN SIDE - Get Single Notice by ID
    // =============================================
    
    @GetMapping("/admin/get/{id}")
    @ResponseBody
    public Map<String, Object> getNoticeById(@PathVariable Integer id, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        if (session.getAttribute("adminId") == null) {
            response.put("success", false);
            response.put("message", "Unauthorized!");
            return response;
        }
        
        try {
            Optional<Notice> noticeOpt = noticeRepository.findById(id);
            if (noticeOpt.isPresent()) {
                Notice notice = noticeOpt.get();
                Map<String, Object> noticeData = new HashMap<>();
                noticeData.put("id", notice.getId());
                noticeData.put("title", notice.getTitle());
                noticeData.put("content", notice.getContent());
                noticeData.put("category", notice.getCategory());
                noticeData.put("isUrgent", notice.getIsUrgent());
                noticeData.put("isActive", notice.getIsActive());
                noticeData.put("createdByName", notice.getCreatedByName());
                noticeData.put("expiryDate", notice.getExpiryDate() != null ? notice.getExpiryDate().toString() : null);
                
                response.put("success", true);
                response.put("notice", noticeData);
            } else {
                response.put("success", false);
                response.put("message", "Notice not found!");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error fetching notice: " + e.getMessage());
            e.printStackTrace();
        }
        
        return response;
    }
    
    // =============================================
    // TEST ENDPOINT - For debugging
    // =============================================
    
    @GetMapping("/test")
    @ResponseBody
    public Map<String, Object> testNotices() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            List<Notice> allNotices = noticeRepository.findAll();
            List<Notice> activeNotices = noticeRepository.findAllActiveNotices();
            LocalDate currentDate = LocalDate.now();
            List<Notice> filteredNotices = noticeRepository.findByIsActiveTrueAndExpiryDateIsNullOrExpiryDateAfterOrderByIsUrgentDescCreatedAtDesc(currentDate);
            
            response.put("success", true);
            response.put("totalNotices", allNotices.size());
            response.put("activeNotices", activeNotices.size());
            response.put("filteredNotices", filteredNotices.size());
            response.put("currentDate", currentDate.toString());
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
        }
        
        return response;
    }
}
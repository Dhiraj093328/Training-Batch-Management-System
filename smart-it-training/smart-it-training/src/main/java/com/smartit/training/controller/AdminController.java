package com.smartit.training.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

    // Show Login Page
    @GetMapping("/login")
    public String showLoginPage() {
        return "admin/admin-login";
    }
    
    // Process Login
    @PostMapping("/login")
    public String processLogin(@RequestParam String userId,
                               @RequestParam String password,
                               HttpSession session) {
        // For testing - replace with actual database validation
        if (userId.equals("admin") && password.equals("admin123")) {
            session.setAttribute("adminId", 1L);
            session.setAttribute("adminName", "Head Office");
            session.setAttribute("adminUserId", userId);
            return "redirect:/admin/dashboard";
        }
        return "redirect:/admin/login?error=true";
    }
    
    // Show Registration Page
    @GetMapping("/register")
    public String showRegisterPage() {
        return "admin/admin-register";
    }
    
    // Logout
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/admin/login";
    }
}
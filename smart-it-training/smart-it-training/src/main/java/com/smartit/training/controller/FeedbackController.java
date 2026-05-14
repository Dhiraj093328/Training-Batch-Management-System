package com.smartit.training.controller;

import com.smartit.training.model.Feedback;
import com.smartit.training.repository.FeedbackRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import java.time.LocalDateTime;

@Controller
public class FeedbackController {

    @Autowired
    private FeedbackRepository feedbackRepository;
    
    // =============================================
    // PUBLIC FEEDBACK PORTAL (No Login Required)
    // =============================================
    
    @GetMapping("/feedback")
    public String showFeedbackForm(Model model) {
        model.addAttribute("feedback", new Feedback());
        return "public/feedback";
    }
    
    @PostMapping("/feedback/submit")
    public String submitFeedback(@RequestParam String name,
                                  @RequestParam String email,
                                  @RequestParam String message,
                                  @RequestParam Integer rating,
                                  RedirectAttributes redirectAttributes) {
        
        System.out.println("===== NEW FEEDBACK SUBMITTED =====");
        System.out.println("Name: " + name);
        System.out.println("Email: " + email);
        System.out.println("Rating: " + rating);
        
        Feedback feedback = new Feedback();
        feedback.setName(name);
        feedback.setEmail(email);
        feedback.setMessage(message);
        feedback.setRating(rating);
        feedback.setIsRead(false);
        feedback.setCreatedAt(LocalDateTime.now());
        
        feedbackRepository.save(feedback);
        
        System.out.println("Feedback saved with ID: " + feedback.getId());
        
        redirectAttributes.addAttribute("success", "true");
        return "redirect:/feedback";
    }
}
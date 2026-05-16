package com.smartit.training.controller;

import com.smartit.training.model.Event;
import com.smartit.training.repository.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

@Controller
@RequestMapping("/events")
public class EventController {

    @Autowired
    private EventRepository eventRepository;
    
    // =============================================
    // PUBLIC VIEW - Show Events Page
    // =============================================
    
    @GetMapping
    public String viewEvents(Model model) {
        try {
            LocalDate currentDate = LocalDate.now();
            
            // Get ALL active events (both upcoming and past)
            // Change this to show all active events, not just upcoming
            List<Event> allActiveEvents = eventRepository.findAllActiveEvents();
            
            // Also get upcoming events separately for display
            List<Event> upcomingEvents = eventRepository.findActiveUpcomingEvents(currentDate);
            
            List<Map<String, Object>> eventList = new ArrayList<>();
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd MMM yyyy");
            
            for (Event event : allActiveEvents) {
                Map<String, Object> eventMap = new HashMap<>();
                eventMap.put("id", event.getId());
                eventMap.put("title", event.getTitle());
                eventMap.put("description", event.getDescription());
                eventMap.put("location", event.getLocation() != null ? event.getLocation() : "Online");
                eventMap.put("category", event.getCategory() != null ? event.getCategory() : "General");
                eventMap.put("isFeatured", event.getIsFeatured());
                eventMap.put("maxParticipants", event.getMaxParticipants());
                eventMap.put("eventTime", event.getEventTime() != null ? event.getEventTime() : "TBD");
                eventMap.put("isActive", event.getIsActive());
                
                // Determine event status
                String status = "Upcoming";
                if (event.getEventDate() != null) {
                    if (event.getEventDate().isBefore(currentDate)) {
                        status = "Completed";
                    } else if (event.getEventDate().isEqual(currentDate)) {
                        status = "Today";
                    }
                }
                eventMap.put("status", status);
                
                if (event.getEventDate() != null) {
                    eventMap.put("formattedEventDate", event.getEventDate().format(dateFormatter));
                    eventMap.put("eventDate", event.getEventDate());
                }
                
                if (event.getRegistrationDeadline() != null) {
                    eventMap.put("formattedDeadline", event.getRegistrationDeadline().format(dateFormatter));
                }
                
                eventList.add(eventMap);
            }
            
            model.addAttribute("events", eventList);
            model.addAttribute("upcomingEvents", upcomingEvents.size());
            model.addAttribute("totalEvents", eventList.size());
            
            long featuredCount = eventList.stream().filter(e -> (Boolean) e.get("isFeatured")).count();
            model.addAttribute("featuredCount", featuredCount);
            
            // Add current date for comparison in JSP
            model.addAttribute("currentDate", currentDate);
            
            System.out.println("Total events loaded for public view: " + eventList.size());
            
        } catch (Exception e) {
            System.err.println("Error loading events: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Error loading events: " + e.getMessage());
            model.addAttribute("events", new ArrayList<>());
            model.addAttribute("totalEvents", 0);
            model.addAttribute("featuredCount", 0);
        }
        
        return "public/events";
    }
    
    // =============================================
    // PUBLIC VIEW - JSON endpoint for AJAX
    // =============================================
    
    @GetMapping("/api/events")
    @ResponseBody
    public Map<String, Object> getEventsApi() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            LocalDate currentDate = LocalDate.now();
            List<Event> events = eventRepository.findAllActiveEvents();
            
            List<Map<String, Object>> eventList = new ArrayList<>();
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd MMM yyyy");
            
            for (Event event : events) {
                Map<String, Object> e = new HashMap<>();
                e.put("id", event.getId());
                e.put("title", event.getTitle());
                e.put("description", event.getDescription());
                e.put("location", event.getLocation());
                e.put("category", event.getCategory());
                e.put("isFeatured", event.getIsFeatured());
                e.put("eventTime", event.getEventTime());
                e.put("formattedEventDate", event.getEventDate() != null ? event.getEventDate().format(dateFormatter) : "");
                e.put("eventDate", event.getEventDate() != null ? event.getEventDate().toString() : "");
                e.put("maxParticipants", event.getMaxParticipants());
                
                if (event.getRegistrationDeadline() != null) {
                    e.put("formattedDeadline", event.getRegistrationDeadline().format(dateFormatter));
                }
                
                eventList.add(e);
            }
            
            response.put("success", true);
            response.put("events", eventList);
            response.put("count", eventList.size());
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
            response.put("events", new ArrayList<>());
            response.put("count", 0);
        }
        
        return response;
    }
}
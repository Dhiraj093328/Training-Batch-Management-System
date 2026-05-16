package com.smartit.training.repository;

import com.smartit.training.model.Event;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;

@Repository
public interface EventRepository extends JpaRepository<Event, Integer> {
    
    // Get active upcoming events (eventDate >= currentDate)
    @Query("SELECT e FROM Event e WHERE e.isActive = true AND e.eventDate >= :currentDate ORDER BY e.isFeatured DESC, e.eventDate ASC, e.createdAt DESC")
    List<Event> findActiveUpcomingEvents(@Param("currentDate") LocalDate currentDate);
    
    // Get ALL active events (both upcoming and past) - USE THIS FOR PUBLIC VIEW
    @Query("SELECT e FROM Event e WHERE e.isActive = true ORDER BY e.eventDate DESC, e.createdAt DESC")
    List<Event> findAllActiveEvents();
    
    // Get all events ordered by creation date (for admin)
    List<Event> findAllByOrderByCreatedAtDesc();
    
    // Get events by category
    List<Event> findByCategoryOrderByEventDateAsc(String category);
    
    // Get featured events
    @Query("SELECT e FROM Event e WHERE e.isActive = true AND e.isFeatured = true AND e.eventDate >= :currentDate ORDER BY e.eventDate ASC")
    List<Event> findFeaturedEvents(@Param("currentDate") LocalDate currentDate);
}
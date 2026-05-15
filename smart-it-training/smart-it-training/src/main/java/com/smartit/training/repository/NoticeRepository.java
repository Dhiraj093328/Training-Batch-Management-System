package com.smartit.training.repository;

import com.smartit.training.model.Notice;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;

@Repository
public interface NoticeRepository extends JpaRepository<Notice, Integer> {
    
    // Method for public view - get active non-expired notices
    List<Notice> findByIsActiveTrueAndExpiryDateIsNullOrExpiryDateAfterOrderByIsUrgentDescCreatedAtDesc(LocalDate currentDate);
    
    // Alternative using @Query for public view
    @Query("SELECT n FROM Notice n WHERE n.isActive = true AND (n.expiryDate IS NULL OR n.expiryDate >= :currentDate) ORDER BY n.isUrgent DESC, n.createdAt DESC")
    List<Notice> findActiveNotices(@Param("currentDate") LocalDate currentDate);
    
    // Get all active notices (for testing)
    @Query("SELECT n FROM Notice n WHERE n.isActive = true ORDER BY n.createdAt DESC")
    List<Notice> findAllActiveNotices();
    
    // Get all notices ordered by creation date (for admin)
    List<Notice> findAllByOrderByCreatedAtDesc();
    
    // Find notices by category
    List<Notice> findByCategoryOrderByCreatedAtDesc(String category);
    
    // Find urgent active notices
    List<Notice> findByIsUrgentTrueAndIsActiveTrueOrderByCreatedAtDesc();
}
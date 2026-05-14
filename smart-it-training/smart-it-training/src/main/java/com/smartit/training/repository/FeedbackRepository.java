package com.smartit.training.repository;

import com.smartit.training.model.Feedback;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface FeedbackRepository extends JpaRepository<Feedback, Integer> {
    
    List<Feedback> findByIsReadOrderByCreatedAtDesc(Boolean isRead);
    
    List<Feedback> findAllByOrderByCreatedAtDesc();
    
    @Query("SELECT AVG(f.rating) FROM Feedback f")
    Double getAverageRating();
    
    long countByIsRead(Boolean isRead);
}
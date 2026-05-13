package com.smartit.training.repository;

import com.smartit.training.model.Placement;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;

@Repository
public interface PlacementRepository extends JpaRepository<Placement, Integer> {
    
    List<Placement> findByIsActiveTrue();
    
    List<Placement> findByLastDateToApplyAfter(LocalDate date);
    
    List<Placement> findByIsActiveTrueAndLastDateToApplyAfterOrderByLastDateToApplyAsc(LocalDate date);
    
    List<Placement> findAllByOrderByCreatedAtDesc();
}
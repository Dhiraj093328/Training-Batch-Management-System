package com.smartit.training.repository;

import com.smartit.training.model.PlacementApplication;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface PlacementApplicationRepository extends JpaRepository<PlacementApplication, Integer> {
    
    List<PlacementApplication> findByStudentId(Integer studentId);
    
    List<PlacementApplication> findByPlacementId(Integer placementId);
    
    Optional<PlacementApplication> findByPlacementIdAndStudentId(Integer placementId, Integer studentId);
    
    boolean existsByPlacementIdAndStudentId(Integer placementId, Integer studentId);
    
    long countByPlacementId(Integer placementId);
}
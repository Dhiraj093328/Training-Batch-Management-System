package com.smartit.training.repository;

import com.smartit.training.model.Syllabus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface SyllabusRepository extends JpaRepository<Syllabus, Integer> {
    
    List<Syllabus> findByBatchName(String batchName);
    
    long countByBatchNameAndIsCompletedTrue(String batchName);
    
    long countByBatchName(String batchName);
}
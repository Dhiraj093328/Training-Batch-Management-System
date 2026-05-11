package com.smartit.training.repository;

import com.smartit.training.model.Exam;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ExamRepository extends JpaRepository<Exam, Integer> {
    
    List<Exam> findByBatchName(String batchName);
    
    List<Exam> findByIsActiveTrue();
}
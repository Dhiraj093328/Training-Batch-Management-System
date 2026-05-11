package com.smartit.training.repository;

import com.smartit.training.model.Batch;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface BatchRepository extends JpaRepository<Batch, Integer> {
    
    boolean existsByBatchName(String batchName);
    
    Optional<Batch> findByBatchName(String batchName);
    
    void deleteByBatchName(String batchName);
}
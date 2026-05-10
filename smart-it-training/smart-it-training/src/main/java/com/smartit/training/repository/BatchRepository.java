package com.smartit.training.repository;

import com.smartit.training.model.Batch;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BatchRepository extends JpaRepository<Batch, Integer> {
    boolean existsByBatchName(String batchName);
}
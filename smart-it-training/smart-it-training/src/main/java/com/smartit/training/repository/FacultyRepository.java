package com.smartit.training.repository;

import com.smartit.training.model.Faculty;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface FacultyRepository extends JpaRepository<Faculty, Integer> {
    
    Optional<Faculty> findByUsername(String username);
    
    Optional<Faculty> findByEmail(String email);
    
    List<Faculty> findByStatus(Faculty.Status status);
    
    boolean existsByUsername(String username);
    
    boolean existsByEmail(String email);
    
    long countByStatus(Faculty.Status status);
}
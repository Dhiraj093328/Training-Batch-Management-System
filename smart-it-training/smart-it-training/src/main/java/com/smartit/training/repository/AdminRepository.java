package com.smartit.training.repository;

import com.smartit.training.model.Admin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface AdminRepository extends JpaRepository<Admin, Integer> {
    
    // Find admin by username (for login)
    Optional<Admin> findByUsername(String username);
    
    // Find admin by email
    Optional<Admin> findByEmail(String email);
    
    // Check if username exists
    boolean existsByUsername(String username);
    
    // Check if email exists
    boolean existsByEmail(String email);
}
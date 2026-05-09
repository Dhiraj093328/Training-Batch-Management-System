package com.smartit.training.repository;

import com.smartit.training.model.Admin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface AdminRepository extends JpaRepository<Admin, Integer> {
    
    Optional<Admin> findByUsername(String username);
    
    Optional<Admin> findByEmail(String email);
    
    Optional<Admin> findByResetToken(String resetToken);
    
    boolean existsByUsername(String username);
    
    boolean existsByEmail(String email);
}
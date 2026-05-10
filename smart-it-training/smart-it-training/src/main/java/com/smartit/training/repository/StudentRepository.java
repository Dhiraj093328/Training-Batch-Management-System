package com.smartit.training.repository;

import com.smartit.training.model.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface StudentRepository extends JpaRepository<Student, Integer> {
    
    Optional<Student> findByUsername(String username);
    
    Optional<Student> findByEmail(String email);
    
    Optional<Student> findByResetToken(String resetToken);
    
    Optional<Student> findByResetOtp(String resetOtp);
    
    List<Student> findByStatus(Student.Status status);
    
    List<Student> findByAdminOfficeName(String adminOfficeName);
    
    List<Student> findByBatchName(String batchName);
    
    boolean existsByUsername(String username);
    
    boolean existsByEmail(String email);
    
    long countByStatus(Student.Status status);
}
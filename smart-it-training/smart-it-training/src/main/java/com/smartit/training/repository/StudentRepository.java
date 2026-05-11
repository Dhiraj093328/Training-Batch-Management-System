package com.smartit.training.repository;

import com.smartit.training.model.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface StudentRepository extends JpaRepository<Student, Integer> {
    
    // =============================================
    // BASIC FIND METHODS
    // =============================================
    
    /**
     * Find student by username (for login)
     */
    Optional<Student> findByUsername(String username);
    
    /**
     * Find student by email (for login and forgot password)
     */
    Optional<Student> findByEmail(String email);
    
    /**
     * Find student by enrollment number
     */
    Optional<Student> findByEnrollmentNo(String enrollmentNo);
    
    // =============================================
    // STATUS BASED METHODS
    // =============================================
    
    /**
     * Find all students by status (PENDING, APPROVED, REJECTED)
     */
    List<Student> findByStatus(Student.Status status);
    
    /**
     * Find students by admin office name
     */
    List<Student> findByAdminOfficeName(String adminOfficeName);
    
    /**
     * Find students by batch name
     */
    List<Student> findByBatchName(String batchName);
    
    /**
     * Find students by status and batch name
     */
    List<Student> findByStatusAndBatchName(Student.Status status, String batchName);
    
    /**
     * Find students by status and admin office name
     */
    List<Student> findByStatusAndAdminOfficeName(Student.Status status, String adminOfficeName);
    
    // =============================================
    // RESET PASSWORD METHODS
    // =============================================
    
    /**
     * Find student by reset token (for password reset)
     */
    Optional<Student> findByResetToken(String resetToken);
    
    /**
     * Find student by OTP (for password reset)
     */
    Optional<Student> findByResetOtp(String resetOtp);
    
    /**
     * Find student by email and reset token
     */
    Optional<Student> findByEmailAndResetToken(String email, String resetToken);
    
    // =============================================
    // EXISTENCE CHECK METHODS
    // =============================================
    
    /**
     * Check if username already exists
     */
    boolean existsByUsername(String username);
    
    /**
     * Check if email already exists
     */
    boolean existsByEmail(String email);
    
    /**
     * Check if enrollment number already exists
     */
    boolean existsByEnrollmentNo(String enrollmentNo);
    
    // =============================================
    // COUNT METHODS
    // =============================================
    
    /**
     * Count students by status
     */
    long countByStatus(Student.Status status);
    
    /**
     * Count students by batch name
     */
    long countByBatchName(String batchName);
    
    /**
     * Count students by admin office name
     */
    long countByAdminOfficeName(String adminOfficeName);
    
    // =============================================
    // DELETE METHODS
    // =============================================
    
    /**
     * Delete student by email
     */
    void deleteByEmail(String email);
    
    /**
     * Delete student by username
     */
    void deleteByUsername(String username);
    
    // =============================================
    // CUSTOM QUERY METHODS
    // =============================================
    
    /**
     * Find students who registered in last 7 days
     */
    @Query("SELECT s FROM Student s WHERE s.createdAt >= :date")
    List<Student> findRecentRegistrations(@Param("date") LocalDateTime date);
    
    /**
     * Find students by name containing keyword
     */
    List<Student> findByNameContainingIgnoreCase(String keyword);
    
    /**
     * Find students by email containing keyword
     */
    List<Student> findByEmailContainingIgnoreCase(String keyword);
    
    /**
     * Find pending students count for a specific admin office
     */
    @Query("SELECT COUNT(s) FROM Student s WHERE s.status = 'PENDING' AND s.adminOfficeName = :officeName")
    long countPendingByAdminOffice(@Param("officeName") String officeName);
    
    /**
     * Find approved students count for a specific batch
     */
    @Query("SELECT COUNT(s) FROM Student s WHERE s.status = 'APPROVED' AND s.batchName = :batchName")
    long countApprovedByBatch(@Param("batchName") String batchName);
    
    // =============================================
    // ORDERED METHODS
    // =============================================
    
    /**
     * Find all students ordered by creation date (newest first)
     */
    List<Student> findAllByOrderByCreatedAtDesc();
    
    /**
     * Find pending students ordered by creation date
     */
    List<Student> findByStatusOrderByCreatedAtDesc(Student.Status status);
    
    /**
     * Find approved students ordered by approval date
     */
    List<Student> findByStatusOrderByApprovedAtDesc(Student.Status status);
    
    // =============================================
    // DATE RANGE METHODS
    // =============================================
    
    /**
     * Find students registered between dates
     */
    List<Student> findByCreatedAtBetween(LocalDateTime startDate, LocalDateTime endDate);
    
    /**
     * Find students approved between dates
     */
    List<Student> findByApprovedAtBetween(LocalDateTime startDate, LocalDateTime endDate);
}
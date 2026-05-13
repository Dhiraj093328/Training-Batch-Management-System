package com.smartit.training.repository;

import com.smartit.training.model.Attendance;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;

@Repository
public interface AttendanceRepository extends JpaRepository<Attendance, Integer> {
    
    // Find by student
    List<Attendance> findByStudentId(Integer studentId);
    
    // Find by batch
    List<Attendance> findByBatchName(String batchName);
    
    // Find by date
    List<Attendance> findByAttendanceDate(LocalDate date);
    
    // Find by batch and date
    List<Attendance> findByBatchNameAndAttendanceDate(String batchName, LocalDate date);
    
    // Find by student and date range (for monthly report)
    List<Attendance> findByStudentIdAndAttendanceDateBetween(Integer studentId, LocalDate startDate, LocalDate endDate);
    
    // Count present days for a student
    @Query("SELECT COUNT(a) FROM Attendance a WHERE a.studentId = :studentId AND a.status = 'PRESENT'")
    Long countPresentByStudentId(@Param("studentId") Integer studentId);
    
    // Count total attendance days for a student
    @Query("SELECT COUNT(a) FROM Attendance a WHERE a.studentId = :studentId")
    Long countTotalByStudentId(@Param("studentId") Integer studentId);
    
    // Delete existing attendance for batch and date
    void deleteByBatchNameAndAttendanceDate(String batchName, LocalDate attendanceDate);
    
    // Get monthly attendance for all students in a batch
    @Query("SELECT a.studentId, a.studentName, COUNT(CASE WHEN a.status = 'PRESENT' THEN 1 END) as present, COUNT(*) as total " +
           "FROM Attendance a WHERE a.batchName = :batchName AND MONTH(a.attendanceDate) = :month " +
           "GROUP BY a.studentId, a.studentName")
    List<Object[]> getMonthlyAttendanceByBatch(@Param("batchName") String batchName, @Param("month") Integer month);
}
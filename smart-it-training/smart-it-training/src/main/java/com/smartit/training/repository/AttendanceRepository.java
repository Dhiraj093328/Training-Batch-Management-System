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
    
    List<Attendance> findByStudentId(Integer studentId);
    
    List<Attendance> findByStudentIdAndAttendanceDateBetween(Integer studentId, LocalDate startDate, LocalDate endDate);
    
    @Query("SELECT COUNT(a) FROM Attendance a WHERE a.studentId = :studentId AND a.status = 'PRESENT'")
    Long countPresentByStudentId(@Param("studentId") Integer studentId);
    
    @Query("SELECT COUNT(a) FROM Attendance a WHERE a.studentId = :studentId")
    Long countTotalByStudentId(@Param("studentId") Integer studentId);
}
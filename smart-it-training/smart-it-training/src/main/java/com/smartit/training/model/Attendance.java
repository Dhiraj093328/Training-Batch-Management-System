package com.smartit.training.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "attendance")
public class Attendance {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(name = "student_id", nullable = false)
    private Integer studentId;
    
    @Column(name = "student_name", length = 100)
    private String studentName;
    
    @Column(name = "batch_name", length = 50)
    private String batchName;
    
    @Column(name = "attendance_date", nullable = false)
    private LocalDate attendanceDate;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private AttendanceStatus status = AttendanceStatus.ABSENT;
    
    @Column(name = "marked_by_faculty_id")
    private Integer markedByFacultyId;
    
    @Column(name = "marked_by_faculty_name", length = 100)
    private String markedByFacultyName;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    public enum AttendanceStatus {
        PRESENT, ABSENT, LATE
    }
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
    
    // Constructors
    public Attendance() {}
    
    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    
    public Integer getStudentId() { return studentId; }
    public void setStudentId(Integer studentId) { this.studentId = studentId; }
    
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    
    public String getBatchName() { return batchName; }
    public void setBatchName(String batchName) { this.batchName = batchName; }
    
    public LocalDate getAttendanceDate() { return attendanceDate; }
    public void setAttendanceDate(LocalDate attendanceDate) { this.attendanceDate = attendanceDate; }
    
    public AttendanceStatus getStatus() { return status; }
    public void setStatus(AttendanceStatus status) { this.status = status; }
    
    public Integer getMarkedByFacultyId() { return markedByFacultyId; }
    public void setMarkedByFacultyId(Integer markedByFacultyId) { this.markedByFacultyId = markedByFacultyId; }
    
    public String getMarkedByFacultyName() { return markedByFacultyName; }
    public void setMarkedByFacultyName(String markedByFacultyName) { this.markedByFacultyName = markedByFacultyName; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
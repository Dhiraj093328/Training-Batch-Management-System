package com.smartit.training.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "placement_application")
public class PlacementApplication {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(name = "placement_id", nullable = false)
    private Integer placementId;
    
    @Column(name = "student_id", nullable = false)
    private Integer studentId;
    
    @Column(name = "student_name", length = 100)
    private String studentName;
    
    @Column(name = "student_email", length = 100)
    private String studentEmail;
    
    @Column(name = "student_contact", length = 15)
    private String studentContact;
    
    @Column(name = "student_batch", length = 50)
    private String studentBatch;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ApplicationStatus status = ApplicationStatus.PENDING;
    
    @Column(name = "applied_at")
    private LocalDateTime appliedAt;
    
    @Column(name = "reviewed_by")
    private Integer reviewedBy;
    
    @Column(name = "reviewed_at")
    private LocalDateTime reviewedAt;
    
    @Column(name = "remarks", columnDefinition = "TEXT")
    private String remarks;
    
    public enum ApplicationStatus {
        PENDING, SHORTLISTED, REJECTED, SELECTED
    }
    
    @PrePersist
    protected void onCreate() {
        appliedAt = LocalDateTime.now();
    }
    
    // Constructors
    public PlacementApplication() {}
    
    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    
    public Integer getPlacementId() { return placementId; }
    public void setPlacementId(Integer placementId) { this.placementId = placementId; }
    
    public Integer getStudentId() { return studentId; }
    public void setStudentId(Integer studentId) { this.studentId = studentId; }
    
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    
    public String getStudentEmail() { return studentEmail; }
    public void setStudentEmail(String studentEmail) { this.studentEmail = studentEmail; }
    
    public String getStudentContact() { return studentContact; }
    public void setStudentContact(String studentContact) { this.studentContact = studentContact; }
    
    public String getStudentBatch() { return studentBatch; }
    public void setStudentBatch(String studentBatch) { this.studentBatch = studentBatch; }
    
    public ApplicationStatus getStatus() { return status; }
    public void setStatus(ApplicationStatus status) { this.status = status; }
    
    public LocalDateTime getAppliedAt() { return appliedAt; }
    public void setAppliedAt(LocalDateTime appliedAt) { this.appliedAt = appliedAt; }
    
    public Integer getReviewedBy() { return reviewedBy; }
    public void setReviewedBy(Integer reviewedBy) { this.reviewedBy = reviewedBy; }
    
    public LocalDateTime getReviewedAt() { return reviewedAt; }
    public void setReviewedAt(LocalDateTime reviewedAt) { this.reviewedAt = reviewedAt; }
    
    public String getRemarks() { return remarks; }
    public void setRemarks(String remarks) { this.remarks = remarks; }
}
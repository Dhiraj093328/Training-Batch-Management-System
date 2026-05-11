package com.smartit.training.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "result")
public class Result {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(name = "student_id", nullable = false)
    private Integer studentId;
    
    @Column(name = "exam_id", nullable = false)
    private Integer examId;
    
    @Column(nullable = false)
    private Integer score;
    
    @Column(name = "total_marks")
    private Integer totalMarks;
    
    private Double percentage;
    
    @Column(name = "is_passed")
    private Boolean isPassed = false;
    
    @Column(name = "submitted_at")
    private LocalDateTime submittedAt;
    
    // Constructors
    public Result() {}
    
    @PrePersist
    protected void onCreate() {
        submittedAt = LocalDateTime.now();
        if (totalMarks != null && totalMarks > 0) {
            percentage = (score * 100.0) / totalMarks;
            isPassed = percentage >= 40;
        }
    }
    
    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    
    public Integer getStudentId() { return studentId; }
    public void setStudentId(Integer studentId) { this.studentId = studentId; }
    
    public Integer getExamId() { return examId; }
    public void setExamId(Integer examId) { this.examId = examId; }
    
    public Integer getScore() { return score; }
    public void setScore(Integer score) { this.score = score; }
    
    public Integer getTotalMarks() { return totalMarks; }
    public void setTotalMarks(Integer totalMarks) { this.totalMarks = totalMarks; }
    
    public Double getPercentage() { return percentage; }
    public void setPercentage(Double percentage) { this.percentage = percentage; }
    
    public Boolean getIsPassed() { return isPassed; }
    public void setIsPassed(Boolean isPassed) { this.isPassed = isPassed; }
    
    public LocalDateTime getSubmittedAt() { return submittedAt; }
    public void setSubmittedAt(LocalDateTime submittedAt) { this.submittedAt = submittedAt; }
}
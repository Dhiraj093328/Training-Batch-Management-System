package com.smartit.training.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "student")
public class Student {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(nullable = false, length = 100)
    private String name;
    
    @Column(nullable = false, unique = true, length = 100)
    private String email;
    
    @Column(length = 15)
    private String contact;
    
    @Column(name = "admin_office_name", length = 100)
    private String adminOfficeName;
    
    @Column(name = "batch_name", length = 50)
    private String batchName;
    
    @Column(nullable = false, unique = true, length = 50)
    private String username;
    
    @Column(nullable = false, length = 255)
    private String password;
    
    @Column(name = "enrollment_no", unique = true, length = 50)
    private String enrollmentNo;
    
    @Column(name = "reset_token", length = 255)
    private String resetToken;
    
    @Column(name = "reset_token_expiry")
    private LocalDateTime resetTokenExpiry;
    
    @Column(name = "reset_otp", length = 10)
    private String resetOtp;
    
    @Column(name = "reset_otp_expiry")
    private LocalDateTime resetOtpExpiry;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private Status status = Status.PENDING;
    
    @Column(name = "approved_by")
    private Integer approvedBy;
    
    @Column(name = "approved_at")
    private LocalDateTime approvedAt;
    
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
    
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    public enum Status {
        PENDING, APPROVED, REJECTED
    }
    
    // Constructors
    public Student() {}
    
    public Student(String name, String email, String contact, String adminOfficeName, 
                   String batchName, String username, String password) {
        this.name = name;
        this.email = email;
        this.contact = contact;
        this.adminOfficeName = adminOfficeName;
        this.batchName = batchName;
        this.username = username;
        this.password = password;
        this.status = Status.PENDING;
    }
    
    // =============================================
    // Automatic Timestamp Management
    // =============================================
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
    
    // =============================================
    // Getters and Setters
    // =============================================
    
    public Integer getId() { 
        return id; 
    }
    
    public void setId(Integer id) { 
        this.id = id; 
    }
    
    public String getName() { 
        return name; 
    }
    
    public void setName(String name) { 
        this.name = name; 
    }
    
    public String getEmail() { 
        return email; 
    }
    
    public void setEmail(String email) { 
        this.email = email; 
    }
    
    public String getContact() { 
        return contact; 
    }
    
    public void setContact(String contact) { 
        this.contact = contact; 
    }
    
    public String getAdminOfficeName() { 
        return adminOfficeName; 
    }
    
    public void setAdminOfficeName(String adminOfficeName) { 
        this.adminOfficeName = adminOfficeName; 
    }
    
    public String getBatchName() { 
        return batchName; 
    }
    
    public void setBatchName(String batchName) { 
        this.batchName = batchName; 
    }
    
    public String getUsername() { 
        return username; 
    }
    
    public void setUsername(String username) { 
        this.username = username; 
    }
    
    public String getPassword() { 
        return password; 
    }
    
    public void setPassword(String password) { 
        this.password = password; 
    }
    
    public String getEnrollmentNo() { 
        return enrollmentNo; 
    }
    
    public void setEnrollmentNo(String enrollmentNo) { 
        this.enrollmentNo = enrollmentNo; 
    }
    
    public String getResetToken() { 
        return resetToken; 
    }
    
    public void setResetToken1(String resetToken) { 
        this.resetToken = resetToken; 
    }
    
    public LocalDateTime getResetTokenExpiry() { 
        return resetTokenExpiry; 
    }
    
    public void setResetTokenExpiry(LocalDateTime resetTokenExpiry) { 
        this.resetTokenExpiry = resetTokenExpiry; 
    }
    
    public String getResetOtp() { 
        return resetOtp; 
    }
    
    public void setResetOtp1(String resetOtp) { 
        this.resetOtp = resetOtp; 
    }
    
    public LocalDateTime getResetOtpExpiry() { 
        return resetOtpExpiry; 
    }
    
    public void setResetOtpExpiry(LocalDateTime resetOtpExpiry) { 
        this.resetOtpExpiry = resetOtpExpiry; 
    }
    
    public Status getStatus() { 
        return status; 
    }
    
    public void setStatus(Status status) { 
        this.status = status; 
    }
    
    public Integer getApprovedBy() { 
        return approvedBy; 
    }
    
    public void setApprovedBy(Integer approvedBy) { 
        this.approvedBy = approvedBy; 
    }
    
    public LocalDateTime getApprovedAt() { 
        return approvedAt; 
    }
    
    public void setApprovedAt(LocalDateTime approvedAt) { 
        this.approvedAt = approvedAt; 
    }
    
    public LocalDateTime getCreatedAt() { 
        return createdAt; 
    }
    
    public void setCreatedAt(LocalDateTime createdAt) { 
        this.createdAt = createdAt; 
    }
    
    public LocalDateTime getUpdatedAt() { 
        return updatedAt; 
    }
    
    public void setUpdatedAt(LocalDateTime updatedAt) { 
        this.updatedAt = updatedAt; 
    }
    
    // =============================================
    // Helper Methods
    // =============================================
    
    public boolean isApproved() {
        return status == Status.APPROVED;
    }
    
    public boolean isPending() {
        return status == Status.PENDING;
    }
    
    public boolean isRejected() {
        return status == Status.REJECTED;
    }
    
    public void approve(Integer adminId) {
        this.status = Status.APPROVED;
        this.approvedBy = adminId;
        this.approvedAt = LocalDateTime.now();
    }
    
    public void reject() {
        this.status = Status.REJECTED;
    }
    
    public void setResetOtp(String otp) {
        this.resetOtp = otp;
        this.resetOtpExpiry = LocalDateTime.now().plusMinutes(10);
    }
    
    public boolean isResetOtpValid(String otp) {
        return this.resetOtp != null && 
               this.resetOtp.equals(otp) && 
               this.resetOtpExpiry != null && 
               LocalDateTime.now().isBefore(this.resetOtpExpiry);
    }
    
    public void clearResetOtp() {
        this.resetOtp = null;
        this.resetOtpExpiry = null;
    }
    
    public void setResetToken(String token) {
        this.resetToken = token;
        this.resetTokenExpiry = LocalDateTime.now().plusHours(1);
    }
    
    public boolean isResetTokenValid(String token) {
        return this.resetToken != null && 
               this.resetToken.equals(token) && 
               this.resetTokenExpiry != null && 
               LocalDateTime.now().isBefore(this.resetTokenExpiry);
    }
    
    public void clearResetToken() {
        this.resetToken = null;
        this.resetTokenExpiry = null;
    }
    
    @Override
    public String toString() {
        return "Student{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", username='" + username + '\'' +
                ", batchName='" + batchName + '\'' +
                ", status=" + status +
                '}';
    }
}
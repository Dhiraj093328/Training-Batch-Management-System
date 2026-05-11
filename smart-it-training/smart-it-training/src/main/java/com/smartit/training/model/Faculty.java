package com.smartit.training.model;

import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "faculty")
public class Faculty {
    
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
    
    @Column(name = "employee_id", unique = true, length = 50)
    private String employeeId;
    
    @Column(length = 255)
    private String qualification;
    
    @Column(name = "experience_years")
    private Integer experienceYears = 0;
    
    @Column(name = "joining_date")
    private LocalDate joiningDate;
    
    @Column(name = "profile_image", length = 255)
    private String profileImage;
    
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
        PENDING, APPROVED, REJECTED, INACTIVE
    }
    
    // Constructors
    public Faculty() {}
    
    public Faculty(String name, String email, String contact, String adminOfficeName, 
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
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }
    
    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }
    
    // Getters and Setters
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
    
    public String getEmployeeId() {
        return employeeId;
    }
    
    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }
    
    public String getQualification() {
        return qualification;
    }
    
    public void setQualification(String qualification) {
        this.qualification = qualification;
    }
    
    public Integer getExperienceYears() {
        return experienceYears;
    }
    
    public void setExperienceYears(Integer experienceYears) {
        this.experienceYears = experienceYears;
    }
    
    public LocalDate getJoiningDate() {
        return joiningDate;
    }
    
    public void setJoiningDate(LocalDate joiningDate) {
        this.joiningDate = joiningDate;
    }
    
    public String getProfileImage() {
        return profileImage;
    }
    
    public void setProfileImage(String profileImage) {
        this.profileImage = profileImage;
    }
    
    public String getResetOtp() {
        return resetOtp;
    }
    
    public void setResetOtp(String resetOtp) {
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
    
    // Helper Methods
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
    
    public void setResetOtp1(String otp) {
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
    
    @Override
    public String toString() {
        return "Faculty{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", username='" + username + '\'' +
                ", batchName='" + batchName + '\'' +
                ", status=" + status +
                '}';
    }
}
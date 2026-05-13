package com.smartit.training.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "placement")
public class Placement {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(name = "company_name", nullable = false, length = 100)
    private String companyName;
    
    @Column(name = "job_role", length = 100)
    private String jobRole;
    
    @Column(name = "job_role_description", columnDefinition = "TEXT")
    private String jobRoleDescription;
    
    @Column(name = "required_skills", columnDefinition = "TEXT")
    private String requiredSkills;
    
    @Column(name = "interview_rounds", columnDefinition = "TEXT")
    private String interviewRounds;
    
    @Column(name = "package_min")
    private Double packageMin;
    
    @Column(name = "package_max")
    private Double packageMax;
    
    @Column(length = 255)
    private String location;
    
    @Column(name = "last_date_to_apply", nullable = false)
    private LocalDate lastDateToApply;
    
    @Column(name = "is_active")
    private Boolean isActive = true;
    
    @Column(name = "added_by")
    private Integer addedBy;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
    
    // Constructors
    public Placement() {}
    
    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    
    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }
    
    public String getJobRole() { return jobRole; }
    public void setJobRole(String jobRole) { this.jobRole = jobRole; }
    
    public String getJobRoleDescription() { return jobRoleDescription; }
    public void setJobRoleDescription(String jobRoleDescription) { this.jobRoleDescription = jobRoleDescription; }
    
    public String getRequiredSkills() { return requiredSkills; }
    public void setRequiredSkills(String requiredSkills) { this.requiredSkills = requiredSkills; }
    
    public String getInterviewRounds() { return interviewRounds; }
    public void setInterviewRounds(String interviewRounds) { this.interviewRounds = interviewRounds; }
    
    public Double getPackageMin() { return packageMin; }
    public void setPackageMin(Double packageMin) { this.packageMin = packageMin; }
    
    public Double getPackageMax() { return packageMax; }
    public void setPackageMax(Double packageMax) { this.packageMax = packageMax; }
    
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    
    public LocalDate getLastDateToApply() { return lastDateToApply; }
    public void setLastDateToApply(LocalDate lastDateToApply) { this.lastDateToApply = lastDateToApply; }
    
    public Boolean getIsActive() { return isActive; }
    public void setIsActive(Boolean isActive) { this.isActive = isActive; }
    
    public Integer getAddedBy() { return addedBy; }
    public void setAddedBy(Integer addedBy) { this.addedBy = addedBy; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}
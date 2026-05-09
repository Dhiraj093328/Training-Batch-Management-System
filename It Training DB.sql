-- =============================================
-- SMART IT TRAINING - COMPLETE DATABASE
-- Based on your project requirements
-- =============================================

CREATE DATABASE IF NOT EXISTS smart_it_training;
USE smart_it_training;

-- =============================================
-- 1. ADMIN TABLE (Administrative Offices)
-- =============================================
CREATE TABLE admin (
    id INT PRIMARY KEY AUTO_INCREMENT,
    admin_office_name VARCHAR(100) NOT NULL,
    contact_no VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    user_id VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    is_master BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- =============================================
-- 2. BATCH TABLE (Java, Python, MERN, Cloud, SAP, etc.)
-- =============================================
CREATE TABLE batch (
    id INT PRIMARY KEY AUTO_INCREMENT,
    batch_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    start_date DATE,
    end_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES admin(id)
);

-- =============================================
-- 3. COURSE TABLE
-- =============================================
CREATE TABLE course (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    duration_weeks INT,
    fees DECIMAL(10,2),
    brochure_path VARCHAR(255),
    image_url VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES admin(id)
);

-- =============================================
-- 4. BATCH_COURSE (Many-to-Many: Which courses in which batch)
-- =============================================
CREATE TABLE batch_course (
    id INT PRIMARY KEY AUTO_INCREMENT,
    batch_id INT NOT NULL,
    course_id INT NOT NULL,
    FOREIGN KEY (batch_id) REFERENCES batch(id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES course(id) ON DELETE CASCADE,
    UNIQUE KEY unique_batch_course (batch_id, course_id)
);

-- =============================================
-- 5. STUDENT TABLE (With Admin Office)
-- =============================================
CREATE TABLE student (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    contact_no VARCHAR(15),
    admin_office_name VARCHAR(100) NOT NULL,
    batch_name VARCHAR(50),
    user_id VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    enrollment_date DATE,
    status ENUM('PENDING', 'APPROVED', 'REJECTED') DEFAULT 'PENDING',
    approved_by INT,
    approved_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (approved_by) REFERENCES admin(id),
    FOREIGN KEY (batch_name) REFERENCES batch(batch_name)
);

-- =============================================
-- 6. FACULTY TABLE (With Admin Office)
-- =============================================
CREATE TABLE faculty (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    contact_no VARCHAR(15),
    admin_office_name VARCHAR(100) NOT NULL,
    batch_name VARCHAR(50),
    user_id VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    qualification VARCHAR(255),
    joining_date DATE,
    status ENUM('PENDING', 'APPROVED', 'REJECTED') DEFAULT 'PENDING',
    approved_by INT,
    approved_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (approved_by) REFERENCES admin(id),
    FOREIGN KEY (batch_name) REFERENCES batch(batch_name)
);

-- =============================================
-- 7. ATTENDANCE TABLE
-- =============================================
CREATE TABLE attendance (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    batch_name VARCHAR(50),
    attendance_date DATE NOT NULL,
    status ENUM('PRESENT', 'ABSENT', 'LATE') DEFAULT 'ABSENT',
    marked_by_faculty_id INT,
    remark VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (marked_by_faculty_id) REFERENCES faculty(id),
    UNIQUE KEY unique_daily_attendance (student_id, attendance_date)
);

-- =============================================
-- 8. NOTICE TABLE
-- =============================================
CREATE TABLE notice (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    category VARCHAR(50),
    is_published BOOLEAN DEFAULT TRUE,
    published_by INT,
    published_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (published_by) REFERENCES admin(id)
);

-- =============================================
-- 9. FEEDBACK TABLE (Public - No Login Required)
-- =============================================
CREATE TABLE feedback (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- 10. FEE RECEIPT TABLE
-- =============================================
CREATE TABLE fee_receipt (
    id INT PRIMARY KEY AUTO_INCREMENT,
    receipt_number VARCHAR(50) UNIQUE NOT NULL,
    student_id INT NOT NULL,
    student_name VARCHAR(100),
    contact_no VARCHAR(15),
    email VARCHAR(100),
    course_name VARCHAR(100),
    paid_amount DECIMAL(10,2) NOT NULL,
    executive_name VARCHAR(100),
    receipt_pdf_path VARCHAR(255),
    generated_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (generated_by) REFERENCES admin(id)
);

-- =============================================
-- 11. PLACEMENT TABLE
-- =============================================
CREATE TABLE placement (
    id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(100) NOT NULL,
    job_role_description TEXT,
    required_skills TEXT,
    interview_round_details TEXT,
    last_date_to_apply DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    added_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (added_by) REFERENCES admin(id)
);

-- =============================================
-- 12. PLACEMENT APPLICATION TABLE
-- =============================================
CREATE TABLE placement_application (
    id INT PRIMARY KEY AUTO_INCREMENT,
    placement_id INT NOT NULL,
    student_id INT NOT NULL,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('PENDING', 'SHORTLISTED', 'REJECTED', 'SELECTED') DEFAULT 'PENDING',
    FOREIGN KEY (placement_id) REFERENCES placement(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    UNIQUE KEY unique_application (placement_id, student_id)
);

-- =============================================
-- 13. EVENT TABLE
-- =============================================
CREATE TABLE event (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    event_date DATE NOT NULL,
    event_time TIME,
    location VARCHAR(255),
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES admin(id)
);

-- =============================================
-- 14. SYLLABUS TABLE (For Faculty)
-- =============================================
CREATE TABLE syllabus (
    id INT PRIMARY KEY AUTO_INCREMENT,
    faculty_id INT NOT NULL,
    batch_name VARCHAR(50),
    subject_name VARCHAR(100),
    topic_name VARCHAR(255) NOT NULL,
    is_completed BOOLEAN DEFAULT FALSE,
    completed_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (faculty_id) REFERENCES faculty(id) ON DELETE CASCADE,
    FOREIGN KEY (batch_name) REFERENCES batch(batch_name)
);

-- =============================================
-- 15. EXAM TABLE
-- =============================================
CREATE TABLE exam (
    id INT PRIMARY KEY AUTO_INCREMENT,
    faculty_id INT NOT NULL,
    batch_name VARCHAR(50),
    title VARCHAR(100) NOT NULL,
    description TEXT,
    duration_minutes INT NOT NULL,
    total_marks INT NOT NULL,
    passing_marks INT,
    exam_date DATE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (faculty_id) REFERENCES faculty(id) ON DELETE CASCADE,
    FOREIGN KEY (batch_name) REFERENCES batch(batch_name)
);

-- =============================================
-- 16. QUESTION TABLE
-- =============================================
CREATE TABLE question (
    id INT PRIMARY KEY AUTO_INCREMENT,
    exam_id INT NOT NULL,
    question_text TEXT NOT NULL,
    option_a VARCHAR(500),
    option_b VARCHAR(500),
    option_c VARCHAR(500),
    option_d VARCHAR(500),
    correct_answer VARCHAR(10),
    marks INT DEFAULT 1,
    FOREIGN KEY (exam_id) REFERENCES exam(id) ON DELETE CASCADE
);

-- =============================================
-- 17. RESULT TABLE
-- =============================================
CREATE TABLE result (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    exam_id INT NOT NULL,
    score INT NOT NULL,
    total_marks INT,
    percentage DECIMAL(5,2),
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (exam_id) REFERENCES exam(id) ON DELETE CASCADE,
    UNIQUE KEY unique_result (student_id, exam_id)
);

-- =============================================
-- 18. ADMIN_ACTIVITY_LOG (Audit Trail)
-- =============================================
CREATE TABLE admin_activity_log (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    admin_id INT NOT NULL,
    action VARCHAR(100) NOT NULL,
    entity_type VARCHAR(50),
    entity_id INT,
    details TEXT,
    ip_address VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (admin_id) REFERENCES admin(id)
);

-- =============================================
-- 19. EMAIL_TEMPLATE TABLE
-- =============================================
CREATE TABLE email_template (
    id INT PRIMARY KEY AUTO_INCREMENT,
    template_name VARCHAR(100) UNIQUE NOT NULL,
    subject VARCHAR(255),
    body TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default email templates
INSERT INTO email_template (template_name, subject, body) VALUES 
('STUDENT_APPROVAL', 'Your Student Account is Approved', 'Dear {name}, your student account has been approved. You can now login with User ID: {userId} and Password: {password}'),
('FACULTY_APPROVAL', 'Your Faculty Account is Approved', 'Dear {name}, your faculty account has been approved. You can now login with User ID: {userId} and Password: {password}'),
('STUDENT_REJECTION', 'Student Account Registration Update', 'Dear {name}, your student account request has been reviewed. Please contact admin for more details.'),
('FACULTY_REJECTION', 'Faculty Account Registration Update', 'Dear {name}, your faculty account request has been reviewed. Please contact admin for more details.');

-- =============================================
-- 20. INSERT DEFAULT BATCHES
-- =============================================
INSERT INTO batch (batch_name, description, is_active) VALUES 
('Java', 'Full Stack Java Development', TRUE),
('Python', 'Python Full Stack Development', TRUE),
('MERN', 'MERN Stack Web Development', TRUE),
('Cloud', 'Cloud Computing & DevOps', TRUE),
('SAP', 'SAP FICO/ABAP Training', TRUE),
('Data Science', 'Data Science & Machine Learning', TRUE);

-- =============================================
-- 21. INSERT DEFAULT COURSES
-- =============================================
INSERT INTO course (title, description, duration_weeks, is_active) VALUES 
('Core Java', 'Java fundamentals to advanced', 8, TRUE),
('Spring Boot', 'Spring Boot microservices', 6, TRUE),
('Python Core', 'Python programming basics', 6, TRUE),
('Django', 'Django web framework', 5, TRUE),
('React JS', 'React frontend development', 5, TRUE),
('Node JS', 'Node.js backend development', 5, TRUE);

-- =============================================
-- 22. INSERT DEFAULT ADMIN (For testing)
-- =============================================
INSERT INTO admin (admin_office_name, contact_no, email, user_id, password, is_master) VALUES 
('Head Office', '9999999999', 'admin@smartit.com', 'admin', 'admin123', TRUE);
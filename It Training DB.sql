CREATE DATABASE smart_it_training;
USE smart_it_training;

-- =============================================
-- 1. ADMIN TABLE (Administrative Offices)
-- =============================================
CREATE TABLE admin (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contact VARCHAR(15),
    office_name VARCHAR(100),
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    reset_token VARCHAR(255),
    reset_token_expiry TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
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
-- 4. BATCH_COURSE (Many-to-Many)
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
-- 5. STUDENT TABLE
-- =============================================
CREATE TABLE student (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    contact VARCHAR(15),
    admin_office_name VARCHAR(100) NOT NULL,
    batch_name VARCHAR(50),
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    enrollment_no VARCHAR(50) UNIQUE,
    status ENUM('PENDING', 'APPROVED', 'REJECTED') DEFAULT 'PENDING',
    approved_by INT,
    approved_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (approved_by) REFERENCES admin(id),
    FOREIGN KEY (batch_name) REFERENCES batch(batch_name)
);

-- =============================================
-- 6. FACULTY TABLE
-- =============================================
CREATE TABLE faculty (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    contact VARCHAR(15),
    admin_office_name VARCHAR(100) NOT NULL,
    batch_name VARCHAR(50),
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    employee_id VARCHAR(50) UNIQUE,
    qualification VARCHAR(255),
    status ENUM('PENDING', 'APPROVED', 'REJECTED') DEFAULT 'PENDING',
    approved_by INT,
    approved_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
    UNIQUE KEY unique_attendance (student_id, attendance_date)
);

-- =============================================
-- 8. NOTICE TABLE (E-Notice Management)
-- =============================================
CREATE TABLE notice (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    category VARCHAR(50),
    is_published BOOLEAN DEFAULT TRUE,
    published_by INT,
    published_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (published_by) REFERENCES admin(id)
);

-- =============================================
-- 9. FEEDBACK TABLE (Public - No Login)
-- =============================================
CREATE TABLE feedback (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    is_read BOOLEAN DEFAULT FALSE,
    replied_by INT,
    reply_message TEXT,
    replied_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (replied_by) REFERENCES admin(id)
);

-- =============================================
-- 10. FEE RECEIPT TABLE (Account Management)
-- =============================================
CREATE TABLE fee_receipt (
    id INT PRIMARY KEY AUTO_INCREMENT,
    receipt_number VARCHAR(50) UNIQUE NOT NULL,
    student_id INT NOT NULL,
    student_name VARCHAR(100),
    contact VARCHAR(15),
    email VARCHAR(100),
    course_name VARCHAR(100),
    paid_amount DECIMAL(10,2) NOT NULL,
    payment_mode ENUM('CASH', 'CARD', 'UPI', 'BANK_TRANSFER') DEFAULT 'CASH',
    transaction_id VARCHAR(100),
    executive_name VARCHAR(100),
    receipt_pdf_path VARCHAR(255),
    generated_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (generated_by) REFERENCES admin(id)
);

-- =============================================
-- 11. PLACEMENT TABLE (Training & Placement)
-- =============================================
CREATE TABLE placement (
    id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(100) NOT NULL,
    job_role VARCHAR(100),
    job_role_description TEXT,
    required_skills TEXT,
    interview_details TEXT,
    package_min DECIMAL(10,2),
    package_max DECIMAL(10,2),
    location VARCHAR(255),
    last_date_to_apply DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    added_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (added_by) REFERENCES admin(id)
);

-- =============================================
-- 12. PLACEMENT APPLICATION TABLE
-- =============================================
CREATE TABLE placement_application (
    id INT PRIMARY KEY AUTO_INCREMENT,
    placement_id INT NOT NULL,
    student_id INT NOT NULL,
    status ENUM('APPLIED', 'SHORTLISTED', 'REJECTED', 'SELECTED') DEFAULT 'APPLIED',
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reviewed_by INT,
    reviewed_at TIMESTAMP,
    remarks TEXT,
    FOREIGN KEY (placement_id) REFERENCES placement(id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (reviewed_by) REFERENCES admin(id),
    UNIQUE KEY unique_application (placement_id, student_id)
);

-- =============================================
-- 13. EVENT TABLE (Event Management)
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
-- 14. SYLLABUS TABLE (Faculty Module)
-- =============================================
CREATE TABLE syllabus (
    id INT PRIMARY KEY AUTO_INCREMENT,
    faculty_id INT NOT NULL,
    batch_name VARCHAR(50),
    subject_name VARCHAR(100),
    topic_name VARCHAR(255) NOT NULL,
    topic_description TEXT,
    order_number INT,
    is_completed BOOLEAN DEFAULT FALSE,
    completed_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
    start_time TIME,
    end_time TIME,
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
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
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
    is_passed BOOLEAN DEFAULT FALSE,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reviewed_by INT,
    remarks TEXT,
    FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
    FOREIGN KEY (exam_id) REFERENCES exam(id) ON DELETE CASCADE,
    FOREIGN KEY (reviewed_by) REFERENCES faculty(id),
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

-- =============================================
-- 20. NOTIFICATION TABLE
-- =============================================
CREATE TABLE notification (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_type ENUM('ADMIN', 'STUDENT', 'FACULTY') NOT NULL,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- INSERT DEFAULT DATA
-- =============================================

-- Insert Default Batches
INSERT INTO batch (batch_name, description, is_active) VALUES 
('Java', 'Full Stack Java Development with Spring Boot', TRUE),
('Python', 'Python Full Stack Development with Django', TRUE),
('MERN', 'MERN Stack Web Development', TRUE),
('Cloud', 'Cloud Computing & DevOps', TRUE),
('SAP', 'SAP FICO/ABAP Training', TRUE),
('Data Science', 'Data Science & Machine Learning', TRUE),
('AWS', 'Amazon Web Services Certification', TRUE),
('Android', 'Android App Development', TRUE);

-- Insert Default Courses
INSERT INTO course (title, description, duration_weeks, fees, is_active) VALUES 
('Core Java', 'Java programming fundamentals to advanced', 8, 15000.00, TRUE),
('Spring Boot', 'Spring Boot microservices development', 6, 12000.00, TRUE),
('Python Core', 'Python programming basics to advanced', 6, 12000.00, TRUE),
('Django', 'Django web framework development', 5, 10000.00, TRUE),
('React JS', 'React frontend development', 5, 10000.00, TRUE),
('Node JS', 'Node.js backend development', 5, 10000.00, TRUE),
('MongoDB', 'MongoDB database design', 4, 8000.00, TRUE),
('AWS Solutions', 'AWS cloud architecture', 8, 20000.00, TRUE);

-- Insert Default Admin (Password: admin123)
INSERT INTO admin (name, email, contact, office_name, username, password, is_active) VALUES 
('Super Admin', 'admin@smartit.com', '9999999999', 'Head Office', 'admin', 'admin123', TRUE);

-- Insert Email Templates
INSERT INTO email_template (template_name, subject, body) VALUES 
('STUDENT_APPROVAL', 'Your Student Account is Approved', 
 'Dear {name},<br><br>Your student account has been approved.<br><br><strong>Login Credentials:</strong><br>Username: {username}<br>Password: {password}<br><br>Login URL: http://localhost:8080/student/login<br><br>Thanks,<br>Smart IT Training Centre'),

('FACULTY_APPROVAL', 'Your Faculty Account is Approved', 
 'Dear {name},<br><br>Your faculty account has been approved.<br><br><strong>Login Credentials:</strong><br>Username: {username}<br>Password: {password}<br><br>Login URL: http://localhost:8080/faculty/login<br><br>Thanks,<br>Smart IT Training Centre'),

('STUDENT_REJECTION', 'Student Account Registration Update', 
 'Dear {name},<br><br>Your student account request has been reviewed. Please contact admin for more details.<br><br>Thanks,<br>Smart IT Training Centre'),

('FACULTY_REJECTION', 'Faculty Account Registration Update', 
 'Dear {name},<br><br>Your faculty account request has been reviewed. Please contact admin for more details.<br><br>Thanks,<br>Smart IT Training Centre'),

('PLACEMENT_APPLIED', 'Placement Application Confirmation',
 'Dear {name},<br><br>You have successfully applied for {company_name}.<br><br>We will notify you once shortlisted.<br><br>Thanks,<br>Smart IT Training Centre'),

('FEE_RECEIPT_GENERATED', 'Fee Receipt Generated',
 'Dear {name},<br><br>Your fee receipt has been generated.<br><br>Amount: {amount}<br>Course: {course}<br><br>Download receipt from your account.<br><br>Thanks,<br>Smart IT Training Centre');

-- Insert Sample Notices
INSERT INTO notice (title, content, category, published_by) VALUES 
('Welcome to New Batch', 'New batches starting from next month. Register now!', 'Announcement', 1),
('Holiday Notice', 'Institute will remain closed on Republic Day.', 'Holiday', 1),
('Exam Schedule', 'Semester exams will start from next week.', 'Exam', 1);

-- Insert Sample Events
INSERT INTO event (title, description, event_date, event_time, location, created_by) VALUES 
('Tech Workshop 2024', 'One day workshop on latest technologies', '2024-12-15', '10:00:00', 'Main Auditorium', 1),
('Career Fair', 'Job fair with 50+ companies', '2024-12-20', '09:00:00', 'Training Center', 1);

-- Insert Sample Feedback
INSERT INTO feedback (name, email, message, rating) VALUES 
('John Doe', 'john@example.com', 'Excellent training programs!', 5),
('Jane Smith', 'jane@example.com', 'Great faculty support', 4);

-- =============================================
-- VIEWS FOR EASY DATA ACCESS
-- =============================================

-- View for Pending Student Approvals
CREATE VIEW pending_students AS
SELECT s.*, a.name as admin_name, a.office_name 
FROM student s 
LEFT JOIN admin a ON s.admin_office_name = a.office_name
WHERE s.status = 'PENDING';

-- View for Pending Faculty Approvals
CREATE VIEW pending_faculty AS
SELECT f.*, a.name as admin_name, a.office_name 
FROM faculty f 
LEFT JOIN admin a ON f.admin_office_name = a.office_name
WHERE f.status = 'PENDING';

-- View for Monthly Attendance Summary
CREATE VIEW monthly_attendance_summary AS
SELECT 
    s.id as student_id,
    s.name as student_name,
    s.batch_name,
    COUNT(CASE WHEN a.status = 'PRESENT' THEN 1 END) as present_days,
    COUNT(*) as total_days,
    ROUND((COUNT(CASE WHEN a.status = 'PRESENT' THEN 1 END) * 100.0 / COUNT(*)), 2) as attendance_percentage
FROM student s
LEFT JOIN attendance a ON s.id = a.student_id 
    AND MONTH(a.attendance_date) = MONTH(CURRENT_DATE)
GROUP BY s.id, s.name, s.batch_name;

-- =============================================
-- INDEXES FOR PERFORMANCE
-- =============================================

CREATE INDEX idx_student_status ON student(status);
CREATE INDEX idx_faculty_status ON faculty(status);
CREATE INDEX idx_attendance_date ON attendance(attendance_date);
CREATE INDEX idx_attendance_student ON attendance(student_id);
CREATE INDEX idx_placement_last_date ON placement(last_date_to_apply);
CREATE INDEX idx_notice_published ON notice(is_published);
CREATE INDEX idx_feedback_read ON feedback(is_read);
CREATE INDEX idx_fee_receipt_student ON fee_receipt(student_id);
CREATE INDEX idx_placement_application_student ON placement_application(student_id);

-- =============================================
-- STORED PROCEDURES
-- =============================================
-- Procedure to approve student
DELIMITER //
CREATE PROCEDURE approve_student(
    IN p_student_id INT,
    IN p_admin_id INT
)
BEGIN
    UPDATE student 
    SET status = 'APPROVED', 
        approved_by = p_admin_id, 
        approved_at = NOW()
    WHERE id = p_student_id;
    
    INSERT INTO admin_activity_log (admin_id, action, entity_type, entity_id, details)
    VALUES (p_admin_id, 'APPROVE_STUDENT', 'STUDENT', p_student_id, 'Student account approved');
END //
DELIMITER ;

-- Procedure to approve faculty
DELIMITER //
CREATE PROCEDURE approve_faculty(
    IN p_faculty_id INT,
    IN p_admin_id INT
)
BEGIN
    UPDATE faculty 
    SET status = 'APPROVED', 
        approved_by = p_admin_id, 
        approved_at = NOW()
    WHERE id = p_faculty_id;
    
    INSERT INTO admin_activity_log (admin_id, action, entity_type, entity_id, details)
    VALUES (p_admin_id, 'APPROVE_FACULTY', 'FACULTY', p_faculty_id, 'Faculty account approved');
END //
DELIMITER ;

-- =============================================
-- TRIGGERS
-- =============================================

-- Trigger to generate receipt number automatically
DELIMITER //
CREATE TRIGGER before_insert_fee_receipt
BEFORE INSERT ON fee_receipt
FOR EACH ROW
BEGIN
    IF NEW.receipt_number IS NULL THEN
        SET NEW.receipt_number = CONCAT('RCP', DATE_FORMAT(NOW(), '%Y%m%d'), LPAD(NEW.student_id, 4, '0'));
    END IF;
END //
DELIMITER ;

-- =============================================
-- DISPLAY ALL TABLES
-- =============================================
SHOW TABLES;
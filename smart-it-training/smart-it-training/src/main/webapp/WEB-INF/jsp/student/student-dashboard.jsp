<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Student Dashboard | Smart IT Training</title>
    
    <!-- External Dependencies -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- External CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/student-dashboard.css">
</head>
<body>

<div class="dashboard-container">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <div class="logo-icon">🎓</div>
            <h2>Smart IT Training</h2>
            <p>Student Portal</p>
        </div>
        <div class="sidebar-menu">
            <div class="menu-item active" data-section="dashboard">
                <i class="fas fa-tachometer-alt"></i> <span>Dashboard</span>
            </div>
            <div class="menu-item" data-section="attendance">
                <i class="fas fa-calendar-check"></i> <span>Attendance Score</span>
            </div>
            <div class="menu-item" data-section="exam">
                <i class="fas fa-file-alt"></i> <span>Online Exam & Result</span>
            </div>
            <div class="menu-item" data-section="syllabus">
                <i class="fas fa-book"></i> <span>Syllabus Coverage</span>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Bar -->
        <div class="top-bar">
            <div class="welcome-text">
                <h3>Welcome, ${sessionScope.studentName}!</h3>
                <p><i class="fas fa-user-graduate"></i> Student Dashboard</p>
            </div>
            <div class="student-badge">
                <i class="fas fa-layer-group"></i> Batch: ${sessionScope.studentBatch}
            </div>
            <div class="date-time">
                <div class="date" id="currentDate"></div>
                <div class="time" id="currentTime"></div>
            </div>
            <a href="${pageContext.request.contextPath}/student/logout" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>

        <!-- ========== DASHBOARD SECTION ========== -->
        <div id="dashboard-section" class="content-section active-section">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-info">
                        <div class="stat-number" id="attendancePercent">0%</div>
                        <div class="stat-label">Overall Attendance</div>
                    </div>
                    <div class="stat-icon"><i class="fas fa-calendar-check"></i></div>
                </div>
                <div class="stat-card">
                    <div class="stat-info">
                        <div class="stat-number" id="examsCompleted">0</div>
                        <div class="stat-label">Exams Completed</div>
                    </div>
                    <div class="stat-icon"><i class="fas fa-file-alt"></i></div>
                </div>
                <div class="stat-card">
                    <div class="stat-info">
                        <div class="stat-number" id="avgScore">0%</div>
                        <div class="stat-label">Average Score</div>
                    </div>
                    <div class="stat-icon"><i class="fas fa-chart-line"></i></div>
                </div>
                <div class="stat-card">
                    <div class="stat-info">
                        <div class="stat-number" id="syllabusPercent">0%</div>
                        <div class="stat-label">Syllabus Covered</div>
                    </div>
                    <div class="stat-icon"><i class="fas fa-book"></i></div>
                </div>
            </div>
            <div class="section-card">
                <div class="section-title">Quick Overview</div>
                <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 15px;">
                    <div>
                        <p><strong><i class="fas fa-user"></i> Name:</strong> ${sessionScope.studentName}</p>
                        <p><strong><i class="fas fa-envelope"></i> Email:</strong> ${sessionScope.studentEmail}</p>
                        <p><strong><i class="fas fa-id-card"></i> Enrollment No:</strong> ${sessionScope.studentEnrollmentNo}</p>
                    </div>
                    <div>
                        <p><strong><i class="fas fa-layer-group"></i> Batch:</strong> ${sessionScope.studentBatch}</p>
                        <p><strong><i class="fas fa-calendar-alt"></i> Login Time:</strong> ${sessionScope.loginTime}</p>
                        <p><strong><i class="fas fa-check-circle"></i> Status:</strong> <span style="color: #28a745;">Active</span></p>
                    </div>
                </div>
            </div>
        </div>

        <!-- ========== ATTENDANCE SCORE SECTION ========== -->
        <div id="attendance-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-calendar-check"></i> My Attendance Score</div>
                
                <div style="margin-bottom: 30px;">
                    <h4>Overall Attendance</h4>
                    <div style="font-size: 2rem; font-weight: 700; color: #667eea;" id="overallAttendance">0%</div>
                    <div class="progress-bar" style="margin-top: 10px;">
                        <div class="progress-fill" id="overallAttendanceBar" style="width: 0%"></div>
                    </div>
                </div>
                
                <div style="margin-bottom: 30px;">
                    <h4>Monthly Attendance Trend</h4>
                    <canvas id="attendanceChart" style="max-height: 300px;"></canvas>
                </div>
                
                <h4>Monthly Attendance Details</h4>
                <table class="attendance-table" id="attendanceTable">
                    <thead>
                        <tr><th>Month</th><th>Present Days</th><th>Total Days</th><th>Attendance %</th><th>Progress</th></tr>
                    </thead>
                    <tbody id="attendanceTableBody"></tbody>
                </table>
            </div>
        </div>

        <!-- ========== ONLINE EXAM & RESULT SECTION ========== -->
        <div id="exam-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-file-alt"></i> Online Exams</div>
                
                <h4><i class="fas fa-clock"></i> Upcoming Exams</h4>
                <div class="exam-grid" id="upcomingExams">
                    <div class="exam-card">
                        <h4>Core Java Assessment</h4>
                        <div class="exam-date"><i class="fas fa-calendar"></i> Dec 15, 2024 | 10:00 AM</div>
                        <div>Duration: 60 mins | Total Marks: 50</div>
                        <span class="exam-status status-upcoming">Not Started</span>
                    </div>
                    <div class="exam-card">
                        <h4>Spring Boot Test</h4>
                        <div class="exam-date"><i class="fas fa-calendar"></i> Dec 20, 2024 | 02:00 PM</div>
                        <div>Duration: 90 mins | Total Marks: 100</div>
                        <span class="exam-status status-upcoming">Not Started</span>
                    </div>
                    <div class="exam-card">
                        <h4>MySQL Database Exam</h4>
                        <div class="exam-date"><i class="fas fa-calendar"></i> Dec 22, 2024 | 11:00 AM</div>
                        <div>Duration: 45 mins | Total Marks: 50</div>
                        <span class="exam-status status-upcoming">Not Started</span>
                    </div>
                </div>

                <h4 style="margin-top: 30px;"><i class="fas fa-chart-line"></i> Completed Exams & Results</h4>
                <div class="result-grid" id="completedExams">
                    <div class="result-card">
                        <h4>Python Fundamentals</h4>
                        <div class="score">42/50</div>
                        <div>Percentage: 84% | Grade: A</div>
                        <div class="grade">Excellent</div>
                        <div><small>Completed: Dec 05, 2024</small></div>
                    </div>
                    <div class="result-card">
                        <h4>Database Management</h4>
                        <div class="score">38/50</div>
                        <div>Percentage: 76% | Grade: B+</div>
                        <div class="grade">Good</div>
                        <div><small>Completed: Nov 28, 2024</small></div>
                    </div>
                    <div class="result-card">
                        <h4>Web Technologies</h4>
                        <div class="score">45/50</div>
                        <div>Percentage: 90% | Grade: A+</div>
                        <div class="grade">Outstanding</div>
                        <div><small>Completed: Nov 15, 2024</small></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ========== SYLLABUS COVERAGE SECTION ========== -->
        <div id="syllabus-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-book"></i> Syllabus Coverage</div>
                
                <div style="margin-bottom: 30px;">
                    <h4>Overall Syllabus Progress</h4>
                    <div style="font-size: 2rem; font-weight: 700; color: #667eea;" id="overallSyllabus">0%</div>
                    <div class="progress-bar" style="margin-top: 10px;">
                        <div class="progress-fill" id="overallSyllabusBar" style="width: 0%"></div>
                    </div>
                </div>
                
                <h4>Subject-wise Progress</h4>
                <div id="subjectProgressList"></div>
                
                <h4 style="margin-top: 30px;">Topic-wise Syllabus</h4>
                <div id="syllabusTopicsList"></div>
            </div>
        </div>
    </div>
</div>

<!-- External JS -->
<script src="${pageContext.request.contextPath}/js/student-dashboard.js"></script>
</body>
</html>
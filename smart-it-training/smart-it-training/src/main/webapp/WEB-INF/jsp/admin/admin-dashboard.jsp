<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Admin Dashboard | Smart IT Training</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: #f0f2f5;
            overflow-x: hidden;
        }

        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 280px;
            background: linear-gradient(135deg, #1a1a2e, #16213e);
            color: white;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            z-index: 100;
        }

        .sidebar-header {
            padding: 25px 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .sidebar-header .logo-icon {
            font-size: 45px;
            margin-bottom: 10px;
        }

        .sidebar-header h2 {
            font-size: 1.2rem;
            margin-bottom: 5px;
        }

        .sidebar-header p {
            font-size: 0.7rem;
            opacity: 0.7;
        }

        .sidebar-menu {
            padding: 20px 0;
        }

        .menu-item {
            padding: 14px 25px;
            display: flex;
            align-items: center;
            gap: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            color: rgba(255,255,255,0.8);
            border-left: 3px solid transparent;
        }

        .menu-item:hover, .menu-item.active {
            background: rgba(255,255,255,0.1);
            border-left-color: #00ffcc;
            color: #00ffcc;
        }

        .menu-item i {
            width: 25px;
            font-size: 1.1rem;
        }

        .main-content {
            margin-left: 280px;
            flex: 1;
            padding: 20px;
        }

        .top-bar {
            background: white;
            border-radius: 15px;
            padding: 15px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .welcome-text h3 {
            color: #333;
            font-size: 1.2rem;
        }

        .welcome-text p {
            color: #666;
            font-size: 0.8rem;
        }

        .date-time {
            text-align: right;
        }

        .date-time .date {
            color: #666;
            font-size: 0.8rem;
        }

        .date-time .time {
            color: #667eea;
            font-size: 1.3rem;
            font-weight: 600;
        }

        .logout-btn {
            background: linear-gradient(135deg, #ff416c, #ff4b2b);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            text-decoration: none;
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(255,65,108,0.4);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .stat-info .stat-number {
            font-size: 1.8rem;
            font-weight: 700;
            color: #333;
        }

        .stat-info .stat-label {
            color: #666;
            font-size: 0.85rem;
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
        }

        .content-section {
            display: none;
            animation: fadeIn 0.3s ease;
        }

        .content-section.active-section {
            display: block;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .section-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .section-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
            border-left: 4px solid #667eea;
            padding-left: 15px;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table th, .data-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        .data-table th {
            background: #f8f9fa;
            font-weight: 600;
        }

        .data-table tr:hover {
            background: #f8f9fa;
        }

        .btn-approve {
            background: #28a745;
            color: white;
            border: none;
            padding: 6px 15px;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 5px;
        }

        .btn-approve:hover {
            background: #218838;
        }

        .btn-reject {
            background: #dc3545;
            color: white;
            border: none;
            padding: 6px 15px;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn-reject:hover {
            background: #c82333;
        }

        .btn-add {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            margin-bottom: 20px;
            font-weight: 500;
        }

        .btn-edit {
            background: #ffc107;
            color: #856404;
            border: none;
            padding: 5px 12px;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 5px;
            font-size: 0.75rem;
        }
        
        .btn-edit:hover {
            background: #e0a800;
        }

        .btn-view, .btn-reply-feedback, .btn-delete-feedback {
            background: #667eea;
            color: white;
            border: none;
            padding: 5px 12px;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 5px;
            font-size: 0.75rem;
        }
        
        .btn-reply-feedback { background: #28a745; }
        .btn-delete-feedback { background: #dc3545; }
        
        .status-read { background: #28a745; color: white; padding: 4px 10px; border-radius: 20px; font-size: 0.7rem; display: inline-block; }
        .status-unread { background: #ffc107; color: #856404; padding: 4px 10px; border-radius: 20px; font-size: 0.7rem; display: inline-block; }
        .stars { color: #ffc107; }
        .urgent-badge { background: #dc3545; color: white; padding: 2px 8px; border-radius: 12px; font-size: 0.7rem; margin-left: 5px; }
        .status-active { background: #28a745; color: white; padding: 4px 10px; border-radius: 20px; font-size: 0.7rem; display: inline-block; }
        .status-inactive { background: #6c757d; color: white; padding: 4px 10px; border-radius: 20px; font-size: 0.7rem; display: inline-block; }
        .featured-badge { background: #ffc107; color: #856404; padding: 2px 8px; border-radius: 12px; font-size: 0.7rem; margin-left: 5px; }

        .progress-bar {
            width: 100%;
            height: 8px;
            background: #e0e0e0;
            border-radius: 10px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, #667eea, #764ba2);
            border-radius: 10px;
            transition: width 0.5s ease;
        }

        .courses-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
        }

        .course-card {
            background: #f8f9fa;
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .course-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .course-card .course-info {
            padding: 15px;
        }

        .course-card h4 {
            margin-bottom: 8px;
        }

        .toast-message {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: #28a745;
            color: white;
            padding: 14px 25px;
            border-radius: 10px;
            z-index: 1000;
            animation: slideInRight 0.3s ease;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            font-weight: 500;
        }

        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1001;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background: white;
            padding: 25px;
            border-radius: 15px;
            width: 550px;
            max-width: 90%;
            max-height: 80vh;
            overflow-y: auto;
        }

        .modal-content textarea, .modal-content input, .modal-content select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 8px;
        }
        
        .modal-content input[type="checkbox"] {
            width: auto;
            margin-right: 10px;
        }

        .modal-buttons {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 15px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .form-group {
            margin-bottom: 10px;
        }

        .form-group label {
            display: block;
            font-weight: 500;
            margin-bottom: 5px;
            color: #333;
        }

        .tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            border-bottom: 1px solid #ddd;
        }
        
        .tab {
            padding: 10px 20px;
            cursor: pointer;
            border: none;
            background: none;
            font-weight: 500;
        }
        
        .tab.active {
            color: #667eea;
            border-bottom: 2px solid #667eea;
        }
        
        .feedback-tab-content {
            display: none;
        }
        
        .feedback-tab-content.active {
            display: block;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 80px;
            }
            .sidebar-header h2, .sidebar-header p, .menu-item span {
                display: none;
            }
            .main-content {
                margin-left: 80px;
            }
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<div class="dashboard-container">
    <div class="sidebar">
        <div class="sidebar-header">
            <div class="logo-icon">🏛️</div>
            <h2>Smart IT Training</h2>
            <p>Admin Portal</p>
        </div>
        <div class="sidebar-menu">
            <div class="menu-item active" data-section="dashboard">
                <i class="fas fa-tachometer-alt"></i> <span>Dashboard</span>
            </div>
            <div class="menu-item" data-section="faculty">
                <i class="fas fa-chalkboard-user"></i> <span>Admin Faculty Dashboard</span>
            </div>
            <div class="menu-item" data-section="student">
                <i class="fas fa-user-graduate"></i> <span>Admin Student Dashboard</span>
            </div>
            <div class="menu-item" data-section="attendance">
                <i class="fas fa-calendar-check"></i> <span>Admin Attendance Dashboard</span>
            </div>
            <div class="menu-item" data-section="feedback">
                <i class="fas fa-star"></i> <span>Admin Feedback Dashboard</span>
            </div>
            <div class="menu-item" data-section="courses">
                <i class="fas fa-book"></i> <span>Admin Courses Dashboard</span>
            </div>
            <div class="menu-item" data-section="account">
                <i class="fas fa-wallet"></i> <span>Admin Account Dashboard</span>
            </div>
            <div class="menu-item" data-section="placement">
                <i class="fas fa-briefcase"></i> <span>Admin Training & Placement</span>
            </div>
            <div class="menu-item" data-section="notice">
                <i class="fas fa-bullhorn"></i> <span>Admin E-Notice Dashboard</span>
            </div>
            <div class="menu-item" data-section="event">
                <i class="fas fa-calendar-alt"></i> <span>Admin Event Dashboard</span>
            </div>
        </div>
    </div>

    <div class="main-content">
        <div class="top-bar">
            <div class="welcome-text">
                <h3>Welcome, ${sessionScope.adminName}!</h3>
                <p><i class="fas fa-shield-alt"></i> Administrative Dashboard</p>
            </div>
            <div class="date-time">
                <div class="date" id="currentDate"></div>
                <div class="time" id="currentTime"></div>
            </div>
            <a href="${pageContext.request.contextPath}/admin/logout" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>

        <!-- Dashboard Section -->
        <div id="dashboard-section" class="content-section active-section">
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-info">
                        <div class="stat-number">${pendingFacultyCount != null ? pendingFacultyCount : 0}</div>
                        <div class="stat-label">Pending Faculty</div>
                    </div>
                    <div class="stat-icon"><i class="fas fa-chalkboard-user"></i></div>
                </div>
                <div class="stat-card">
                    <div class="stat-info">
                        <div class="stat-number">${pendingStudentsCount != null ? pendingStudentsCount : 0}</div>
                        <div class="stat-label">Pending Students</div>
                    </div>
                    <div class="stat-icon"><i class="fas fa-user-graduate"></i></div>
                </div>
                <div class="stat-card">
                    <div class="stat-info">
                        <div class="stat-number">${approvedStudentsCount != null ? approvedStudentsCount : 0}</div>
                        <div class="stat-label">Approved Students</div>
                    </div>
                    <div class="stat-icon"><i class="fas fa-users"></i></div>
                </div>
                <div class="stat-card">
                    <div class="stat-info">
                        <div class="stat-number">${totalStudentsCount != null ? totalStudentsCount : 0}</div>
                        <div class="stat-label">Total Registered</div>
                    </div>
                    <div class="stat-icon"><i class="fas fa-database"></i></div>
                </div>
            </div>
            <div class="section-card">
                <div class="section-title">Quick Actions</div>
                <p>Select any option from the left menu to manage different modules.</p>
                <ul style="margin-top: 15px; margin-left: 20px;">
                    <li><i class="fas fa-check-circle" style="color: #28a745;"></i> Approve Faculty/Student Requests</li>
                    <li><i class="fas fa-book" style="color: #667eea;"></i> Manage Courses & Brochures</li>
                    <li><i class="fas fa-file-invoice-dollar" style="color: #28a745;"></i> Generate Fee Receipts</li>
                    <li><i class="fas fa-briefcase" style="color: #764ba2;"></i> Add Placement Opportunities</li>
                    <li><i class="fas fa-bullhorn" style="color: #ffc107;"></i> Publish Notices & Events</li>
                    <li><i class="fas fa-star" style="color: #fd7e14;"></i> View Feedback & Attendance Reports</li>
                </ul>
            </div>
        </div>

        <!-- Faculty Section -->
        <div id="faculty-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-chalkboard-user"></i> Faculty Requests</div>
                <c:choose>
                    <c:when test="${not empty pendingFaculty}">
                        <table class="data-table">
                            <thead>
                                <tr><th>Name</th><th>Contact</th><th>Batch</th><th>Username</th><th>Admin Office</th><th>Qualification</th><th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${pendingFaculty}" var="faculty">
                                    <tr id="faculty-row-${faculty.id}">
                                        <td>${faculty.name}</td>
                                        <td>${faculty.contact}</td>
                                        <td>${faculty.batchName}</td>
                                        <td>${faculty.username}</td>
                                        <td>${faculty.adminOfficeName}</td>
                                        <td>${faculty.qualification}</td>
                                        <td>
                                            <button class="btn-approve" onclick="approveFaculty(${faculty.id})">Accept</button>
                                            <button class="btn-reject" onclick="showFacultyRejectModal(${faculty.id}, '${faculty.name}')">Reject</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center; padding: 30px;"><i class="fas fa-check-circle" style="color: #28a745; font-size: 48px;"></i><p>No pending faculty requests</p></div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Student Section -->
        <div id="student-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-user-graduate"></i> Student Requests 
                    <c:if test="${pendingStudentsCount > 0}"><span style="font-size:0.8rem;background:#ffc107;color:#856404;padding:2px 10px;border-radius:20px;margin-left:10px;">${pendingStudentsCount} Pending</span></c:if>
                </div>
                <c:choose>
                    <c:when test="${not empty pendingStudents}">
                        <table class="data-table">
                            <thead>
                                <tr><th>Name</th><th>Contact</th><th>Batch</th><th>Username</th><th>Admin Office</th><th>Enrollment No</th><th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${pendingStudents}" var="student">
                                    <tr id="student-row-${student.id}">
                                        <td>${student.name}</td>
                                        <td>${student.contact}</td>
                                        <td>${student.batchName}</td>
                                        <td>${student.username}</td>
                                        <td>${student.adminOfficeName}</td>
                                        <td>${student.enrollmentNo}</td>
                                        <td>
                                            <button class="btn-approve" onclick="approveStudent(${student.id})">Accept</button>
                                            <button class="btn-reject" onclick="showStudentRejectModal(${student.id}, '${student.name}')">Reject</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align:center;padding:40px;"><i class="fas fa-check-circle" style="color:#28a745;font-size:48px;"></i><p>No pending student requests</p></div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Attendance Section -->
        <div id="attendance-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-calendar-check"></i> Attendance Reports</div>
                <div style="margin-bottom:20px;">
                    <label>Select Batch: </label>
                    <select id="batchSelect" onchange="loadAttendance()" style="padding:8px 15px;border-radius:8px;border:1px solid #ddd;margin-left:10px;">
                        <option value="Java">Java Batch</option>
                        <option value="Python">Python Batch</option>
                        <option value="MERN">MERN Batch</option>
                        <option value="Cloud">Cloud Batch</option>
                    </select>
                </div>
                <table class="data-table"><thead>运转<th>Student Name</th><th>Attendance %</th><th>Progress</th> </tr></thead><tbody id="attendanceList"></tbody></table>
            </div>
        </div>

        <!-- Feedback Section -->
        <div id="feedback-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-star"></i> Feedback Management</div>
                
                <div class="stats-grid" style="margin-bottom: 20px;">
                    <div class="stat-card"><div class="stat-info"><div class="stat-number" id="totalFeedbacks">0</div><div class="stat-label">Total Feedbacks</div></div><div class="stat-icon"><i class="fas fa-comments"></i></div></div>
                    <div class="stat-card"><div class="stat-info"><div class="stat-number" id="unreadFeedbacks">0</div><div class="stat-label">Unread</div></div><div class="stat-icon"><i class="fas fa-envelope"></i></div></div>
                    <div class="stat-card"><div class="stat-info"><div class="stat-number" id="avgRating">0</div><div class="stat-label">Average Rating</div></div><div class="stat-icon"><i class="fas fa-star"></i></div></div>
                </div>
                
                <div class="tabs">
                    <button class="tab active" onclick="showFeedbackTab('all')">All Feedbacks</button>
                    <button class="tab" onclick="showFeedbackTab('unread')">Unread (<span id="unreadCountBadge">0</span>)</button>
                </div>
                
                <div id="all-feedback-tab" class="feedback-tab-content active">
                    <table class="data-table">
                        <thead>运转<th>Date</th><th>Name</th><th>Email</th><th>Rating</th><th>Message</th><th>Status</th><th>Action</th> </tr></thead>
                        <tbody id="allFeedbackBody"></tbody>
                    </table>
                </div>
                <div id="unread-feedback-tab" class="feedback-tab-content">
                    <table class="data-table">
                        <thead>运转<th>Date</th><th>Name</th><th>Email</th><th>Rating</th><th>Message</th><th>Action</th> </tr></thead>
                        <tbody id="unreadFeedbackBody"></tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Courses Section -->
        <div id="courses-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-book"></i> Course Management</div>
                <button class="btn-add" onclick="addCourse()"><i class="fas fa-plus"></i> Add New Course</button>
                <div class="courses-grid" id="coursesList"></div>
            </div>
        </div>

        <!-- Account Section -->
        <div id="account-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-wallet"></i> Fee Receipt Generation</div>
                <button class="btn-add" onclick="showReceiptForm()"><i class="fas fa-file-invoice-dollar"></i> Generate Fee Receipt</button>
                <div id="receiptForm" style="display:none; margin-top:20px; padding:20px; background:#f8f9fa; border-radius:12px;">
                    <h4>Generate Fee Receipt</h4>
                    <input type="text" placeholder="Student Name" id="studentName" style="width:100%; padding:10px; margin:10px 0; border:1px solid #ddd; border-radius:8px;">
                    <input type="text" placeholder="Contact Number" id="contactNo" style="width:100%; padding:10px; margin:10px 0; border:1px solid #ddd; border-radius:8px;">
                    <input type="email" placeholder="Email" id="email" style="width:100%; padding:10px; margin:10px 0; border:1px solid #ddd; border-radius:8px;">
                    <input type="text" placeholder="Course" id="courseName" style="width:100%; padding:10px; margin:10px 0; border:1px solid #ddd; border-radius:8px;">
                    <input type="number" placeholder="Amount" id="amount" style="width:100%; padding:10px; margin:10px 0; border:1px solid #ddd; border-radius:8px;">
                    <input type="text" placeholder="Executive Name" id="executiveName" style="width:100%; padding:10px; margin:10px 0; border:1px solid #ddd; border-radius:8px;">
                    <button type="button" class="btn-add" onclick="generateReceipt()">Generate PDF Receipt</button>
                </div>
            </div>
        </div>

        <!-- Placement Section -->
        <div id="placement-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-briefcase"></i> Placement Management</div>
                <button class="btn-add" onclick="showPlacementForm()"><i class="fas fa-plus"></i> Add New Placement</button>
                <div id="placementForm" style="display:none; margin-top:20px; padding:20px; background:#f8f9fa; border-radius:12px;">
                    <h4>Add New Placement Opportunity</h4>
                    <input type="text" placeholder="Company Name" id="companyName" style="width:100%; padding:10px; margin:10px 0; border:1px solid #ddd; border-radius:8px;">
                    <textarea placeholder="Job Role Description" id="jobRoleDesc" style="width:100%; padding:10px; margin:10px 0; border:1px solid #ddd; border-radius:8px;" rows="3"></textarea>
                    <textarea placeholder="Required Skills" id="skills" style="width:100%; padding:10px; margin:10px 0; border:1px solid #ddd; border-radius:8px;" rows="2"></textarea>
                    <textarea placeholder="Interview Round Details" id="interviewDetails" style="width:100%; padding:10px; margin:10px 0; border:1px solid #ddd; border-radius:8px;" rows="2"></textarea>
                    <input type="date" placeholder="Last Date to Apply" id="lastDate" style="width:100%; padding:10px; margin:10px 0; border:1px solid #ddd; border-radius:8px;">
                    <button type="button" class="btn-add" onclick="addPlacement()">Add Placement</button>
                </div>
            </div>
        </div>

        <!-- Notice Section -->
        <div id="notice-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-bullhorn"></i> E-Notice Management</div>
                <button class="btn-add" onclick="showNoticeForm()"><i class="fas fa-plus"></i> Publish New Notice</button>
                <div id="noticeForm" style="display:none; margin-top:20px; padding:20px; background:#f8f9fa; border-radius:12px;">
                    <h4>Publish Notice</h4>
                    <input type="text" placeholder="Notice Title" id="noticeTitle" style="width:100%; padding:10px; margin:10px 0; border:1px solid #ddd; border-radius:8px;">
                    <textarea placeholder="Notice Content" id="noticeContent" style="width:100%; padding:10px; margin:10px 0; border:1px solid #ddd; border-radius:8px;" rows="4"></textarea>
                    
                    <div style="margin:10px 0;">
                        <label>Category: </label>
                        <select id="noticeCategory" style="padding:8px; border-radius:8px; border:1px solid #ddd; margin-left:10px;">
                            <option value="General">General</option>
                            <option value="Academic">Academic</option>
                            <option value="Exam">Exam</option>
                            <option value="Placement">Placement</option>
                            <option value="Event">Event</option>
                            <option value="Holiday">Holiday</option>
                        </select>
                    </div>
                    
                    <div style="margin:10px 0;">
                        <label>Expiry Date: </label>
                        <input type="date" id="noticeExpiryDate" style="padding:8px; border-radius:8px; border:1px solid #ddd; margin-left:10px;">
                    </div>
                    
                    <div style="margin:10px 0;">
                        <input type="checkbox" id="noticeUrgent"> 
                        <label>Mark as URGENT</label>
                    </div>
                    
                    <button type="button" class="btn-add" onclick="publishNotice()">Publish Notice</button>
                </div>
                
                <div style="margin-top: 30px;">
                    <h4>Published Notices</h4>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Title</th>
                                <th>Category</th>
                                <th>Publish Date</th>
                                <th>Status</th>
                                <th>Created By</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody id="noticesTableBody">
                            <tr><td colspan="7" style="text-align:center;">Loading notices...<\/td><\/tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Event Section - CORRECTED FULL VERSION -->
        <div id="event-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-calendar-alt"></i> Event Management</div>
                <button class="btn-add" onclick="toggleEventForm()"><i class="fas fa-plus"></i> Create New Event</button>
                
                <!-- Event Form -->
                <div id="eventForm" style="display:none; margin-top:20px; padding:20px; background:#f8f9fa; border-radius:12px;">
                    <h4><i class="fas fa-calendar-plus"></i> Create New Event</h4>
                    <form id="createEventForm" onsubmit="return false;">
                        <div class="form-row">
                            <div class="form-group">
                                <label>Event Title *</label>
                                <input type="text" id="eventTitle" name="title" class="form-control" style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px;">
                            </div>
                            <div class="form-group">
                                <label>Category *</label>
                                <select id="eventCategory" name="category" class="form-control" style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px;">
                                    <option value="Workshop">Workshop</option>
                                    <option value="Seminar">Seminar</option>
                                    <option value="Training">Training</option>
                                    <option value="Webinar">Webinar</option>
                                    <option value="Conference">Conference</option>
                                    <option value="Competition">Competition</option>
                                    <option value="Cultural">Cultural</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label>Event Description *</label>
                            <textarea id="eventDesc" name="description" rows="3" placeholder="Describe the event details..." class="form-control" style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px;"></textarea>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label>Event Date *</label>
                                <input type="date" id="eventDate" name="eventDate" class="form-control" style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px;">
                            </div>
                            <div class="form-group">
                                <label>Event Time</label>
                                <input type="time" id="eventTime" name="eventTime" class="form-control" style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px;">
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label>Location</label>
                                <input type="text" id="eventLocation" name="location" placeholder="Venue / Online link" class="form-control" style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px;">
                            </div>
                            <div class="form-group">
                                <label>Max Participants</label>
                                <input type="number" id="maxParticipants" name="maxParticipants" placeholder="Optional" class="form-control" style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px;">
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label>Registration Deadline</label>
                                <input type="date" id="registrationDeadline" name="registrationDeadline" class="form-control" style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px;">
                            </div>
                            <div class="form-group" style="display: flex; align-items: center; gap: 15px;">
                                <label style="display: flex; align-items: center; gap: 5px; cursor: pointer;">
                                    <input type="checkbox" id="isFeatured" name="isFeatured" value="true"> 
                                    <span>⭐ Mark as Featured Event</span>
                                </label>
                            </div>
                        </div>
                        
                        <div class="modal-buttons" style="margin-top: 20px;">
                            <button type="button" class="btn-add" onclick="createNewEvent()">Create Event</button>
                            <button type="button" class="btn-reject" onclick="$('#eventForm').slideUp();">Cancel</button>
                        </div>
                    </form>
                </div>
                
                <!-- Events List Table -->
                <div style="margin-top: 30px;">
                    <h4>All Events 
                        <a href="${pageContext.request.contextPath}/events" target="_blank" style="font-size: 0.8rem; margin-left: 10px;">
                            <i class="fas fa-external-link-alt"></i> View Public Events Page
                        </a>
                    </h4>
                    <div style="overflow-x: auto;">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Title</th>
                                    <th>Category</th>
                                    <th>Event Date</th>
                                    <th>Location</th>
                                    <th>Featured</th>
                                    <th>Status</th>
                                    <th>Created By</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody id="eventsTableBody">
                                <tr><td colspan="9" style="text-align:center;">Loading events... <i class="fas fa-spinner fa-spin"></i><\/td><\/tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modals -->
<div id="facultyRejectModal" class="modal">
    <div class="modal-content"><h3>Reject Faculty Request</h3><p id="rejectFacultyName"></p><textarea id="facultyRejectReason" rows="3" placeholder="Enter reason for rejection (optional)"></textarea><input type="hidden" id="rejectFacultyId"><div class="modal-buttons"><button class="btn-reject" onclick="confirmFacultyReject()">Confirm Reject</button><button class="btn-approve" onclick="closeFacultyModal()" style="background:#6c757d;">Cancel</button></div></div>
</div>

<div id="studentRejectModal" class="modal">
    <div class="modal-content"><h3>Reject Student Request</h3><p id="rejectStudentName"></p><textarea id="studentRejectReason" rows="3" placeholder="Enter reason for rejection (optional)"></textarea><input type="hidden" id="rejectStudentId"><div class="modal-buttons"><button class="btn-reject" onclick="confirmStudentReject()">Confirm Reject</button><button class="btn-approve" onclick="closeStudentModal()" style="background:#6c757d;">Cancel</button></div></div>
</div>

<div id="feedbackReplyModal" class="modal">
    <div class="modal-content"><h3>Reply to Feedback</h3><p id="replyFeedbackName"></p><textarea id="replyMessage" rows="4" placeholder="Enter your reply message..."></textarea><input type="hidden" id="replyFeedbackId"><div class="modal-buttons"><button class="btn-reply-feedback" onclick="submitFeedbackReply()">Send Reply</button><button class="btn-approve" onclick="closeFeedbackReplyModal()" style="background:#6c757d;">Cancel</button></div></div>
</div>

<div id="viewFeedbackModal" class="modal">
    <div class="modal-content"><h3>Feedback Details</h3><div id="viewFeedbackContent"></div><button class="btn-approve" onclick="closeViewFeedbackModal()" style="margin-top:15px;">Close</button></div>
</div>

<!-- Edit Event Modal -->
<div id="editEventModal" class="modal">
    <div class="modal-content">
        <h3><i class="fas fa-edit"></i> Edit Event</h3>
        <input type="hidden" id="editEventId">
        <div class="form-group">
            <label>Event Title *</label>
            <input type="text" id="editEventTitle" placeholder="Enter event title" class="form-control" style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px;">
        </div>
        <div class="form-group">
            <label>Category *</label>
            <select id="editEventCategory" class="form-control" style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px;">
                <option value="Workshop">Workshop</option>
                <option value="Seminar">Seminar</option>
                <option value="Training">Training</option>
                <option value="Webinar">Webinar</option>
                <option value="Conference">Conference</option>
                <option value="Competition">Competition</option>
                <option value="Cultural">Cultural</option>
            </select>
        </div>
        <div class="form-group">
            <label>Event Description *</label>
            <textarea id="editEventDesc" rows="3" placeholder="Describe the event details..." class="form-control" style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px;"></textarea>
        </div>
        <div class="form-row">
            <div class="form-group">
                <label>Event Date *</label>
                <input type="date" id="editEventDate" class="form-control" style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px;">
            </div>
            <div class="form-group">
                <label>Event Time</label>
                <input type="time" id="editEventTime" class="form-control" style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px;">
            </div>
        </div>
        <div class="form-row">
            <div class="form-group">
                <label>Location</label>
                <input type="text" id="editEventLocation" placeholder="Venue / Online link" class="form-control" style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px;">
            </div>
            <div class="form-group">
                <label>Max Participants</label>
                <input type="number" id="editMaxParticipants" placeholder="Optional" class="form-control" style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px;">
            </div>
        </div>
        <div class="form-row">
            <div class="form-group">
                <label>Registration Deadline</label>
                <input type="date" id="editRegistrationDeadline" class="form-control" style="width:100%; padding:10px; border:1px solid #ddd; border-radius:8px;">
            </div>
            <div class="form-group" style="display: flex; align-items: center; gap: 15px;">
                <label style="display: flex; align-items: center; gap: 5px; cursor: pointer;">
                    <input type="checkbox" id="editIsFeatured"> 
                    <span>⭐ Mark as Featured Event</span>
                </label>
            </div>
        </div>
        <div class="modal-buttons">
            <button class="btn-approve" onclick="updateEvent()">Update Event</button>
            <button class="btn-reject" onclick="closeEditModal()">Cancel</button>
        </div>
    </div>
</div>

<script>
    const contextPath = '${pageContext.request.contextPath}';
    let currentRejectFacultyId = null;
    let currentRejectStudentId = null;

    function updateDateTime() {
        const now = new Date();
        document.getElementById('currentDate').innerHTML = '<i class="far fa-calendar-alt"></i> ' + now.toLocaleDateString('en-IN', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
        document.getElementById('currentTime').innerHTML = '<i class="far fa-clock"></i> ' + now.toLocaleTimeString('en-IN', { hour: '2-digit', minute: '2-digit', second: '2-digit' });
    }
    updateDateTime();
    setInterval(updateDateTime, 1000);

    // Sidebar Navigation
    const menuItems = document.querySelectorAll('.menu-item');
    const sections = document.querySelectorAll('.content-section');
    menuItems.forEach(item => {
        item.addEventListener('click', function() {
            const sectionId = this.getAttribute('data-section');
            menuItems.forEach(i => i.classList.remove('active'));
            this.classList.add('active');
            sections.forEach(section => section.classList.remove('active-section'));
            document.getElementById(sectionId + '-section').classList.add('active-section');
            if (sectionId === 'feedback') { loadAllFeedbacks(); loadFeedbackStats(); }
            if (sectionId === 'notice') { loadNotices(); }
            if (sectionId === 'event') { loadEvents(); }
        });
    });

    function showToast(message, type) {
        const toast = $('<div class="toast-message">' + message + '</div>');
        if (type === 'error') toast.css('background', '#dc3545');
        else if (type === 'success') toast.css('background', '#28a745');
        else toast.css('background', '#17a2b8');
        $('body').append(toast);
        setTimeout(() => toast.fadeOut(300, () => toast.remove()), 3000);
    }

    // ========== FEEDBACK FUNCTIONS ==========
    function showFeedbackTab(tab) {
        document.querySelectorAll('.feedback-tab-content').forEach(t => t.classList.remove('active'));
        document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
        if (tab === 'all') {
            document.getElementById('all-feedback-tab').classList.add('active');
            document.querySelector('.tabs .tab:first-child').classList.add('active');
            loadAllFeedbacks();
        } else {
            document.getElementById('unread-feedback-tab').classList.add('active');
            document.querySelector('.tabs .tab:last-child').classList.add('active');
            loadUnreadFeedbacks();
        }
    }

    function loadFeedbackStats() {
        $.ajax({ url: contextPath + '/admin/feedback/stats', type: 'GET', success: function(data) {
            if (data.success) {
                $('#totalFeedbacks').text(data.total); $('#unreadFeedbacks').text(data.unread); 
                $('#avgRating').text(data.avgRating); $('#unreadCountBadge').text(data.unread);
            }
        }, error: function() { console.log('Error loading stats'); } });
    }

    function loadAllFeedbacks() {
        $.ajax({ url: contextPath + '/admin/feedback/all', type: 'GET', success: function(response) {
            if (response.success) {
                let html = ''; let stars = '';
                response.feedbacks.forEach(f => {
                    stars = '★'.repeat(f.rating) + '☆'.repeat(5-f.rating);
                    let dateStr = new Date(f.createdAt).toLocaleDateString();
                    html += '<tr id="feedback-row-' + f.id + '">' +
                        '<td>' + dateStr + '</td>' +
                        '<td>' + f.name + '</td>' +
                        '<td>' + f.email + '</td>' +
                        '<td><span class="stars">' + stars + '</span> (' + f.rating + ')</td>' +
                        '<td>' + (f.message.length > 50 ? f.message.substring(0,50)+'...' : f.message) + '</td>' +
                        '<td><span class="' + (f.read ? 'status-read' : 'status-unread') + '">' + (f.read ? 'Read' : 'Unread') + '</span></td>' +
                        '<td><button class="btn-view" onclick="viewFeedback(' + f.id + ', \'' + f.name.replace(/'/g, "\\'") + '\', \'' + f.email + '\', ' + f.rating + ', \'' + f.message.replace(/'/g, "\\'") + '\', \'' + f.createdAt + '\')">View</button>' +
                        '<button class="btn-reply-feedback" onclick="showReplyModal(' + f.id + ', \'' + f.name.replace(/'/g, "\\'") + '\')">Reply</button>' +
                        '<button class="btn-delete-feedback" onclick="deleteFeedback(' + f.id + ')">Delete</button></td>' +
                        '</tr>';
                });
                $('#allFeedbackBody').html(html);
                if (response.feedbacks.length === 0) $('#allFeedbackBody').html('<tr><td colspan="7" style="text-align:center;">No feedback found</td></tr>');
            }
        }, error: function() { showToast('Error loading feedbacks!', 'error'); } });
    }

    function loadUnreadFeedbacks() {
        $.ajax({ url: contextPath + '/admin/feedback/unread', type: 'GET', success: function(response) {
            if (response.success) {
                let html = ''; let stars = '';
                response.feedbacks.forEach(f => {
                    stars = '★'.repeat(f.rating) + '☆'.repeat(5-f.rating);
                    let dateStr = new Date(f.createdAt).toLocaleDateString();
                    html += '<tr id="unread-row-' + f.id + '">' +
                        '<td>' + dateStr + '</td>' +
                        '<td>' + f.name + '</td>' +
                        '<td>' + f.email + '</td>' +
                        '<td><span class="stars">' + stars + '</span></td>' +
                        '<td>' + (f.message.length > 50 ? f.message.substring(0,50)+'...' : f.message) + '</td>' +
                        '<td><button class="btn-view" onclick="viewFeedback(' + f.id + ', \'' + f.name.replace(/'/g, "\\'") + '\', \'' + f.email + '\', ' + f.rating + ', \'' + f.message.replace(/'/g, "\\'") + '\', \'' + f.createdAt + '\')">View</button>' +
                        '<button class="btn-reply-feedback" onclick="showReplyModal(' + f.id + ', \'' + f.name.replace(/'/g, "\\'") + '\')">Reply</button>' +
                        '<button class="btn-delete-feedback" onclick="deleteFeedback(' + f.id + ')">Delete</button></td>' +
                        '</tr>';
                });
                $('#unreadFeedbackBody').html(html);
                if (response.feedbacks.length === 0) $('#unreadFeedbackBody').html('<tr><td colspan="6" style="text-align:center;">No unread feedback</td></tr>');
            }
        }, error: function() { showToast('Error loading unread feedbacks!', 'error'); } });
    }

    function viewFeedback(id, name, email, rating, message, date) {
        let stars = '★'.repeat(rating) + '☆'.repeat(5-rating);
        $('#viewFeedbackContent').html('<p><strong>Name:</strong> ' + name + '</p><p><strong>Email:</strong> ' + email + '</p><p><strong>Rating:</strong> <span class="stars">' + stars + '</span> (' + rating + ')</p><p><strong>Date:</strong> ' + new Date(date).toLocaleString() + '</p><p><strong>Message:</strong> ' + message + '</p>');
        $('#viewFeedbackModal').css('display', 'flex');
        $.ajax({ url: contextPath + '/admin/feedback/mark-read', type: 'POST', data: { feedbackId: id }, success: function() { loadAllFeedbacks(); loadFeedbackStats(); } });
    }

    function showReplyModal(id, name) {
        $('#replyFeedbackId').val(id); 
        $('#replyFeedbackName').html('<strong>' + name + '</strong>'); 
        $('#replyMessage').val(''); 
        $('#feedbackReplyModal').css('display', 'flex');
    }

    function submitFeedbackReply() {
        const id = $('#replyFeedbackId').val(); 
        const message = $('#replyMessage').val();
        if (!message) { showToast('Please enter a reply message!', 'error'); return; }
        $.ajax({ url: contextPath + '/admin/feedback/reply', type: 'POST', data: { feedbackId: id, replyMessage: message }, success: function(response) {
            if (response.success) { showToast(response.message, 'success'); closeFeedbackReplyModal(); loadAllFeedbacks(); loadFeedbackStats(); }
            else showToast(response.message, 'error');
        }, error: function() { showToast('Error sending reply!', 'error'); } });
    }

    function deleteFeedback(id) {
        if (!confirm('Are you sure you want to delete this feedback?')) return;
        $.ajax({ url: contextPath + '/admin/feedback/delete', type: 'POST', data: { feedbackId: id }, success: function(response) {
            if (response.success) { showToast(response.message, 'success'); $('#feedback-row-' + id).remove(); loadFeedbackStats(); }
            else showToast(response.message, 'error');
        }, error: function() { showToast('Error deleting feedback!', 'error'); } });
    }

    function closeFeedbackReplyModal() { $('#feedbackReplyModal').css('display', 'none'); }
    function closeViewFeedbackModal() { $('#viewFeedbackModal').css('display', 'none'); }

    // Faculty Functions
    function approveFaculty(facultyId) {
        if (!confirm('Approve this faculty?')) return;
        const row = $('#faculty-row-' + facultyId);
        const btn = row.find('.btn-approve');
        const orig = btn.html();
        btn.html('<i class="fas fa-spinner fa-spin"></i>'); btn.prop('disabled',true);
        $.ajax({ url: contextPath + '/admin/approve-faculty', type: 'POST', data: { facultyId: facultyId }, success: function(r) { 
            if(r.success){ showToast(r.message,'success'); row.fadeOut(); } 
            else { showToast(r.message,'error'); btn.html(orig); btn.prop('disabled',false); } 
        }, error: function() { showToast('Error!','error'); btn.html(orig); btn.prop('disabled',false); } });
    }

    function showFacultyRejectModal(id, name) { 
        currentRejectFacultyId = id; 
        $('#rejectFacultyId').val(id); 
        $('#rejectFacultyName').html('Faculty: <strong>' + name + '</strong>'); 
        $('#facultyRejectReason').val(''); 
        $('#facultyRejectModal').css('display','flex'); 
    }

    function confirmFacultyReject() { 
        const id = currentRejectFacultyId; 
        const reason = $('#facultyRejectReason').val(); 
        const row = $('#faculty-row-' + id); 
        const btn = row.find('.btn-reject'); 
        const orig = btn.html(); 
        btn.html('<i class="fas fa-spinner fa-spin"></i>'); btn.prop('disabled',true);
        $.ajax({ url: contextPath + '/admin/reject-faculty', type: 'POST', data: { facultyId: id, reason: reason }, success: function(r) { 
            if(r.success){ showToast(r.message,'error'); row.fadeOut(); closeFacultyModal(); } 
            else { showToast(r.message,'error'); btn.html(orig); btn.prop('disabled',false); } 
        }, error: function() { showToast('Error!','error'); btn.html(orig); btn.prop('disabled',false); } });
    }

    function closeFacultyModal() { $('#facultyRejectModal').css('display','none'); currentRejectFacultyId = null; }

    // Student Functions
    function approveStudent(studentId) {
        if (!confirm('Approve this student?')) return;
        const row = $('#student-row-' + studentId);
        const btn = row.find('.btn-approve');
        const orig = btn.html();
        btn.html('<i class="fas fa-spinner fa-spin"></i>'); btn.prop('disabled',true);
        $.ajax({ url: contextPath + '/admin/approve-student', type: 'POST', data: { studentId: studentId }, success: function(r) { 
            if(r.success){ showToast(r.message,'success'); row.fadeOut(); } 
            else { showToast(r.message,'error'); btn.html(orig); btn.prop('disabled',false); } 
        }, error: function() { showToast('Error!','error'); btn.html(orig); btn.prop('disabled',false); } });
    }

    function showStudentRejectModal(id, name) { 
        currentRejectStudentId = id; 
        $('#rejectStudentId').val(id); 
        $('#rejectStudentName').html('Student: <strong>' + name + '</strong>'); 
        $('#studentRejectReason').val(''); 
        $('#studentRejectModal').css('display','flex'); 
    }

    function confirmStudentReject() { 
        const id = currentRejectStudentId; 
        const reason = $('#studentRejectReason').val(); 
        const row = $('#student-row-' + id); 
        const btn = row.find('.btn-reject'); 
        const orig = btn.html(); 
        btn.html('<i class="fas fa-spinner fa-spin"></i>'); btn.prop('disabled',true);
        $.ajax({ url: contextPath + '/admin/reject-student', type: 'POST', data: { studentId: id, reason: reason }, success: function(r) { 
            if(r.success){ showToast(r.message,'error'); row.fadeOut(); closeStudentModal(); } 
            else { showToast(r.message,'error'); btn.html(orig); btn.prop('disabled',false); } 
        }, error: function() { showToast('Error!','error'); btn.html(orig); btn.prop('disabled',false); } });
    }

    function closeStudentModal() { $('#studentRejectModal').css('display','none'); currentRejectStudentId = null; }

    // Attendance Function
    function loadAttendance() {
        const batch = $('#batchSelect').val();
        const data = { 'Java':[{name:'Alice Brown',p:85},{name:'Bob Wilson',p:92},{name:'Charlie Davis',p:78}], 'Python':[{name:'David Miller',p:88},{name:'Emma Watson',p:95}], 'MERN':[{name:'Frank Ocean',p:82},{name:'Grace Lee',p:90}], 'Cloud':[{name:'Henry Ford',p:75},{name:'Ivy Chen',p:89}] };
        const students = data[batch] || []; 
        const tbody = $('#attendanceList'); 
        tbody.empty();
        students.forEach(s => { tbody.append('<tr><td>' + s.name + '</td><td>' + s.p + '%</td><td><div class="progress-bar"><div class="progress-fill" style="width:' + s.p + '%"></div></div></td></tr>'); });
    }
    loadAttendance();

    // Courses Functions
    const courses = [{ title:'Full Stack Java', desc:'Learn Java, Spring Boot, React', duration:'6 months', fees:'₹45,000' }, { title:'Python Development', desc:'Python, Django, Flask', duration:'5 months', fees:'₹40,000' }, { title:'MERN Stack', desc:'MongoDB, Express, React, Node', duration:'5 months', fees:'₹40,000' }];
    function displayCourses() { 
        const c = $('#coursesList'); 
        if(!c.length) return; 
        c.empty(); 
        courses.forEach(crs => { c.append('<div class="course-card"><div class="course-info"><h4>' + crs.title + '</h4><p>' + crs.desc + '</p><p><strong>Duration:</strong> ' + crs.duration + '</p><p><strong>Fees:</strong> ' + crs.fees + '</p><button class="btn-approve" onclick="downloadBrochure(\'' + crs.title + '\')">Download Brochure</button></div></div>'); }); 
    }
    displayCourses();
    function addCourse() { showToast('Add new course form will open.', 'info'); }
    function downloadBrochure(cn) { showToast('Downloading brochure for ' + cn, 'info'); }
    function showReceiptForm() { const f = $('#receiptForm'); if(f.length) f.toggle(); }
    function generateReceipt() { showToast('PDF Receipt Generated!', 'success'); }
    function showPlacementForm() { const f = $('#placementForm'); if(f.length) f.toggle(); }
    function addPlacement() { showToast('New placement added!', 'success'); }
    
    // ========== NOTICE FUNCTIONS ==========
    function showNoticeForm() { 
        const form = $('#noticeForm'); 
        if(form.length) form.toggle(); 
        if(form.is(':visible')) loadNotices();
    }

    function publishNotice() {
        const title = $('#noticeTitle').val();
        const content = $('#noticeContent').val();
        const category = $('#noticeCategory').val();
        const isUrgent = $('#noticeUrgent').is(':checked');
        const expiryDate = $('#noticeExpiryDate').val();
        
        if(!title || !content) {
            showToast('Please enter title and content!', 'error');
            return;
        }
        
        $.ajax({
            url: contextPath + '/admin/notice/publish',
            type: 'POST',
            data: { 
                title: title, 
                content: content, 
                category: category, 
                isUrgent: isUrgent, 
                expiryDate: expiryDate 
            },
            success: function(response) {
                if(response.success) {
                    showToast(response.message, 'success');
                    $('#noticeTitle').val('');
                    $('#noticeContent').val('');
                    $('#noticeCategory').val('General');
                    $('#noticeUrgent').prop('checked', false);
                    $('#noticeExpiryDate').val('');
                    loadNotices();
                } else {
                    showToast(response.message, 'error');
                }
            },
            error: function() { showToast('Error publishing notice!', 'error'); }
        });
    }

    function loadNotices() {
        $.ajax({
            url: contextPath + '/admin/notices',
            type: 'GET',
            success: function(response) {
                if(response.success && response.notices) {
                    let html = '';
                    response.notices.forEach(function(notice) {
                        const status = notice.isActive ? 'Active' : 'Inactive';
                        const statusClass = notice.isActive ? 'status-active' : 'status-inactive';
                        const urgentBadge = notice.isUrgent ? '<span class="urgent-badge">URGENT</span>' : '';
                        html += '<tr id="notice-row-' + notice.id + '">' +
                            '<td>' + notice.id + '</td>' +
                            '<td>' + notice.title + ' ' + urgentBadge + '</td>' +
                            '<td>' + notice.category + '</td>' +
                            '<td>' + new Date(notice.createdAt).toLocaleDateString() + '</td>' +
                            '<td><span class="' + statusClass + '">' + status + '</span></td>' +
                            '<td>' + notice.createdByName + '</td>' +
                            '<td><button class="btn-delete-feedback" onclick="deleteNotice(' + notice.id + ')">Delete</button></td>' +
                            '</tr>';
                    });
                    $('#noticesTableBody').html(html);
                    if(response.notices.length === 0) {
                        $('#noticesTableBody').html('<tr><td colspan="7" style="text-align:center;">No notices found</td></tr>');
                    }
                } else {
                    $('#noticesTableBody').html('<tr><td colspan="7" style="text-align:center;">No notices found</td></tr>');
                }
            },
            error: function() { 
                showToast('Error loading notices!', 'error');
                $('#noticesTableBody').html('<tr><td colspan="7" style="text-align:center;">Error loading notices</td></tr>');
            }
        });
    }

    function deleteNotice(noticeId) {
        if(!confirm('Are you sure you want to delete this notice?')) return;
        
        $.ajax({
            url: contextPath + '/admin/notice/delete',
            type: 'POST',
            data: { noticeId: noticeId },
            success: function(response) {
                if(response.success) {
                    showToast(response.message, 'success');
                    $('#notice-row-' + noticeId).remove();
                    loadNotices();
                } else {
                    showToast(response.message, 'error');
                }
            },
            error: function() { showToast('Error deleting notice!', 'error'); }
        });
    }

    // ========== EVENT FUNCTIONS - CORRECTED ==========
    function toggleEventForm() { 
        const form = $('#eventForm'); 
        if(form.length) form.slideToggle(); 
    }

    function createNewEvent() {
        console.log("Create Event button clicked");
        
        const title = $('#eventTitle').val().trim();
        const description = $('#eventDesc').val().trim();
        const eventDate = $('#eventDate').val();
        const eventTime = $('#eventTime').val();
        const location = $('#eventLocation').val().trim();
        const category = $('#eventCategory').val();
        const isFeatured = $('#isFeatured').is(':checked');
        const maxParticipants = $('#maxParticipants').val();
        const registrationDeadline = $('#registrationDeadline').val();
        
        if(!title) {
            showToast('Please enter event title!', 'error');
            return;
        }
        if(!description) {
            showToast('Please enter event description!', 'error');
            return;
        }
        if(!eventDate) {
            showToast('Please select event date!', 'error');
            return;
        }
        
        const createBtn = $('.btn-add:contains("Create Event")').first();
        const originalText = createBtn.html();
        createBtn.html('<i class="fas fa-spinner fa-spin"></i> Creating...').prop('disabled', true);
        
        $.ajax({
            url: contextPath + '/admin/event/create',
            type: 'POST',
            data: {
                title: title,
                description: description,
                eventDate: eventDate,
                eventTime: eventTime,
                location: location,
                category: category,
                isFeatured: isFeatured,
                maxParticipants: maxParticipants,
                registrationDeadline: registrationDeadline
            },
            success: function(response) {
                console.log("Response:", response);
                if(response.success) {
                    showToast(response.message, 'success');
                    $('#eventTitle').val('');
                    $('#eventDesc').val('');
                    $('#eventDate').val('');
                    $('#eventTime').val('');
                    $('#eventLocation').val('');
                    $('#maxParticipants').val('');
                    $('#registrationDeadline').val('');
                    $('#isFeatured').prop('checked', false);
                    $('#eventCategory').val('Workshop');
                    $('#eventForm').slideUp();
                    loadEvents();
                } else {
                    showToast(response.message || 'Error creating event!', 'error');
                }
                createBtn.html(originalText).prop('disabled', false);
            },
            error: function(xhr) {
                console.error("Error:", xhr);
                let errorMsg = 'Error creating event!';
                if(xhr.responseJSON && xhr.responseJSON.message) {
                    errorMsg = xhr.responseJSON.message;
                }
                showToast(errorMsg, 'error');
                createBtn.html(originalText).prop('disabled', false);
            }
        });
    }

    function loadEvents() {
        $.ajax({
            url: contextPath + '/admin/events',
            type: 'GET',
            success: function(response) {
                console.log("Events response:", response);
                if(response.success && response.events) {
                    let html = '';
                    response.events.forEach(function(event) {
                        const statusClass = event.isActive ? 'status-active' : 'status-inactive';
                        const statusText = event.isActive ? 'Active' : 'Inactive';
                        const featuredStar = event.isFeatured ? '<span style="color: #ffc107;">★</span>' : '☆';
                        const featuredBadge = event.isFeatured ? '<span class="featured-badge">Featured</span>' : '';
                        
                        html += '<tr id="event-row-' + event.id + '">' +
                            '<td>' + event.id + '</td>' +
                            '<td>' + event.title + ' ' + featuredBadge + '</td>' +
                            '<td>' + (event.category || 'General') + '</td>' +
                            '<td>' + (event.formattedEventDate || event.eventDate) + '</td>' +
                            '<td>' + (event.location || 'Online') + '</td>' +
                            '<td style="text-align: center;">' + featuredStar + '</td>' +
                            '<td><span class="' + statusClass + '">' + statusText + '</span></td>' +
                            '<td>' + (event.createdByName || 'Admin') + '</td>' +
                            '<td>' +
                            '<button class="btn-edit" onclick="editEvent(' + event.id + ')"><i class="fas fa-edit"></i> Edit</button> ' +
                            '<button class="btn-approve" onclick="toggleEventStatus(' + event.id + ')"><i class="fas fa-toggle-on"></i> Toggle</button> ' +
                            '<button class="btn-delete-feedback" onclick="deleteEvent(' + event.id + ')"><i class="fas fa-trash"></i> Delete</button>' +
                            '</td>' +
                            '</tr>';
                    });
                    $('#eventsTableBody').html(html);
                    if(response.events.length === 0) {
                        $('#eventsTableBody').html('<tr><td colspan="9" style="text-align:center;">No events found</td></tr>');
                    }
                } else {
                    $('#eventsTableBody').html('<tr><td colspan="9" style="text-align:center;">No events found</td></tr>');
                }
            },
            error: function(xhr) { 
                console.error("Error loading events:", xhr);
                showToast('Error loading events!', 'error');
                $('#eventsTableBody').html('<tr><td colspan="9" style="text-align:center;">Error loading events</td></tr>');
            }
        });
    }

    function editEvent(eventId) {
        $.ajax({
            url: contextPath + '/admin/event/get/' + eventId,
            type: 'GET',
            success: function(response) {
                if(response.success && response.event) {
                    const event = response.event;
                    $('#editEventId').val(event.id);
                    $('#editEventTitle').val(event.title);
                    $('#editEventDesc').val(event.description);
                    $('#editEventCategory').val(event.category);
                    $('#editEventDate').val(event.eventDate);
                    $('#editEventTime').val(event.eventTime);
                    $('#editEventLocation').val(event.location);
                    $('#editMaxParticipants').val(event.maxParticipants);
                    $('#editRegistrationDeadline').val(event.registrationDeadline);
                    $('#editIsFeatured').prop('checked', event.isFeatured);
                    $('#editEventModal').css('display', 'flex');
                } else {
                    showToast('Error loading event details!', 'error');
                }
            },
            error: function() { showToast('Error loading event details!', 'error'); }
        });
    }

    function updateEvent() {
        const eventData = {
            id: $('#editEventId').val(),
            title: $('#editEventTitle').val(),
            description: $('#editEventDesc').val(),
            eventDate: $('#editEventDate').val(),
            eventTime: $('#editEventTime').val(),
            location: $('#editEventLocation').val(),
            category: $('#editEventCategory').val(),
            isFeatured: $('#editIsFeatured').is(':checked'),
            maxParticipants: $('#editMaxParticipants').val(),
            registrationDeadline: $('#editRegistrationDeadline').val()
        };
        
        if(!eventData.title || !eventData.description || !eventData.eventDate) {
            showToast('Please fill required fields!', 'error');
            return;
        }
        
        const updateBtn = $('.modal-buttons .btn-approve').first();
        const originalText = updateBtn.html();
        updateBtn.html('<i class="fas fa-spinner fa-spin"></i> Updating...').prop('disabled', true);
        
        $.ajax({
            url: contextPath + '/admin/event/update',
            type: 'POST',
            data: eventData,
            success: function(response) {
                if(response.success) {
                    showToast(response.message, 'success');
                    closeEditModal();
                    loadEvents();
                } else {
                    showToast(response.message || 'Error updating event!', 'error');
                }
                updateBtn.html(originalText).prop('disabled', false);
            },
            error: function() { 
                showToast('Error updating event!', 'error');
                updateBtn.html(originalText).prop('disabled', false);
            }
        });
    }

    function toggleEventStatus(eventId) {
        $.ajax({
            url: contextPath + '/admin/event/toggle-status',
            type: 'POST',
            data: { id: eventId },
            success: function(response) {
                if(response.success) {
                    showToast(response.message, 'success');
                    loadEvents();
                } else {
                    showToast(response.message || 'Error updating status!', 'error');
                }
            },
            error: function() { showToast('Error updating status!', 'error'); }
        });
    }

    function deleteEvent(eventId) {
        if(!confirm('Are you sure you want to delete this event?')) return;
        
        $.ajax({
            url: contextPath + '/admin/event/delete',
            type: 'POST',
            data: { id: eventId },
            success: function(response) {
                if(response.success) {
                    showToast(response.message, 'success');
                    loadEvents();
                } else {
                    showToast(response.message || 'Error deleting event!', 'error');
                }
            },
            error: function() { showToast('Error deleting event!', 'error'); }
        });
    }

    function closeEditModal() {
        $('#editEventModal').css('display', 'none');
        $('#editEventId').val('');
    }

    // Close modals when clicking outside
    $(window).click(function(e) {
        if ($(e.target).is('#facultyRejectModal')) closeFacultyModal();
        if ($(e.target).is('#studentRejectModal')) closeStudentModal();
        if ($(e.target).is('#feedbackReplyModal')) closeFeedbackReplyModal();
        if ($(e.target).is('#viewFeedbackModal')) closeViewFeedbackModal();
        if ($(e.target).is('#editEventModal')) closeEditModal();
    });
    
    // Load initial data
    loadFeedbackStats();
    loadEvents();
</script>
</body>
</html>
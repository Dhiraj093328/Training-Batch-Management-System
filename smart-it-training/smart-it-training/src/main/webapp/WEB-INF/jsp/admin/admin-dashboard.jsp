<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
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

        /* ========== DASHBOARD CONTAINER ========== */
        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }

        /* ========== SIDEBAR ========== */
        .sidebar {
            width: 280px;
            background: linear-gradient(135deg, #1a1a2e, #16213e);
            color: white;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            transition: all 0.3s ease;
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

        /* ========== MAIN CONTENT ========== */
        .main-content {
            margin-left: 280px;
            flex: 1;
            padding: 20px;
        }

        /* Top Bar */
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
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(255,65,108,0.4);
        }

        /* Stats Cards */
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

        /* Content Sections */
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

        /* Tables */
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
            transition: all 0.3s ease;
        }

        .btn-approve:hover {
            background: #218838;
            transform: scale(1.02);
        }

        .btn-reject {
            background: #dc3545;
            color: white;
            border: none;
            padding: 6px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-reject:hover {
            background: #c82333;
            transform: scale(1.02);
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

        /* Progress Bar */
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

        /* Course Cards */
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

        /* Toast Message */
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

        /* Modal Styles */
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
            width: 400px;
            max-width: 90%;
        }

        .modal-content textarea {
            width: 100%;
            padding: 10px;
            margin: 15px 0;
            border: 1px solid #ddd;
            border-radius: 8px;
            resize: vertical;
        }

        .modal-buttons {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }

        /* Responsive */
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
        }
    </style>
</head>
<body>

<div class="dashboard-container">
    <!-- Sidebar -->
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

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Bar -->
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

        <!-- ========== 1. DASHBOARD SECTION ========== -->
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

        <!-- ========== 2. ADMIN FACULTY DASHBOARD ========== -->
        <div id="faculty-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-chalkboard-user"></i> Faculty Requests</div>
                <c:choose>
                    <c:when test="${not empty pendingFaculty}">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Contact</th>
                                    <th>Batch</th>
                                    <th>Username</th>
                                    <th>Admin Office</th>
                                    <th>Qualification</th>
                                    <th>Action</th>
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
                                            <button class="btn-approve" onclick="approveFaculty(${faculty.id})">
                                                <i class="fas fa-check"></i> Accept
                                            </button>
                                            <button class="btn-reject" onclick="showFacultyRejectModal(${faculty.id}, '${faculty.name}')">
                                                <i class="fas fa-times"></i> Reject
                                            </button>
                                         </td>
                                     </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center; padding: 30px;">
                            <i class="fas fa-check-circle" style="color: #28a745; font-size: 48px;"></i>
                            <p style="margin-top: 10px;">No pending faculty requests</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- ========== 3. ADMIN STUDENT DASHBOARD ========== -->
        <div id="student-section" class="content-section">
            <div class="section-card">
                <div class="section-title">
                    <i class="fas fa-user-graduate"></i> Student Requests 
                    <c:if test="${pendingStudentsCount > 0}">
                        <span style="font-size: 0.8rem; background: #ffc107; color: #856404; padding: 2px 10px; border-radius: 20px; margin-left: 10px;">
                            ${pendingStudentsCount} Pending
                        </span>
                    </c:if>
                </div>
                
                <c:choose>
                    <c:when test="${not empty pendingStudents}">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Contact</th>
                                    <th>Batch</th>
                                    <th>Username</th>
                                    <th>Admin Office</th>
                                    <th>Enrollment No</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody id="studentRequestsList">
                                <c:forEach items="${pendingStudents}" var="student">
                                    <tr id="student-row-${student.id}">
                                        <td>${student.name}</td>
                                        <td>${student.contact}</td>
                                        <td>${student.batchName}</td>
                                        <td>${student.username}</td>
                                        <td>${student.adminOfficeName}</td>
                                        <td>${student.enrollmentNo}</td>
                                        <td>
                                            <button class="btn-approve" onclick="approveStudent(${student.id})">
                                                <i class="fas fa-check"></i> Accept
                                            </button>
                                            <button class="btn-reject" onclick="showStudentRejectModal(${student.id}, '${student.name}')">
                                                <i class="fas fa-times"></i> Reject
                                            </button>
                                         </td>
                                     </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center; padding: 40px;">
                            <i class="fas fa-check-circle" style="color: #28a745; font-size: 48px;"></i>
                            <p style="margin-top: 10px; color: #666;">No pending student requests</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- ========== 4. ADMIN ATTENDANCE DASHBOARD ========== -->
        <div id="attendance-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-calendar-check"></i> Attendance Reports</div>
                <div style="margin-bottom: 20px;">
                    <label>Select Batch: </label>
                    <select id="batchSelect" onchange="loadAttendance()" style="padding: 8px 15px; border-radius: 8px; border: 1px solid #ddd; margin-left: 10px;">
                        <option value="Java">Java Batch</option>
                        <option value="Python">Python Batch</option>
                        <option value="MERN">MERN Batch</option>
                        <option value="Cloud">Cloud Batch</option>
                    </select>
                </div>
                <table class="data-table">
                    <thead><tr><th>Student Name</th><th>Attendance %</th><th>Progress</th></tr></thead>
                    <tbody id="attendanceList"></tbody>
                </table>
            </div>
        </div>

        <!-- ========== 5. ADMIN FEEDBACK DASHBOARD ========== -->
        <div id="feedback-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-star"></i> Student Feedback</div>
                <table class="data-table">
                    <thead><tr><th>Name</th><th>Email</th><th>Rating</th><th>Message</th><th>Date</th></tr></thead>
                    <tbody id="feedbackList"></tbody>
                </table>
            </div>
        </div>

        <!-- ========== 6. ADMIN COURSES DASHBOARD ========== -->
        <div id="courses-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-book"></i> Course Management</div>
                <button class="btn-add" onclick="addCourse()"><i class="fas fa-plus"></i> Add New Course</button>
                <div class="courses-grid" id="coursesList"></div>
            </div>
        </div>

        <!-- ========== 7. ADMIN ACCOUNT DASHBOARD ========== -->
        <div id="account-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-wallet"></i> Fee Receipt Generation</div>
                <button class="btn-add" onclick="showReceiptForm()"><i class="fas fa-file-invoice-dollar"></i> Generate Fee Receipt</button>
                <div id="receiptForm" style="display: none; margin-top: 20px; padding: 20px; background: #f8f9fa; border-radius: 12px;">
                    <h4>Generate Fee Receipt</h4>
                    <input type="text" placeholder="Student Name" id="studentName" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                    <input type="text" placeholder="Contact Number" id="contactNo" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                    <input type="email" placeholder="Email" id="email" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                    <input type="text" placeholder="Course" id="courseName" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                    <input type="number" placeholder="Amount" id="amount" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                    <input type="text" placeholder="Executive Name" id="executiveName" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                    <button type="button" class="btn-add" onclick="generateReceipt()">Generate PDF Receipt</button>
                </div>
            </div>
        </div>

        <!-- ========== 8. ADMIN PLACEMENT DASHBOARD ========== -->
        <div id="placement-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-briefcase"></i> Placement Management</div>
                <button class="btn-add" onclick="showPlacementForm()"><i class="fas fa-plus"></i> Add New Placement</button>
                <div id="placementForm" style="display: none; margin-top: 20px; padding: 20px; background: #f8f9fa; border-radius: 12px;">
                    <h4>Add New Placement Opportunity</h4>
                    <input type="text" placeholder="Company Name" id="companyName" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                    <textarea placeholder="Job Role Description" id="jobRoleDesc" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;" rows="3"></textarea>
                    <textarea placeholder="Required Skills" id="skills" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;" rows="2"></textarea>
                    <textarea placeholder="Interview Round Details" id="interviewDetails" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;" rows="2"></textarea>
                    <input type="date" placeholder="Last Date to Apply" id="lastDate" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                    <button type="button" class="btn-add" onclick="addPlacement()">Add Placement</button>
                </div>
            </div>
        </div>

        <!-- ========== 9. ADMIN NOTICE DASHBOARD ========== -->
        <div id="notice-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-bullhorn"></i> E-Notice Management</div>
                <button class="btn-add" onclick="showNoticeForm()"><i class="fas fa-plus"></i> Publish New Notice</button>
                <div id="noticeForm" style="display: none; margin-top: 20px; padding: 20px; background: #f8f9fa; border-radius: 12px;">
                    <h4>Publish Notice</h4>
                    <input type="text" placeholder="Notice Title" id="noticeTitle" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                    <textarea placeholder="Notice Content" id="noticeContent" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;" rows="4"></textarea>
                    <button type="button" class="btn-add" onclick="publishNotice()">Publish Notice</button>
                </div>
            </div>
        </div>

        <!-- ========== 10. ADMIN EVENT DASHBOARD ========== -->
        <div id="event-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-calendar-alt"></i> Event Management</div>
                <button class="btn-add" onclick="showEventForm()"><i class="fas fa-plus"></i> Create New Event</button>
                <div id="eventForm" style="display: none; margin-top: 20px; padding: 20px; background: #f8f9fa; border-radius: 12px;">
                    <h4>Create Event</h4>
                    <input type="text" placeholder="Event Title" id="eventTitle" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                    <textarea placeholder="Event Description" id="eventDesc" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;" rows="3"></textarea>
                    <input type="date" placeholder="Event Date" id="eventDate" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                    <input type="time" placeholder="Event Time" id="eventTime" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                    <input type="text" placeholder="Location" id="eventLocation" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                    <button type="button" class="btn-add" onclick="createEvent()">Create Event</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Faculty Reject Modal -->
<div id="facultyRejectModal" class="modal">
    <div class="modal-content">
        <h3>Reject Faculty Request</h3>
        <p id="rejectFacultyName"></p>
        <textarea id="facultyRejectReason" rows="3" placeholder="Enter reason for rejection (optional)"></textarea>
        <input type="hidden" id="rejectFacultyId">
        <div class="modal-buttons">
            <button class="btn-reject" onclick="confirmFacultyReject()">Confirm Reject</button>
            <button class="btn-approve" onclick="closeFacultyModal()" style="background: #6c757d;">Cancel</button>
        </div>
    </div>
</div>

<!-- Student Reject Modal -->
<div id="studentRejectModal" class="modal">
    <div class="modal-content">
        <h3>Reject Student Request</h3>
        <p id="rejectStudentName"></p>
        <textarea id="studentRejectReason" rows="3" placeholder="Enter reason for rejection (optional)"></textarea>
        <input type="hidden" id="rejectStudentId">
        <div class="modal-buttons">
            <button class="btn-reject" onclick="confirmStudentReject()">Confirm Reject</button>
            <button class="btn-approve" onclick="closeStudentModal()" style="background: #6c757d;">Cancel</button>
        </div>
    </div>
</div>

<script>
    let currentRejectFacultyId = null;
    let currentRejectStudentId = null;

    // ========== DATE & TIME ==========
    function updateDateTime() {
        const now = new Date();
        document.getElementById('currentDate').innerHTML = '<i class="far fa-calendar-alt"></i> ' + now.toLocaleDateString('en-IN', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
        document.getElementById('currentTime').innerHTML = '<i class="far fa-clock"></i> ' + now.toLocaleTimeString('en-IN', { hour: '2-digit', minute: '2-digit', second: '2-digit' });
    }
    updateDateTime();
    setInterval(updateDateTime, 1000);

    // ========== SIDEBAR NAVIGATION ==========
    const menuItems = document.querySelectorAll('.menu-item');
    const sections = document.querySelectorAll('.content-section');

    menuItems.forEach(item => {
        item.addEventListener('click', function() {
            const sectionId = this.getAttribute('data-section');
            menuItems.forEach(i => i.classList.remove('active'));
            this.classList.add('active');
            sections.forEach(section => section.classList.remove('active-section'));
            document.getElementById(sectionId + '-section').classList.add('active-section');
        });
    });

    // ========== SHOW TOAST MESSAGE ==========
    function showToast(message, type) {
        const toast = $('<div class="toast-message">' + message + '</div>');
        if (type === 'error') toast.css('background', '#dc3545');
        else if (type === 'success') toast.css('background', '#28a745');
        else toast.css('background', '#17a2b8');
        $('body').append(toast);
        setTimeout(() => toast.fadeOut(300, () => toast.remove()), 3000);
    }

    // ========== FACULTY APPROVAL FUNCTIONS ==========
    function approveFaculty(facultyId) {
        if (!confirm('Are you sure you want to APPROVE this faculty member? They will receive an email with login credentials.')) {
            return;
        }
        
        const row = $('#faculty-row-' + facultyId);
        const approveBtn = row.find('.btn-approve');
        const originalText = approveBtn.html();
        
        approveBtn.html('<i class="fas fa-spinner fa-spin"></i> Processing...');
        approveBtn.prop('disabled', true);
        
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/approve-faculty',
            type: 'POST',
            data: { facultyId: facultyId },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    showToast('✅ ' + response.message, 'success');
                    row.fadeOut(300, function() { $(this).remove(); });
                } else {
                    showToast('❌ ' + response.message, 'error');
                    approveBtn.html(originalText);
                    approveBtn.prop('disabled', false);
                }
            },
            error: function() {
                showToast('❌ Error approving faculty!', 'error');
                approveBtn.html(originalText);
                approveBtn.prop('disabled', false);
            }
        });
    }

    function showFacultyRejectModal(facultyId, facultyName) {
        currentRejectFacultyId = facultyId;
        document.getElementById('rejectFacultyId').value = facultyId;
        document.getElementById('rejectFacultyName').innerHTML = 'Faculty: <strong>' + facultyName + '</strong>';
        document.getElementById('facultyRejectReason').value = '';
        document.getElementById('facultyRejectModal').style.display = 'flex';
    }

    function confirmFacultyReject() {
        const facultyId = currentRejectFacultyId;
        const reason = document.getElementById('facultyRejectReason').value;
        const row = $('#faculty-row-' + facultyId);
        const rejectBtn = row.find('.btn-reject');
        const originalText = rejectBtn.html();
        
        rejectBtn.html('<i class="fas fa-spinner fa-spin"></i> Processing...');
        rejectBtn.prop('disabled', true);
        
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/reject-faculty',
            type: 'POST',
            data: { facultyId: facultyId, reason: reason },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    showToast('❌ Faculty rejected', 'error');
                    row.fadeOut(300, function() { $(this).remove(); });
                    closeFacultyModal();
                } else {
                    showToast('❌ ' + response.message, 'error');
                    rejectBtn.html(originalText);
                    rejectBtn.prop('disabled', false);
                }
            },
            error: function() {
                showToast('❌ Error rejecting faculty!', 'error');
                rejectBtn.html(originalText);
                rejectBtn.prop('disabled', false);
            }
        });
    }

    function closeFacultyModal() {
        document.getElementById('facultyRejectModal').style.display = 'none';
        currentRejectFacultyId = null;
    }

    // ========== STUDENT APPROVAL FUNCTIONS ==========
    function approveStudent(studentId) {
        if (!confirm('Are you sure you want to APPROVE this student? They will receive an email with login credentials.')) {
            return;
        }
        
        const row = $('#student-row-' + studentId);
        const approveBtn = row.find('.btn-approve');
        const originalText = approveBtn.html();
        
        approveBtn.html('<i class="fas fa-spinner fa-spin"></i> Processing...');
        approveBtn.prop('disabled', true);
        
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/approve-student',
            type: 'POST',
            data: { studentId: studentId },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    showToast('✅ ' + response.message, 'success');
                    row.fadeOut(300, function() { $(this).remove(); });
                } else {
                    showToast('❌ ' + response.message, 'error');
                    approveBtn.html(originalText);
                    approveBtn.prop('disabled', false);
                }
            },
            error: function() {
                showToast('❌ Error approving student!', 'error');
                approveBtn.html(originalText);
                approveBtn.prop('disabled', false);
            }
        });
    }

    function showStudentRejectModal(studentId, studentName) {
        currentRejectStudentId = studentId;
        document.getElementById('rejectStudentId').value = studentId;
        document.getElementById('rejectStudentName').innerHTML = 'Student: <strong>' + studentName + '</strong>';
        document.getElementById('studentRejectReason').value = '';
        document.getElementById('studentRejectModal').style.display = 'flex';
    }

    function confirmStudentReject() {
        const studentId = currentRejectStudentId;
        const reason = document.getElementById('studentRejectReason').value;
        const row = $('#student-row-' + studentId);
        const rejectBtn = row.find('.btn-reject');
        const originalText = rejectBtn.html();
        
        rejectBtn.html('<i class="fas fa-spinner fa-spin"></i> Processing...');
        rejectBtn.prop('disabled', true);
        
        $.ajax({
            url: '${pageContext.request.contextPath}/admin/reject-student',
            type: 'POST',
            data: { studentId: studentId, reason: reason },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    showToast('❌ Student rejected', 'error');
                    row.fadeOut(300, function() { $(this).remove(); });
                    closeStudentModal();
                } else {
                    showToast('❌ ' + response.message, 'error');
                    rejectBtn.html(originalText);
                    rejectBtn.prop('disabled', false);
                }
            },
            error: function() {
                showToast('❌ Error rejecting student!', 'error');
                rejectBtn.html(originalText);
                rejectBtn.prop('disabled', false);
            }
        });
    }

    function closeStudentModal() {
        document.getElementById('studentRejectModal').style.display = 'none';
        currentRejectStudentId = null;
    }

    // ========== LOAD ATTENDANCE ==========
    function loadAttendance() {
        const batch = document.getElementById('batchSelect').value;
        const attendanceData = {
            'Java': [{ name: 'Alice Brown', percentage: 85 }, { name: 'Bob Wilson', percentage: 92 }, { name: 'Charlie Davis', percentage: 78 }],
            'Python': [{ name: 'David Miller', percentage: 88 }, { name: 'Emma Watson', percentage: 95 }],
            'MERN': [{ name: 'Frank Ocean', percentage: 82 }, { name: 'Grace Lee', percentage: 90 }],
            'Cloud': [{ name: 'Henry Ford', percentage: 75 }, { name: 'Ivy Chen', percentage: 89 }]
        };
        const students = attendanceData[batch] || [];
        const tbody = document.getElementById('attendanceList');
        tbody.innerHTML = '';
        students.forEach(s => {
            tbody.innerHTML += `<tr><td>${s.name}</td><td>${s.percentage}%</td><td><div class="progress-bar"><div class="progress-fill" style="width: ${s.percentage}%"></div></div></td></tr>`;
        });
    }
    loadAttendance();

    // ========== COURSES ==========
    const courses = [
        { title: 'Full Stack Java', desc: 'Learn Java, Spring Boot, React', duration: '6 months', fees: '₹45,000' },
        { title: 'Python Development', desc: 'Python, Django, Flask', duration: '5 months', fees: '₹40,000' },
        { title: 'MERN Stack', desc: 'MongoDB, Express, React, Node', duration: '5 months', fees: '₹40,000' }
    ];
    
    function displayCourses() {
        const container = document.getElementById('coursesList');
        if (!container) return;
        container.innerHTML = '';
        courses.forEach(c => {
            container.innerHTML += `<div class="course-card"><div class="course-info"><h4>${c.title}</h4><p>${c.desc}</p><p><strong>Duration:</strong> ${c.duration}</p><p><strong>Fees:</strong> ${c.fees}</p><button class="btn-approve" onclick="downloadBrochure('${c.title}')">Download Brochure</button></div></div>`;
        });
    }
    displayCourses();
    function addCourse() { showToast('Add new course form will open.', 'info'); }
    function downloadBrochure(courseName) { showToast('Downloading brochure for ' + courseName, 'info'); }

    // ========== FEE RECEIPT ==========
    function showReceiptForm() { const f = document.getElementById('receiptForm'); if (f) f.style.display = f.style.display === 'none' ? 'block' : 'none'; }
    function generateReceipt() { showToast('PDF Receipt Generated!', 'success'); }

    // ========== PLACEMENT ==========
    function showPlacementForm() { const f = document.getElementById('placementForm'); if (f) f.style.display = f.style.display === 'none' ? 'block' : 'none'; }
    function addPlacement() { showToast('New placement added!', 'success'); }

    // ========== NOTICE ==========
    function showNoticeForm() { const f = document.getElementById('noticeForm'); if (f) f.style.display = f.style.display === 'none' ? 'block' : 'none'; }
    function publishNotice() { showToast('Notice published!', 'success'); }

    // ========== EVENT ==========
    function showEventForm() { const f = document.getElementById('eventForm'); if (f) f.style.display = f.style.display === 'none' ? 'block' : 'none'; }
    function createEvent() { showToast('Event created!', 'success'); }

    // Close modals when clicking outside
    $(window).click(function(e) {
        if ($(e.target).is('#facultyRejectModal')) closeFacultyModal();
        if ($(e.target).is('#studentRejectModal')) closeStudentModal();
    });
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            color: #333;
        }

        .data-table tr:hover {
            background: #f8f9fa;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .status-approved {
            background: #d4edda;
            color: #155724;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .btn-approve {
            background: #28a745;
            color: white;
            border: none;
            padding: 5px 12px;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 5px;
        }

        .btn-reject {
            background: #dc3545;
            color: white;
            border: none;
            padding: 5px 12px;
            border-radius: 5px;
            cursor: pointer;
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

        .course-card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }

        .course-card .course-info {
            padding: 15px;
        }

        .course-card h4 {
            margin-bottom: 8px;
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
                        <div class="stat-number">12</div>
                        <div class="stat-label">Pending Faculty</div>
                    </div>
                    <div class="stat-icon"><i class="fas fa-chalkboard-user"></i></div>
                </div>
                <div class="stat-card">
                    <div class="stat-info">
                        <div class="stat-number">45</div>
                        <div class="stat-label">Pending Students</div>
                    </div>
                    <div class="stat-icon"><i class="fas fa-user-graduate"></i></div>
                </div>
                <div class="stat-card">
                    <div class="stat-info">
                        <div class="stat-number">8</div>
                        <div class="stat-label">Active Batches</div>
                    </div>
                    <div class="stat-icon"><i class="fas fa-layer-group"></i></div>
                </div>
                <div class="stat-card">
                    <div class="stat-info">
                        <div class="stat-number">94%</div>
                        <div class="stat-label">Placement Rate</div>
                    </div>
                    <div class="stat-icon"><i class="fas fa-briefcase"></i></div>
                </div>
            </div>
            <div class="section-card">
                <div class="section-title">Quick Actions</div>
                <p>Select any option from the left menu to manage different modules.</p>
                <ul style="margin-top: 15px; margin-left: 20px;">
                    <li>Approve Faculty/Student Requests</li>
                    <li>Manage Courses & Brochures</li>
                    <li>Generate Fee Receipts</li>
                    <li>Add Placement Opportunities</li>
                    <li>Publish Notices & Events</li>
                    <li>View Feedback & Attendance Reports</li>
                </ul>
            </div>
        </div>

        <!-- ========== 2. ADMIN FACULTY DASHBOARD ========== -->
        <div id="faculty-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-chalkboard-user"></i> Faculty Requests</div>
                <table class="data-table">
                    <thead>
                        <tr><th>Name</th><th>Contact</th><th>Batch</th><th>Username</th><th>Admin Office</th><th>Action</th></tr>
                    </thead>
                    <tbody id="facultyRequestsList">
                        <tr><td>John Smith</td><td>9876543210</td><td>Java</td><td>john_faculty</td><td>Head Office</td><td><button class="btn-approve" onclick="approveFaculty(1)">Accept</button><button class="btn-reject" onclick="rejectFaculty(1)">Reject</button></td></tr>
                        <tr><td>Sarah Johnson</td><td>9876543211</td><td>Python</td><td>sarah_faculty</td><td>Head Office</td><td><button class="btn-approve" onclick="approveFaculty(2)">Accept</button><button class="btn-reject" onclick="rejectFaculty(2)">Reject</button></td></tr>
                        <tr><td>Mike Brown</td><td>9876543212</td><td>MERN</td><td>mike_faculty</td><td>Branch Office</td><td><button class="btn-approve" onclick="approveFaculty(3)">Accept</button><button class="btn-reject" onclick="rejectFaculty(3)">Reject</button></td></tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- ========== 3. ADMIN STUDENT DASHBOARD ========== -->
        <div id="student-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-user-graduate"></i> Student Requests</div>
                <table class="data-table">
                    <thead>
                        <tr><th>Name</th><th>Contact</th><th>Batch</th><th>Username</th><th>Admin Office</th><th>Action</th></tr>
                    </thead>
                    <tbody id="studentRequestsList">
                        <tr><td>Alice Brown</td><td>9876543213</td><td>Java</td><td>alice_student</td><td>Head Office</td><td><button class="btn-approve" onclick="approveStudent(1)">Accept</button><button class="btn-reject" onclick="rejectStudent(1)">Reject</button></td></tr>
                        <tr><td>Bob Wilson</td><td>9876543214</td><td>Python</td><td>bob_student</td><td>Head Office</td><td><button class="btn-approve" onclick="approveStudent(2)">Accept</button><button class="btn-reject" onclick="rejectStudent(2)">Reject</button></td></tr>
                        <tr><td>Charlie Davis</td><td>9876543215</td><td>Cloud</td><td>charlie_student</td><td>Branch Office</td><td><button class="btn-approve" onclick="approveStudent(3)">Accept</button><button class="btn-reject" onclick="rejectStudent(3)">Reject</button></td></tr>
                    </tbody>
                </table>
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
                    <form id="receiptFormData">
                        <input type="text" placeholder="Student Name" id="studentName" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                        <input type="text" placeholder="Contact Number" id="contactNo" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                        <input type="email" placeholder="Email" id="email" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                        <input type="text" placeholder="Course" id="courseName" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                        <input type="number" placeholder="Amount" id="amount" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                        <input type="text" placeholder="Executive Name" id="executiveName" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                        <button type="button" class="btn-add" onclick="generateReceipt()">Generate PDF Receipt</button>
                    </form>
                </div>
                <div id="receiptsList" style="margin-top: 20px;"></div>
            </div>
        </div>

        <!-- ========== 8. ADMIN PLACEMENT DASHBOARD ========== -->
        <div id="placement-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-briefcase"></i> Placement Management</div>
                <button class="btn-add" onclick="showPlacementForm()"><i class="fas fa-plus"></i> Add New Placement</button>
                <div id="placementForm" style="display: none; margin-top: 20px; padding: 20px; background: #f8f9fa; border-radius: 12px;">
                    <h4>Add New Placement Opportunity</h4>
                    <form id="placementFormData">
                        <input type="text" placeholder="Company Name" id="companyName" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                        <textarea placeholder="Job Role Description" id="jobRoleDesc" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;" rows="3"></textarea>
                        <textarea placeholder="Required Skills" id="skills" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;" rows="2"></textarea>
                        <textarea placeholder="Interview Round Details" id="interviewDetails" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;" rows="2"></textarea>
                        <input type="date" placeholder="Last Date to Apply" id="lastDate" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                        <button type="button" class="btn-add" onclick="addPlacement()">Add Placement</button>
                    </form>
                </div>
                <div id="placementsList" style="margin-top: 20px;"></div>
            </div>
        </div>

        <!-- ========== 9. ADMIN NOTICE DASHBOARD ========== -->
        <div id="notice-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-bullhorn"></i> E-Notice Management</div>
                <button class="btn-add" onclick="showNoticeForm()"><i class="fas fa-plus"></i> Publish New Notice</button>
                <div id="noticeForm" style="display: none; margin-top: 20px; padding: 20px; background: #f8f9fa; border-radius: 12px;">
                    <h4>Publish Notice</h4>
                    <form>
                        <input type="text" placeholder="Notice Title" id="noticeTitle" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                        <textarea placeholder="Notice Content" id="noticeContent" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;" rows="4"></textarea>
                        <button type="button" class="btn-add" onclick="publishNotice()">Publish Notice</button>
                    </form>
                </div>
                <div id="noticesList" style="margin-top: 20px;"></div>
            </div>
        </div>

        <!-- ========== 10. ADMIN EVENT DASHBOARD ========== -->
        <div id="event-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-calendar-alt"></i> Event Management</div>
                <button class="btn-add" onclick="showEventForm()"><i class="fas fa-plus"></i> Create New Event</button>
                <div id="eventForm" style="display: none; margin-top: 20px; padding: 20px; background: #f8f9fa; border-radius: 12px;">
                    <h4>Create Event</h4>
                    <form>
                        <input type="text" placeholder="Event Title" id="eventTitle" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                        <textarea placeholder="Event Description" id="eventDesc" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;" rows="3"></textarea>
                        <input type="date" placeholder="Event Date" id="eventDate" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                        <input type="time" placeholder="Event Time" id="eventTime" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                        <input type="text" placeholder="Location" id="eventLocation" style="width: 100%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 8px;">
                        <button type="button" class="btn-add" onclick="createEvent()">Create Event</button>
                    </form>
                </div>
                <div id="eventsList" style="margin-top: 20px;"></div>
            </div>
        </div>
    </div>
</div>

<script>
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

    // ========== LOAD ATTENDANCE ==========
    function loadAttendance() {
        const batch = document.getElementById('batchSelect').value;
        const attendanceData = {
            'Java': [
                { name: 'Alice Brown', percentage: 85 },
                { name: 'Bob Wilson', percentage: 92 },
                { name: 'Charlie Davis', percentage: 78 }
            ],
            'Python': [
                { name: 'David Miller', percentage: 88 },
                { name: 'Emma Watson', percentage: 95 }
            ],
            'MERN': [
                { name: 'Frank Ocean', percentage: 82 },
                { name: 'Grace Lee', percentage: 90 }
            ],
            'Cloud': [
                { name: 'Henry Ford', percentage: 75 },
                { name: 'Ivy Chen', percentage: 89 }
            ]
        };
        
        const students = attendanceData[batch] || [];
        const tbody = document.getElementById('attendanceList');
        tbody.innerHTML = '';
        students.forEach(s => {
            tbody.innerHTML += `<tr><td>${s.name}</td><td>${s.percentage}%</td><td><div class="progress-bar"><div class="progress-fill" style="width: ${s.percentage}%"></div></div></td></tr>`;
        });
    }
    loadAttendance();

    // ========== FACULTY ACTIONS ==========
    function approveFaculty(id) { alert('Faculty approved! Email sent to faculty.'); }
    function rejectFaculty(id) { alert('Faculty request rejected.'); }
    function approveStudent(id) { alert('Student approved! Email sent to student.'); }
    function rejectStudent(id) { alert('Student request rejected.'); }

    // ========== COURSES ==========
    const courses = [
        { title: 'Full Stack Java', desc: 'Learn Java, Spring Boot, React', duration: '6 months', fees: '₹45,000' },
        { title: 'Python Development', desc: 'Python, Django, Flask', duration: '5 months', fees: '₹40,000' },
        { title: 'MERN Stack', desc: 'MongoDB, Express, React, Node', duration: '5 months', fees: '₹40,000' }
    ];
    function displayCourses() {
        const container = document.getElementById('coursesList');
        container.innerHTML = '';
        courses.forEach(c => {
            container.innerHTML += `
                <div class="course-card">
                    <div class="course-info">
                        <h4>${c.title}</h4>
                        <p>${c.desc}</p>
                        <p><strong>Duration:</strong> ${c.duration}</p>
                        <p><strong>Fees:</strong> ${c.fees}</p>
                        <button class="btn-approve" style="margin-top: 10px;">Download Brochure</button>
                    </div>
                </div>
            `;
        });
    }
    displayCourses();
    function addCourse() { alert('Add new course form will open.'); }

    // ========== FEE RECEIPT ==========
    function showReceiptForm() {
        const form = document.getElementById('receiptForm');
        form.style.display = form.style.display === 'none' ? 'block' : 'none';
    }
    function generateReceipt() {
        alert('PDF Receipt Generated!\n\nStudent: ' + document.getElementById('studentName').value + '\nAmount: ₹' + document.getElementById('amount').value + '\n\nReceipt saved successfully.');
    }

    // ========== PLACEMENT ==========
    function showPlacementForm() {
        const form = document.getElementById('placementForm');
        form.style.display = form.style.display === 'none' ? 'block' : 'none';
    }
    function addPlacement() { alert('New placement added successfully!'); }

    // ========== NOTICE ==========
    function showNoticeForm() {
        const form = document.getElementById('noticeForm');
        form.style.display = form.style.display === 'none' ? 'block' : 'none';
    }
    function publishNotice() { alert('Notice published successfully!'); }

    // ========== EVENT ==========
    function showEventForm() {
        const form = document.getElementById('eventForm');
        form.style.display = form.style.display === 'none' ? 'block' : 'none';
    }
    function createEvent() { alert('Event created successfully!'); }
</script>
</body>
</html>
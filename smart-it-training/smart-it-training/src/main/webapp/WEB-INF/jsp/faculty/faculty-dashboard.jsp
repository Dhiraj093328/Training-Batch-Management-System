<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Faculty Dashboard | Smart IT Training</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Poppins', sans-serif;
            background: #f0f2f5;
            overflow-x: hidden;
        }
        .dashboard-container { display: flex; min-height: 100vh; }
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
        .sidebar-header .logo-icon { font-size: 45px; margin-bottom: 10px; }
        .sidebar-header h2 { font-size: 1.2rem; margin-bottom: 5px; }
        .sidebar-menu { padding: 20px 0; }
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
        .menu-item i { width: 25px; font-size: 1.1rem; }
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
        .welcome-text h3 { color: #333; font-size: 1.2rem; }
        .welcome-text p { color: #666; font-size: 0.8rem; }
        .faculty-badge {
            background: linear-gradient(135deg, #667eea, #764ba2);
            padding: 8px 15px;
            border-radius: 20px;
            color: white;
            font-size: 0.8rem;
        }
        .date-time { text-align: right; }
        .date-time .date { color: #666; font-size: 0.8rem; }
        .date-time .time { color: #667eea; font-size: 1.3rem; font-weight: 600; }
        .logout-btn {
            background: linear-gradient(135deg, #ff416c, #ff4b2b);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            text-decoration: none;
        }
        .content-section { display: none; animation: fadeIn 0.3s ease; }
        .content-section.active-section { display: block; }
        @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
        .section-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 25px;
        }
        .section-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
            border-left: 4px solid #667eea;
            padding-left: 15px;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
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
        }
        .stat-info .stat-number { font-size: 1.8rem; font-weight: 700; color: #333; }
        .stat-info .stat-label { color: #666; font-size: 0.85rem; }
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
        @media (max-width: 768px) {
            .sidebar { width: 80px; }
            .sidebar-header h2, .sidebar-header p, .menu-item span { display: none; }
            .main-content { margin-left: 80px; }
        }
    </style>
</head>
<body>

<div class="dashboard-container">
    <div class="sidebar">
        <div class="sidebar-header">
            <div class="logo-icon">👩‍🏫</div>
            <h2>Smart IT Training</h2>
            <p>Faculty Portal</p>
        </div>
        <div class="sidebar-menu">
            <div class="menu-item active" data-section="dashboard"><i class="fas fa-tachometer-alt"></i> <span>Dashboard</span></div>
            <div class="menu-item" data-section="attendance"><i class="fas fa-calendar-check"></i> <span>Attendance Management</span></div>
            <div class="menu-item" data-section="exam"><i class="fas fa-file-alt"></i> <span>Online Exam & Result</span></div>
            <div class="menu-item" data-section="syllabus"><i class="fas fa-book"></i> <span>Syllabus Coverage</span></div>
        </div>
    </div>

    <div class="main-content">
        <div class="top-bar">
            <div class="welcome-text">
                <h3>Welcome, ${sessionScope.facultyName}!</h3>
                <p><i class="fas fa-chalkboard-user"></i> Faculty Dashboard</p>
            </div>
            <div class="faculty-badge">
                <i class="fas fa-id-card"></i> ID: ${sessionScope.facultyEmployeeId}
            </div>
            <div class="date-time">
                <div class="date" id="currentDate"></div>
                <div class="time" id="currentTime"></div>
            </div>
            <a href="${pageContext.request.contextPath}/faculty/logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>

        <!-- Dashboard Section -->
        <div id="dashboard-section" class="content-section active-section">
            <div class="stats-grid">
                <div class="stat-card"><div class="stat-info"><div class="stat-number">120</div><div class="stat-label">Total Students</div></div><div class="stat-icon"><i class="fas fa-users"></i></div></div>
                <div class="stat-card"><div class="stat-info"><div class="stat-number">8</div><div class="stat-label">Upcoming Exams</div></div><div class="stat-icon"><i class="fas fa-file-alt"></i></div></div>
                <div class="stat-card"><div class="stat-info"><div class="stat-number">75%</div><div class="stat-label">Avg Attendance</div></div><div class="stat-icon"><i class="fas fa-calendar-check"></i></div></div>
                <div class="stat-card"><div class="stat-info"><div class="stat-number">85%</div><div class="stat-label">Syllabus Covered</div></div><div class="stat-icon"><i class="fas fa-book"></i></div></div>
            </div>
            <div class="section-card">
                <div class="section-title">Welcome to Faculty Dashboard</div>
                <p>Select from the menu to manage attendance, create exams, and track syllabus coverage.</p>
            </div>
        </div>

        <!-- Attendance Management Section -->
        <div id="attendance-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-calendar-check"></i> Attendance Management</div>
                <p>Attendance management features will be displayed here.</p>
            </div>
        </div>

        <!-- Online Exam Section -->
        <div id="exam-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-file-alt"></i> Online Exam & Result</div>
                <p>Exam creation and result management features will be displayed here.</p>
            </div>
        </div>

        <!-- Syllabus Section -->
        <div id="syllabus-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-book"></i> Syllabus Coverage</div>
                <p>Syllabus tracking features will be displayed here.</p>
            </div>
        </div>
    </div>
</div>

<script>
    function updateDateTime() {
        const now = new Date();
        document.getElementById('currentDate').innerHTML = '<i class="far fa-calendar-alt"></i> ' + now.toLocaleDateString('en-IN', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
        document.getElementById('currentTime').innerHTML = '<i class="far fa-clock"></i> ' + now.toLocaleTimeString('en-IN', { hour: '2-digit', minute: '2-digit' });
    }
    updateDateTime();
    setInterval(updateDateTime, 1000);

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
</script>
</body>
</html>
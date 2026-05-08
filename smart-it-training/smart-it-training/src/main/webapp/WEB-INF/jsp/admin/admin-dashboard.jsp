<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Admin Dashboard | Smart IT Training</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&family=Space+Grotesk:wght@400;500;600&display=swap" rel="stylesheet">
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <!-- Chart.js for Analytics -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: #0a0f1e;
            overflow-x: hidden;
        }

        /* ========== LIVE IT BACKGROUND ========== */
        .bg-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 0;
            overflow: hidden;
        }

        .animated-bg {
            position: absolute;
            width: 100%;
            height: 100%;
            background: linear-gradient(125deg, #0a0f1e 0%, #0d1428 25%, #0f1a30 50%, #0d1428 75%, #0a0f1e 100%);
            background-size: 400% 400%;
            animation: gradientShift 15s ease infinite;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .tech-orb-1, .tech-orb-2, .tech-orb-3, .tech-orb-4 {
            position: absolute;
            border-radius: 50%;
            filter: blur(80px);
            opacity: 0.5;
            animation: floatOrb 20s infinite alternate ease-in-out;
        }

        .tech-orb-1 {
            width: 50vw;
            height: 50vw;
            background: radial-gradient(circle, #667eea, #764ba2);
            top: -20vh;
            left: -20vw;
            animation-duration: 25s;
        }

        .tech-orb-2 {
            width: 60vw;
            height: 60vw;
            background: radial-gradient(circle, #00e5ff, #0055cc);
            bottom: -30vh;
            right: -25vw;
            animation-duration: 30s;
        }

        .tech-orb-3 {
            width: 40vw;
            height: 40vw;
            background: radial-gradient(circle, #f093fb, #f5576c);
            top: 40%;
            left: 30%;
            animation-duration: 28s;
            opacity: 0.3;
        }

        .tech-orb-4 {
            width: 45vw;
            height: 45vw;
            background: radial-gradient(circle, #4facfe, #00f2fe);
            bottom: 20%;
            left: -15%;
            animation-duration: 35s;
        }

        @keyframes floatOrb {
            0% { transform: translate(0, 0) scale(1); }
            100% { transform: translate(5%, 8%) scale(1.1); }
        }

        .circuit-lines {
            position: absolute;
            width: 100%;
            height: 100%;
            background-image: 
                repeating-linear-gradient(90deg, rgba(0, 255, 200, 0.08) 0px, rgba(0, 255, 200, 0.08) 1px, transparent 1px, transparent 60px),
                repeating-linear-gradient(0deg, rgba(0, 255, 200, 0.05) 0px, rgba(0, 255, 200, 0.05) 1px, transparent 1px, transparent 60px);
            animation: circuitMove 20s linear infinite;
            pointer-events: none;
        }

        @keyframes circuitMove {
            0% { background-position: 0 0; }
            100% { background-position: 60px 60px; }
        }

        .matrix-rain {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: repeating-linear-gradient(0deg,
                rgba(0, 255, 200, 0.03) 0px,
                rgba(0, 255, 200, 0.03) 2px,
                transparent 2px,
                transparent 15px);
            animation: matrixFall 8s linear infinite;
            pointer-events: none;
        }

        @keyframes matrixFall {
            0% { background-position: 0 0; }
            100% { background-position: 0 30px; }
        }

        .scan-line {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(to bottom, transparent, rgba(0, 255, 200, 0.05), transparent);
            animation: scanMove 8s linear infinite;
            pointer-events: none;
        }

        @keyframes scanMove {
            0% { transform: translateY(-100%); }
            100% { transform: translateY(100%); }
        }

        /* ========== DASHBOARD CONTAINER ========== */
        .dashboard-wrapper {
            position: relative;
            z-index: 10;
            display: flex;
            min-height: 100vh;
        }

        /* ========== SIDEBAR ========== */
        .sidebar {
            width: 280px;
            background: rgba(10, 20, 35, 0.95);
            backdrop-filter: blur(15px);
            border-right: 1px solid rgba(0, 255, 200, 0.3);
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            transition: all 0.3s ease;
        }

        .sidebar-header {
            padding: 25px 20px;
            text-align: center;
            border-bottom: 1px solid rgba(0, 255, 200, 0.3);
        }

        .sidebar-header .logo-icon {
            font-size: 45px;
            margin-bottom: 10px;
            display: inline-block;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .sidebar-header h2 {
            color: white;
            font-size: 1.2rem;
            margin-bottom: 5px;
        }

        .sidebar-header p {
            color: #00ffcc;
            font-size: 0.7rem;
            font-family: monospace;
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
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            border-left: 3px solid transparent;
        }

        .menu-item:hover, .menu-item.active {
            background: rgba(0, 255, 200, 0.1);
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
            background: rgba(15, 25, 45, 0.85);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            padding: 15px 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            border: 1px solid rgba(0, 255, 200, 0.3);
        }

        .welcome-text h3 {
            color: white;
            font-size: 1.2rem;
        }

        .welcome-text p {
            color: #00ffcc;
            font-size: 0.8rem;
        }

        .date-time {
            text-align: right;
        }

        .date-time .date {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.8rem;
        }

        .date-time .time {
            color: #00ffcc;
            font-size: 1.3rem;
            font-weight: 600;
            font-family: monospace;
        }

        .logout-btn {
            background: linear-gradient(135deg, #ff416c, #ff4b2b);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(255, 65, 108, 0.4);
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: rgba(15, 25, 45, 0.85);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            padding: 20px;
            border: 1px solid rgba(0, 255, 200, 0.3);
            transition: all 0.3s ease;
            animation: fadeInUp 0.5s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            border-color: #00ffcc;
            box-shadow: 0 10px 30px rgba(0, 255, 200, 0.2);
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .stat-icon {
            font-size: 35px;
            color: #00ffcc;
            margin-bottom: 15px;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: white;
        }

        .stat-label {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.85rem;
            margin-top: 5px;
        }

        /* Charts Section */
        .charts-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }

        .chart-card {
            background: rgba(15, 25, 45, 0.85);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            padding: 20px;
            border: 1px solid rgba(0, 255, 200, 0.3);
        }

        .chart-card h4 {
            color: white;
            margin-bottom: 15px;
            font-size: 1rem;
        }

        canvas {
            max-height: 250px;
        }

        /* Recent Activity */
        .activity-section {
            background: rgba(15, 25, 45, 0.85);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            padding: 20px;
            border: 1px solid rgba(0, 255, 200, 0.3);
        }

        .activity-section h4 {
            color: white;
            margin-bottom: 15px;
            font-size: 1.1rem;
        }

        .activity-list {
            list-style: none;
        }

        .activity-item {
            padding: 12px 0;
            border-bottom: 1px solid rgba(0, 255, 200, 0.1);
            display: flex;
            align-items: center;
            gap: 12px;
            color: rgba(255, 255, 255, 0.8);
        }

        .activity-item i {
            color: #00ffcc;
            width: 30px;
        }

        /* Content Sections */
        .content-section {
            display: none;
            animation: fadeIn 0.5s ease;
        }

        .content-section.active-section {
            display: block;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .section-card {
            background: rgba(15, 25, 45, 0.85);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            padding: 25px;
            border: 1px solid rgba(0, 255, 200, 0.3);
        }

        .section-card h3 {
            color: white;
            margin-bottom: 20px;
            border-left: 3px solid #00ffcc;
            padding-left: 15px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .sidebar {
                width: 80px;
            }
            .sidebar-header h2, .sidebar-header p, .menu-item span {
                display: none;
            }
            .menu-item {
                justify-content: center;
                padding: 14px;
            }
            .menu-item i {
                font-size: 1.3rem;
            }
            .main-content {
                margin-left: 80px;
            }
            .charts-section {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

    <!-- LIVE IT BACKGROUND -->
    <div class="bg-container">
        <div class="animated-bg"></div>
        <div class="tech-orb-1"></div>
        <div class="tech-orb-2"></div>
        <div class="tech-orb-3"></div>
        <div class="tech-orb-4"></div>
        <div class="circuit-lines"></div>
        <div class="matrix-rain"></div>
        <div class="scan-line"></div>
    </div>

    <div class="dashboard-wrapper">
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
                    <i class="fas fa-chalkboard-user"></i> <span>Faculty Requests</span>
                </div>
                <div class="menu-item" data-section="student">
                    <i class="fas fa-user-graduate"></i> <span>Student Requests</span>
                </div>
                <div class="menu-item" data-section="attendance">
                    <i class="fas fa-calendar-check"></i> <span>Attendance Reports</span>
                </div>
                <div class="menu-item" data-section="feedback">
                    <i class="fas fa-star"></i> <span>Feedback</span>
                </div>
                <div class="menu-item" data-section="courses">
                    <i class="fas fa-book"></i> <span>Courses</span>
                </div>
                <div class="menu-item" data-section="account">
                    <i class="fas fa-wallet"></i> <span>Account</span>
                </div>
                <div class="menu-item" data-section="placement">
                    <i class="fas fa-briefcase"></i> <span>Placement</span>
                </div>
                <div class="menu-item" data-section="notice">
                    <i class="fas fa-bullhorn"></i> <span>Notice</span>
                </div>
                <div class="menu-item" data-section="event">
                    <i class="fas fa-calendar-alt"></i> <span>Event</span>
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

            <!-- Dashboard Section -->
            <div id="dashboard-section" class="content-section active-section">
                <!-- Stats Cards -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon"><i class="fas fa-user-graduate"></i></div>
                        <div class="stat-number">1,248</div>
                        <div class="stat-label">Total Students</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="fas fa-chalkboard-user"></i></div>
                        <div class="stat-number">48</div>
                        <div class="stat-label">Total Faculty</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="fas fa-layer-group"></i></div>
                        <div class="stat-number">12</div>
                        <div class="stat-label">Active Batches</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon"><i class="fas fa-briefcase"></i></div>
                        <div class="stat-number">94%</div>
                        <div class="stat-label">Placement Rate</div>
                    </div>
                </div>

                <!-- Charts -->
                <div class="charts-section">
                    <div class="chart-card">
                        <h4><i class="fas fa-chart-line"></i> Enrollment Trend</h4>
                        <canvas id="enrollmentChart"></canvas>
                    </div>
                    <div class="chart-card">
                        <h4><i class="fas fa-chart-pie"></i> Course Distribution</h4>
                        <canvas id="courseChart"></canvas>
                    </div>
                </div>

                <!-- Recent Activity -->
                <div class="activity-section">
                    <h4><i class="fas fa-clock"></i> Recent Activities</h4>
                    <ul class="activity-list">
                        <li class="activity-item"><i class="fas fa-user-plus"></i> New student registration: John Doe (Java Batch)</li>
                        <li class="activity-item"><i class="fas fa-chalkboard-user"></i> Faculty request: Sarah Smith pending approval</li>
                        <li class="activity-item"><i class="fas fa-calendar-check"></i> Attendance marked for 15 students</li>
                        <li class="activity-item"><i class="fas fa-star"></i> New feedback received from 3 students</li>
                        <li class="activity-item"><i class="fas fa-briefcase"></i> New placement added: Google</li>
                    </ul>
                </div>
            </div>

            <!-- Faculty Section -->
            <div id="faculty-section" class="content-section">
                <div class="section-card">
                    <h3><i class="fas fa-chalkboard-user"></i> Faculty Requests</h3>
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-number">12</div>
                            <div class="stat-label">Pending Requests</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">36</div>
                            <div class="stat-label">Approved Faculty</div>
                        </div>
                    </div>
                    <div class="activity-list" id="facultyRequestsList">
                        <div class="activity-item"><i class="fas fa-user"></i> John Smith - Java Batch <button class="logout-btn" style="margin-left: auto; padding: 5px 15px;">Approve</button></div>
                        <div class="activity-item"><i class="fas fa-user"></i> Jane Doe - Python Batch <button class="logout-btn" style="margin-left: auto; padding: 5px 15px;">Approve</button></div>
                        <div class="activity-item"><i class="fas fa-user"></i> Mike Johnson - MERN Batch <button class="logout-btn" style="margin-left: auto; padding: 5px 15px;">Approve</button></div>
                    </div>
                </div>
            </div>

            <!-- Student Section -->
            <div id="student-section" class="content-section">
                <div class="section-card">
                    <h3><i class="fas fa-user-graduate"></i> Student Requests</h3>
                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="stat-number">45</div>
                            <div class="stat-label">Pending Requests</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-number">1,203</div>
                            <div class="stat-label">Approved Students</div>
                        </div>
                    </div>
                    <div class="activity-list" id="studentRequestsList">
                        <div class="activity-item"><i class="fas fa-user"></i> Alice Brown - Java Batch <button class="logout-btn" style="margin-left: auto; padding: 5px 15px;">Approve</button></div>
                        <div class="activity-item"><i class="fas fa-user"></i> Bob Wilson - Python Batch <button class="logout-btn" style="margin-left: auto; padding: 5px 15px;">Approve</button></div>
                    </div>
                </div>
            </div>

            <!-- Other Sections (Placeholders) -->
            <div id="attendance-section" class="content-section">
                <div class="section-card">
                    <h3><i class="fas fa-calendar-check"></i> Attendance Reports</h3>
                    <p>Attendance management module - Coming Soon!</p>
                </div>
            </div>

            <div id="feedback-section" class="content-section">
                <div class="section-card">
                    <h3><i class="fas fa-star"></i> Feedback Management</h3>
                    <div class="activity-list">
                        <div class="activity-item"><i class="fas fa-star"></i> "Excellent training program!" - Rahul M.</div>
                        <div class="activity-item"><i class="fas fa-star"></i> "Great faculty support" - Priya S.</div>
                        <div class="activity-item"><i class="fas fa-star"></i> "Best IT training center" - Amit K.</div>
                    </div>
                </div>
            </div>

            <div id="courses-section" class="content-section">
                <div class="section-card">
                    <h3><i class="fas fa-book"></i> Course Management</h3>
                    <p>Course management module - Coming Soon!</p>
                </div>
            </div>

            <div id="account-section" class="content-section">
                <div class="section-card">
                    <h3><i class="fas fa-wallet"></i> Account Management</h3>
                    <p>Fee receipt generation module - Coming Soon!</p>
                </div>
            </div>

            <div id="placement-section" class="content-section">
                <div class="section-card">
                    <h3><i class="fas fa-briefcase"></i> Placement Management</h3>
                    <p>Placement module - Coming Soon!</p>
                </div>
            </div>

            <div id="notice-section" class="content-section">
                <div class="section-card">
                    <h3><i class="fas fa-bullhorn"></i> Notice Management</h3>
                    <p>Notice module - Coming Soon!</p>
                </div>
            </div>

            <div id="event-section" class="content-section">
                <div class="section-card">
                    <h3><i class="fas fa-calendar-alt"></i> Event Management</h3>
                    <p>Event management module - Coming Soon!</p>
                </div>
            </div>
        </div>
    </div>

    <script>
        // ========== DATE & TIME ==========
        function updateDateTime() {
            const now = new Date();
            const dateStr = now.toLocaleDateString('en-IN', { 
                weekday: 'long', 
                year: 'numeric', 
                month: 'long', 
                day: 'numeric' 
            });
            const timeStr = now.toLocaleTimeString('en-IN', { 
                hour: '2-digit', 
                minute: '2-digit', 
                second: '2-digit' 
            });
            
            document.getElementById('currentDate').innerHTML = '<i class="far fa-calendar-alt"></i> ' + dateStr;
            document.getElementById('currentTime').innerHTML = '<i class="far fa-clock"></i> ' + timeStr;
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
                
                sections.forEach(section => {
                    section.classList.remove('active-section');
                });
                
                document.getElementById(sectionId + '-section').classList.add('active-section');
            });
        });

        // ========== CHARTS ==========
        // Enrollment Chart
        const enrollmentCtx = document.getElementById('enrollmentChart').getContext('2d');
        new Chart(enrollmentCtx, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                datasets: [{
                    label: 'New Enrollments',
                    data: [65, 78, 92, 84, 110, 135],
                    borderColor: '#00ffcc',
                    backgroundColor: 'rgba(0, 255, 200, 0.1)',
                    tension: 0.4,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: { labels: { color: 'white' } }
                },
                scales: {
                    y: { grid: { color: 'rgba(255,255,255,0.1)' }, ticks: { color: 'white' } },
                    x: { grid: { color: 'rgba(255,255,255,0.1)' }, ticks: { color: 'white' } }
                }
            }
        });

        // Course Distribution Chart
        const courseCtx = document.getElementById('courseChart').getContext('2d');
        new Chart(courseCtx, {
            type: 'doughnut',
            data: {
                labels: ['Java', 'Python', 'MERN', 'Cloud', 'Data Science'],
                datasets: [{
                    data: [30, 25, 20, 15, 10],
                    backgroundColor: ['#667eea', '#764ba2', '#00ffcc', '#f093fb', '#4facfe'],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: { labels: { color: 'white' } }
                }
            }
        });

        // ========== ANIMATED COUNTERS ==========
        function animateCounter(element, target) {
            let current = 0;
            const increment = target / 50;
            const timer = setInterval(() => {
                current += increment;
                if (current >= target) {
                    element.textContent = target.toLocaleString();
                    clearInterval(timer);
                } else {
                    element.textContent = Math.floor(current).toLocaleString();
                }
            }, 30);
        }

        // Animate stats when in view
        const statNumbers = document.querySelectorAll('.stat-number');
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const target = parseInt(entry.target.textContent.replace(/[^0-9]/g, ''));
                    if (!isNaN(target)) {
                        animateCounter(entry.target, target);
                    }
                    observer.unobserve(entry.target);
                }
            });
        });

        statNumbers.forEach(num => observer.observe(num));

        console.log('%c🏛️ Admin Dashboard Loaded', 'color: #00ffcc; font-size: 16px; font-weight: bold;');
    </script>
</body>
</html>
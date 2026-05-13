<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Attendance Dashboard | Smart IT Training</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Poppins', sans-serif;
            background: #f0f2f5;
            min-height: 100vh;
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
        .sidebar-header p { font-size: 0.7rem; opacity: 0.7; }
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
        
        .form-group { margin-bottom: 20px; }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }
        .form-group select, .form-group input {
            width: 100%;
            padding: 10px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 0.95rem;
        }
        .form-group select:focus, .form-group input:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .attendance-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .attendance-table th, .attendance-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        .attendance-table th {
            background: #f8f9fa;
            font-weight: 600;
        }
        .attendance-table tr:hover { background: #f8f9fa; }
        
        .attendance-checkbox {
            width: 20px;
            height: 20px;
            cursor: pointer;
            accent-color: #28a745;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 10px 25px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
            margin-top: 15px;
        }
        .btn-primary:hover { transform: translateY(-2px); }
        
        .toast-message {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: #28a745;
            color: white;
            padding: 12px 20px;
            border-radius: 8px;
            z-index: 1000;
        }
        
        @media (max-width: 768px) {
            .sidebar { width: 80px; }
            .sidebar-header h2, .sidebar-header p, .menu-item span { display: none; }
            .main-content { margin-left: 80px; }
            .attendance-table { font-size: 12px; }
            .attendance-table th, .attendance-table td { padding: 8px; }
        }
    </style>
</head>
<body>

<div class="dashboard-container">
    <div class="sidebar">
        <div class="sidebar-header">
            <div class="logo-icon">📋</div>
            <h2>Attendance</h2>
            <p>Faculty Portal</p>
        </div>
        <div class="sidebar-menu">
            <div class="menu-item active" data-section="dashboard">
                <i class="fas fa-tachometer-alt"></i> <span>Dashboard</span>
            </div>
            <div class="menu-item" data-section="mark-attendance">
                <i class="fas fa-pen-alt"></i> <span>Mark Attendance</span>
            </div>
        </div>
    </div>

    <div class="main-content">
        <div class="top-bar">
            <div class="welcome-text">
                <h3>Welcome, ${sessionScope.facultyName}!</h3>
                <p><i class="fas fa-calendar-check"></i> Attendance Management Portal</p>
            </div>
            <div class="faculty-badge">
                <i class="fas fa-layer-group"></i> Batch: ${sessionScope.facultyBatch}
            </div>
            <div class="date-time">
                <div class="date" id="currentDate"></div>
                <div class="time" id="currentTime"></div>
            </div>
            <a href="${pageContext.request.contextPath}/attendance/logout" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>

        <!-- Dashboard Section -->
        <div id="dashboard-section" class="content-section active-section">
            <div class="section-card">
                <div class="section-title">Today's Overview</div>
                <div style="text-align: center; padding: 40px;">
                    <i class="fas fa-calendar-check" style="font-size: 64px; color: #667eea;"></i>
                    <p style="margin-top: 20px;">Select batch and date to mark attendance.</p>
                </div>
            </div>
        </div>

        <!-- Mark Attendance Section -->
        <div id="mark-attendance-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-pen-alt"></i> Mark Attendance</div>
                
                <div class="form-group">
                    <label><i class="fas fa-layer-group"></i> Select Batch</label>
                    <select id="batchSelect">
                        <option value="">-- Select Batch --</option>
                        <option value="Java">Java Batch</option>
                        <option value="Python">Python Batch</option>
                        <option value="MERN">MERN Batch</option>
                        <option value="Cloud">Cloud Batch</option>
                        <option value="Data Science">Data Science Batch</option>
                        <option value="AWS">AWS Batch</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-calendar"></i> Select Date</label>
                    <input type="date" id="attendanceDate" value="">
                </div>
                
                <button class="btn-primary" onclick="loadStudents()" style="margin-right: 10px;">
                    <i class="fas fa-users"></i> Load Students
                </button>
                
                <div id="studentListContainer" style="display: none; margin-top: 20px;">
                    <table class="attendance-table">
                        <thead>
                            <tr><th>Enrollment No</th><th>Student Name</th><th style="text-align: center;">Present</th>
                        </thead>
                        <tbody id="studentTableBody"></tbody>
                    </table>
                    <button class="btn-primary" onclick="saveAttendance()">
                        <i class="fas fa-save"></i> Save Attendance
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    let currentStudents = [];
    let currentAttendanceStatus = {};
    
    // Set today's date
    const today = new Date().toISOString().split('T')[0];
    document.getElementById('attendanceDate').value = today;
    
    // Date & Time
    function updateDateTime() {
        const now = new Date();
        document.getElementById('currentDate').innerHTML = '<i class="far fa-calendar-alt"></i> ' + now.toLocaleDateString('en-IN', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
        document.getElementById('currentTime').innerHTML = '<i class="far fa-clock"></i> ' + now.toLocaleTimeString('en-IN', { hour: '2-digit', minute: '2-digit' });
    }
    updateDateTime();
    setInterval(updateDateTime, 1000);
    
    // Sidebar Navigation
    const menuItems = document.querySelectorAll('.menu-item');
    const sections = document.querySelectorAll('.content-section');
    menuItems.forEach(function(item) {
        item.addEventListener('click', function() {
            const sectionId = this.getAttribute('data-section');
            menuItems.forEach(function(i) { i.classList.remove('active'); });
            this.classList.add('active');
            sections.forEach(function(section) { section.classList.remove('active-section'); });
            document.getElementById(sectionId + '-section').classList.add('active-section');
        });
    });
    
    function showToast(message, isError) {
        const toast = $('<div class="toast-message">' + message + '</div>');
        if (isError) toast.css('background', '#dc3545');
        $('body').append(toast);
        setTimeout(function() { toast.remove(); }, 3000);
    }
    
    function loadStudents() {
        const batch = $('#batchSelect').val();
        if (!batch) {
            showToast('Please select a batch!', true);
            return;
        }
        
        // Use sample data instead of AJAX for testing
        const sampleStudents = {
            'Java': [
                { id: 1, name: 'Alice Brown', enrollmentNo: 'SIT001' },
                { id: 2, name: 'Bob Wilson', enrollmentNo: 'SIT002' },
                { id: 3, name: 'Charlie Davis', enrollmentNo: 'SIT003' }
            ],
            'Python': [
                { id: 4, name: 'David Miller', enrollmentNo: 'SIT004' },
                { id: 5, name: 'Emma Watson', enrollmentNo: 'SIT005' }
            ],
            'MERN': [
                { id: 6, name: 'Frank Ocean', enrollmentNo: 'SIT006' },
                { id: 7, name: 'Grace Lee', enrollmentNo: 'SIT007' }
            ],
            'Cloud': [
                { id: 8, name: 'Henry Ford', enrollmentNo: 'SIT008' },
                { id: 9, name: 'Ivy Chen', enrollmentNo: 'SIT009' }
            ],
            'Data Science': [
                { id: 10, name: 'Jack Sparrow', enrollmentNo: 'SIT010' }
            ],
            'AWS': [
                { id: 11, name: 'Kate Winslet', enrollmentNo: 'SIT011' }
            ]
        };
        
        currentStudents = sampleStudents[batch] || [];
        currentAttendanceStatus = {};
        displayStudentList();
    }
    
    function displayStudentList() {
        const tbody = $('#studentTableBody');
        tbody.empty();
        
        if (currentStudents.length === 0) {
            tbody.append('<tr><td colspan="3" style="text-align: center;">No students found in this batch</td></tr>');
            $('#studentListContainer').show();
            return;
        }
        
        for (let i = 0; i < currentStudents.length; i++) {
            const student = currentStudents[i];
            const isPresent = currentAttendanceStatus[student.id] === 'PRESENT';
            
            const row = '<tr>' +
                '<td>' + (student.enrollmentNo || 'N/A') + '</td>' +
                '<td>' + student.name + '</td>' +
                '<td style="text-align: center;"><input type="checkbox" class="attendance-checkbox" data-student-id="' + student.id + '" ' + (isPresent ? 'checked' : '') + '></td>' +
                '</tr>';
            tbody.append(row);
        }
        
        $('#studentListContainer').show();
    }
    
    function saveAttendance() {
        const batch = $('#batchSelect').val();
        const date = $('#attendanceDate').val();
        
        if (!batch || !date) {
            showToast('Please select batch and date!', true);
            return;
        }
        
        if (currentStudents.length === 0) {
            showToast('No students to mark attendance for!', true);
            return;
        }
        
        let presentCount = 0;
        $('.attendance-checkbox').each(function() {
            if ($(this).is(':checked')) {
                presentCount++;
            }
        });
        
        showToast('Attendance saved! ' + presentCount + ' students marked present.', false);
    }
</script>
</body>
</html>
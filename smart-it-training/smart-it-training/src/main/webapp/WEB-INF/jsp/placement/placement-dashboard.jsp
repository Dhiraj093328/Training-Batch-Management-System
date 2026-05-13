<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Training & Placement | Student Dashboard</title>
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
        .student-badge {
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
        
        .placement-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 20px;
        }
        .placement-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            border: 1px solid #e0e0e0;
        }
        .placement-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        .placement-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 15px 20px;
        }
        .placement-header h3 { font-size: 1.2rem; margin-bottom: 5px; }
        .placement-header .company { font-size: 0.85rem; opacity: 0.9; }
        .placement-body { padding: 20px; }
        .placement-detail {
            margin-bottom: 12px;
            display: flex;
            align-items: flex-start;
            gap: 10px;
        }
        .placement-detail i { width: 20px; color: #667eea; margin-top: 3px; }
        .placement-detail .detail-text { flex: 1; color: #555; font-size: 0.85rem; }
        .placement-footer {
            padding: 15px 20px;
            border-top: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .deadline { font-size: 0.75rem; color: #ff4444; }
        .deadline.available { color: #28a745; }
        .btn-apply {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 20px;
            cursor: pointer;
            font-weight: 500;
        }
        .btn-apply:hover { transform: scale(1.02); }
        .btn-applied {
            background: #6c757d;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 20px;
            cursor: not-allowed;
        }
        .btn-disabled {
            background: #dc3545;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 20px;
            cursor: not-allowed;
        }
        .applications-table {
            width: 100%;
            border-collapse: collapse;
        }
        .applications-table th, .applications-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        .applications-table th { background: #f8f9fa; font-weight: 600; }
        .status-pending { background: #ffc107; color: #856404; padding: 4px 10px; border-radius: 20px; font-size: 0.7rem; display: inline-block; }
        .status-shortlisted { background: #17a2b8; color: white; padding: 4px 10px; border-radius: 20px; font-size: 0.7rem; display: inline-block; }
        .status-selected { background: #28a745; color: white; padding: 4px 10px; border-radius: 20px; font-size: 0.7rem; display: inline-block; }
        .status-rejected { background: #dc3545; color: white; padding: 4px 10px; border-radius: 20px; font-size: 0.7rem; display: inline-block; }
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
            .placement-grid { grid-template-columns: 1fr; }
            .applications-table { font-size: 12px; }
            .applications-table th, .applications-table td { padding: 8px; }
        }
    </style>
</head>
<body>

<div class="dashboard-container">
    <div class="sidebar">
        <div class="sidebar-header">
            <div class="logo-icon">🎯</div>
            <h2>Training & Placement</h2>
            <p>Student Portal</p>
        </div>
        <div class="sidebar-menu">
            <div class="menu-item active" data-section="dashboard">
                <i class="fas fa-briefcase"></i> <span>Placements</span>
            </div>
            <div class="menu-item" data-section="applications">
                <i class="fas fa-file-alt"></i> <span>My Applications</span>
            </div>
        </div>
    </div>

    <div class="main-content">
        <div class="top-bar">
            <div class="welcome-text">
                <h3>Welcome, ${sessionScope.studentName}!</h3>
                <p><i class="fas fa-briefcase"></i> Training & Placement Portal</p>
            </div>
            <div class="student-badge">
                <i class="fas fa-id-card"></i> ${sessionScope.studentEnrollmentNo}
            </div>
            <div class="date-time">
                <div class="date" id="currentDate"></div>
                <div class="time" id="currentTime"></div>
            </div>
            <a href="${pageContext.request.contextPath}/placement/logout" class="logout-btn">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>

        <!-- Placements Section -->
        <div id="dashboard-section" class="content-section active-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-briefcase"></i> Current Job Openings</div>
                <div class="placement-grid" id="placementsGrid">
                    <c:forEach items="${placements}" var="placement">
                        <div class="placement-card" id="placement-${placement.id}">
                            <div class="placement-header">
                                <h3>${placement.jobRole}</h3>
                                <div class="company">${placement.companyName}</div>
                            </div>
                            <div class="placement-body">
                                <div class="placement-detail">
                                    <i class="fas fa-align-left"></i>
                                    <div class="detail-text">${placement.jobRoleDescription}</div>
                                </div>
                                <div class="placement-detail">
                                    <i class="fas fa-code"></i>
                                    <div class="detail-text"><strong>Skills:</strong> ${placement.requiredSkills}</div>
                                </div>
                                <div class="placement-detail">
                                    <i class="fas fa-comments"></i>
                                    <div class="detail-text"><strong>Interview Rounds:</strong> ${placement.interviewRounds}</div>
                                </div>
                                <div class="placement-detail">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <div class="detail-text"><strong>Location:</strong> ${placement.location}</div>
                                </div>
                                <c:if test="${placement.packageMin != null}">
                                    <div class="placement-detail">
                                        <i class="fas fa-rupee-sign"></i>
                                        <div class="detail-text"><strong>CTC:</strong> ${placement.packageMin} - ${placement.packageMax} LPA</div>
                                    </div>
                                </c:if>
                            </div>
                            <div class="placement-footer">
                                <div class="deadline ${placement.lastDateToApply >= today ? 'available' : ''}">
                                    <i class="fas fa-calendar-alt"></i> Apply by: ${placement.lastDateToApply}
                                </div>
                                <c:choose>
                                    <c:when test="${appliedPlacementIds.contains(placement.id)}">
                                        <button class="btn-applied" disabled><i class="fas fa-check"></i> Applied</button>
                                    </c:when>
                                    <c:when test="${placement.lastDateToApply >= today}">
                                        <button class="btn-apply" onclick="applyForPlacement(${placement.id})">Apply Now</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn-disabled" disabled><i class="fas fa-times"></i> Closed</button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty placements}">
                        <div style="text-align: center; padding: 40px; grid-column: 1/-1;">
                            <i class="fas fa-info-circle" style="font-size: 48px; color: #667eea;"></i>
                            <p style="margin-top: 15px;">No active job openings at the moment. Please check back later.</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- My Applications Section -->
        <div id="applications-section" class="content-section">
            <div class="section-card">
                <div class="section-title"><i class="fas fa-file-alt"></i> My Applications</div>
                <div id="applicationsContainer">
                    <div style="text-align: center; padding: 40px;">
                        <i class="fas fa-spinner fa-pulse" style="font-size: 32px; color: #667eea;"></i>
                        <p>Loading your applications...</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    let appliedPlacementIds = new Set(${appliedPlacementIds});
    
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
            
            if (sectionId === 'applications') {
                loadMyApplications();
            }
        });
    });
    
    function showToast(message, isError) {
        const toast = $('<div class="toast-message">' + message + '</div>');
        if (isError) toast.css('background', '#dc3545');
        $('body').append(toast);
        setTimeout(() => toast.remove(), 3000);
    }
    
    function applyForPlacement(placementId) {
        if (!confirm('Are you sure you want to apply for this position?')) return;
        
        $.ajax({
            url: '${pageContext.request.contextPath}/placement/apply',
            type: 'POST',
            data: { placementId: placementId },
            success: function(response) {
                if (response.success) {
                    showToast(response.message);
                    $('#placement-' + placementId + ' .btn-apply').replaceWith('<button class="btn-applied" disabled><i class="fas fa-check"></i> Applied</button>');
                    appliedPlacementIds.add(placementId);
                } else {
                    showToast(response.message, true);
                }
            },
            error: function() { showToast('Error applying for placement!', true); }
        });
    }
    
    function loadMyApplications() {
        $.ajax({
            url: '${pageContext.request.contextPath}/placement/my-applications',
            type: 'GET',
            success: function(response) {
                if (response.success && response.applications.length > 0) {
                    let html = '<table class="applications-table">' +
                        '<thead><tr><th>Company</th><th>Position</th><th>Applied On</th><th>Last Date</th><th>Status</th></tr></thead><tbody>';
                    response.applications.forEach(app => {
                        const statusClass = 'status-' + app.status.toLowerCase();
                        html += '<tr>' +
                            '<td>' + app.companyName + '</td>' +
                            '<td>' + app.jobRole + '</td>' +
                            '<td>' + new Date(app.appliedAt).toLocaleDateString() + '</td>' +
                            '<td>' + new Date(app.lastDate).toLocaleDateString() + '</td>' +
                            '<td><span class="' + statusClass + '">' + app.status + '</span></td>' +
                            '</tr>';
                    });
                    html += '</tbody></table>';
                    $('#applicationsContainer').html(html);
                } else {
                    $('#applicationsContainer').html('<div style="text-align: center; padding: 40px;"><i class="fas fa-inbox" style="font-size: 48px; color: #667eea;"></i><p style="margin-top: 15px;">You haven\'t applied for any positions yet.</p></div>');
                }
            },
            error: function() { $('#applicationsContainer').html('<div style="text-align: center; padding: 40px; color: red;">Error loading applications</div>'); }
        });
    }
</script>
</body>
</html>
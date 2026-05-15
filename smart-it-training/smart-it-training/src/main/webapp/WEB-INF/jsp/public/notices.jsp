<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>E-Notice Board | Smart IT Training</title>
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
        .header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 60px 20px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: rgba(255,255,255,0.1);
            transform: rotate(45deg);
            pointer-events: none;
        }
        .header h1 { font-size: 2.5rem; margin-bottom: 10px; animation: fadeInDown 0.6s ease; }
        .header p { opacity: 0.9; animation: fadeInUp 0.6s ease; }
        .container { max-width: 1200px; margin: 0 auto; padding: 40px 20px; }
        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 25px;
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            padding: 10px 20px;
            background: white;
            border-radius: 10px;
            transition: all 0.3s ease;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        .back-btn:hover { 
            background: #667eea; 
            color: white; 
            transform: translateX(-5px);
            box-shadow: 0 5px 15px rgba(102,126,234,0.3);
        }
        .stats-bar {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }
        .stat-box {
            background: white;
            padding: 12px 20px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        .stat-box i { font-size: 1.5rem; color: #667eea; }
        .stat-box span { font-weight: 600; color: #333; }
        .refresh-btn {
            margin-left: auto;
            background: #28a745;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 8px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
        }
        .refresh-btn:hover { background: #218838; transform: rotate(180deg); }
        .notices-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 25px;
            animation: fadeIn 0.5s ease;
        }
        .notice-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            position: relative;
        }
        .notice-card:hover { 
            transform: translateY(-8px); 
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }
        .notice-header {
            padding: 20px;
            border-bottom: 1px solid #eee;
            position: relative;
            background: linear-gradient(135deg, #f8f9fa, #fff);
        }
        .notice-header.urgent { 
            background: linear-gradient(135deg, #fff3cd, #ffeaa7);
            border-left: 4px solid #ffc107;
        }
        .notice-category {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 4px 12px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border-radius: 20px;
            font-size: 0.7rem;
            margin-bottom: 10px;
        }
        .notice-title { 
            font-size: 1.25rem; 
            font-weight: 600; 
            color: #333; 
            margin-bottom: 8px;
            line-height: 1.4;
        }
        .notice-date {
            font-size: 0.7rem;
            color: #999;
            display: flex;
            align-items: center;
            gap: 8px;
            margin-top: 10px;
            flex-wrap: wrap;
        }
        .urgent-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: #ffc107;
            color: #856404;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.7rem;
            font-weight: 600;
            animation: pulse 1.5s infinite;
        }
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }
        .notice-body { padding: 20px; }
        .notice-content { 
            color: #555; 
            line-height: 1.6; 
            margin-bottom: 15px;
            word-wrap: break-word;
        }
        .notice-footer {
            padding: 15px 20px;
            background: #f8f9fa;
            border-top: 1px solid #eee;
            font-size: 0.75rem;
            color: #999;
            display: flex;
            justify-content: flex-end;
            flex-wrap: wrap;
            gap: 10px;
        }
        .no-notices {
            text-align: center;
            padding: 60px;
            background: white;
            border-radius: 15px;
            grid-column: 1/-1;
            animation: fadeIn 0.5s ease;
        }
        .no-notices i { font-size: 64px; color: #ddd; margin-bottom: 20px; }
        .loading {
            text-align: center;
            padding: 60px;
            grid-column: 1/-1;
        }
        .loading i { font-size: 48px; color: #667eea; animation: spin 1s linear infinite; }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @media (max-width: 768px) {
            .header h1 { font-size: 1.8rem; }
            .notices-grid { grid-template-columns: 1fr; }
            .stats-bar { flex-direction: column; }
            .refresh-btn { margin-left: 0; }
        }
        .toast-message {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: #28a745;
            color: white;
            padding: 12px 20px;
            border-radius: 10px;
            z-index: 1000;
            animation: slideInRight 0.3s ease;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
    </style>
</head>
<body>
    <div class="header">
        <i class="fas fa-bullhorn" style="font-size: 50px; margin-bottom: 15px;"></i>
        <h1>📢 E-Notice Board</h1>
        <p>Stay updated with latest announcements and notifications</p>
    </div>
    
    <div class="container">
        <div class="stats-bar">
            <a href="${pageContext.request.contextPath}/menu" class="back-btn">
                <i class="fas fa-arrow-left"></i> Back to Menu
            </a>
            <div class="stat-box">
                <i class="fas fa-newspaper"></i>
                <span>Total Notices: <span id="totalNotices">${totalNotices != null ? totalNotices : 0}</span></span>
            </div>
            <div class="stat-box">
                <i class="fas fa-exclamation-triangle"></i>
                <span>Urgent: <span id="urgentCount">0</span></span>
            </div>
            <button class="refresh-btn" onclick="refreshNotices()">
                <i class="fas fa-sync-alt"></i> Refresh
            </button>
        </div>
        
        <div id="noticesContainer" class="notices-grid">
            <c:choose>
                <c:when test="${not empty notices}">
                    <c:forEach items="${notices}" var="notice">
                        <div class="notice-card" data-id="${notice.id}">
                            <div class="notice-header ${notice.isUrgent ? 'urgent' : ''}">
                                <c:if test="${notice.isUrgent}">
                                    <span class="urgent-badge"><i class="fas fa-exclamation-triangle"></i> URGENT</span>
                                </c:if>
                                <div class="notice-category">
                                    <i class="fas fa-tag"></i> ${notice.category}
                                </div>
                                <h3 class="notice-title">${notice.title}</h3>
                                <div class="notice-date">
                                    <span><i class="fas fa-calendar-alt"></i> 
                                        Published: ${notice.formattedDate != null ? notice.formattedDate : notice.createdAt}
                                    </span>
                                </div>
                            </div>
                            <div class="notice-body">
                                <div class="notice-content">${notice.content}</div>
                            </div>
                            <c:if test="${notice.expiryDate != null}">
                                <div class="notice-footer">
                                    <span><i class="fas fa-hourglass-end"></i> 
                                        Valid till: ${notice.expiryDateFormatted != null ? notice.expiryDateFormatted : notice.expiryDate}
                                    </span>
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-notices">
                        <i class="fas fa-bell-slash"></i>
                        <h3>No Notices Available</h3>
                        <p style="margin-top: 10px;">There are no notices at the moment. Please check back later.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>
        let autoRefreshInterval;
        
        $(document).ready(function() {
            updateUrgentCount();
            startAutoRefresh();
        });
        
        function updateUrgentCount() {
            const urgentCount = $('.notice-card .urgent-badge').length;
            $('#urgentCount').text(urgentCount);
        }
        
        function showToast(message, type = 'success') {
            const toast = $('<div class="toast-message">' + message + '</div>');
            if (type === 'error') toast.css('background', '#dc3545');
            else if (type === 'info') toast.css('background', '#17a2b8');
            else toast.css('background', '#28a745');
            $('body').append(toast);
            setTimeout(() => toast.fadeOut(300, () => toast.remove()), 3000);
        }
        
        function refreshNotices() {
            $('#noticesContainer').html('<div class="loading"><i class="fas fa-spinner fa-spin"></i><p>Loading notices...</p></div>');
            
            $.ajax({
                url: '${pageContext.request.contextPath}/notice/api/notices',
                type: 'GET',
                dataType: 'json',
                success: function(response) {
                    if (response.success && response.notices && response.notices.length > 0) {
                        displayNotices(response.notices);
                        $('#totalNotices').text(response.notices.length);
                        showToast('Notices refreshed successfully!', 'success');
                    } else if (response.success && (!response.notices || response.notices.length === 0)) {
                        displayEmptyState();
                        $('#totalNotices').text(0);
                        showToast('No notices available', 'info');
                    } else {
                        displayEmptyState();
                        showToast(response.error || 'Error loading notices', 'error');
                    }
                    updateUrgentCount();
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                    displayEmptyState();
                    showToast('Failed to load notices. Please try again.', 'error');
                }
            });
        }
        
        function displayNotices(notices) {
            let html = '';
            let urgentCount = 0;
            
            notices.forEach(function(notice) {
                const isUrgent = notice.isUrgent;
                if (isUrgent) urgentCount++;
                
                const urgentClass = isUrgent ? 'urgent' : '';
                const urgentBadge = isUrgent ? '<span class="urgent-badge"><i class="fas fa-exclamation-triangle"></i> URGENT</span>' : '';
                
                let footerHtml = '';
                if (notice.expiryDate) {
                    footerHtml = `<div class="notice-footer">
                                    <span><i class="fas fa-hourglass-end"></i> Valid till: ${notice.expiryDate}</span>
                                </div>`;
                }
                
                html += `
                    <div class="notice-card" data-id="` + notice.id + `">
                        <div class="notice-header ` + urgentClass + `">
                            ` + urgentBadge + `
                            <div class="notice-category">
                                <i class="fas fa-tag"></i> ` + (notice.category || 'General') + `
                            </div>
                            <h3 class="notice-title">` + escapeHtml(notice.title) + `</h3>
                            <div class="notice-date">
                                <span><i class="fas fa-calendar-alt"></i> 
                                    Published: ` + (notice.formattedDate || new Date(notice.createdAt).toLocaleString()) + `
                                </span>
                            </div>
                        </div>
                        <div class="notice-body">
                            <div class="notice-content">` + escapeHtml(notice.content) + `</div>
                        </div>
                        ` + footerHtml + `
                    </div>
                `;
            });
            
            $('#noticesContainer').html(html);
            $('#urgentCount').text(urgentCount);
        }
        
        function displayEmptyState() {
            $('#noticesContainer').html(`
                <div class="no-notices">
                    <i class="fas fa-bell-slash"></i>
                    <h3>No Notices Available</h3>
                    <p style="margin-top: 10px;">There are no notices at the moment. Please check back later.</p>
                </div>
            `);
            $('#urgentCount').text(0);
        }
        
        function escapeHtml(text) {
            if (!text) return '';
            const div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }
        
        function startAutoRefresh() {
            if (autoRefreshInterval) clearInterval(autoRefreshInterval);
            autoRefreshInterval = setInterval(function() {
                refreshNotices();
            }, 30000); // Refresh every 30 seconds
        }
        
        function stopAutoRefresh() {
            if (autoRefreshInterval) {
                clearInterval(autoRefreshInterval);
                autoRefreshInterval = null;
            }
        }
        
        // Optional: Stop auto-refresh when page is hidden
        document.addEventListener('visibilitychange', function() {
            if (document.hidden) {
                stopAutoRefresh();
            } else {
                startAutoRefresh();
                refreshNotices();
            }
        });
    </script>
</body>
</html>
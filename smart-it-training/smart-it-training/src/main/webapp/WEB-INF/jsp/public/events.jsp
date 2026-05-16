<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Events | Smart IT Training</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
        }
        .header h1 { font-size: 2.5rem; margin-bottom: 10px; }
        .header p { opacity: 0.9; }
        .stats-bar {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-top: 20px;
            flex-wrap: wrap;
        }
        .stat-item {
            background: rgba(255,255,255,0.2);
            padding: 8px 20px;
            border-radius: 30px;
            font-size: 0.9rem;
        }
        .container { max-width: 1200px; margin: 0 auto; padding: 40px 20px; }
        .back-btn {
            display: inline-block;
            margin-bottom: 20px;
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
        }
        .back-btn:hover { text-decoration: underline; }
        .events-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
        }
        .event-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
        }
        .event-card:hover { transform: translateY(-5px); box-shadow: 0 10px 25px rgba(0,0,0,0.15); }
        .event-card.featured { border: 2px solid #ffc107; }
        .event-header {
            padding: 20px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            position: relative;
        }
        .featured-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: #ffc107;
            color: #856404;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.7rem;
            font-weight: 600;
        }
        .event-status {
            position: absolute;
            top: 15px;
            left: 15px;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.7rem;
            font-weight: 600;
        }
        .status-upcoming { background: #17a2b8; color: white; }
        .status-today { background: #28a745; color: white; }
        .status-completed { background: #6c757d; color: white; }
        .event-category {
            display: inline-block;
            padding: 4px 12px;
            background: rgba(255,255,255,0.2);
            border-radius: 20px;
            font-size: 0.7rem;
            margin-bottom: 10px;
        }
        .event-title { font-size: 1.2rem; font-weight: 600; margin-bottom: 8px; margin-top: 25px; }
        .event-datetime {
            font-size: 0.8rem;
            opacity: 0.9;
            display: flex;
            gap: 15px;
            margin-top: 10px;
        }
        .event-body { padding: 20px; }
        .event-description { color: #555; line-height: 1.6; margin-bottom: 15px; }
        .event-location {
            display: inline-block;
            padding: 5px 12px;
            background: #f0f2f5;
            border-radius: 20px;
            font-size: 0.8rem;
            color: #667eea;
            margin-bottom: 10px;
        }
        .event-footer {
            padding: 15px 20px;
            background: #f8f9fa;
            border-top: 1px solid #eee;
            font-size: 0.75rem;
            color: #999;
            display: flex;
            justify-content: space-between;
        }
        .no-events {
            text-align: center;
            padding: 60px;
            background: white;
            border-radius: 15px;
            grid-column: 1/-1;
        }
        .tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 30px;
            border-bottom: 2px solid #e0e0e0;
        }
        .tab-btn {
            padding: 12px 24px;
            background: none;
            border: none;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 500;
            color: #666;
            transition: all 0.3s;
        }
        .tab-btn.active {
            color: #667eea;
            border-bottom: 2px solid #667eea;
        }
        .tab-content {
            display: none;
        }
        .tab-content.active {
            display: block;
        }
        @media (max-width: 768px) {
            .header h1 { font-size: 1.8rem; }
            .events-grid { grid-template-columns: 1fr; }
            .stats-bar { gap: 15px; }
            .stat-item { font-size: 0.75rem; }
        }
    </style>
</head>
<body>
    <div class="header">
        <i class="fas fa-calendar-alt" style="font-size: 50px; margin-bottom: 15px;"></i>
        <h1>🎯 Events & Workshops</h1>
        <p>Join our workshops, seminars, and training sessions</p>
        <div class="stats-bar">
            <div class="stat-item"><i class="fas fa-calendar"></i> Total: ${totalEvents} Events</div>
            <div class="stat-item"><i class="fas fa-star"></i> Featured: ${featuredCount}</div>
            <div class="stat-item"><i class="fas fa-clock"></i> Upcoming: ${upcomingEvents}</div>
        </div>
    </div>
    
    <div class="container">
        <a href="${pageContext.request.contextPath}/menu" class="back-btn">
            <i class="fas fa-arrow-left"></i> Back to Menu
        </a>
        
        <div class="tabs">
            <button class="tab-btn active" onclick="showTab('all')">All Events</button>
            <button class="tab-btn" onclick="showTab('upcoming')">Upcoming</button>
            <button class="tab-btn" onclick="showTab('featured')">Featured</button>
        </div>
        
        <div id="all-tab" class="tab-content active">
            <div class="events-grid">
                <c:forEach items="${events}" var="event">
                    <div class="event-card ${event.isFeatured ? 'featured' : ''}">
                        <div class="event-header">
                            <div class="event-status status-${event.status.toLowerCase()}">
                                <c:choose>
                                    <c:when test="${event.status == 'Today'}"><i class="fas fa-play"></i> Today</c:when>
                                    <c:when test="${event.status == 'Upcoming'}"><i class="fas fa-calendar-week"></i> Upcoming</c:when>
                                    <c:otherwise><i class="fas fa-check-circle"></i> Completed</c:otherwise>
                                </c:choose>
                            </div>
                            <c:if test="${event.isFeatured}">
                                <span class="featured-badge"><i class="fas fa-star"></i> FEATURED</span>
                            </c:if>
                            <div class="event-category">${event.category}</div>
                            <h3 class="event-title">${event.title}</h3>
                            <div class="event-datetime">
                                <span><i class="fas fa-calendar-day"></i> ${event.formattedEventDate}</span>
                                <span><i class="fas fa-clock"></i> ${event.eventTime}</span>
                            </div>
                        </div>
                        <div class="event-body">
                            <div class="event-location">
                                <i class="fas fa-map-marker-alt"></i> ${event.location}
                            </div>
                            <div class="event-description">${event.description}</div>
                            <c:if test="${event.maxParticipants != null}">
                                <div style="font-size: 0.8rem; color: #666; margin-top: 10px;">
                                    <i class="fas fa-users"></i> Max: ${event.maxParticipants} participants
                                </div>
                            </c:if>
                        </div>
                        <div class="event-footer">
                            <c:if test="${event.formattedDeadline != null}">
                                <span><i class="fas fa-hourglass-half"></i> Register by: ${event.formattedDeadline}</span>
                            </c:if>
                            <c:if test="${event.formattedDeadline == null}">
                                <span><i class="fas fa-ticket-alt"></i> Open Registration</span>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty events}">
                    <div class="no-events">
                        <i class="fas fa-calendar-times" style="font-size: 48px; color: #999;"></i>
                        <p style="margin-top: 15px;">No events available at the moment.</p>
                        <p style="font-size: 0.85rem;">Check back later for exciting events!</p>
                    </div>
                </c:if>
            </div>
        </div>
        
        <div id="upcoming-tab" class="tab-content">
            <div class="events-grid">
                <c:forEach items="${events}" var="event">
                    <c:if test="${event.status == 'Upcoming' or event.status == 'Today'}">
                        <div class="event-card ${event.isFeatured ? 'featured' : ''}">
                            <div class="event-header">
                                <div class="event-status status-${event.status.toLowerCase()}">
                                    <c:choose>
                                        <c:when test="${event.status == 'Today'}"><i class="fas fa-play"></i> Today</c:when>
                                        <c:otherwise><i class="fas fa-calendar-week"></i> Upcoming</c:otherwise>
                                    </c:choose>
                                </div>
                                <c:if test="${event.isFeatured}">
                                    <span class="featured-badge"><i class="fas fa-star"></i> FEATURED</span>
                                </c:if>
                                <div class="event-category">${event.category}</div>
                                <h3 class="event-title">${event.title}</h3>
                                <div class="event-datetime">
                                    <span><i class="fas fa-calendar-day"></i> ${event.formattedEventDate}</span>
                                    <span><i class="fas fa-clock"></i> ${event.eventTime}</span>
                                </div>
                            </div>
                            <div class="event-body">
                                <div class="event-location">
                                    <i class="fas fa-map-marker-alt"></i> ${event.location}
                                </div>
                                <div class="event-description">${event.description}</div>
                                <c:if test="${event.maxParticipants != null}">
                                    <div style="font-size: 0.8rem; color: #666; margin-top: 10px;">
                                        <i class="fas fa-users"></i> Max: ${event.maxParticipants} participants
                                    </div>
                                </c:if>
                            </div>
                            <div class="event-footer">
                                <c:if test="${event.formattedDeadline != null}">
                                    <span><i class="fas fa-hourglass-half"></i> Register by: ${event.formattedDeadline}</span>
                                </c:if>
                                <c:if test="${event.formattedDeadline == null}">
                                    <span><i class="fas fa-ticket-alt"></i> Open Registration</span>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
                <c:if test="${empty events}">
                    <div class="no-events">
                        <i class="fas fa-calendar-times" style="font-size: 48px; color: #999;"></i>
                        <p style="margin-top: 15px;">No upcoming events at the moment.</p>
                    </div>
                </c:if>
            </div>
        </div>
        
        <div id="featured-tab" class="tab-content">
            <div class="events-grid">
                <c:forEach items="${events}" var="event">
                    <c:if test="${event.isFeatured}">
                        <div class="event-card featured">
                            <div class="event-header">
                                <div class="event-status status-${event.status.toLowerCase()}">
                                    <c:choose>
                                        <c:when test="${event.status == 'Today'}"><i class="fas fa-play"></i> Today</c:when>
                                        <c:when test="${event.status == 'Upcoming'}"><i class="fas fa-calendar-week"></i> Upcoming</c:when>
                                        <c:otherwise><i class="fas fa-check-circle"></i> Completed</c:otherwise>
                                    </c:choose>
                                </div>
                                <span class="featured-badge"><i class="fas fa-star"></i> FEATURED</span>
                                <div class="event-category">${event.category}</div>
                                <h3 class="event-title">${event.title}</h3>
                                <div class="event-datetime">
                                    <span><i class="fas fa-calendar-day"></i> ${event.formattedEventDate}</span>
                                    <span><i class="fas fa-clock"></i> ${event.eventTime}</span>
                                </div>
                            </div>
                            <div class="event-body">
                                <div class="event-location">
                                    <i class="fas fa-map-marker-alt"></i> ${event.location}
                                </div>
                                <div class="event-description">${event.description}</div>
                            </div>
                            <div class="event-footer">
                                <span><i class="fas fa-star"></i> Featured Event</span>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
                <c:if test="${empty events}">
                    <div class="no-events">
                        <i class="fas fa-star" style="font-size: 48px; color: #999;"></i>
                        <p style="margin-top: 15px;">No featured events at the moment.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <script>
        function showTab(tabName) {
            // Hide all tabs
            document.querySelectorAll('.tab-content').forEach(tab => {
                tab.classList.remove('active');
            });
            // Remove active class from all buttons
            document.querySelectorAll('.tab-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            // Show selected tab
            document.getElementById(tabName + '-tab').classList.add('active');
            // Add active class to clicked button
            event.target.classList.add('active');
        }
    </script>
</body>
</html>
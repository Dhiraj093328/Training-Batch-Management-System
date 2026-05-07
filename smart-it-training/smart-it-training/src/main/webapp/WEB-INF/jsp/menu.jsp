<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">

<head>
    <title>Smart IT Training Centre - Menu</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes" />
    
    <!-- External CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css">
</head>

<body>

    <!-- ULTRA ATTRACTIVE IT BACKGROUND -->
    <div class="hyper-it-bg">
        <div class="circuit-lines"></div>
        <div class="binary-rain"></div>
        <div class="tech-orb orb-cyan-big"></div>
        <div class="tech-orb orb-magenta-big"></div>
        <div class="tech-orb orb-gold-big"></div>
        <div class="tech-orb orb-purple-big"></div>
        <div class="tech-orb orb-green-big"></div>
        <div class="scan-glow"></div>
    </div>

    <div class="page">
        <!-- Header with Smart IT Logo Image -->
        <div class="header-cyber">
            <table cellpadding="8" cellspacing="5" style="width:100%; color:#fff;">
                <tr>
                    <td style="width:120px; text-align:center;">
                        <img src="${pageContext.request.contextPath}/images/logo.png" alt="Smart IT Logo" class="smart-logo" 
                             onerror="this.src='https://via.placeholder.com/90x90?text=Smart+IT'"/>
                    </td>
                    <td style="text-align: center;">
                        <div style="font-size: 0.75rem; letter-spacing: 2px; opacity:0.9; color:#00ffcc;">⚡ TRAINING
                            BATCH MANAGEMENT SYSTEM ⚡</div>
                        <div style="font-size: 2rem; font-weight: 800; margin: 6px 0; text-shadow: 0 0 15px #00ffcc;">
                            Smart IT Training Center</div>
                    </td>
                    <td style="width:120px; text-align:center;">
                        <div class="date-time" id="currentDateTime" style="font-size:0.7rem; color:#00ffcc;"></div>
                    </td>
                </tr>
            </table>
        </div>

        <div class="main" style="padding: 0px 28px 20px 28px;">
            <!-- Live Support Bar -->
            <div class="support-bar"
                style="display: flex; flex-wrap: wrap; align-items: center; justify-content: space-between; padding: 5px 25px;">
                <div style="flex:1; overflow: hidden; padding: 8px 0;">
                    <marquee behavior="scroll" direction="left" scrollamount="5" onmouseover="this.stop();"
                        onmouseout="this.start();">
                        🟢 24x7 Live Support : (+91) 7420070217 | (+91) 9545161724 | (+91) 8999419776 | ✉️
                        support@smartittrainingcentre.com | 🌐 Live Chat Active
                    </marquee>
                </div>
                <div style="background:#00ffcc33; border-radius: 60px; padding: 5px 18px; border:1px solid #00ffcc;">
                    <span style="color:#00ffcc; font-weight: 800;">💬 24/7 HELPDESK</span>
                </div>
            </div>

            <!-- Back to Home Button -->
            <div style="margin: 20px 0 10px;">
                <a href="${pageContext.request.contextPath}/" class="home-link-modern" style="display: inline-block;">🏠 Back to Home</a>
            </div>

            <!-- ACADEMIC EXCELLENCE MODULES -->
            <div style="display: flex; justify-content: center; margin-top: 36px;">
                <div class="section-header"><span>📚 ACADEMIC EXCELLENCE MODULES</span></div>
            </div>
            <table style="width:100%; margin-top: 20px;" align="center" cellpadding="15">
                <tr>
                    <td class="style27">
                        <div class="module-card" data-module="Attendance Management" onclick="window.location.href='${pageContext.request.contextPath}/attendance/login'">
                            <img src="${pageContext.request.contextPath}/images/Attendance.png" alt="Attendance" class="card-image-cover"
                                onerror="this.src='https://via.placeholder.com/300x200?text=Attendance+Module'" />
                            <div class="card-btn-overlay">
                                <button class="butt-overlay" onclick="event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/attendance/login'">📋 Attendance Management</button>
                            </div>
                        </div>
                    </td>
                    <td class="style27">
                        <div class="module-card" data-module="Online Examination" onclick="window.location.href='${pageContext.request.contextPath}/exam/login'">
                            <img src="${pageContext.request.contextPath}/images/Result.png" alt="Exam" class="card-image-cover"
                                onerror="this.src='https://via.placeholder.com/300x200?text=Exam+Module'" />
                            <div class="card-btn-overlay">
                                <button class="butt-overlay" onclick="event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/exam/login'">📝 Online Exam</button>
                            </div>
                        </div>
                    </td>
                    <td class="style27">
                        <div class="module-card" data-module="Feedback Management" onclick="window.location.href='${pageContext.request.contextPath}/feedback'">
                            <img src="${pageContext.request.contextPath}/images/feedback.png" alt="Feedback" class="card-image-cover"
                                onerror="this.src='https://via.placeholder.com/300x200?text=Feedback+Module'" />
                            <div class="card-btn-overlay">
                                <button class="butt-overlay" onclick="event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/feedback'">📢 Feedback Management</button>
                            </div>
                        </div>
                    </td>
                    <td class="style27">
                        <div class="module-card" data-module="E-Notice Management" onclick="window.location.href='${pageContext.request.contextPath}/notice/view'">
                            <img src="${pageContext.request.contextPath}/images/Notice.png" alt="E-Notice" class="card-image-cover"
                                onerror="this.src='https://via.placeholder.com/300x200?text=Notice+Module'" />
                            <div class="card-btn-overlay">
                                <button class="butt-overlay" onclick="event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/notice/view'">📢 E-Notice Management</button>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>

            <!-- ADMINISTRATIVE & OPERATIONS HUB -->
            <div style="display: flex; justify-content: center; margin-top: 36px;">
                <div class="section-header"><span>🏛️ ADMINISTRATIVE & OPERATIONS HUB</span></div>
            </div>
            <table style="width:100%; margin-top: 8px;" align="center" cellpadding="15">
                <tr>
                    <td class="style27">
                        <div class="module-card" data-module="Administrative Office" onclick="window.location.href='${pageContext.request.contextPath}/admin/login'">
                            <img src="${pageContext.request.contextPath}/images/Administrative.png" alt="Admin Office" class="card-image-cover"
                                onerror="this.src='https://via.placeholder.com/300x200?text=Admin+Office'" />
                            <div class="card-btn-overlay">
                                <button class="butt-overlay" onclick="event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/admin/login'">🏢 Administrative Office</button>
                            </div>
                        </div>
                    </td>
                    <td class="style27">
                        <div class="module-card" data-module="Faculty Management" onclick="window.location.href='${pageContext.request.contextPath}/faculty/login'">
                            <img src="${pageContext.request.contextPath}/images/Faculty.png" alt="Faculty" class="card-image-cover"
                                onerror="this.src='https://via.placeholder.com/300x200?text=Faculty+Module'" />
                            <div class="card-btn-overlay">
                                <button class="butt-overlay" onclick="event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/faculty/login'">👩‍🏫 Faculty Management</button>
                            </div>
                        </div>
                    </td>
                    <td class="style27">
                        <div class="module-card" data-module="Courses & Brochures" onclick="window.location.href='${pageContext.request.contextPath}/courses'">
                            <img src="${pageContext.request.contextPath}/images/Browchers.png" alt="Courses" class="card-image-cover"
                                onerror="this.src='https://via.placeholder.com/300x200?text=Course+Brochure'" />
                            <div class="card-btn-overlay">
                                <button class="butt-overlay" onclick="event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/courses'">📘 Courses & Brochures</button>
                            </div>
                        </div>
                    </td>
                    <td class="style27">
                        <div class="module-card" data-module="Account Management System" onclick="window.location.href='${pageContext.request.contextPath}/account/login'">
                            <img src="${pageContext.request.contextPath}/images/Account.png" alt="Account" class="card-image-cover"
                                onerror="this.src='https://via.placeholder.com/300x200?text=Accounts+Module'" />
                            <div class="card-btn-overlay">
                                <button class="butt-overlay" onclick="event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/account/login'">💰 Account Management</button>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>

            <!-- CAREER & STUDENT ENGAGEMENT -->
            <div style="display: flex; justify-content: center; margin-top: 36px;">
                <div class="section-header"><span>🎯 CAREER & STUDENT ENGAGEMENT</span></div>
            </div>
            <table style="width:100%;" align="center" cellpadding="15">
                <tr>
                    <td class="style27">
                        <div class="module-card" data-module="Training And Placement" onclick="window.location.href='${pageContext.request.contextPath}/placement/login'">
                            <img src="${pageContext.request.contextPath}/images/Training and placement.png" alt="Placement" class="card-image-cover"
                                onerror="this.src='https://via.placeholder.com/300x200?text=Training+Placement'" />
                            <div class="card-btn-overlay">
                                <button class="butt-overlay" onclick="event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/placement/login'">🎓 Training & Placement</button>
                            </div>
                        </div>
                    </td>
                    <td class="style27">
                        <div class="module-card" data-module="Student Portal" onclick="window.location.href='${pageContext.request.contextPath}/student/login'">
                            <img src="${pageContext.request.contextPath}/images/Student Portal.png" alt="Student Portal" class="card-image-cover"
                                onerror="this.src='https://via.placeholder.com/300x200?text=Student+Portal'" />
                            <div class="card-btn-overlay">
                                <button class="butt-overlay" onclick="event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/student/login'">👨‍🎓 Student Portal</button>
                            </div>
                        </div>
                    </td>
                    <td class="style27">
                        <div class="module-card" data-module="Fun And Events Management" onclick="window.location.href='${pageContext.request.contextPath}/events'">
                            <img src="${pageContext.request.contextPath}/images/Fun.png" alt="Fun & Events" class="card-image-cover"
                                onerror="this.src='https://via.placeholder.com/300x200?text=Events+Module'" />
                            <div class="card-btn-overlay">
                                <button class="butt-overlay" onclick="event.stopPropagation(); window.location.href='${pageContext.request.contextPath}/events'">🎉 Events Management</button>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>

            <!-- CONNECT WITH US SECTION -->
            <div class="connect-wrapper"
                style="display: flex; flex-wrap: wrap; justify-content: space-between; align-items: center;">
                <div
                    style="font-size: 1.5rem; font-weight: 800; background: linear-gradient(125deg, #00ffcc, #00aaff); background-clip: text; -webkit-background-clip: text; color: transparent;">
                    🌟 Connect & Follow Us
                </div>
                <div style="display: flex; gap: 22px; align-items: center; flex-wrap: wrap;">
                    <div class="social-icon-enhanced" data-social="Facebook" onclick="window.open('https://facebook.com/smartittraining', '_blank')">📘</div>
                    <div class="social-icon-enhanced" data-social="Twitter" onclick="window.open('https://twitter.com/smartittraining', '_blank')">𝕏</div>
                    <div class="social-icon-enhanced" data-social="LinkedIn" onclick="window.open('https://linkedin.com/company/smartittraining', '_blank')">in</div>
                    <div class="social-icon-enhanced" data-social="Instagram" onclick="window.open('https://instagram.com/smartittraining', '_blank')">📷</div>
                    <div class="social-icon-enhanced" data-social="YouTube" onclick="window.open('https://youtube.com/@smartittraining', '_blank')">▶️</div>
                    <div class="social-icon-enhanced" data-social="WhatsApp" onclick="window.open('https://wa.me/917420070217', '_blank')">💬</div>
                </div>
                <div><a href="${pageContext.request.contextPath}/" class="home-link-modern">🏠 Organization Home</a></div>
            </div>
        </div>

        <!-- FOOTER -->
        <div class="art-footer">
            <div class="footer-contact-line">
                <span>📧 helpdesk@smartittrainingcentre.com</span>
                <span>📞 +91 7420070217</span>
                <span>📍 Head Office: Indore, MP, India</span>
            </div>
            <p style="margin-top: 12px; font-size: 0.75rem;">© <span id="currentYear"></span> Smart IT Training Centre — All Rights Reserved.</p>
        </div>
    </div>

    <!-- External JavaScript -->
    <script src="${pageContext.request.contextPath}/js/menu.js"></script>
    
    <script>
        // Display current date and time
        function updateDateTime() {
            const now = new Date();
            const dateTimeStr = now.toLocaleString('en-IN', { 
                day: '2-digit', 
                month: '2-digit', 
                year: 'numeric',
                hour: '2-digit',
                minute: '2-digit',
                hour12: true 
            });
            const dateTimeElement = document.getElementById('currentDateTime');
            if (dateTimeElement) {
                dateTimeElement.innerHTML = '📅 ' + dateTimeStr;
            }
        }
        updateDateTime();
        setInterval(updateDateTime, 60000);
        
        // Set current year
        document.getElementById('currentYear').innerText = new Date().getFullYear();
        
        // Add click animation to all module cards
        document.querySelectorAll('.module-card').forEach(card => {
            card.addEventListener('click', function() {
                this.style.transform = 'scale(0.98)';
                setTimeout(() => {
                    this.style.transform = '';
                }, 200);
            });
        });
        
        // Add click animation to buttons
        document.querySelectorAll('.butt-overlay').forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.stopPropagation();
                this.style.transform = 'scale(0.95)';
                setTimeout(() => {
                    this.style.transform = '';
                }, 150);
            });
        });
    </script>
</body>
</html>
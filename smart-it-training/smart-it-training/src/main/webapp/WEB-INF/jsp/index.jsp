<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <title>LUMINA//CORE | The Art of Infinite IT</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,600;14..32,700;14..32,800&family=Space+Grotesk:wght@400;500;600;700&family=Playfair+Display:ital,wght@0,500;0,600;1,500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

    <div class="hero-slider">
        <div class="slider-track">
            <div class="slide slide-1"></div>
            <div class="slide slide-2"></div>
            <div class="slide slide-3"></div>
            <div class="slide slide-4"></div>
            <div class="slide slide-5"></div>
            <div class="slide slide-6"></div>
            <div class="slide slide-7"></div>
            <div class="slide slide-8"></div>
            <div class="slide slide-9"></div>
            <div class="slide slide-10"></div>
            <div class="slide slide-11"></div>
            <div class="slide slide-12"></div>
            <div class="slide slide-1"></div>
            <div class="slide slide-2"></div>
            <div class="slide slide-3"></div>
            <div class="slide slide-4"></div>
            <div class="slide slide-5"></div>
            <div class="slide slide-6"></div>
            <div class="slide slide-7"></div>
            <div class="slide slide-8"></div>
            <div class="slide slide-9"></div>
            <div class="slide slide-10"></div>
            <div class="slide slide-11"></div>
            <div class="slide slide-12"></div>
        </div>
    </div>
    
    <div class="prism-veil"></div>
    <div class="nebulae-glow"></div>
    <div class="hex-grid"></div>
    <canvas id="cosmicParticles"></canvas>
    <div class="orbital-rings"></div>
    
    <div class="hero-wrapper">
        <div class="poetry-container">
            <div class="badge">
                <div class="heartbeat"></div>
                <span>✦ INFINITE INTELLIGENCE ORCHESTRA ✦</span>
            </div>
            <h1>The Soul of<br>Conscious Infrastructure</h1>
            <div class="desc">
                Autonomous resilience • Cognitive automation • Quantum-ready fabric<br>
                Enter the living IT ecosystem — boundless, self-aware, eternal.
            </div>
            
            <!-- WORKING BUTTON TO OPEN MENU PAGE -->
            <button class="explore-btn" onclick="window.location.href='${pageContext.request.contextPath}/menu'">
                <span>Explore the Nexus</span>
                <span class="btn-icon">∞</span>
            </button>
            
            <div style="margin-top: 2.2rem; font-size: 0.7rem; opacity: 0.7; letter-spacing: 1.2px; font-family: monospace;">
                <span>⚡ 99.999% uptime • self-healing mesh • edge quantum intelligence ⚡</span>
            </div>
        </div>
    </div>
    
    <div class="stats-section">
        <div class="stat-item"><div class="stat-num">12K+</div><div class="stat-label">Students Trained</div></div>
        <div class="stat-item"><div class="stat-num">48</div><div class="stat-label">Expert Courses</div></div>
        <div class="stat-item"><div class="stat-num">96%</div><div class="stat-label">Job Placement</div></div>
        <div class="stat-item"><div class="stat-num">4.9★</div><div class="stat-label">Avg. Rating</div></div>
    </div>
    
    <div class="courses-section">
        <div class="section-heading">
            <h2>Elite IT Programs</h2>
            <p>Curated by industry architects — hands-on, immersive, career-ready</p>
        </div>
        <div class="itc-courses">
            <div class="course-card"><div class="course-icon">🌐</div><h3>Full-Stack Web Development</h3><p>Master HTML, CSS, JavaScript, React, Node.js and databases to build end-to-end apps.</p><div class="course-meta"><span class="course-level level-beginner">Beginner</span><span class="course-duration">6 months</span></div></div>
            <div class="course-card"><div class="course-icon">💻</div><h3>Java Backend Development</h3><p>Learn Spring Boot, REST APIs, JWT security, and build scalable backend systems.</p><div class="course-meta"><span class="course-level level-intermediate">Intermediate</span><span class="course-duration">5 months</span></div></div>
            <div class="course-card"><div class="course-icon">📊</div><h3>Data Science & ML</h3><p>Python, Pandas, Machine Learning and real-world data analysis projects.</p><div class="course-meta"><span class="course-level level-advanced">Advanced</span><span class="course-duration">6 months</span></div></div>
            <div class="course-card"><div class="course-icon">📱</div><h3>Android App Development</h3><p>Build modern mobile apps using Java/Kotlin with real-world projects.</p><div class="course-meta"><span class="course-level level-beginner">Beginner</span><span class="course-duration">4 months</span></div></div>
            <div class="course-card"><div class="course-icon">☁️</div><h3>Cloud Computing (AWS)</h3><p>Learn AWS services, deployment, and cloud architecture fundamentals.</p><div class="course-meta"><span class="course-level level-intermediate">Intermediate</span><span class="course-duration">3 months</span></div></div>
            <div class="course-card"><div class="course-icon">🔐</div><h3>Cyber Security</h3><p>Learn ethical hacking, network security, and penetration testing.</p><div class="course-meta"><span class="course-level level-advanced">Advanced</span><span class="course-duration">5 months</span></div></div>
        </div>
    </div>
    
    <div class="why-choose-section">
        <div class="section-heading">
            <h2>Why Choose Us</h2>
            <p>Everything you need to succeed in your tech career</p>
        </div>
        <div class="features-grid">
            <div class="feature-card"><div class="feature-icon-wrapper">🎓</div><div class="feature-text"><h4>Expert Instructors</h4><p>Learn from industry professionals with 10+ years of real-world experience.</p></div></div>
            <div class="feature-card"><div class="feature-icon-wrapper">🧪</div><div class="feature-text"><h4>Hands-On Labs</h4><p>Practice on live projects and real environments, not just theory.</p></div></div>
            <div class="feature-card"><div class="feature-icon-wrapper">📜</div><div class="feature-text"><h4>Certifications</h4><p>Earn industry-recognized certificates upon course completion.</p></div></div>
            <div class="feature-card"><div class="feature-icon-wrapper">💼</div><div class="feature-text"><h4>Career Support</h4><p>Dedicated placement team with 96% job placement success rate.</p></div></div>
        </div>
    </div>
    
    <div class="cosmic-signature">
        <span>⌇ INFINITE DATA STREAM • THE ART OF INFRASTRUCTURE ⌇</span>
    </div>
    
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>
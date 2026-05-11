// student-dashboard.js

// ========== DATE & TIME ==========
function updateDateTime() {
    const now = new Date();
    document.getElementById('currentDate').innerHTML = '<i class="far fa-calendar-alt"></i> ' + now.toLocaleDateString('en-IN', { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' });
    document.getElementById('currentTime').innerHTML = '<i class="far fa-clock"></i> ' + now.toLocaleTimeString('en-IN', { hour: '2-digit', minute: '2-digit' });
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
        
        // Load data when section is opened
        if (sectionId === 'attendance') loadAttendanceData();
        if (sectionId === 'syllabus') loadSyllabusData();
    });
});

// ========== ATTENDANCE DATA ==========
function loadAttendanceData() {
    // Monthly attendance data
    const monthlyData = [
        { month: 'January', present: 22, total: 24, percent: 92 },
        { month: 'February', present: 20, total: 22, percent: 91 },
        { month: 'March', present: 18, total: 23, percent: 78 },
        { month: 'April', present: 21, total: 22, percent: 95 },
        { month: 'May', present: 19, total: 21, percent: 90 },
        { month: 'June', present: 23, total: 24, percent: 96 }
    ];
    
    // Calculate overall attendance
    let totalPresent = 0, totalDays = 0;
    monthlyData.forEach(m => {
        totalPresent += m.present;
        totalDays += m.total;
    });
    const overallPercent = Math.round((totalPresent / totalDays) * 100);
    
    document.getElementById('attendancePercent').innerText = overallPercent + '%';
    document.getElementById('overallAttendance').innerText = overallPercent + '%';
    document.getElementById('overallAttendanceBar').style.width = overallPercent + '%';
    
    // Populate table
    const tbody = document.getElementById('attendanceTableBody');
    tbody.innerHTML = '';
    monthlyData.forEach(m => {
        tbody.innerHTML += `
            <tr>
                <td>${m.month}</td>
                <td>${m.present}</td>
                <td>${m.total}</td>
                <td>${m.percent}%</td>
                <td><div class="progress-bar"><div class="progress-fill" style="width: ${m.percent}%"></div></div></td>
            </tr>
        `;
    });
    
    // Create chart
    createAttendanceChart(monthlyData);
}

function createAttendanceChart(data) {
    const ctx = document.getElementById('attendanceChart').getContext('2d');
    // Destroy existing chart if it exists to avoid duplication
    if (window.attendanceChartInstance) {
        window.attendanceChartInstance.destroy();
    }
    window.attendanceChartInstance = new Chart(ctx, {
        type: 'line',
        data: {
            labels: data.map(d => d.month),
            datasets: [{
                label: 'Attendance Percentage',
                data: data.map(d => d.percent),
                borderColor: '#667eea',
                backgroundColor: 'rgba(102, 126, 234, 0.1)',
                tension: 0.4,
                fill: true
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: { position: 'top' }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    max: 100,
                    title: { display: true, text: 'Percentage (%)' }
                }
            }
        }
    });
}

// ========== SYLLABUS DATA ==========
function loadSyllabusData() {
    const overallPercent = 72;
    document.getElementById('syllabusPercent').innerText = overallPercent + '%';
    document.getElementById('overallSyllabus').innerText = overallPercent + '%';
    document.getElementById('overallSyllabusBar').style.width = overallPercent + '%';
    
    // Subject-wise progress
    const subjects = [
        { name: 'Core Java', completed: 12, total: 15, percent: 80 },
        { name: 'Spring Boot', completed: 8, total: 12, percent: 67 },
        { name: 'MySQL', completed: 10, total: 10, percent: 100 },
        { name: 'React JS', completed: 6, total: 10, percent: 60 },
        { name: 'HTML/CSS', completed: 8, total: 8, percent: 100 }
    ];
    
    const subjectContainer = document.getElementById('subjectProgressList');
    subjectContainer.innerHTML = '';
    subjects.forEach(sub => {
        subjectContainer.innerHTML += `
            <div class="subject-progress">
                <div class="subject-title">${sub.name}</div>
                <div style="display: flex; justify-content: space-between; margin-bottom: 5px;">
                    <span>${sub.completed}/${sub.total} topics completed</span>
                    <span>${sub.percent}%</span>
                </div>
                <div class="progress-bar"><div class="progress-fill" style="width: ${sub.percent}%"></div></div>
            </div>
        `;
    });
    
    // Topic-wise syllabus
    const topics = [
        { subject: 'Core Java', topic: 'Introduction to Java', completed: true },
        { subject: 'Core Java', topic: 'OOP Concepts', completed: true },
        { subject: 'Core Java', topic: 'Exception Handling', completed: true },
        { subject: 'Core Java', topic: 'Collections Framework', completed: false },
        { subject: 'Core Java', topic: 'Multithreading', completed: false },
        { subject: 'Spring Boot', topic: 'Spring Core', completed: true },
        { subject: 'Spring Boot', topic: 'Spring MVC', completed: true },
        { subject: 'Spring Boot', topic: 'Spring Data JPA', completed: false },
        { subject: 'MySQL', topic: 'SQL Basics', completed: true },
        { subject: 'MySQL', topic: 'Joins', completed: true },
        { subject: 'React JS', topic: 'Components', completed: true },
        { subject: 'React JS', topic: 'Props & State', completed: false }
    ];
    
    const topicsContainer = document.getElementById('syllabusTopicsList');
    topicsContainer.innerHTML = '';
    let currentSubject = '';
    topics.forEach(topic => {
        if (currentSubject !== topic.subject) {
            currentSubject = topic.subject;
            topicsContainer.innerHTML += `<h5 style="margin-top: 15px; color: #667eea;">${topic.subject}</h5>`;
        }
        topicsContainer.innerHTML += `
            <div class="syllabus-item">
                <div class="topic">
                    <i class="fas ${topic.completed ? 'fa-check-circle completed' : 'fa-circle pending'}"></i>
                    <span>${topic.topic}</span>
                </div>
                <span class="${topic.completed ? 'completed' : 'pending'}">
                    ${topic.completed ? 'Completed' : 'Pending'}
                </span>
                <div class="syllabus-progress">
                    <div class="progress-bar"><div class="progress-fill" style="width: ${topic.completed ? 100 : 0}%"></div></div>
                </div>
            </div>
        `;
    });
}

// ========== ANIMATION FOR STATS ==========
function animateNumbers() {
    const attendance = 85;
    const exams = 4;
    const avgScore = 82;
    const syllabus = 70;
    
    animateNumber('attendancePercent', attendance);
    animateNumber('examsCompleted', exams);
    animateNumber('avgScore', avgScore);
    animateNumber('syllabusPercent', syllabus);
}

function animateNumber(elementId, target) {
    const element = document.getElementById(elementId);
    if (!element) return;
    let current = 0;
    const increment = target / 50;
    const isPercent = elementId === 'attendancePercent' || elementId === 'avgScore' || elementId === 'syllabusPercent';
    const timer = setInterval(() => {
        current += increment;
        if (current >= target) {
            element.innerText = target + (isPercent ? '%' : '');
            clearInterval(timer);
        } else {
            element.innerText = Math.floor(current) + (isPercent ? '%' : '');
        }
    }, 20);
}

// ========== INITIALIZATION ==========
document.addEventListener('DOMContentLoaded', () => {
    loadAttendanceData();
    animateNumbers();
    console.log('%c🎓 Student Dashboard Loaded', 'color: #667eea; font-size: 14px; font-weight: bold;');
});
// Smart School MIS - Main JavaScript (Separate file)
// Fluid Dashboard with all required modules

(function() {
    'use strict';

    // ---------- MODULE DESCRIPTIONS & ALERTS ----------
    const getModuleMessage = (moduleName) => {
        const messages = {
            'Attendance Management': '📊 Attendance Management Module: Mark attendance, generate monthly summaries, real-time tracking with automated alerts.',
            'Online Examination': '✍️ Online Examination: Create question banks, auto-grading, secure exam environment with instant results.',
            'Feedback Management': '📝 Feedback Management: Collect surveys, course evaluations, faculty feedback & sentiment analysis.',
            'Learning Material Distribution': '📚 Learning Material Distribution: Upload notes, assignments, video lectures, and track student downloads.',
            'Administrative Office': '🏛️ Administrative Office: Workflow automation, circulars, document repository & internal approvals.',
            'Faculty Information System': '👩‍🏫 Faculty Information System: Manage faculty profiles, leaves, workload, performance reviews.',
            'Library Management System': '📖 Library Management System: Issue/return books, online catalog, fine management, digital resources.',
            'Account Management System': '💰 Account Management System: Fee collection, expense tracking, financial reporting & ledger management.',
            'Training And Placement': '🎯 Training And Placement: Manage recruiters, student applications, campus drives, placement records.',
            'Student Portal': '👨‍🎓 Student Portal: Access exam results, timetable, assignments, fee status, and announcements.',
            'Fun And Events Management': '🎉 Fun And Events Management: Organize cultural events, fests, sports meets, celebrations & engagement activities.'
        };
        return messages[moduleName] || `🚀 Launching ${moduleName} module. Advanced features available.`;
    };

    // Attach event listeners to all module buttons
    const attachModuleListeners = () => {
        const allModuleBtns = document.querySelectorAll('.module-btn');
        allModuleBtns.forEach(btn => {
            // Skip empty hidden card buttons
            if (btn.closest('.empty-card')) return;
            
            const moduleName = btn.getAttribute('data-module');
            if (moduleName) {
                // Remove existing listeners to avoid duplicates (just in case)
                const newBtn = btn.cloneNode(true);
                btn.parentNode.replaceChild(newBtn, btn);
                newBtn.addEventListener('click', (e) => {
                    e.preventDefault();
                    const message = getModuleMessage(moduleName);
                    alert(message);
                });
            }
        });
    };

    // ---------- HELP BUTTON HANDLER ----------
    const initHelpButton = () => {
        const helpButton = document.getElementById('helpBtn');
        if (helpButton) {
            helpButton.addEventListener('click', () => {
                alert("📞 Need Assistance? Contact our 24/7 support:\n(+91) 7276-499-399\n(+91) 7721-899-399\n(+91) 8379-899-399\nEmail: support@smartschoolmis.com");
            });
        }
    };

    // ---------- SOCIAL ICONS INTERACTIONS ----------
    const initSocialIcons = () => {
        const socialMap = [
            { id: 'fbIcon', message: '🔵 Facebook: Follow Smart School MIS for updates on new features and campus news!' },
            { id: 'twIcon', message: '🐦 Twitter: @SmartSchoolMIS - latest edtech trends and product announcements.' },
            { id: 'inIcon', message: '🔗 LinkedIn: Smart School ERP | Centralized Management for modern institutions.' },
            { id: 'igIcon', message: '📸 Instagram: @smartschoolmis - campus moments, events, and behind the scenes.' }
        ];
        
        socialMap.forEach(item => {
            const icon = document.getElementById(item.id);
            if (icon) {
                icon.addEventListener('click', () => alert(item.message));
            }
        });
    };

    // ---------- ORGANIZATION HOME LINK ----------
    const initOrgLink = () => {
        const orgLink = document.getElementById('orgHomeLink');
        if (orgLink) {
            orgLink.addEventListener('click', (e) => {
                e.preventDefault();
                alert("🏫 Navigate to organization's official website.\n(Redirect to institute portal would happen here in production.)");
                // Uncomment below to enable actual redirect:
                // window.location.href = "https://www.dypgroup.edu.in";
            });
        }
    };

    // ---------- MARQUEE ENHANCEMENT (stop/start on hover) ----------
    const initMarqueeControls = () => {
        const marqueeElem = document.querySelector('marquee');
        if (marqueeElem) {
            marqueeElem.addEventListener('mouseover', () => marqueeElem.stop());
            marqueeElem.addEventListener('mouseout', () => marqueeElem.start());
        }
    };

    // ---------- IMAGE FALLBACK HANDLER ----------
    const initImageFallback = () => {
        const allImages = document.querySelectorAll('.card-icon img');
        allImages.forEach(img => {
            img.addEventListener('error', function() {
                if (!this.src.includes('placeholder') && !this.src.includes('via.placeholder.com')) {
                    this.src = 'https://via.placeholder.com/90?text=Module';
                }
            });
        });
    };

    // ---------- ADDITIONAL: LOGGER FOR INIT (dev) ----------
    const logReady = () => {
        console.log('✅ Smart School MIS | Fluid Dashboard ready — HTML/CSS/JS separated. All modules active.');
    };

    // Initialize everything when DOM is fully loaded
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', () => {
            attachModuleListeners();
            initHelpButton();
            initSocialIcons();
            initOrgLink();
            initMarqueeControls();
            initImageFallback();
            logReady();
        });
    } else {
        // DOM already loaded
        attachModuleListeners();
        initHelpButton();
        initSocialIcons();
        initOrgLink();
        initMarqueeControls();
        initImageFallback();
        logReady();
    }
})();
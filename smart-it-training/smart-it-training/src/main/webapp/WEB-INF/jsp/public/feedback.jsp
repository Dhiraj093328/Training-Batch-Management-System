<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <title>Feedback | Smart IT Training</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        .feedback-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
            overflow: hidden;
            animation: fadeInUp 0.5s ease;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .feedback-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            padding: 30px;
            text-align: center;
            color: white;
        }
        .feedback-header i { font-size: 60px; margin-bottom: 15px; }
        .feedback-header h1 { font-size: 2rem; margin-bottom: 5px; }
        .feedback-header p { opacity: 0.9; }
        .feedback-body { padding: 30px; }
        .form-group { margin-bottom: 20px; }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }
        .form-group label i { margin-right: 8px; color: #667eea; }
        .form-group input, .form-group textarea, .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 0.95rem;
            font-family: 'Poppins', sans-serif;
        }
        .form-group input:focus, .form-group textarea:focus, .form-group select:focus {
            outline: none;
            border-color: #667eea;
        }
        .rating-group {
            display: flex;
            flex-direction: row-reverse;
            justify-content: flex-end;
            gap: 10px;
        }
        .rating-group input {
            display: none;
        }
        .rating-group label {
            font-size: 30px;
            color: #ddd;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .rating-group label:hover,
        .rating-group label:hover ~ label,
        .rating-group input:checked ~ label {
            color: #ffc107;
        }
        .submit-btn {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .submit-btn:hover { transform: translateY(-2px); box-shadow: 0 10px 25px rgba(102,126,234,0.4); }
        .alert {
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
        }
        .alert-success { background: #d4edda; color: #155724; border-left: 4px solid #28a745; }
        .back-link { text-align: center; margin-top: 20px; }
        .back-link a { color: white; text-decoration: none; opacity: 0.8; }
        .back-link a:hover { opacity: 1; text-decoration: underline; }
        @media (max-width: 600px) {
            .feedback-header h1 { font-size: 1.5rem; }
            .rating-group label { font-size: 25px; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="feedback-card">
            <div class="feedback-header">
                <i class="fas fa-star"></i>
                <h1>We Value Your Feedback</h1>
                <p>Help us improve our training programs</p>
            </div>
            
            <div class="feedback-body">
                <c:if test="${not empty param.success}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i> Thank you for your feedback! We appreciate your input.
                    </div>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/feedback/submit" method="post" id="feedbackForm">
                    <div class="form-group">
                        <label><i class="fas fa-user"></i> Your Name</label>
                        <input type="text" name="name" required placeholder="Enter your full name">
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-envelope"></i> Email Address</label>
                        <input type="email" name="email" required placeholder="your@email.com">
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-star"></i> Rating</label>
                        <div class="rating-group">
                            <input type="radio" name="rating" value="5" id="star5" required><label for="star5">★</label>
                            <input type="radio" name="rating" value="4" id="star4"><label for="star4">★</label>
                            <input type="radio" name="rating" value="3" id="star3"><label for="star3">★</label>
                            <input type="radio" name="rating" value="2" id="star2"><label for="star2">★</label>
                            <input type="radio" name="rating" value="1" id="star1"><label for="star1">★</label>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label><i class="fas fa-comment"></i> Your Message</label>
                        <textarea name="message" rows="5" required placeholder="Please share your experience, suggestions, or concerns..."></textarea>
                    </div>
                    
                    <button type="submit" class="submit-btn">Submit Feedback</button>
                </form>
            </div>
        </div>
        
        <div class="back-link">
            <a href="${pageContext.request.contextPath}/menu"><i class="fas fa-arrow-left"></i> Back to Menu</a>
        </div>
    </div>
    
    <script>
        document.getElementById('feedbackForm').addEventListener('submit', function() {
            const btn = this.querySelector('.submit-btn');
            btn.innerHTML = '<i class="fas fa-spinner fa-pulse"></i> Submitting...';
            btn.disabled = true;
        });
    </script>
</body>
</html>
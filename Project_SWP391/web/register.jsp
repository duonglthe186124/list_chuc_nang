<%-- 
    Document   : register
    Created on : Oct 10, 2025, 12:01:11 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Register Account</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="register-container">
        <h2>Register Account</h2>
        <form id="registerForm" action="registerStaff" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label for="fullname">Full name</label>
                    <input type="text" id="fullname" name="fullname" placeholder="John Doe" required>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="example@gmail.com" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="address">Contact Address</label>
                    <input type="text" id="address" name="address" required>
                </div>
                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" placeholder="+84912345678" required>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                    <div id="password-strength-status"></div> 
                    <small>Use at least 8 characters, combining uppercase, lowercase, numbers, and special characters.</small>
                </div>
                <div class="form-group">
                    <label for="confirm_password">Confirm Password</label>
                    <input type="password" id="confirm_password" name="confirm_password" required>
                </div>
            </div>
            
            <div id="error-message" class="error-text">
                <%
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null) {
                %>
                    <p><%= errorMessage %></p>
                <%
                    }
                %>
            </div>

            <button type="submit" class="create-btn">Create Staff</button>

            <p class="login-link">
                You have an account? <a href="WEB-INF/view/login_page.jsp">Login</a>
            </p>
        </form>
    </div>

    <script src="validation.js"></script>
</body>
</html>
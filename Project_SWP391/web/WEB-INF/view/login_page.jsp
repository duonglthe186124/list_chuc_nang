<%-- 
    Document   : login_page
    Created on : Sep 25, 2025, 8:02:45 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign In</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login_style.css">
    </head>
    <body>
        <div class="login-container">
        <h2>Sign in</h2>

        <form id="registerForm" action="loginStaff" method="post">
            
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="notification">
                <%
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null) {
                %>
                    <span><%= errorMessage %></span>
                <%
                    }
                %>
            </div>

            <div class="options-row">
                <div class="remember-me">
                    <input type="checkbox" id="remember" name="remember">
                    <label for="remember">Remember me</label>
                </div>
                <a href="${pageContext.request.contextPath}/forgot-password" class="forgot-password">Forgot password?</a>
            </div>
            
            <p class="register-link">
                You don't have an account? <a href="${pageContext.request.contextPath}/RegisterStaff">Register</a>
            </p>

            <button type="submit" class="signin-btn">Sign in</button>
        </form>

        <div class="separator">
            <span>OR</span>
        </div>

        <div class="social-login">
            <button type="button" class="social-btn google-btn">
                <img src="${pageContext.request.contextPath}/resources/img/google.webp" alt="Google Icon">
                Continue with Google
            </button>
            <button type="button" class="social-btn phone-btn">
                 <img src="${pageContext.request.contextPath}/resources/img/phone.jpg" alt="Phone Icon">
                Continue with Phone number
            </button>
        </div>
    </div>
    </body>
</html>

<%-- 
    Document   : forgot_password
    Created on : Oct 27, 2025, 10:42:06 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Recover Account</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login_style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/forgotpassword_style.css">
    </head>
    <body>
        <div class="login-container" style="max-width: 450px;">
            <h2>Recover my account</h2>
            
            <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                
                <div class="notification-area"> 
                    <% String message = (String) request.getAttribute("message");
                       if (message != null) { %>
                        <span class="notification <%= message.startsWith("Error") ? "error-message" : "success-message" %>">
                            <%= message %>
                        </span>
                    <% } %>
                </div>

                <div class="form-group">
                    <input type="text" name="credential" placeholder="Email or Phone number" 
                           value="${param.credential != null ? param.credential : ''}" 
                           required style="text-align: center;">
                </div>

                <div class="options-row" style="gap: 10px; margin-top: 30px;">
                    <a href="${pageContext.request.contextPath}/loginStaff" class="social-btn" style="flex: 1; text-decoration: none; color: black;">Cancel</a>
                    <button type="submit" class="signin-btn" style="flex: 1; margin: 0; border-radius: 6px;">Send reset password code</button>
                </div>
            </form>
        </div>
    </body>
</html>

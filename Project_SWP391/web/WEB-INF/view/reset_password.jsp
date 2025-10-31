<%-- 
    Document   : reset_password
    Created on : Oct 27, 2025, 10:43:16 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Reset Password</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login_style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/resetpassword_style.css">

    </head>
    <body>
        <div class="login-container" style="max-width: 450px; text-align: left;">
            <h2 style="text-align: center;">Reset password</h2>
            
            <form action="${pageContext.request.contextPath}/reset-password" method="post">
                <div class="notification" style="text-align: center; margin-bottom: 20px;">
                    <% String error = (String) request.getAttribute("error");
                       if (error != null) { %>
                        <span class="error-message"><%= error %></span>
                    <% } %>
                </div>
                
                <input type="hidden" name="email" value="${email}">

                <div class="form-group">
                    <label>Reset code</label>
                    <input type="text" name="reset_code" value="${param.reset_code != null ? param.reset_code : ''}" required>
                </div>
                 <div class="form-group password-wrapper">
                    <label>New password</label>
                    <input type="password" name="new_password" id="new_password" 
                           value="${param.new_password != null ? param.new_password : ''}" required>
                    <i class="fas fa-eye-slash toggle-password"></i>
                    <div class="password-strength-indicator"><div id="strength-bar"></div></div>
                    <div id="strength-text" class="strength-text"></div>
                </div>
                 <div class="form-group password-wrapper">
                    <label>Confirm new password</label>
                    <input type="password" name="confirm_password" id="confirm_password" 
                           value="${param.confirm_password != null ? param.confirm_password : ''}" required>
                    <i class="fas fa-eye-slash toggle-password"></i>
                </div>
                
                <div class="options-row" style="gap: 10px; margin-top: 30px;">
                    <a href="${pageContext.request.contextPath}/forgot-password" class="btn btn-secondary">Cancel</a>
                    <button type="submit" name="action" value="change" class="signin-btn" style="flex: 1; margin: 0; border-radius: 6px;">Change</button>
                </div>
            </form>
        </div>
        <script src="${pageContext.request.contextPath}/resources/js/password-strength.js"></script>
    </body>
</html>

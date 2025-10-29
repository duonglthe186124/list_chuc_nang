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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login_style.css">
    <style>
        .password-wrapper { position: relative; } 
        .toggle-password { position: absolute; top: 70%; right: 15px; transform: translateY(-50%); cursor: pointer; color: #888; }
        .password-strength-indicator {
            height: 5px;
            background-color: #eee;
            margin-top: 5px;
            border-radius: 2.5px;
            overflow: hidden;
        }
        .password-strength-indicator div {
            height: 100%;
            width: 0%;
            transition: width 0.3s ease-in-out, background-color 0.3s ease-in-out;
            background-color: transparent;
        }
        .strength-text {
            font-size: 0.85em;
            margin-top: 5px;
            text-align: right;
        }
        .strength-weak { color: #dc3545; background-color: #dc3545; }
        .strength-medium { color: #ffc107; background-color: #ffc107; }
        .strength-strong { color: #28a745; background-color: #28a745; }
        .notification {
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
        }
        .notification span {
            font-weight: bold;
        }
        .error-message {
            color: #dc3545; 
            border: 1px solid #dc3545;
            background-color: #f8d7da;
        }
    </style>
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
                <button type="submit" name="action" value="cancel" class="social-btn" 
                        style="flex: 1; text-decoration: none; color: black; border: 1px solid #ccc; background-color: #f0f0f0;">Cancel</button>
                <button type="submit" name="action" value="change" class="signin-btn" style="flex: 1; margin: 0; border-radius: 6px;">Change</button>
            </div>
        </form>
    </div>
    <script src="${pageContext.request.contextPath}/resources/js/password-toggle.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/password-strength.js"></script>
</body>
</html>

<%-- 
    Document   : change_password
    Created on : Oct 31, 2025, 1:54:57 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/changepassword_style.css">
    </head>
    <body>
        <div class="change-password-container">
            <h2>Change password</h2>
            <form action="${pageContext.request.contextPath}/change-password" method="post">
                <div class="notification-area">
                    <% if (request.getAttribute("successMessage") != null) { %>
                        <div class="notification success"><%= request.getAttribute("successMessage") %></div>
                    <% } else if (request.getAttribute("errorMessage") != null) { %>
                        <div class="notification error"><%= request.getAttribute("errorMessage") %></div>
                    <% } %>
                </div>

                <div class="form-group password-wrapper">
                    <label for="old_password">Old password</label>
                    <input type="password" id="old_password" name="old_password" required>
                </div>

                <div class="form-group password-wrapper">
                    <label for="new_password">New password</label>
                    <input type="password" id="new_password" name="new_password" required>
                </div>

                <div class="form-group password-wrapper">
                    <label for="confirm_password">Confirm new password</label>
                    <input type="password" id="confirm_password" name="confirm_password" required>
                </div>

                <div class="button-group">
                    <a href="${pageContext.request.contextPath}/PersonalProfile" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary">Change</button>
                </div>
            </form>
        </div>
        <script src="${pageContext.request.contextPath}/resources/js/password-strength.js"></script>
    </body>
</html>

<%-- 
    Document   : personal_profile
    Created on : Oct 31, 2025, 12:16:49 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Personal Profile</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/profile_style.css">
    </head>
    <body>
        <div class="profile-container">
            <aside class="profile-sidebar">
                <div class="avatar-section">
                    <div class="avatar-placeholder"><span>Avatar</span></div>
                    <button class="btn btn-secondary">Change avatar</button>
                </div>
                <a href="${pageContext.request.contextPath}/change-password" class="btn btn-secondary password-btn">Change password</a>
            </aside>

            <main class="profile-main">
                <h2>Personal Profile</h2>

                <%-- HIỂN THỊ THÔNG BÁO --%>
                <div class="notification-area">
                    <% if (request.getAttribute("successMessage") != null) { %>
                        <div class="notification success"><%= request.getAttribute("successMessage") %></div>
                    <% } else if (request.getAttribute("errorMessage") != null) { %>
                        <div class="notification error"><%= request.getAttribute("errorMessage") %></div>
                    <% } %>
                </div>

                <%-- Form sẽ gửi dữ liệu đến ProfileServlet bằng phương thức POST --%>
                <form id="profile-form" action="${pageContext.request.contextPath}/profile" method="post">
                    <div class="form-group">
                        <label for="fullname">Fullname</label>
                        <input type="text" id="fullname" name="fullname" value="${userProfile.fullname}" disabled>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" value="${userProfile.email}" disabled>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone</label>
                        <input type="tel" id="phone" name="phone" value="${userProfile.phone}" disabled>
                    </div>
                    <div class="form-group">
                        <label for="address">Address</label>
                        <input type="text" id="address" name="address" value="${userProfile.address}" disabled>
                    </div>

                    <div class="form-actions">
                        <button type="button" id="edit-btn" class="btn btn-secondary">Edit</button>
                        <button type="submit" id="save-btn" class="btn btn-primary">Save</button>
                    </div>
                </form>
            </main>
        </div>

        <script src="${pageContext.request.contextPath}/resources/js/profile_script.js"></script>
    </body>
</html>

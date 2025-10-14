<%-- 
    Document   : header
    Created on : Oct 12, 2025, 2:14:36 PM
    Author     : Ha Trung KI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<header class="header">
    <div class="header-left">
        <h1>Warehouse Management System</h1>
    </div>
    <div class="header-right">
        <div class="user-info">
            <span class="username">Welcome, ${sessionScope.user.fullname}</span>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Logout</a>
        </div>
    </div>
</header>
</html>

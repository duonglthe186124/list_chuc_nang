<%-- 
    Document   : header
    Created on : Oct 28, 2025, 10:53:34 PM
    Author     : Ha Trung KI
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>

<%-- 
    HEADER.JSP
    Đây là thanh điều hướng trên cùng, nằm trong <div class="main-content">
--%>

<div class="header">
    <div class="header-left">
        <div class="search-bar">
            <input type="text" placeholder="Tìm kiếm...">
            <button type="submit">Tìm</button>
        </div>
    </div>
    
    <div class="header-right">
        <div class="user-info">
            <span class="user-name">
                Xin chào, ${sessionScope.user.fullName} 
            </span>
            <div class="user-avatar">
                <img src="path/to/avatar.png" alt="Avatar">
            </div>
            <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
        </div>
    </div>
</div>
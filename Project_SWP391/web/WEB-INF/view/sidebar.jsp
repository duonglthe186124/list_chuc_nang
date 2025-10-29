<%-- 
    Document   : sidebar
    Created on : Oct 28, 2025, 10:53:57 PM
    Author     : Ha Trung KI
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 
    SIDEBAR.JSP
    Đây là thanh menu bên trái.
--%>

<div class="sidebar">
    <div class="sidebar-header">
        <h3>Tên Dự Án</h3>
    </div>

    <ul class="sidebar-menu">
        <li>
            <a href="${pageContext.request.contextPath}/home">
                <span class="icon">🏠</span> <span>Dashboard</span>
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/products">
                <span class="icon">📱</span>
                <span>Quản lý Sản phẩm</span>
            </a>
        </li>

        <li class="menu-header"><span>Kho hàng</span></li>
        <li>
            <a href="${pageContext.request.contextPath}/warehouse/inventory">
                <span class="icon">📦</span>
                <span>Tồn kho</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/warehouse/receipt">
                <span class="icon">📥</span>
                <span>Nhập kho</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/warehouse/issue">
                <span class="icon">📤</span>
                <span>Xuất kho</span>
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/warehouse/locations">
                <span class="icon">📍</span>
                <span>Vị trí kho</span>
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/warehouse/inspections">
                <span class="icon">✅</span>
                <span>Kiểm định (QC)</span>
            </a>
        </li>

        <li class="menu-header"><span>Báo cáo</span></li>
        <li>
            <a href="${pageContext.request.contextPath}/warehouse/report">
                <span class="icon">📊</span>
                <span>Báo cáo Tồn kho</span>
            </a>
        </li>

        <li class="menu-header"><span>Bán hàng</span></li>
        <li>
            <a href="${pageContext.request.contextPath}/orders">
                <span class="icon">🛒</span>
                <span>Quản lý Đơn hàng</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/users">
                <span class="icon">👥</span>
                <span>Quản lý Người dùng</span>
            </a>
        </li>
    </ul>
</div>

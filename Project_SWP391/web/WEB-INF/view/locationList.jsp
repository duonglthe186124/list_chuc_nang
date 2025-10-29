<%-- 
    Document   : locationList
    Created on : Oct 28, 2025, 11:40:14 PM
    Author     : Ha Trung KI
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý Vị trí kho</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css"> 
        <%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/product_screen.css"> --%>
        <<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/location_list.css"/>
        <style>
            .form-container {
                padding: 20px;
                background: #f9f9f9;
                border-radius: 8px;
                margin-bottom: 20px;
            }
            .form-row {
                display: flex;
                gap: 15px;
                margin-bottom: 10px;
            }
            .form-group {
                flex: 1;
            }
            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }
            .form-group input {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <nav class="nav">
            <div class="brand">
                <a href="home.html">
                    <div class="logo" aria-hidden>
                        <svg
                            width="26"
                            height="26"
                            viewBox="0 0 24 24"
                            fill="none"
                            xmlns="http://www.w3.org/2000/svg"
                            >
                        <rect
                            x="2"
                            y="2"
                            width="20"
                            height="20"
                            rx="4"
                            fill="black"
                            opacity="0.12"
                            />
                        <path
                            d="M6 16V8h4l4 4v4"
                            stroke="#06121a"
                            stroke-width="1.2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            />
                        </svg>
                    </div>
                </a>
                <div>
                    <h1>StockPhone</h1>
                    <p>Phone Stock Management System</p>
                </div>
            </div>

            <div class="navlinks" role="navigation" aria-label="Primary">
                <a href="${pageContext.request.contextPath}/home">Home</a>
                <a href="${pageContext.request.contextPath}/products">Products</a>
                <a href="${pageContext.request.contextPath}/about">About</a>
                <a href="${pageContext.request.contextPath}/policy">Policy</a>
                <a href="${pageContext.request.contextPath}/report">Reports</a>
            </div>

            <div class="cta">
                <button class="icon-btn" title="Tìm kiếm" aria-label="Tìm kiếm">
                    <svg
                        width="18"
                        height="18"
                        viewBox="0 0 24 24"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                        >
                    <path
                        d="M21 21l-4.35-4.35"
                        stroke="currentColor"
                        stroke-width="1.4"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        />
                    <circle
                        cx="11"
                        cy="11"
                        r="6"
                        stroke="currentColor"
                        stroke-width="1.4"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        />
                    </svg>
                </button>

                <a
                    class="icon-btn"
                    href="login.html"
                    title="Đăng nhập"
                    aria-label="Đăng nhập"
                    >
                    <svg
                        width="18"
                        height="18"
                        viewBox="0 0 24 24"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                        >
                    <path
                        d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"
                        stroke="currentColor"
                        stroke-width="1.4"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        />
                    <circle
                        cx="12"
                        cy="7"
                        r="4"
                        stroke="currentColor"
                        stroke-width="1.4"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        />
                    </svg>
                </a>

                <button
                    class="hamburger"
                    id="hamburger"
                    aria-controls="mobileMenu"
                    aria-expanded="false"
                    >
                    <svg
                        width="26"
                        height="26"
                        viewBox="0 0 24 24"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                        >
                    <path
                        d="M4 7h16M4 12h16M4 17h16"
                        stroke="currentColor"
                        stroke-width="1.6"
                        stroke-linecap="round"
                        />
                    </svg>
                </button>
            </div>
        </nav>
        <div class="layout">
            <aside class="sidebar" aria-label="Sidebaar">
                <h3 class="sidebar-title">Outbound Inventory</h3>

                <div class="sidebar-menu">
                    <a class="menu-item" href="${pageContext.request.contextPath}/home">
                        <span class="icon">🏠</span> <span>Dashboard</span>
                    </a>
                    <a class="menu-item" href="${pageContext.request.contextPath}/products">
                        <span class="icon">📱</span>
                        <span>Quản lý Sản phẩm</span>
                    </a>
                    <a class="menu-item active" href="${pageContext.request.contextPath}/warehouse/inventory">
                        <span class="icon">📦</span>
                        <span>Tồn kho</span>
                    </a>
                    <a class="menu-item" href="${pageContext.request.contextPath}/inbound/create-receipt">
                        <span class="icon">📥</span>
                        <span>Nhập kho</span>
                    </a>
                    <a class="menu-item" href="${pageContext.request.contextPath}/warehouse/issue">
                        <span class="icon">📤</span>
                        <span>Xuất kho</span>
                    </a>
                    <a class="menu-item" href="${pageContext.request.contextPath}/warehouse/locations">
                        <span class="icon">📍</span>
                        <span>Vị trí kho</span>
                    </a>
                    <a class="menu-item" href="${pageContext.request.contextPath}/warehouse/inspections">
                        <span class="icon">✅</span>
                        <span>Kiểm định (QC)</span>
                    </a>
                    <a class="menu-item" href="${pageContext.request.contextPath}/warehouse/report">
                        <span class="icon">📊</span>
                        <span>Báo cáo Tồn kho</span>
                    </a>
                    <a class="menu-item" href="${pageContext.request.contextPath}/orders">
                        <span class="icon">🛒</span>
                        <span>Quản lý Đơn hàng</span>
                    </a>
                    <a class="menu-item" href="${pageContext.request.contextPath}/users">
                        <span class="icon">👥</span>
                        <span>Quản lý Người dùng</span>
                    </a>
                </div>
            </aside>
            <main class="main">
                <div class="main-header" id="main-header">
                    <h1>Danh sách Vị trí kho</h1>
                </div>

                <div class="main-content">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Mã Vị trí</th>
                                <th>Khu</th>
                                <th>Dãy</th>
                                <th>Ô</th>
                                <th>Sức chứa</th>
                                <th>Số lượng hiện tại</th>
                                <th>Mô tả</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.locationList}" var="loc">
                                <tr>
                                    <td>${loc.code}</td>
                                    <td>${loc.area}</td>
                                    <td>${loc.aisle}</td>
                                    <td>${loc.slot}</td>
                                    <td>${loc.capacity}</td>
                                    <td>${loc.current_capacity}</td>
                                    <td>${loc.description}</td>
                                    <td>
                                        <a href="#">Sửa</a> | <a href="#">Xóa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </body>
</html>

<%--
<div class="container">
    <jsp:include page="/WEB-INF/view/sidebar.jsp" /> 

                    <div class="main-content">
                        <jsp:include page="/WEB-INF/view/header.jsp" />

                        <div class="content-area">
                            <c:if test="${not empty errorMessage}">
                                <div style="color: red; background: #ffebee; padding: 10px; margin-bottom: 15px;">
                                    ${errorMessage}
                                </div>
                            </c:if>

                            <div class="form-container">
                                <h2>Thêm Vị trí kho mới</h2>
                                <form action="${pageContext.request.contextPath}/warehouse/locations" method="POST">
                                    <div class="form-row">
                                        <div class="form-group">
                                            <label>Mã Vị trí (Code):</label>
                                            <input type="text" name="code" placeholder="VD: A-01-01" required>
                                        </div>
                                        <div class="form-group">
                                            <label>Khu (Area):</label>
                                            <input type="text" name="area" placeholder="VD: Khu A" required>
                                        </div>
                                        <div class="form-group">
                                            <label>Dãy (Aisle):</label>
                                            <input type="text" name="aisle" placeholder="VD: Dãy 01" required>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group">
                                            <label>Ô (Slot):</label>
                                            <input type="text" name="slot" placeholder="VD: Ô 01" required>
                                        </div>
                                        <div class="form-group">
                                            <label>Sức chứa (Capacity):</label>
                                            <input type="number" name="capacity" value="1" min="1" required>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group" style="flex: 1;">
                                            <label>Mô tả:</label>
                                            <input type="text" name="description" placeholder="VD: Khu hàng dễ vỡ">
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Thêm Vị trí</button>
                                </form>
                            </div>

                            <hr>

                            <h2>Danh sách Vị trí kho</h2>

                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Mã Vị trí</th>
                                        <th>Khu</th>
                                        <th>Dãy</th>
                                        <th>Ô</th>
                                        <th>Sức chứa</th>
                                        <th>Mô tả</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.locationList}" var="loc">
                                        <tr>
                                            <td>${loc.code}</td>
                                            <td>${loc.area}</td>
                                            <td>${loc.aisle}</td>
                                            <td>${loc.slot}</td>
                                            <td>${loc.capacity}</td>
                                            <td>${loc.description}</td>
                                            <td>
                                                <a href="#">Sửa</a> | <a href="#">Xóa</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
--%>
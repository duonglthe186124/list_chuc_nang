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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css"> 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/product_screen.css">
    <style>
        .form-container { padding: 20px; background: #f9f9f9; border-radius: 8px; margin-bottom: 20px; }
        .form-row { display: flex; gap: 15px; margin-bottom: 10px; }
        .form-group { flex: 1; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group input { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; }
    </style>
</head>
<body>
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
</body>
</html>

<%-- 
    Document   : inventoryList
    Created on : Oct 28, 2025, 10:47:08 PM
    Author     : Ha Trung KI
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý Tồn kho</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css"> 
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/product_screen.css"> 
    </head>
    <body>
        <div class="container">
            <jsp:include page="/WEB-INF/view/sidebar.jsp" /> 

            <div class="main-content">
                <jsp:include page="/WEB-INF/view/header.jsp" />

                <div class="content-area">
                    <div class="content-header">
                        <h2>Danh sách Tồn kho (Đếm động)</h2>
                        <a href="${pageContext.request.contextPath}/warehouse/receipt" class="btn btn-primary">Tạo phiếu nhập</a>
                        <a href="${pageContext.request.contextPath}/warehouse/issue" class="btn btn-secondary">Tạo phiếu xuất</a>
                    </div>
                    <hr>

                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Mã SP (SKU)</th>
                                <th>Tên Sản phẩm</th>
                                <th>Số lượng Tồn (IMEI)</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.stockList}" var="p">
                                <tr>
                                    <td>${p.skuCode}</td>
                                    <td>${p.productName}</td>
                                    <td>
                                        <strong>${p.stockQuantity}</strong>
                                    </td>
                                    <td>
                                        <a href="inventoryDetail?pid=${p.productId}">Xem chi tiết IMEI</a> 
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty requestScope.stockList}">
                                <tr>
                                    <td colspan="4" style="text-align: center;">Không có sản phẩm nào.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
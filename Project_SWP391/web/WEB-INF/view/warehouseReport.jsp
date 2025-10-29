<%-- 
    Document   : warehouseReport
    Created on : Oct 29, 2025, 12:09:01 AM
    Author     : Ha Trung KI
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Báo cáo Tồn kho</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css"> 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/product_screen.css">
    <style>
        .filter-form { padding: 20px; background: #f9f9f9; border-radius: 8px; margin-bottom: 20px; }
        .filter-form form { display: flex; align-items: flex-end; gap: 15px; }
        .form-group { flex: 1; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group input, .form-group select { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="container">
        <jsp:include page="/WEB-INF/view/sidebar.jsp" /> 
        
        <div class="main-content">
            <jsp:include page="/WEB-INF/view/header.jsp" />
            
            <div class="content-area">
                <h2>Báo cáo Thống kê Tồn kho</h2>
                <hr>
                
                <c:if test="${not empty errorMessage}">
                    <div style="color: red; background: #ffebee; padding: 10px; margin-bottom: 15px;">
                        ${errorMessage}
                    </div>
                </c:if>

                <div class="filter-form">
                    <form action="${pageContext.request.contextPath}/warehouse/report" method="GET">
                        <div class="form-group">
                            <label>Tìm theo Tên Sản phẩm:</label>
                            <input type="text" name="productName" value="${selectedProductName}">
                        </div>
                        
                        <div class="form-group">
                            <label>Lọc theo Nhãn hàng:</label>
                            <select name="brandId">
                                <option value="0">-- Tất cả Nhãn hàng --</option>
                                <c:forEach items="${brandList}" var="brand">
                                    <option value="${brand.brand_id}" ${brand.brand_id == selectedBrandId ? 'selected' : ''}>
                                        ${brand.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <button type="submit" class="btn btn-primary">Lọc</button>
                    </form>
                </div>

                <h2>Kết quả</h2>
                
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Mã SP (SKU)</th>
                            <th>Tên Sản phẩm</th>
                            <th>Số lượng Tồn (IMEI)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.reportList}" var="p">
                            <tr>
                                <td>${p.skuCode}</td>
                                <td>${p.productName}</td>
                                <td style="text-align: center; font-weight: bold;">
                                    ${p.stockQuantity}
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty requestScope.reportList}">
                            <tr>
                                <td colspan="3" style="text-align: center;">Không tìm thấy sản phẩm nào khớp với bộ lọc.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>

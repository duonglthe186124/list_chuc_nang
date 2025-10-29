<%-- 
    Document   : qualityInspectionList
    Created on : Oct 28, 2025, 11:58:31 PM
    Author     : Ha Trung KI
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản lý Chất lượng (QC)</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css"> 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/product_screen.css">
    <style>
        .form-container { padding: 20px; background: #f9f9f9; border-radius: 8px; margin-bottom: 20px; }
        .form-row { display: flex; gap: 15px; margin-bottom: 10px; }
        .form-group { flex: 1; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 8px; border: 1px solid #ccc; border-radius: 4px; }
        .result-pass { color: green; font-weight: bold; }
        .result-fail { color: red; font-weight: bold; }
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
                    <h2>Tạo Phiếu Kiểm định (QC)</h2>
                    <form action="${pageContext.request.contextPath}/warehouse/inspections" method="POST">
                        <div class="form-row">
                            <div class="form-group" style="flex: 2;">
                                <label>IMEI Sản phẩm:</label>
                                <input type="text" name="imei" placeholder="Quét hoặc nhập IMEI của sản phẩm..." required>
                            </div>
                            <div class="form-group" style="flex: 1;">
                                <label>Kết quả (Result):</label>
                                <select name="result" required>
                                    <option value="Pass">Đạt (Pass)</option>
                                    <option value="Fail">Hỏng (Fail)</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-row">
                             <div class="form-group" style="flex: 1;">
                                <label>Kiểm tại Vị trí:</label>
                                <select name="location_id" required>
                                    <option value="">-- Chọn vị trí --</option>
                                    <c:forEach items="${requestScope.locationList}" var="loc">
                                        <option value="${loc.location_id}">${loc.code}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-row">
                             <div class="form-group" style="flex: 1;">
                                <label>Ghi chú (Note):</label>
                                <textarea name="note" rows="3" placeholder="VD: Vỏ máy bị xước nhẹ..."></textarea>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Lưu Phiếu QC</button>
                    </form>
                </div>

                <hr>

                <h2>Lịch sử Kiểm định</h2>
                
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Mã QC</th>
                            <th>Sản phẩm</th>
                            <th>IMEI</th>
                            <th>Kết quả</th>
                            <th>Ngày kiểm</th>
                            <th>Người kiểm</th>
                            <th>Vị trí</th>
                            <th>Ghi chú</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.inspectionList}" var="qc">
                            <tr>
                                <td>${qc.inspection_no}</td>
                                <td>${qc.productName}</td>
                                <td>${qc.imei}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${qc.result == 'Pass'}"><span class="result-pass">Đạt</span></c:when>
                                        <c:otherwise><span class="result-fail">Hỏng</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td><fmt:formatDate value="${qc.inspected_date}" pattern="dd-MM-yyyy"/></td>
                                <td>${qc.inspectorName}</td>
                                <td>${qc.locationCode}</td>
                                <td>${qc.note}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
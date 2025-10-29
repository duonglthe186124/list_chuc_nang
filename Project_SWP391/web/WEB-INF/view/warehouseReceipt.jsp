<%-- 
    Document   : warehouseReceipt
    Created on : Oct 28, 2025, 10:21:24 PM
    Author     : Ha Trung KI
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tạo Phiếu Nhập Kho</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layout.css"> 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/create_receipt.css">
</head>
<body>
    <div class="container">
        <jsp:include page="/WEB-INF/view/sidebar.jsp" />
        
        <div class="main-content">
            <jsp:include page="/WEB-INF/view/header.jsp" />
            
            <div class="content-area">
                <h2>Tạo Phiếu Nhập Kho (Module Kho)</h2>
                <hr>
                
                <c:if test="${not empty errorMessage}">
                    <div style="color: red; background: #ffebee; border: 1px solid #e57373; padding: 10px; margin-bottom: 15px;">
                        ${errorMessage}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/warehouse/receipt" method="POST" id="receiptForm">
                    
                    <div class="form-group">
                        <label>Nhà cung cấp:</label>
                        <select name="supplierId" required>
                            <option value="1">Nhà cung cấp A (Test)</option>
                            <option value="2">Nhà cung cấp B (Test)</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Sản phẩm:</label>
                        <select name="productId" required>
                            <option value="1">iPhone 15 Pro Max (Test)</option>
                            <option value="2">Samsung S24 Ultra (Test)</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Số lượng nhập:</label>
                        <input type="number" name="quantity" id="quantity" required min="1">
                    </div>
                    
                    <div class="form-group">
                        <label>Giá nhập (trên 1 SP):</label>
                        <input type="number" name="importPrice" step="0.01" required min="0">
                    </div>

                    <div class="form-group">
                        <label for="imeiList">Danh sách IMEI (mỗi IMEI 1 dòng):</label>
                        <textarea class="form-control" 
                                  id="imeiList" 
                                  name="imeiList" 
                                  rows="10" 
                                  placeholder="Dán danh sách IMEI/Serial vào đây..."
                                  required></textarea>
                        <small>Số dòng IMEI phải <b id="imeiCount">0</b>, bằng Số lượng nhập.</small>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">Lưu Phiếu Nhập</button>
                </form>
            </div>
        </div>
    </div>
    
    <script>
        document.getElementById('receiptForm').addEventListener('submit', function(event) {
            let quantity = document.getElementById('quantity').valueAsNumber;
            let imeiList = document.getElementById('imeiList').value.split('\n').filter(Boolean); // Lọc dòng trống
            
            if (quantity !== imeiList.length) {
                alert('Lỗi: Số lượng IMEI (' + imeiList.length + ') không khớp với số lượng nhập (' + quantity + ').');
                event.preventDefault(); // Ngăn form submit
            }
        });

        // Đếm số IMEI khi người dùng gõ
        document.getElementById('imeiList').addEventListener('input', function() {
            let imeiList = this.value.split('\n').filter(Boolean);
            document.getElementById('imeiCount').textContent = imeiList.length;
        });
    </script>
</body>
</html>
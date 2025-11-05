<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Chi tiết sản phẩm</title>
        <style>
            body {
                font-family: "Segoe UI", Arial, sans-serif;
                background-color: #f5f7fa;
                margin: 0;
                padding: 25px;
            }

            .container {
                max-width: 1200px;
                margin: auto;
                background: #fff;
                padding: 30px 40px;
                border-radius: 14px;
                box-shadow: 0 3px 10px rgba(0,0,0,0.08);
            }

            h2 {
                color: #2c3e50;
                margin-top: 0;
                margin-bottom: 20px;
            }

            .product-header {
                display: flex;
                align-items: center;
                gap: 30px;
                margin-bottom: 30px;
            }

            .product-header img {
                width: 200px;
                height: 200px;
                object-fit: cover;
                border-radius: 12px;
                border: 1px solid #ddd;
            }

            .product-details {
                flex: 1;
            }

            .detail-line {
                margin-bottom: 10px;
            }

            .detail-label {
                font-weight: bold;
                color: #34495e;
            }

            .unit-section {
                margin-top: 40px;
            }

            .unit-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(270px, 1fr));
                gap: 20px;
                margin-top: 20px;
            }

            .unit-card {
                background: #fafafa;
                border: 1px solid #e0e0e0;
                border-radius: 12px;
                padding: 15px 18px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.05);
                transition: transform 0.15s ease-in-out;
            }

            .unit-card:hover {
                transform: translateY(-3px);
            }

            .unit-title {
                font-weight: bold;
                color: #2c3e50;
                margin-bottom: 8px;
            }

            .unit-info {
                font-size: 14px;
                line-height: 1.6;
                color: #555;
            }

            .back-btn {
                display: inline-block;
                background-color: #3498db;
                color: white;
                padding: 10px 20px;
                border-radius: 6px;
                text-decoration: none;
                font-weight: bold;
                margin-top: 25px;
            }

            .back-btn:hover {
                background-color: #2980b9;
            }

            .search-section {
                background: #f9fafc;
                border: 1px solid #e1e4e8;
                border-radius: 10px;
                padding: 20px 25px;
                margin-top: 30px;
            }

            .search-section h3 {
                margin: 0 0 15px 0;
                color: #2c3e50;
                font-size: 18px;
                font-weight: 600;
            }

            .search-form {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            .search-fields {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
            }

            .field {
                display: flex;
                flex-direction: column;
                flex: 1;
                min-width: 220px;
            }

            .field label {
                font-weight: 500;
                color: #34495e;
                margin-bottom: 5px;
            }

            .field input,
            .field select {
                padding: 8px 10px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 14px;
            }

            .search-buttons {
                display: flex;
                gap: 12px;
                margin-top: 10px;
            }

            .btn-search {
                background-color: #3498db;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 6px;
                font-weight: bold;
                cursor: pointer;
            }

            .btn-search:hover {
                background-color: #2980b9;
            }

            .btn-reset {
                background-color: #e0e0e0;
                color: #333;
                text-decoration: none;
                padding: 8px 16px;
                border-radius: 6px;
                font-weight: bold;
            }

            .btn-reset:hover {
                background-color: #bdbdbd;
            }

            .pagination {
                display: inline-block;
                margin-top: 25px;
            }

            .pagination .page-link {
                color: #3498db;
                padding: 8px 12px;
                text-decoration: none;
                border: 1px solid #ddd;
                margin: 0 3px;
                border-radius: 6px;
                font-weight: 500;
            }

            .pagination .page-link:hover {
                background-color: #3498db;
                color: white;
            }

            .pagination .active {
                background-color: #3498db;
                color: white;
                border: 1px solid #2980b9;
            }

        </style>

    </head>
    <body>

        <div class="container">
            <h2>Thông tin sản phẩm ${product.name}</h2>

            <div class="product-header">
                <img src="${product.imageUrl}" alt="Ảnh sản phẩm">
                <div class="product-details">
                    <div class="detail-line"><span class="detail-label">Tên sản phẩm:</span> ${product.name}</div>
                    <div class="detail-line"><span class="detail-label">Thương hiệu:</span> ${product.brandName}</div>
                    <div class="detail-line"><span class="detail-label">SKU:</span> ${product.skuCode}</div>
                    <div class="detail-line"><span class="detail-label">Màn hình:</span> ${product.screenType} - ${product.screenSize} inch</div>
                    <div class="detail-line"><span class="detail-label">Bộ nhớ:</span> ${product.memory}</div>
                    <div class="detail-line"><span class="detail-label">Bộ nhớ lưu trữ:</span> ${product.storage}</div>
                    <div class="detail-line"><span class="detail-label">CPU:</span> ${product.cpu}</div>
                    <div class="detail-line"><span class="detail-label">Camera:</span> ${product.camera} MP</div>
                    <div class="detail-line"><span class="detail-label">Dung lượng pin:</span> ${product.batteryCapacity} mAh</div>
                    <div class="detail-line"><span class="detail-label">Giá nhập:</span> 
                        <fmt:formatNumber value="${product.purchasePrice}" type="currency"/> VND
                    </div>
                </div>
            </div>

            <div class="unit-section">
                <h2>Danh sách đơn vị sản phẩm</h2>
                <c:if test="${not empty error}">
                    <div style="color: #e74c3c; font-weight: bold; margin-bottom: 15px;">
                        ${error}
                    </div>
                </c:if>
                <div class="unit-grid">
                    <c:forEach var="u" items="${units}">
                        <div class="unit-card">
                            <div class="unit-title">Unit #${u.unitId}</div>
                            <div class="unit-info">
                                <div><b>IMEI:</b> ${u.imei}</div>
                                <div><b>Serial:</b> ${u.serialNumber}</div>
                                <div><b>Trạng thái:</b> ${u.status}</div>
                                <div><b>Bảo hành từ:</b> ${u.warrantyStart}</div>
                                <div><b>Đến:</b> ${u.warrantyEnd}</div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <c:set var="actionUrl" value="${pageContext.request.contextPath}/products/view?id=${product.productId}" />
            <c:if test="${not empty param.imei or not empty param.serial or not empty param.status}">
                <c:set var="actionUrl" value="${pageContext.request.contextPath}/product/viewUnit?id=${product.productId}&imei=${param.imei}&serial=${param.serial}&status=${param.status}" />
            </c:if>
            <c:if test="${totalPages > 1}">
                <div class="pagination" style="margin-top: 30px; text-align: center;">
                    <c:if test="${pageIndex > 1}">
                        <a href="${actionUrl}&page=${pageIndex - 1}" class="page-link">« Trước</a>
                    </c:if>

                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <a href="${actionUrl}&page=${i}" 
                           class="page-link ${i == pageIndex ? 'active' : ''}">
                            ${i}
                        </a>
                    </c:forEach>

                    <c:if test="${pageIndex < totalPages}">
                        <a href="${actionUrl}&page=${pageIndex + 1}" class="page-link">Sau »</a>
                    </c:if>
                </div>
            </c:if>

            <div style="text-align: center; margin-top: 20px;">
                <form id="jumpForm" onsubmit="return handleJumpPage(event)" novalidate>
                    <input type="hidden" id="actionUrl" value="${actionUrl}">
                    <label for="jumpPage">Đi tới trang:</label>
                    <input type="number" id="jumpPage" name="page" min="1" max="${totalPages}" 
                           style="width: 70px; padding: 5px;" placeholder="1" required>
                    <button type="submit" style="padding: 6px 10px;">OK</button>
                </form>
            </div>


            <div class="search-section">
                <h3>Tìm kiếm đơn vị sản phẩm</h3>
                <form method="get" action="${pageContext.request.contextPath}/product/viewUnit" class="search-form">
                    <input type="hidden" name="id" value="${product.productId}"/>

                    <div class="search-fields">
                        <div class="field">
                            <label>IMEI:</label>
                            <input type="text" name="imei" placeholder="Nhập IMEI..." value="${param.imei}" />
                        </div>

                        <div class="field">
                            <label>Serial:</label>
                            <input type="text" name="serial" placeholder="Nhập Serial..." value="${param.serial}" />
                        </div>

                        <div class="field">
                            <label>Trạng thái:</label>
                            <select name="status">
                                <option value="">-- Tất cả --</option>
                                <c:forEach var="s" items="${status}">
                                    <option value="${s.statusCode}" 
                                            <c:if test="${param.status eq s.statusCode}">selected</c:if>>
                                        ${s.statusCode}
                                    </option>   
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="search-buttons">
                        <button type="submit" class="btn-search">🔍 Tìm kiếm</button>
                        <a href="${pageContext.request.contextPath}/product/viewUnit?id=${product.productId}" class="btn-reset">Làm mới</a>
                    </div>
                </form>
            </div>



            <a href="${pageContext.request.contextPath}/products" class="back-btn">⬅ Quay lại danh sách sản phẩm</a>
        </div>

        <script>
            function handleJumpPage(event) {
                event.preventDefault();

                const totalPages = ${totalPages};
                const input = document.getElementById('jumpPage');
                const value = parseInt(input.value);
                const baseUrl = document.getElementById('actionUrl').value.trim();

                // Kiểm tra giá trị nhập
                if (isNaN(value) || value < 1) {
                    alert("⚠️ Vui lòng nhập số nguyên dương ≥ 1!");
                    return false;
                }
                if (value > totalPages) {
                    alert("⚠️ Trang nhập vượt quá tổng số trang hiện có (" + totalPages + ").");
                    return false;
                }

                // Điều hướng tới trang được chọn
                window.location.href = baseUrl + "&page=" + value;
                return true;
            }
        </script>

    </body> 
</html>

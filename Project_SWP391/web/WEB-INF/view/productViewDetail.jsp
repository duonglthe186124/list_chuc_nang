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

    <a href="${pageContext.request.contextPath}/products" class="back-btn">⬅ Quay lại danh sách sản phẩm</a>
</div>

</body>
</html>

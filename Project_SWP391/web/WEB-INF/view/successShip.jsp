<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Giao hàng thành công</title>
        <style>
            body {
                font-family: "Segoe UI", Arial, sans-serif;
                background-color: #f7f8fa;
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 700px;
                margin: 80px auto;
                background-color: #fff;
                padding: 30px 40px;
                border-radius: 12px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            h2 {
                color: #28a745;
                margin-bottom: 20px;
                font-size: 26px;
            }

            p {
                font-size: 16px;
                color: #444;
                margin: 8px 0;
            }

            .info-box {
                background-color: #f2fdf5;
                border: 1px solid #d1f2d6;
                padding: 20px;
                border-radius: 10px;
                margin: 20px 0;
                text-align: left;
            }

            .btn {
                display: inline-block;
                background-color: #007bff;
                color: white;
                padding: 10px 20px;
                border-radius: 6px;
                text-decoration: none;
                font-weight: 500;
                transition: background-color 0.2s;
            }

            .btn:hover {
                background-color: #0056b3;
            }

            .footer {
                margin-top: 30px;
                font-size: 13px;
                color: #777;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>✅ Giao hàng đã được tạo thành công!</h2>

            <p>Đơn hàng của bạn đã được cập nhật trạng thái và tạo thông tin giao hàng thành công.</p>

            <div class="info-box">
                <p><strong>Mã đơn hàng:</strong> ${orderId}</p>
                <p><strong>Mã giao hàng:</strong> ${shipNo}</p>
                <p><strong>Trạng thái mới:</strong> ${newStatus}</p>
                <p><strong>Số lượng giao:</strong> ${qty}</p>
                <c:if test="${not empty note}">
                    <p><strong>Ghi chú:</strong> ${note}</p>
                </c:if>
            </div>

            <a href="${pageContext.request.contextPath}/order/list">⬅ Quay lại danh sách đơn hàng</a>
        </div>
    </body>
</html>

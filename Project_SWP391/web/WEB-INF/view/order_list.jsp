<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order List</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .error {
            color: red;
            margin-top: 10px;
        }
        .no-data {
            color: #666;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <h1>Order List</h1>

    <!-- Hiển thị thông báo lỗi nếu có -->
    <c:if test="${not empty errorMessage}">
        <p class="error">${errorMessage}</p>
    </c:if>

    <!-- Kiểm tra và hiển thị thông báo nếu không có đơn hàng -->
    <c:choose>
        <c:when test="${empty orders}">
            <p class="no-data">No orders found.</p>
        </c:when>
        <c:otherwise>
            <table>
                <tr>
                    <th>Order Number</th>
                    <th>Product Name</th>
                    <th>Order Quantity</th>
                    <th>Unit Price</th>
                    <th>Line Amount</th>
                    <th>Customer Name</th>
                    <th>Customer Email</th>
                    <th>Customer Phone</th>
                    <th>Customer Address</th>
                    <th>Order Date</th>
                    <th>Order Status</th>
                    <th>Shipment ID</th>
                    <th>Shipment Date</th>
                    <th>Shipment Status</th>
                    <th>Shipment Note</th>
                    <th>Shipped Quantity</th>
                    <th>Shipper Name</th>
                    <th>Shipper Email</th>
                    <th>Shipper Phone</th>
                </tr>
                <c:forEach var="order" items="${orders}">
                    <tr>
                        <td>${order.orderNumber}</td>
                        <td>${order.productName}</td>
                        <td>${order.orderQuantity}</td>
                        <td><fmt:formatNumber value="${order.productUnitPrice}" type="currency" currencyCode="VND"/></td>
                        <td><fmt:formatNumber value="${order.orderAmount}" type="currency" currencyCode="VND"/></td>
                        <td>${order.cusName}</td>
                        <td>${order.cusEmail}</td>
                        <td>${order.cusPhone}</td>
                        <td>${order.cusAddress}</td>
                        <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
                        <td>${order.orderStatus}</td>
                        <td>${order.shipMentId}</td>
                        <td><fmt:formatDate value="${order.shipmentDate}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
                        <td>${order.shipmentStatus}</td>
                        <td>${order.shipmentNote}</td>
                        <td>${order.shippedQuantity}</td>
                        <td>${order.shipperName}</td>
                        <td>${order.shipperEmail}</td>
                        <td>${order.shipperPhone}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</body>
</html>
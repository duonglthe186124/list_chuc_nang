<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Prepare Shipment #${order.orderId}</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f8f9fa;
                padding: 20px;
            }
            .container {
                max-width: 700px;
                margin: 0 auto;
                background: white;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
            h2 {
                color: #007bff;
                border-bottom: 2px solid #007bff;
                padding-bottom: 10px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
            }
            th, td {
                border: 1px solid #dee2e6;
                padding: 12px;
                text-align: left;
            }
            th {
                background: #007bff;
                color: white;
            }
            .back-btn {
                padding: 10px 20px;
                background: #6c757d;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
            }
            .back-btn:hover {
                background: #5a6268;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Prepare Shipment</h2>
            <h3>Order: #${order.orderId} - ${order.productName}</h3>

            <table>
                <tr><th>Information</th><th>Details</th></tr>
                <tr><td><strong>Product</strong></td><td>${order.productName} (x${order.qty})</td></tr>
                <tr><td><strong>Unit Price</strong></td><td><fmt:formatNumber value="${order.unitPrice}" type="currency" currencyCode="USD"/></td></tr>
                <tr><td><strong>Total Amount</strong></td><td><fmt:formatNumber value="${order.lineAmount}" type="currency" currencyCode="USD"/></td></tr>
                <tr><td><strong>Customer</strong></td><td>${order.cusName}</td></tr>
                <tr><td><strong>Email</strong></td><td>${order.cusEmail}</td></tr>
                <tr><td><strong>Phone</strong></td><td>${order.cusPhone}</td></tr>
                <tr><td><strong>Address</strong></td><td>${order.cusAddress}</td></tr>
                <tr><td><strong>Order Date</strong></td><td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm:ss"/></td></tr>
                <tr><td><strong>Unit ID (for delivery)</strong></td><td><span style="color:green; font-weight:bold;">${order.unitId} (SOLD)</span></td></tr>                
            </table>
            
                    <select name="status">
                        <option value="">-- Status --</option>
                        <c:forEach var="st" items="${statuses}">
                            <option value="${st.statusCode}">${st.statusCode}</option>
                        </c:forEach>
                    </select><br>

            <hr>
            <p style="color:green; font-weight:bold;">This order is ready to create a shipment!</p>
            <a href="javascript:history.back()" class="back-btn">Back to List</a>
        </div>
    </body>
</html>
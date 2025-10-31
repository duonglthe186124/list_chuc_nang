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
            .unit-id {
                color: #28a745;
                font-weight: bold;
            }
        </style>

    </head>
    <body>
        <div class="container">
            <h2>Prepare Shipment</h2>
            <h3>Order: #${order.orderId} - ${order.productName}</h3>

            <table>
                <tr><th>Information</th><th>Details</th></tr>
                <tr><td><strong>Order ID</strong></td><td>${order.orderId}</td></tr>
                <tr><td><strong>Product ID</strong></td><td>${order.productId}</td></tr>
                <tr><td><strong>Product Name</strong></td><td>${order.productName}</td></tr>
                <tr><td><strong>Quantity</strong></td><td>${order.qty}</td></tr>
                <tr><td><strong>Unit Price</strong></td><td><fmt:formatNumber value="${order.unitPrice}" type="currency" currencyCode="USD"/></td></tr>
                <tr><td><strong>Total Amount</strong></td><td><fmt:formatNumber value="${order.lineAmount}" type="currency" currencyCode="USD"/></td></tr>
                <tr><td><strong>Customer ID</strong></td><td>${order.userId}</td></tr>
                <tr><td><strong>Customer</strong></td><td>${order.cusName}</td></tr>
                <tr><td><strong>Email</strong></td><td>${order.cusEmail}</td></tr>
                <tr><td><strong>Phone</strong></td><td>${order.cusPhone}</td></tr>
                <tr><td><strong>Address</strong></td><td>${order.cusAddress}</td></tr>
                <tr><td><strong>Order Date</strong></td><td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td></tr>
                <tr><td><strong>Status</strong></td><td>${order.status}</td></tr>
                <tr>
                    <td><strong>Unit IDs (Will be delivery):</strong></td>
                    <td>
                        <c:choose>
                            <c:when test="${empty unitIds}">
                                Chưa có unit nào được chọn.
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="uid" items="${unitIds}" varStatus="loop">
                                    ${uid}<c:if test="${!loop.last}"> | </c:if>
                                </c:forEach>
                                <br>
                                Total: ${unitIds.size()} unit
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </table>

            <!-- DATA FOR INSERT SHIPMENT - Shipment_Line - Shipment_unit -->
            <form action="${pageContext.request.contextPath}/complete/ship" method="post">

                <!-- Order_id Shipment-->
                <input type="hidden" name="orderId" value="${order.orderId}">

                <!-- product id Shipment_lines-->
                <input type="hidden" name="productId" value="${order.productId}">

                <!-- qty Shipment_lines-->
                <input type="hidden" name="qtyShipLine" value="${order.qty}">

                <!--Unit_ids shipment_units-->
                <c:forEach var="uid" items="${unitIds}">
                    <input type="hidden" name="unitIds" value="${uid}">
                </c:forEach>


                <!-- Hidden info to restore on error -->
                <input type="hidden" name="productName" value="${order.productName}">
                <input type="hidden" name="unitPrice" value="${order.unitPrice}">
                <input type="hidden" name="lineAmount" value="${order.lineAmount}">
                <input type="hidden" name="userId" value="${order.userId}">
                <input type="hidden" name="cusName" value="${order.cusName}">
                <input type="hidden" name="cusEmail" value="${order.cusEmail}">
                <input type="hidden" name="cusPhone" value="${order.cusPhone}">
                <input type="hidden" name="cusAddress" value="${order.cusAddress}">
                <input type="hidden" name="orderDate" value="<fmt:formatDate value='${order.orderDate}' pattern='yyyy-MM-dd HH:mm:ss'/>">
                <input type="hidden" name="status" value="${order.status}">   


                <!-- Order_Status -->
                <label><strong>Update Status:</strong></label>
                <select name="newStatus" style="padding:8px; margin-left:10px;">
                    <option value="">-- Select Status --</option>
                    <c:forEach var="st" items="${statuses}">
                        <option value="${st.statusCode}" ${st.statusCode == order.status ? 'selected' : ''}>
                            ${st.statusCode}
                        </option>
                    </c:forEach>
                </select><br>

                <!-- Ship_no Shipments -->
                <strong>Ship_code:</strong>
                <input type="text" name="ship_no" value="${ship_no != null ? ship_no : ''}" />
                <c:if test="${not empty error}">
                    <div style="color:red; font-weight:bold; margin-top:5px;">
                        ${error}
                    </div>
                </c:if>
                <br>

                <!-- select ship employees -->
                <label><strong>Ship Employees:</strong></label>
                <select name="shipperId">
                    <option value="">-- Select Employee --</option>
                    <c:forEach var="s" items="${shipList}">
                        <option value="${s.eId}">${s.eName}</option>
                    </c:forEach>
                </select><br><br>

                <button type="submit" style="padding:8px 15px; background:#007bff; color:white; border:none; border-radius:5px; cursor:pointer;">
                    Update
                </button>
            </form>

            <hr>
            <p style="color:green; font-weight:bold;">This order is ready to create a shipment!</p>
            <a href="javascript:history.back()" class="back-btn">Back to List</a>
        </div>
    </body>
</html>
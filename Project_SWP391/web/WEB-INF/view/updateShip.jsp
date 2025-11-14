<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Update Shipment</title>
        <style>
            table {
                border-collapse: collapse;
                width: 60%;
                margin: 20px auto;
            }
            th, td {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: left;
            }
            .form-section {
                width: 60%;
                margin: 20px auto;
            }
            label {
                font-weight: bold;
                display: block;
                margin-top: 10px;
            }
            select, textarea, input[type=submit] {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
            }
        </style>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/update_ship.css">
    </head>
    <body>

        <h2 style="text-align:center;">Cập nhật thông tin Shipment</h2>

        <!-- Bảng thông tin shipment -->
        <table class="info-table">
            <tr><th>Shipment ID</th><td>${shipmentId}</td></tr>
            <tr><th>Order ID</th><td>${orderId}</td></tr>
            <tr><th>Product ID</th><td>${productId}</td></tr>
            <tr><th>Product</th><td>${phoneName}</td></tr>
            <tr><th>Customer</th><td>${cusName}</td></tr>
            <tr><th>Phone</th><td>${cusPhone}</td></tr>
            <tr><th>Quantity</th><td>${shipmentQty}</td></tr>
        </table>

        <c:if test="${not empty error}">
            <div class="error-message">
                ${error}
            </div>
        </c:if>


        <!-- Form cập nhật status và note -->
        <div class="form-section">
            <form action="${pageContext.request.contextPath}/confirm/ship" method="post">
                <input type="hidden" name="shipmentId" value="${shipmentId}" />
                <input type="hidden" name="orderId" value="${orderId}" />
                <input type="hidden" name="productId" value="${productId}" />
                <input type="hidden" name="shipmentQty" value="${shipmentQty}" />
                <input type="hidden" name="cusName" value="${cusName}" />
                <input type="hidden" name="cusPhone" value="${cusPhone}" />
                <input type="hidden" name="phoneName" value="${phoneName}" />

                <label>Trạng thái (Status):</label>
                <select name="shipmentStatus">
                    <c:forEach var="st" items="${listStatus}">
                        <option value="${st.statusCode}"
                                <c:if test="${st.statusCode == shipmentStatus}">selected</c:if>>
                            ${st.statusCode}
                        </option>
                    </c:forEach>
                </select>

                <label>Ghi chú (Note):</label>
                <textarea name="shipmentNote" rows="3">${shipmentNote}</textarea><br>
                
                <div class="form-buttons" style="margin-top: 20px; display: flex; gap: 10px; justify-content: flex-end;">
                    <button type="reset" 
                            style="padding: 8px 16px; border: 1px solid #ccc; border-radius: 6px; background-color: #f3f3f3; color: #333; cursor: pointer; transition: 0.2s;"
                            onmouseover="this.style.backgroundColor = '#e0e0e0'" 
                            onmouseout="this.style.backgroundColor = '#f3f3f3'">
                        Cancel
                    </button>

                    <input type="submit" value="Cập nhật Shipment" 
                           style="padding: 8px 16px; border: none; border-radius: 6px; background-color: #4f46e5; color: #fff; font-weight: 600; cursor: pointer; transition: 0.2s;"
                           onmouseover="this.style.backgroundColor = '#4338ca'" 
                           onmouseout="this.style.backgroundColor = '#4f46e5'"/>
                </div>
            </form>
        </div>

    </body>
</html>

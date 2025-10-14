<%-- 
    Document   : audit
    Created on : Oct 12, 2025, 2:25:17 PM
    Author     : Ha Trung KI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/view/layout/header.jsp"/>
<jsp:include page="/WEB-INF/view/layout/sidebar.jsp"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/inventory.css"/>

<div class="content">
    <h2>Inventory Audit</h2>
    <form method="post" class="form-grid">
        <label>Inventory ID:</label>
        <select name="inventoryId">
            <c:forEach var="i" items="${inventoryList}">
                <option value="${i.inventory_id}">${i.inventory_id} - Product ${i.product_id}</option>
            </c:forEach>
        </select>

        <label>Actual Quantity:</label>
        <input type="number" name="actualQty" min="0">

        <label>Note:</label>
        <input type="text" name="note">

        <button type="submit">Audit</button>
    </form>

    <table>
        <thead><tr><th>ID</th><th>Product</th><th>Location</th><th>Qty</th><th>Last Updated</th></tr></thead>
        <tbody>
        <c:forEach var="i" items="${inventoryList}">
            <tr>
                <td>${i.inventory_id}</td>
                <td>${i.product_id}</td>
                <td>${i.location_id}</td>
                <td>${i.qty}</td>
                <td>${i.last_update}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
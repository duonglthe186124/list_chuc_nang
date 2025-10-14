<%-- 
    Document   : inbound
    Created on : Oct 12, 2025, 2:20:07 PM
    Author     : Ha Trung KI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/view/layout/header.jsp"/>
<jsp:include page="/WEB-INF/view/layout/sidebar.jsp"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/inventory.css"/>

<div class="content">
    <h2>Inbound Inventory</h2>
    <form method="post" class="form-grid">
        <label>Product:</label>
        <select name="productId" required>
            <c:forEach var="p" items="${products}">
                <option value="${p.product_id}">${p.product_name}</option>
            </c:forEach>
        </select>

        <label>Location:</label>
        <select name="locationId" required>
            <c:forEach var="l" items="${locations}">
                <option value="${l.location_id}">${l.code}</option>
            </c:forEach>
        </select>

        <label>Quantity:</label>
        <input type="number" name="qty" min="1" required>

        <label>Note:</label>
        <input type="text" name="note" placeholder="Optional note">

        <button type="submit">Add Inbound</button>
    </form>

    <h3>Current Inventory</h3>
    <table>
        <thead>
        <tr><th>ID</th><th>Product</th><th>Location</th><th>Qty</th><th>Last Updated</th></tr>
        </thead>
        <tbody>
        <c:forEach var="i" items="${inboundList}">
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
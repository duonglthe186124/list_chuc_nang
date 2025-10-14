<%-- 
    Document   : move
    Created on : Oct 12, 2025, 2:25:09 PM
    Author     : Ha Trung KI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/view/layout/header.jsp"/>
<jsp:include page="/WEB-INF/view/layout/sidebar.jsp"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/inventory.css"/>

<div class="content">
    <h2>Move Inventory</h2>
    <form method="post" class="form-grid">
        <label>Product:</label>
        <select name="productId">
            <c:forEach var="p" items="${products}">
                <option value="${p.product_id}">${p.product_name}</option>
            </c:forEach>
        </select>

        <label>From Location:</label>
        <select name="fromLocation">
            <c:forEach var="l" items="${locations}">
                <option value="${l.location_id}">${l.code}</option>
            </c:forEach>
        </select>

        <label>To Location:</label>
        <select name="toLocation">
            <c:forEach var="l" items="${locations}">
                <option value="${l.location_id}">${l.code}</option>
            </c:forEach>
        </select>

        <label>Quantity:</label>
        <input type="number" name="qty" min="1">

        <label>Note:</label>
        <input type="text" name="note">

        <button type="submit">Move</button>
    </form>
</div>

<%-- 
    Document   : report
    Created on : Oct 12, 2025, 2:25:41 PM
    Author     : Ha Trung KI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/view/layout/header.jsp"/>
<jsp:include page="/WEB-INF/view/layout/sidebar.jsp"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/inventory.css"/>

<div class="content">
    <h2>Inventory Report</h2>
    <div class="report-grid">
        <div>Total Products: ${report.totalProducts}</div>
        <div>Current Stock: ${report.currentStock}</div>
        <div>Total Inbound: ${report.totalInbound}</div>
        <div>Total Outbound: ${report.totalOutbound}</div>
    </div>

    <table>
        <thead><tr><th>ID</th><th>Product</th><th>Location</th><th>Qty</th><th>Last Updated</th></tr></thead>
        <tbody>
        <c:forEach var="r" items="${inventoryList}">
            <tr>
                <td>${r.inventory_id}</td>
                <td>${r.product_id}</td>
                <td>${r.location_id}</td>
                <td>${r.qty}</td>
                <td>${r.last_update}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
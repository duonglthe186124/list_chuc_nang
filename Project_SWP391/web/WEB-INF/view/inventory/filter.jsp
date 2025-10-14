<%-- 
    Document   : filter
    Created on : Oct 12, 2025, 2:25:35 PM
    Author     : Ha Trung KI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/view/layout/header.jsp"/>
<jsp:include page="/WEB-INF/view/layout/sidebar.jsp"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/inventory.css"/>

<div class="content">
    <h2>Filter Transactions</h2>
    <form method="post" class="form-grid">
        <label>Type:</label>
        <select name="txType">
            <option value="">All</option>
            <option>Inbound</option>
            <option>Outbound</option>
            <option>Moving</option>
        </select>

        <label>From:</label>
        <input type="date" name="from">
        <label>To:</label>
        <input type="date" name="to">

        <label>Product:</label>
        <select name="productId">
            <option value="">All</option>
            <c:forEach var="p" items="${products}">
                <option value="${p.product_id}">${p.product_name}</option>
            </c:forEach>
        </select>

        <label>Employee:</label>
        <select name="employeeId">
            <option value="">All</option>
            <c:forEach var="e" items="${employees}">
                <option value="${e.employee_id}">${e.fullname}</option>
            </c:forEach>
        </select>

        <button type="submit">Filter</button>
    </form>

    <h3>Results</h3>
    <table>
        <thead><tr><th>ID</th><th>Type</th><th>Product</th><th>Qty</th><th>Date</th><th>Note</th></tr></thead>
        <tbody>
        <c:forEach var="tx" items="${txList}">
            <tr>
                <td>${tx.tx_id}</td>
                <td>${tx.tx_type}</td>
                <td>${tx.product_id}</td>
                <td>${tx.qty}</td>
                <td>${tx.tx_date}</td>
                <td>${tx.note}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
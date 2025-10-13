<%-- 
    Document   : filter
    Created on : Oct 12, 2025, 2:25:35 PM
    Author     : Ha Trung KI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/sidebar.jsp" %>
<!DOCTYPE html>
<html>
<div class="main-content">
    <h2>🔍 Filter Inventory Records</h2>

    <form class="filter-form" method="get" action="filter">
        <label>Transaction Type:</label>
        <select name="txType">
            <option value="">All</option>
            <option value="inbound">Inbound</option>
            <option value="outbound">Outbound</option>
            <option value="move">Move</option>
        </select>

        <label>Product ID:</label>
        <input type="number" name="productId">

        <label>Date Range:</label>
        <input type="date" name="from"> to 
        <input type="date" name="to">

        <button type="submit">Filter</button>
    </form>

    <table class="data-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Type</th>
                <th>Product</th>
                <th>Qty</th>
                <th>Date</th>
                <th>Employee</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="tx" items="${txList}">
                <tr>
                    <td>${tx.tx_id}</td>
                    <td>${tx.tx_type}</td>
                    <td>${tx.product_name}</td>
                    <td>${tx.qty}</td>
                    <td>${tx.tx_date}</td>
                    <td>${tx.employee_name}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</html>
<%@ include file="../layout/footer.jsp" %>

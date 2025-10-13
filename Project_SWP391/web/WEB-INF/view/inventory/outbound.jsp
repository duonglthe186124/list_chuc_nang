<%-- 
    Document   : outbound
    Created on : Oct 12, 2025, 2:24:27 PM
    Author     : Ha Trung KI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/sidebar.jsp" %>
<!DOCTYPE html>
<html>
<div class="main-content">
    <h2>🚚 Outbound Inventory</h2>
    <div class="toolbar">
        <button class="btn-add" onclick="location.href='outbound?action=add'">+ Add Outbound Record</button>
        <form class="search-box" method="get" action="outbound">
            <input type="text" name="keyword" placeholder="Search product...">
            <button type="submit">Search</button>
        </form>
    </div>

    <table class="data-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Product</th>
                <th>Qty</th>
                <th>Date</th>
                <th>Destination</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="outbound" items="${outboundList}">
                <tr>
                    <td>${outbound.outbound_id}</td>
                    <td>${outbound.product_name}</td>
                    <td>${outbound.qty}</td>
                    <td>${outbound.date}</td>
                    <td>${outbound.destination}</td>
                    <td>
                        <a href="outbound?action=edit&id=${outbound.outbound_id}" class="btn-edit">Edit</a>
                        <a href="outbound?action=delete&id=${outbound.outbound_id}" class="btn-delete">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</html>
<%@ include file="../layout/footer.jsp" %>
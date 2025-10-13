<%-- 
    Document   : inbound
    Created on : Oct 12, 2025, 2:20:07 PM
    Author     : Ha Trung KI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/sidebar.jsp" %>
<!DOCTYPE html>
<html>
<div class="main-content">
    <h2>📦 Inbound Inventory</h2>
    <div class="toolbar">
        <button class="btn-add" onclick="location.href='inbound?action=add'">+ Add Inbound Record</button>
        <form class="search-box" method="get" action="inbound">
            <input type="text" name="keyword" placeholder="Search product or supplier...">
            <button type="submit">Search</button>
        </form>
    </div>

    <table class="data-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Supplier</th>
                <th>Product</th>
                <th>Qty</th>
                <th>Date</th>
                <th>Warehouse</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="inbound" items="${inboundList}">
                <tr>
                    <td>${inbound.inbound_id}</td>
                    <td>${inbound.supplier_name}</td>
                    <td>${inbound.product_name}</td>
                    <td>${inbound.qty}</td>
                    <td>${inbound.date}</td>
                    <td>${inbound.location_code}</td>
                    <td>
                        <a href="inbound?action=edit&id=${inbound.inbound_id}" class="btn-edit">Edit</a>
                        <a href="inbound?action=delete&id=${inbound.inbound_id}" class="btn-delete">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</html>
<%@ include file="../layout/footer.jsp" %>

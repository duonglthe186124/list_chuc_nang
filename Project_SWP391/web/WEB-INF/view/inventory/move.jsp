<%-- 
    Document   : move
    Created on : Oct 12, 2025, 2:25:09 PM
    Author     : Ha Trung KI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/sidebar.jsp" %>
<!DOCTYPE html>
<html>
<div class="main-content">
    <h2>🔄 Move / Transfer Inventory</h2>
    <div class="toolbar">
        <button class="btn-add" onclick="location.href='move?action=add'">+ Add Move Record</button>
    </div>

    <table class="data-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Product</th>
                <th>From Location</th>
                <th>To Location</th>
                <th>Qty</th>
                <th>Date</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="move" items="${moveList}">
                <tr>
                    <td>${move.tx_id}</td>
                    <td>${move.product_name}</td>
                    <td>${move.from_location_name}</td>
                    <td>${move.to_location_name}</td>
                    <td>${move.qty}</td>
                    <td>${move.tx_date}</td>
                    <td>
                        <a href="move?action=edit&id=${move.tx_id}" class="btn-edit">Edit</a>
                        <a href="move?action=delete&id=${move.tx_id}" class="btn-delete">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</html>
<%@ include file="../layout/footer.jsp" %>

<%-- 
    Document   : quality
    Created on : Oct 12, 2025, 2:25:28 PM
    Author     : Ha Trung KI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/sidebar.jsp" %>
<!DOCTYPE html>
<html>
<div class="main-content">
    <h2>🧪 Quality Control</h2>
    <div class="toolbar">
        <button class="btn-add" onclick="location.href='quality?action=add'">+ Add QC Record</button>
    </div>

    <table class="data-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Product</th>
                <th>Inspector</th>
                <th>State</th>
                <th>Error</th>
                <th>Date</th>
                <th>Remarks</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="qc" items="${qcList}">
                <tr>
                    <td>${qc.qc_id}</td>
                    <td>${qc.product_name}</td>
                    <td>${qc.inspector_name}</td>
                    <td>${qc.state}</td>
                    <td>${qc.error}</td>
                    <td>${qc.qc_date}</td>
                    <td>${qc.remarks}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</html>
<%@ include file="../layout/footer.jsp" %>
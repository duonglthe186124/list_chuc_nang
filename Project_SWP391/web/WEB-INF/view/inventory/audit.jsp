<%-- 
    Document   : audit
    Created on : Oct 12, 2025, 2:25:17 PM
    Author     : Ha Trung KI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/sidebar.jsp" %>
<!DOCTYPE html>
<html>
<div class="main-content">
    <h2>📋 Inventory Audit</h2>
    <p>Compare recorded vs actual quantities.</p>
    <table class="data-table">
        <thead>
            <tr>
                <th>Product</th>
                <th>Recorded Qty</th>
                <th>Actual Qty</th>
                <th>Difference</th>
                <th>Auditor</th>
                <th>Date</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="audit" items="${auditList}">
                <tr>
                    <td>${audit.product_name}</td>
                    <td>${audit.recorded_qty}</td>
                    <td>${audit.actual_qty}</td>
                    <td>${audit.diff}</td>
                    <td>${audit.employee_name}</td>
                    <td>${audit.date}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</html>
<%@ include file="../layout/footer.jsp" %>

<%-- 
    Document   : quality
    Created on : Oct 12, 2025, 2:25:28 PM
    Author     : Ha Trung KI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/view/layout/header.jsp"/>
<jsp:include page="/WEB-INF/view/layout/sidebar.jsp"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/inventory.css"/>

<div class="content">
    <h2>Quality Control</h2>
    <form method="post" class="form-grid">
        <label>Product:</label>
        <select name="productId">
            <c:forEach var="p" items="${products}">
                <option value="${p.product_id}">${p.product_name}</option>
            </c:forEach>
        </select>

        <label>Inspector ID:</label>
        <input type="number" name="inspectorId" min="1" required>

        <label>State:</label>
        <select name="state">
            <option>Passed</option>
            <option>Failed</option>
        </select>

        <label>Error:</label>
        <input type="text" name="error">

        <label>Remarks:</label>
        <input type="text" name="remarks">

        <button type="submit">Submit QC</button>
    </form>

    <h3>Quality Records</h3>
    <table>
        <thead><tr><th>ID</th><th>Inspector</th><th>Date</th><th>State</th><th>Error</th><th>Remarks</th></tr></thead>
        <tbody>
        <c:forEach var="q" items="${qcList}">
            <tr>
                <td>${q.qc_id}</td>
                <td>${q.inspector_id}</td>
                <td>${q.qc_date}</td>
                <td>${q.state}</td>
                <td>${q.error}</td>
                <td>${q.remarks}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<%-- 
    Document   : sidebar
    Created on : Oct 12, 2025, 2:15:59 PM
    Author     : Ha Trung KI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<aside class="sidebar">
    <nav class="nav">
        <ul>
            <li><a href="${pageContext.request.contextPath}/dashboard">🏠 Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/inbound">📦 Inbound Inventory</a></li>
            <li><a href="${pageContext.request.contextPath}/outbound">🚚 Outbound Inventory</a></li>
            <li><a href="${pageContext.request.contextPath}/move">🔄 Move / Transfer</a></li>
            <li><a href="${pageContext.request.contextPath}/audit">📋 Stock Audit</a></li>
            <li><a href="${pageContext.request.contextPath}/quality">🧪 Quality Control</a></li>
            <li><a href="${pageContext.request.contextPath}/filter">🔍 Filter Records</a></li>
            <li><a href="${pageContext.request.contextPath}/report">📊 Reports</a></li>
        </ul>
    </nav>
</aside>
</html>

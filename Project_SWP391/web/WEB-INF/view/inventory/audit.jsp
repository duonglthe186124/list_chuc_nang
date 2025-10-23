<%-- 
    Document   : audit
    Created on : Oct 23, 2025, 11:49:17 PM
    Author     : Ha Trung KI
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Stock Audit Logs</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
</head>
<body>
    <div class="layout">
        <aside class="sidebar">
            <h3>Warehouse Menu</h3>
            <div class="sidebar-menu">
                <a href="${pageContext.request.contextPath}/inventory" class="menu-item">Inventory</a>
                <a href="${pageContext.request.contextPath}/inbound" class="menu-item">Inbound</a>
                <a href="${pageContext.request.contextPath}/audit" class="menu-item active">Stock Audit</a>
                <a href="${pageContext.request.contextPath}/quality" class="menu-item">Quality Inspection</a>
                <a href="${pageContext.request.contextPath}/filter" class="menu-item">Transaction Filter</a>
            </div>
        </aside>

        <main class="main">
            <div class="main-header">
                <h1>Stock Audit Logs</h1>
            </div>

            <div class="table-container">
                <table class="transaction-table">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>User</th>
                            <th>Event Type</th>
                            <th>Reference Table</th>
                            <th>Reference ID</th>
                            <th>Value</th>
                            <th>Detail</th>
                            <th>Note</th>
                            <th>Event Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="a" items="${audits}" varStatus="st">
                            <tr>
                                <td>${st.count}</td>
                                <td>${a.user_fullname}</td>
                                <td>${a.event_type}</td>
                                <td>${a.reference_table}</td>
                                <td>${a.reference_id}</td>
                                <td>${a.monetary_value}</td>
                                <td>${a.detail}</td>
                                <td>${a.note}</td>
                                <td>${a.event_time}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</body>
</html>

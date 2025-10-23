<%-- 
    Document   : quality
    Created on : Oct 23, 2025, 11:49:46 PM
    Author     : Ha Trung KI
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quality Inspection Reports</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
</head>
<body>
    <div class="layout">
        <aside class="sidebar">
            <h3>Warehouse Menu</h3>
            <div class="sidebar-menu">
                <a href="${pageContext.request.contextPath}/inventory" class="menu-item">Inventory</a>
                <a href="${pageContext.request.contextPath}/inbound" class="menu-item">Inbound</a>
                <a href="${pageContext.request.contextPath}/audit" class="menu-item">Stock Audit</a>
                <a href="${pageContext.request.contextPath}/quality" class="menu-item active">Quality Inspection</a>
                <a href="${pageContext.request.contextPath}/filter" class="menu-item">Transaction Filter</a>
            </div>
        </aside>

        <main class="main">
            <div class="main-header">
                <h1>Quality Inspection Reports</h1>
            </div>

            <div class="table-container">
                <table class="transaction-table">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Inspection No</th>
                            <th>Employee</th>
                            <th>Location</th>
                            <th>Status</th>
                            <th>Result</th>
                            <th>Note</th>
                            <th>Inspected Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="q" items="${qualityList}" varStatus="st">
                            <tr>
                                <td>${st.count}</td>
                                <td>${q.inspection_no}</td>
                                <td>${q.employee_code} - ${q.fullname}</td>
                                <td>${q.location_code}</td>
                                <td>${q.status}</td>
                                <td>${q.result}</td>
                                <td>${q.note}</td>
                                <td>${q.inspected_at}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</body>
</html>

<%-- 
    Document   : inbound
    Created on : Oct 23, 2025, 11:48:46 PM
    Author     : Ha Trung KI
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Inbound Receipts</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
</head>
<body>
    <div class="layout">
        <aside class="sidebar">
            <h3>Warehouse Menu</h3>
            <div class="sidebar-menu">
                <a href="${pageContext.request.contextPath}/inventory" class="menu-item">Inventory</a>
                <a href="${pageContext.request.contextPath}/inbound" class="menu-item active">Inbound</a>
                <a href="${pageContext.request.contextPath}/audit" class="menu-item">Stock Audit</a>
                <a href="${pageContext.request.contextPath}/quality" class="menu-item">Quality Inspection</a>
                <a href="${pageContext.request.contextPath}/filter" class="menu-item">Transaction Filter</a>
            </div>
        </aside>

        <main class="main">
            <div class="main-header">
                <h1>Inbound Receipts</h1>
            </div>

            <div class="table-container">
                <table class="transaction-table">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Receipt No</th>
                            <th>Supplier</th>
                            <th>Created By</th>
                            <th>Status</th>
                            <th>Received Date</th>
                            <th>Note</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${receipts}" varStatus="st">
                            <tr>
                                <td>${st.count}</td>
                                <td>${r.receipts_no}</td>
                                <td>${r.supplier_name}</td>
                                <td>${r.employee_name}</td>
                                <td>${r.status}</td>
                                <td>${r.received_at}</td>
                                <td>${r.note}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</body>
</html>

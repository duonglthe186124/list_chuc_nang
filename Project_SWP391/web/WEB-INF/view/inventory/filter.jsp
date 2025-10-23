<%-- 
    Document   : filter
    Created on : Oct 23, 2025, 11:50:04 PM
    Author     : Ha Trung KI
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Transaction Filter</title>
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
                <a href="${pageContext.request.contextPath}/quality" class="menu-item">Quality Inspection</a>
                <a href="${pageContext.request.contextPath}/filter" class="menu-item active">Transaction Filter</a>
            </div>
        </aside>

        <main class="main">
            <div class="main-header">
                <h1>Transaction Filter</h1>
            </div>

            <form method="get">
                <div style="display:flex;gap:10px;margin-bottom:12px;">
                    <input type="text" name="employee" placeholder="Employee code..." value="${param.employee}" />
                    <select name="type">
                        <option value="">All types</option>
                        <option value="Inbound">Inbound</option>
                        <option value="Outbound">Outbound</option>
                        <option value="Moving">Moving</option>
                        <option value="Destroy">Destroy</option>
                    </select>
                    <button type="submit">Filter</button>
                </div>
            </form>

            <div class="table-container">
                <table class="transaction-table">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Transaction Type</th>
                            <th>Product</th>
                            <th>Employee</th>
                            <th>Fullname</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="f" items="${filteredList}" varStatus="st">
                            <tr>
                                <td>${st.count}</td>
                                <td>${f.tx_type}</td>
                                <td>${f.product_name}</td>
                                <td>${f.employee_code}</td>
                                <td>${f.fullname}</td>
                                <td>${f.tx_date}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</body>
</html>

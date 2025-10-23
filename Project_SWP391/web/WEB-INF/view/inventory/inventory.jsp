<%-- 
    Document   : inventory
    Created on : Oct 23, 2025, 11:48:04 PM
    Author     : Ha Trung KI
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Inventory Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
</head>
<body>
    <div class="layout">
        <aside class="sidebar">
            <h3>Warehouse Menu</h3>
            <div class="sidebar-menu">
                <a href="${pageContext.request.contextPath}/inventory" class="menu-item active">Inventory</a>
                <a href="${pageContext.request.contextPath}/inbound" class="menu-item">Inbound</a>
                <a href="${pageContext.request.contextPath}/audit" class="menu-item">Stock Audit</a>
                <a href="${pageContext.request.contextPath}/quality" class="menu-item">Quality Inspection</a>
                <a href="${pageContext.request.contextPath}/filter" class="menu-item">Transaction Filter</a>
            </div>
        </aside>

        <main class="main">
            <div class="main-header">
                <h1>Inventory Management</h1>
            </div>

            <div class="table-container">
                <table class="transaction-table">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Product</th>
                            <th>SKU Code</th>
                            <th>Quantity</th>
                            <th>Available Units</th>
                            <th>Last Updated</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="i" items="${inventories}" varStatus="st">
                            <tr>
                                <td>${st.count}</td>
                                <td>${i.product_name}</td>
                                <td>${i.sku_code}</td>
                                <td>${i.total_qty}</td>
                                <td>${i.available_qty}</td>
                                <td>${i.last_updated}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</body>
</html>

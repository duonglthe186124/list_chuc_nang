<%-- 
    Document   : report
    Created on : Oct 12, 2025, 2:25:41 PM
    Author     : Ha Trung KI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/sidebar.jsp" %>
<!DOCTYPE html>
<html>
<div class="main-content">
    <h2>📊 Inventory Reports</h2>

    <div class="report-section">
        <h3>Overview</h3>
        <p>Total Products: ${report.totalProducts}</p>
        <p>Total Inbound: ${report.totalInbound}</p>
        <p>Total Outbound: ${report.totalOutbound}</p>
        <p>Current Stock: ${report.currentStock}</p>
    </div>

    <div class="report-chart">
        <canvas id="inventoryChart"></canvas>
    </div>
</div>
</html>

<%@ include file="../layout/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
const ctx = document.getElementById('inventoryChart');
new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ['Inbound', 'Outbound', 'Available'],
        datasets: [{
            label: 'Quantity',
            data: [${report.totalInbound}, ${report.totalOutbound}, ${report.currentStock}],
            borderWidth: 1
        }]
    },
    options: { scales: { y: { beginAtZero: true } } }
});
</script>
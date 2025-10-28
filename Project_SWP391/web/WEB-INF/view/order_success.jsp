<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Order Success</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 50px;
        }
        .button {
            padding: 10px 20px;
            margin: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h1>Order Created Successfully!</h1>
    <p>Your order has been processed.</p>
    <%
        String contextPath = request.getContextPath();
        Integer userId = request.getParameter("userId") != null ? Integer.parseInt(request.getParameter("userId")) : null;
        Integer orderId = request.getParameter("orderId") != null ? Integer.parseInt(request.getParameter("orderId")) : null;
        if (userId != null && orderId != null) {
            out.println("<p>Order ID: " + orderId + "</p>");
        }
    %>
    <form action="<%= contextPath %>/products" method="get">
        <button type="submit" class="button">Quay về trang products</button>
    </form>
    <form action="<%= contextPath %>/order/list" method="get">
        <input type="hidden" name="userId" value="<%= userId %>">
        <input type="hidden" name="orderId" value="<%= orderId %>">
        <button type="submit" class="button">Xem Order List</button>
    </form>
</body>
</html>
<%-- 
    Document   : product_screen
    Created on : 4 thg 10, 2025, 16:50:46
    Author     : hoang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Products Screen</h1>
        <form action="${pageContext.request.contextPath}/products/search" method="get" class="search-form">
            <input type="text" name="keyword" placeholder="Search product by name" value="${param.keyword}">
            <button type="submit">Search</button>
        </form>

        <form action="${pageContext.request.contextPath}/products/filter" method="get">
            <label>Price:</label>
            <select name="price">
                <option value="">-- Select --</option>
                <option value="1">$0 - $100</option>
                <option value="2">$100 - $300</option>
                <option value="3">$300 - $500</option>
                <option value="4">$500 - $800</option>
                <option value="5">$800+</option>
            </select><br>

            <label>Brand:</label>
            <select name="brand">
                <option value="">-- Select --</option>
                <option value="1">Apple</option>
                <option value="2">Samsung</option>
                <option value="3">Xiaomi</option>
                <option value="4">Oppo</option>
                <option value="5">Vivo</option>
            </select><br>

            <label>CPU:</label>
            <select name="cpu">
                <option value="">-- Select --</option>
                <option value="1">i3</option>
                <option value="2">i5</option>
                <option value="3">i7</option>
                <option value="4">Ryzen 5</option>
                <option value="5">Ryzen 7</option>
            </select><br>

            <label>Memory (RAM):</label>
            <select name="memory">
                <option value="">-- Select --</option>
                <option value="1">4GB</option>
                <option value="2">8GB</option>
                <option value="3">16GB</option>
                <option value="4">32GB</option>
                <option value="5">64GB</option>
            </select><br>

            <label>Storage:</label>
            <select name="storage">
                <option value="">-- Select --</option>
                <option value="1">64GB</option>
                <option value="2">128GB</option>
                <option value="3">256GB</option>
                <option value="4">512GB</option>
                <option value="5">1TB</option>
            </select><br>

            <label>Color:</label>
            <select name="color">
                <option value="">-- Select --</option>
                <option value="1">Black</option>
                <option value="2">White</option>
                <option value="3">Blue</option>
                <option value="4">Red</option>
                <option value="5">Green</option>
            </select><br>

            <label>Battery Capacity:</label>
            <select name="battery">
                <option value="">-- Select --</option>
                <option value="1">3000mAh</option>
                <option value="2">4000mAh</option>
                <option value="3">5000mAh</option>
                <option value="4">6000mAh</option>
                <option value="5">7000mAh</option>
            </select><br>

            <label>Screen Size:</label>
            <select name="screen_size">
                <option value="">-- Select --</option>
                <option value="1">5 inch</option>
                <option value="2">6 inch</option>
                <option value="3">6.5 inch</option>
                <option value="4">7 inch</option>
                <option value="5">8 inch</option>
            </select><br>

            <label>Screen Type:</label>
            <select name="screen_type">
                <option value="">-- Select --</option>
                <option value="1">LCD</option>
                <option value="2">OLED</option>
                <option value="3">AMOLED</option>
                <option value="4">Super AMOLED</option>
                <option value="5">Retina</option>
            </select><br>

            <label>Camera:</label>
            <select name="camera">
                <option value="">-- Select --</option>
                <option value="1">8MP</option>
                <option value="2">12MP</option>
                <option value="3">48MP</option>
                <option value="4">64MP</option>
                <option value="5">108MP</option>
            </select><br><br>

            <button type="submit">Apply Filter</button>
            <button type="reset">Reset</button>
        </form><br><!-- comment -->
        <a href="${pageContext.request.contextPath}/products/add">
            <button type="button">Add Product</button>
        </a>


    </body>
</html>

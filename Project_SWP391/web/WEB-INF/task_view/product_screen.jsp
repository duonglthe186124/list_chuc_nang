<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Products Screen</h1><br><!-- comment -->
        <a href="${pageContext.request.contextPath}/index.htm">
            <button type="button">Home</button>
        </a><br>
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
        </form><br>

        <a href="${pageContext.request.contextPath}/products/add">
            <button type="button">Add Product</button>
        </a>

        <table border="1" cellpadding="5" cellspacing="0">
            <tr>
                <th>Name</th>
                <th>Brand</th>
                <th>CPU</th>
                <th>Memory</th>
                <th>Storage</th>
                <th>Camera</th>
                <th>Type</th>
                <th>Quantity</th>
                <th>Image</th>
                <th>Actions</th>
            </tr>

            <c:forEach var="p" items="${products}">
                <tr>
                    <td>${p.productName}</td>
                    <td>${p.brandName}</td>
                    <td>${p.cpu}</td>
                    <td>${p.memory}</td>
                    <td>${p.storage}</td>
                    <td>${p.camera}</td>
                    <td>${p.typeName}</td>
                    <td>${p.qty}</td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty p.imageUrl}">
                                ${p.imageUrl}
                            </c:when>
                            <c:otherwise>
                                <i>No image URL</i>
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>
                        <form action="${pageContext.request.contextPath}/products/view" method="get" style="display:inline;">
                            <input type="hidden" name="id" value="${p.productId}">
                            <button type="submit">View</button>
                        </form>

                        <form action="${pageContext.request.contextPath}/products/edit" method="get" style="display:inline;">
                            <input type="hidden" name="id" value="${p.productId}">
                            <button type="submit">Edit</button>
                        </form>

                        <form action="${pageContext.request.contextPath}/products/delete" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="${p.productId}">
                            <button type="submit" onclick="return confirm('Are you sure to delete this product?')">Delete</button>
                        </form>

                        <form action="${pageContext.request.contextPath}/products/order" method="post" style="display:inline;">
                            <input type="hidden" name="id" value="${p.productId}">
                            <button type="submit">Order</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <!-- ✅ Phân trang nâng cao -->
        <div style="margin-top:20px; text-align:center;">

            <c:if test="${totalPages > 1}">
                <c:set var="maxPageDisplay" value="5" />
                <c:set var="startPage" value="${((pageIndex - 1) / maxPageDisplay) * maxPageDisplay + 1}" />
                <c:set var="endPage" value="${startPage + maxPageDisplay - 1}" />
                <c:if test="${endPage > totalPages}">
                    <c:set var="endPage" value="${totalPages}" />
                </c:if>

                <!-- Nút Prev -->
                <c:if test="${pageIndex > 1}">
                    <a href="${pageContext.request.contextPath}/products?page=${pageIndex - 1}">Prev</a>
                </c:if>

                <!-- Hiển thị các số trang trong khung -->
                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                    <c:choose>
                        <c:when test="${i == pageIndex}">
                            <b>[${i}]</b>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/products?page=${i}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                    &nbsp;
                </c:forEach>

                <!-- Nút Next -->
                <c:if test="${pageIndex < totalPages}">
                    <a href="${pageContext.request.contextPath}/products?page=${pageIndex + 1}">Next</a>
                </c:if>
            </c:if>

        </div>

        <!-- ✅ Ô nhập trang nhanh -->
        <div style="margin-top:15px;">
            <label for="goToPage">Go to page:</label>
            <input type="number" id="goToPage" min="1" max="${totalPages}" style="width:60px;">
            <button type="button" onclick="jumpToPage()">Go</button>
        </div>

        <script>
            function jumpToPage() {
                const input = document.getElementById("goToPage");
                const page = parseInt(input.value);
                const total = ${totalPages};

                if (isNaN(page) || page < 1) {
                    alert("⚠️ Please enter a positive number (≥ 1).");
                    return;
                }
                if (page > total) {
                    alert("⚠️ Page " + page + " exceeds total " + total + " pages.");
                    return;
                }

                // Điều hướng đến trang được nhập
                window.location.href = "${pageContext.request.contextPath}/products?page=" + page;
            }
        </script>


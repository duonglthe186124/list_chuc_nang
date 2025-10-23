<%-- 
    Document   : product_search_filter
    Created on : 11 thg 10, 2025, 19:31:20
    Author     : hoang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Filtered Products</title>
    </head>
    <body>
        <h1>Products Screen</h1>
        <a href="${pageContext.request.contextPath}/index.htm">
            <button type="button">Home</button>
        </a><br>

        <!-- 🔍 Ô tìm kiếm chung -->
        <form action="${pageContext.request.contextPath}/products/filter" method="get" class="search-form">
            <input type="text" name="keyword" placeholder="Search by name or code" value="${param.keyword}">
            <button type="submit">Search</button>
        </form>

        <!-- 🎯 Form lọc nâng cao -->
        <form action="${pageContext.request.contextPath}/products/filter" method="get">
            <label>Price:</label>
            <select name="price">
                <option value="">-- Select Price --</option>
                <c:forEach var="r" items="${priceRanges}">
                    <c:choose>
                        <c:when test="${empty r.max}">
                            <option value="${r.min}+" <c:if test="${param.price == r.min.toString().concat('+')}">selected</c:if>>${r.label}</option>
                        </c:when>
                        <c:otherwise>
                            <option value="${r.min}-${r.max}" <c:if test="${param.price == r.min.toString().concat('-').concat(r.max.toString())}">selected</c:if>>${r.label}</option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </select><br>

            <label>Brand:</label>
            <select name="brand" id="brand">
                <option value="">-- Select Brand --</option>
                <c:forEach var="b" items="${brandOptions}">
                    <option value="${b.brandName}" <c:if test="${param.brand == b.brandName}">selected</c:if>>${b.brandName}</option>
                </c:forEach>
            </select>

            <label>CPU:</label>
            <select name="cpu">
                <option value="">-- Select --</option>             
                <c:forEach var="c" items="${cpuOptions}">
                    <option value="${c.cpu}" <c:if test="${param.cpu == c.cpu}">selected</c:if>>${c.cpu}</option>
                </c:forEach>
            </select><br>

            <label>Memory (RAM):</label>
            <select name="memory">
                <option value="">-- Select --</option>               
                <c:forEach var="m" items="${memoryOptions}">
                    <option value="${m.memory}" <c:if test="${param.memory == m.memory}">selected</c:if>>${m.memory}</option>
                </c:forEach>
            </select><br>

            <label>Storage:</label>
            <select name="storage">
                <option value="">-- Select --</option>
                <c:forEach var="s" items="${storageOptions}">
                    <option value="${s.storage}" <c:if test="${param.storage == s.storage}">selected</c:if>>${s.storage}</option>
                </c:forEach>
            </select><br>

            <label>Color:</label>
            <select name="color">
                <option value="">-- Select --</option>
                <c:forEach var="co" items="${colorOptions}">
                    <option value="${co.color}" <c:if test="${param.color == co.color}">selected</c:if>>${co.color}</option>
                </c:forEach>
            </select><br>

            <label>Battery Capacity:</label>
            <select name="battery">
                <option value="">-- Select --</option>
                <c:forEach var="ba" items="${batteryOptions}">
                    <option value="${ba.battery}" <c:if test="${param.battery == ba.battery}">selected</c:if>>${ba.battery} mAh</option>
                </c:forEach>
            </select><br>

            <label>Screen Size:</label>
            <select name="screen_size">
                <option value="">-- Select --</option>
                <c:forEach var="ss" items="${ScreenSizeOptions}">
                    <option value="${ss.screenSize}" <c:if test="${param.screen_size == ss.screenSize}">selected</c:if>>${ss.screenSize}</option>
                </c:forEach>
            </select><br>

            <label>Screen Type:</label>
            <select name="screen_type">
                <option value="">-- Select --</option>
                <c:forEach var="st" items="${ScreenTypeOptions}">
                    <option value="${st.screenType}" <c:if test="${param.screen_type == st.screenType}">selected</c:if>>${st.screenType}</option>
                </c:forEach>
            </select><br>

            <label>Camera:</label>
            <select name="camera">
                <option value="">-- Select --</option>
                <c:forEach var="cam" items="${cameraOptions}">
                    <option value="${cam.camera}" <c:if test="${param.camera == cam.camera}">selected</c:if>>${cam.camera} MP</option>
                </c:forEach>
            </select><br><br>

            <button type="submit">Apply Filter</button>
            <button type="reset" onclick="window.location.href = '${pageContext.request.contextPath}/products'">Reset</button>
        </form><br>

        <a href="${pageContext.request.contextPath}/products/add">
            <button type="button">Add Product</button>
        </a>

        <a href="${pageContext.request.contextPath}/order/list">
            <button type="button">View Order List</button>
        </a>   

        <c:choose>
            <c:when test="${not empty notFoundMessage}">
                <div style="color:red; font-weight:bold; margin-top:20px;">
                    ${notFoundMessage}
                </div>
            </c:when>
            <c:otherwise>
                <table border="1" cellpadding="5" cellspacing="0">
                    <tr>
                        <th>Name</th>
                        <th>Brand</th>  
                        <th>Code</th>
                        <th>CPU</th>
                        <th>Memory</th>
                        <th>Storage</th>
                        <th>Camera</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Image</th>
                        <th>Actions</th>
                    </tr>

                    <c:forEach var="p" items="${products}">
                        <tr>
                            <td>${p.productName}</td>
                            <td>${p.brandName}</td>
                            <td>${p.sku_code}</td>
                            <td>${p.cpu}</td>
                            <td>${p.memory}</td>
                            <td>${p.storage}</td>
                            <td>${p.camera}</td>
                            <td>${p.qty}</td>
                            <td>${p.price}</td>
                            <td style="text-align:center;">
                                <c:choose>
                                    <c:when test="${not empty p.imageUrl}">
                                        <img src="${p.imageUrl}" alt="Product image" width="80" height="80" style="object-fit: cover; border-radius: 8px;" />
                                    </c:when>
                                    <c:otherwise><i>No image</i></c:otherwise>
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
                                <form action="${pageContext.request.contextPath}/order" method="get" style="display:inline;">
                                    <input type="hidden" name="id" value="${p.productId}">
                                    <button type="submit">Order</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </c:otherwise>
        </c:choose>

        <div style="margin-top:20px; text-align:center;">
            <c:if test="${totalPages > 1}">
                <c:set var="maxPageDisplay" value="3" />
                <c:set var="startPage" value="${((pageIndex - 1) / maxPageDisplay) * maxPageDisplay + 1}" />
                <c:set var="endPage" value="${startPage + maxPageDisplay - 1}" />
                <c:if test="${endPage > totalPages}">
                    <c:set var="endPage" value="${totalPages}" />
                </c:if>

                <!-- Nút Prev -->
                <c:if test="${pageIndex > 1}">
                    <c:url value="/products/filter" var="prevUrl">
                        <c:param name="page" value="${pageIndex - 1}" />
                        <c:if test="${not empty param.keyword}">
                            <c:param name="keyword" value="${param.keyword}" />
                        </c:if>
                        <c:if test="${not empty param.brand}">
                            <c:param name="brand" value="${param.brand}" />
                        </c:if>
                        <c:if test="${not empty param.cpu}">
                            <c:param name="cpu" value="${param.cpu}" />
                        </c:if>
                        <c:if test="${not empty param.memory}">
                            <c:param name="memory" value="${param.memory}" />
                        </c:if>
                        <c:if test="${not empty param.storage}">
                            <c:param name="storage" value="${param.storage}" />
                        </c:if>
                        <c:if test="${not empty param.color}">
                            <c:param name="color" value="${param.color}" />
                        </c:if>
                        <c:if test="${not empty param.battery}">
                            <c:param name="battery" value="${param.battery}" />
                        </c:if>
                        <c:if test="${not empty param.screen_size}">
                            <c:param name="screen_size" value="${param.screen_size}" />
                        </c:if>
                        <c:if test="${not empty param.screen_type}">
                            <c:param name="screen_type" value="${param.screen_type}" />
                        </c:if>
                        <c:if test="${not empty param.camera}">
                            <c:param name="camera" value="${param.camera}" />
                        </c:if>
                        <c:if test="${not empty param.price}">
                            <c:param name="price" value="${param.price}" />
                        </c:if>
                    </c:url>
                    <a href="${prevUrl}">Prev</a>
                </c:if>

                <!-- Hiển thị các số trang trong khung -->
                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                    <c:url value="/products/filter" var="pageUrl">
                        <c:param name="page" value="${i}" />
                        <c:if test="${not empty param.keyword}">
                            <c:param name="keyword" value="${param.keyword}" />
                        </c:if>
                        <c:if test="${not empty param.brand}">
                            <c:param name="brand" value="${param.brand}" />
                        </c:if>
                        <c:if test="${not empty param.cpu}">
                            <c:param name="cpu" value="${param.cpu}" />
                        </c:if>
                        <c:if test="${not empty param.memory}">
                            <c:param name="memory" value="${param.memory}" />
                        </c:if>
                        <c:if test="${not empty param.storage}">
                            <c:param name="storage" value="${param.storage}" />
                        </c:if>
                        <c:if test="${not empty param.color}">
                            <c:param name="color" value="${param.color}" />
                        </c:if>
                        <c:if test="${not empty param.battery}">
                            <c:param name="battery" value="${param.battery}" />
                        </c:if>
                        <c:if test="${not empty param.screen_size}">
                            <c:param name="screen_size" value="${param.screen_size}" />
                        </c:if>
                        <c:if test="${not empty param.screen_type}">
                            <c:param name="screen_type" value="${param.screen_type}" />
                        </c:if>
                        <c:if test="${not empty param.camera}">
                            <c:param name="camera" value="${param.camera}" />
                        </c:if>
                        <c:if test="${not empty param.price}">
                            <c:param name="price" value="${param.price}" />
                        </c:if>
                    </c:url>
                    <c:choose>
                        <c:when test="${i == pageIndex}">
                            <b>[${i}]</b>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageUrl}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                    &nbsp;
                </c:forEach>

                <!-- Nút Next -->
                <c:if test="${pageIndex < totalPages}">
                    <c:url value="/products/filter" var="nextUrl">
                        <c:param name="page" value="${pageIndex + 1}" />
                        <c:if test="${not empty param.keyword}">
                            <c:param name="keyword" value="${param.keyword}" />
                        </c:if>
                        <c:if test="${not empty param.brand}">
                            <c:param name="brand" value="${param.brand}" />
                        </c:if>
                        <c:if test="${not empty param.cpu}">
                            <c:param name="cpu" value="${param.cpu}" />
                        </c:if>
                        <c:if test="${not empty param.memory}">
                            <c:param name="memory" value="${param.memory}" />
                        </c:if>
                        <c:if test="${not empty param.storage}">
                            <c:param name="storage" value="${param.storage}" />
                        </c:if>
                        <c:if test="${not empty param.color}">
                            <c:param name="color" value="${param.color}" />
                        </c:if>
                        <c:if test="${not empty param.battery}">
                            <c:param name="battery" value="${param.battery}" />
                        </c:if>
                        <c:if test="${not empty param.screen_size}">
                            <c:param name="screen_size" value="${param.screen_size}" />
                        </c:if>
                        <c:if test="${not empty param.screen_type}">
                            <c:param name="screen_type" value="${param.screen_type}" />
                        </c:if>
                        <c:if test="${not empty param.camera}">
                            <c:param name="camera" value="${param.camera}" />
                        </c:if>
                        <c:if test="${not empty param.price}">
                            <c:param name="price" value="${param.price}" />
                        </c:if>
                    </c:url>
                    <a href="${nextUrl}">Next</a>
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

                // Xây dựng URL với các tham số lọc
                let url = "${pageContext.request.contextPath}/products/filter?page=" + page;
            <c:if test="${not empty param.keyword}">
            url += "&keyword=${param.keyword}";
            </c:if>
            <c:if test="${not empty param.brand}">
            url += "&brand=${param.brand}";
            </c:if>
            <c:if test="${not empty param.cpu}">
            url += "&cpu=${param.cpu}";
            </c:if>
            <c:if test="${not empty param.memory}">
            url += "&memory=${param.memory}";
            </c:if>
            <c:if test="${not empty param.storage}">
            url += "&storage=${param.storage}";
            </c:if>
            <c:if test="${not empty param.color}">
            url += "&color=${param.color}";
            </c:if>
            <c:if test="${not empty param.battery}">
            url += "&battery=${param.battery}";
            </c:if>
            <c:if test="${not empty param.screen_size}">
            url += "&screen_size=${param.screen_size}";
            </c:if>
            <c:if test="${not empty param.screen_type}">
            url += "&screen_type=${param.screen_type}";
            </c:if>
            <c:if test="${not empty param.camera}">
            url += "&camera=${param.camera}";
            </c:if>
            <c:if test="${not empty param.price}">
            url += "&price=${param.price}";
            </c:if>

                // Điều hướng đến trang được nhập
                window.location.href = url;
            }
        </script>
    </body>
</html>
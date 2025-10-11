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

        <form action="${pageContext.request.contextPath}/products/filter" method="post">
            <label>Price:</label>
            <select name="price">
                <option value="">-- Select Price --</option>
                <c:forEach var="r" items="${priceRanges}">
                    <c:choose>
                        <c:when test="${empty r.max}">
                            <option value="${r.min}-">${r.label}</option>
                        </c:when>
                        <c:otherwise>
                            <option value="${r.min}-${r.max}">${r.label}</option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </select><br>

            <label>Brand:</label>
            <select name="brand" id="brand">
                <option value="">-- Select Brand --</option>
                <c:forEach var="b" items="${brandOptions}">
                    <option value="${b.brandName}">${b.brandName}</option>
                </c:forEach>
            </select>

            <label>CPU:</label>
            <select name="cpu">
                <option value="">-- Select --</option>             
                <c:forEach var="c" items="${cpuOptions}">
                    <option value="${c.cpu}">${c.cpu}</option>
                </c:forEach>
            </select><br>

            <label>Memory (RAM):</label>
            <select name="memory">
                <option value="">-- Select --</option>               
                <c:forEach var="m" items="${memoryOptions}">
                    <option value="${m.memory}">${m.memory}</option>
                </c:forEach>
            </select><br>

            <label>Storage:</label>
            <select name="storage">
                <option value="">-- Select --</option>
                <c:forEach var="s" items="${storageOptions}">
                    <option value="${s.storage}">${s.storage}</option>
                </c:forEach>
            </select><br>

            <label>Color:</label>
            <select name="color">
                <option value="">-- Select --</option>
                <c:forEach var="co" items="${colorOptions}">
                    <option value="${co.color}">${co.color}</option>
                </c:forEach>
            </select><br>

            <label>Battery Capacity:</label>
            <select name="battery">
                <option value="">-- Select --</option>
                <c:forEach var="ba" items="${batteryOptions}">
                    <option value="${ba.battery}">${ba.battery} mAh</option>
                </c:forEach>
            </select><br>

            <label>Screen Size:</label>
            <select name="screen_size">
                <option value="">-- Select --</option>
                <c:forEach var="ss" items="${ScreenSizeOptions}">
                    <option value="${ss.screenSize}">${ss.screenSize}</option>
                </c:forEach>
            </select><br>

            <label>Screen Type:</label>
            <select name="screen_type">
                <option value="">-- Select --</option>
                <c:forEach var="st" items="${ScreenTypeOptions}">
                    <option value="${st.screenType}">${st.screenType}</option>
                </c:forEach>
            </select><br>

            <label>Camera:</label>
            <select name="camera">
                <option value="">-- Select --</option>
                <c:forEach var="cam" items="${cameraOptions}">
                    <option value="${cam.camera}">${cam.camera} MP</option>
                </c:forEach>
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


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
                        <option value="${r.min}-" ${param.price == (r.min + '-') ? 'selected' : ''}>${r.label}</option>
                    </c:when>
                    <c:otherwise>
                        <option value="${r.min}-${r.max}" ${param.price == (r.min + '-' + r.max) ? 'selected' : ''}>${r.label}</option>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </select><br>

        <label>Brand:</label>
        <select name="brand" id="brand">
            <option value="">-- Select Brand --</option>
            <c:forEach var="b" items="${brandOptions}">
                <option value="${b.brandName}" ${param.brand == b.brandName ? 'selected' : ''}>${b.brandName}</option>
            </c:forEach>
        </select>

        <label>CPU:</label>
        <select name="cpu">
            <option value="">-- Select --</option>             
            <c:forEach var="c" items="${cpuOptions}">
                <option value="${c.cpu}" ${param.cpu == c.cpu ? 'selected' : ''}>${c.cpu}</option>
            </c:forEach>
        </select><br>

        <label>Memory (RAM):</label>
        <select name="memory">
            <option value="">-- Select --</option>               
            <c:forEach var="m" items="${memoryOptions}">
                <option value="${m.memory}" ${param.memory == m.memory ? 'selected' : ''}>${m.memory}</option>
            </c:forEach>
        </select><br>

        <label>Storage:</label>
        <select name="storage">
            <option value="">-- Select --</option>
            <c:forEach var="s" items="${storageOptions}">
                <option value="${s.storage}" ${param.storage == s.storage ? 'selected' : ''}>${s.storage}</option>
            </c:forEach>
        </select><br>

        <label>Color:</label>
        <select name="color">
            <option value="">-- Select --</option>
            <c:forEach var="co" items="${colorOptions}">
                <option value="${co.color}" ${param.color == co.color ? 'selected' : ''}>${co.color}</option>
            </c:forEach>
        </select><br>

        <label>Battery Capacity:</label>
        <select name="battery">
            <option value="">-- Select --</option>
            <c:forEach var="ba" items="${batteryOptions}">
                <option value="${ba.battery}" ${param.battery == ba.battery ? 'selected' : ''}>${ba.battery} mAh</option>
            </c:forEach>
        </select><br>

        <label>Screen Size:</label>
        <select name="screen_size">
            <option value="">-- Select --</option>
            <c:forEach var="ss" items="${ScreenSizeOptions}">
                <option value="${ss.screenSize}" ${param.screen_size == ss.screenSize ? 'selected' : ''}>${ss.screenSize}</option>
            </c:forEach>
        </select><br>

        <label>Screen Type:</label>
        <select name="screen_type">
            <option value="">-- Select --</option>
            <c:forEach var="st" items="${ScreenTypeOptions}">
                <option value="${st.screenType}" ${param.screen_type == st.screenType ? 'selected' : ''}>${st.screenType}</option>
            </c:forEach>
        </select><br>

        <label>Camera:</label>
        <select name="camera">
            <option value="">-- Select --</option>
            <c:forEach var="cam" items="${cameraOptions}">
                <option value="${cam.camera}" ${param.camera == cam.camera ? 'selected' : ''}>${cam.camera} MP</option>
            </c:forEach>
        </select><br><br>

        <button type="submit">Apply Filter</button>
        <button type="reset" onclick="window.location='${pageContext.request.contextPath}/products'">Reset</button>
    </form><br>

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
                <td>${p.imageUrl != null ? p.imageUrl : 'No image'}</td>
                <td>
                    <form action="${pageContext.request.contextPath}/products/view" method="get">
                        <input type="hidden" name="id" value="${p.productId}">
                        <button type="submit">View</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>

    <!-- ✅ Phân trang giữ filter -->
    <div style="margin-top:20px; text-align:center;">
        <c:if test="${totalPages > 1}">
            <c:forEach var="i" begin="1" end="${totalPages}">
                <c:choose>
                    <c:when test="${i == pageIndex}">
                        <b>[${i}]</b>
                    </c:when>
                    <c:otherwise>
                        <form action="${pageContext.request.contextPath}/products/filter" method="post" style="display:inline;">
                            <!-- giữ filter khi đổi trang -->
                            <input type="hidden" name="page" value="${i}">
                            <input type="hidden" name="price" value="${param.price}">
                            <input type="hidden" name="brand" value="${param.brand}">
                            <input type="hidden" name="cpu" value="${param.cpu}">
                            <input type="hidden" name="memory" value="${param.memory}">
                            <input type="hidden" name="storage" value="${param.storage}">
                            <input type="hidden" name="color" value="${param.color}">
                            <input type="hidden" name="battery" value="${param.battery}">
                            <input type="hidden" name="screen_size" value="${param.screen_size}">
                            <input type="hidden" name="screen_type" value="${param.screen_type}">
                            <input type="hidden" name="camera" value="${param.camera}">
                            <button type="submit" style="border:none;background:none;color:blue;cursor:pointer;">${i}</button>
                        </form>
                    </c:otherwise>
                </c:choose>
                &nbsp;
            </c:forEach>
        </c:if>
    </div>

</body>
</html>

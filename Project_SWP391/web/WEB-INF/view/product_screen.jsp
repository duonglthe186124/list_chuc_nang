<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product_screen.css">
    </head>
    <body>
        <nav class="nav">
            <div class="brand">
                <a href="home.html">
                    <div class="logo" aria-hidden>
                        <svg
                            width="26"
                            height="26"
                            viewBox="0 0 24 24"
                            fill="none"
                            xmlns="http://www.w3.org/2000/svg"
                            >
                        <rect
                            x="2"
                            y="2"
                            width="20"
                            height="20"
                            rx="4"
                            fill="black"
                            opacity="0.12"
                            />
                        <path
                            d="M6 16V8h4l4 4v4"
                            stroke="#06121a"
                            stroke-width="1.2"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            />
                        </svg>
                    </div>
                </a>
                <div>
                    <h1>StockPhone</h1>
                    <p>Phone Stock Management System</p>
                </div>
            </div>

            <div class="navlinks" role="navigation" aria-label="Primary">
                <a href="${pageContext.request.contextPath}/home">Home</a>
                <a href="${pageContext.request.contextPath}/products">Products</a>
                <a href="${pageContext.request.contextPath}/about">About</a>
                <a href="${pageContext.request.contextPath}/policy">Policy</a>
                <a href="${pageContext.request.contextPath}/report">Reports</a>
            </div>

            <div class="cta">
                <button class="icon-btn" title="Tìm kiếm" aria-label="Tìm kiếm">
                    <svg
                        width="18"
                        height="18"
                        viewBox="0 0 24 24"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                        >
                    <path
                        d="M21 21l-4.35-4.35"
                        stroke="currentColor"
                        stroke-width="1.4"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        />
                    <circle
                        cx="11"
                        cy="11"
                        r="6"
                        stroke="currentColor"
                        stroke-width="1.4"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        />
                    </svg>
                </button>

                <a
                    class="icon-btn"
                    href="login.html"
                    title="Đăng nhập"
                    aria-label="Đăng nhập"
                    >
                    <svg
                        width="18"
                        height="18"
                        viewBox="0 0 24 24"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                        >
                    <path
                        d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"
                        stroke="currentColor"
                        stroke-width="1.4"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        />
                    <circle
                        cx="12"
                        cy="7"
                        r="4"
                        stroke="currentColor"
                        stroke-width="1.4"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        />
                    </svg>
                </a>

                <button
                    class="hamburger"
                    id="hamburger"
                    aria-controls="mobileMenu"
                    aria-expanded="false"
                    >
                    <svg
                        width="26"
                        height="26"
                        viewBox="0 0 24 24"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                        >
                    <path
                        d="M4 7h16M4 12h16M4 17h16"
                        stroke="currentColor"
                        stroke-width="1.6"
                        stroke-linecap="round"
                        />
                    </svg>
                </button>
            </div>
        </nav>

        <div class="layout">
            <aside class="sidebar" aria-label="Sidebaar">
                <h3 class="sidebar-title">Role Pannel</h3>

                <div class="sidebar-menu">
                    <a class="menu-item active" href="${pageContext.request.contextPath}/products">Products</a>
                    <a class="menu-item" href="${pageContext.request.contextPath}/order/list">Order List</a>
                    <a class="menu-item">Manager fields</a>
                    <a class="menu-item" href="">Manager fields</a>
                    <a class="menu-item" href="">Manager fields</a>
                    <a class="menu-item">Manager fields</a>
                    <a class="menu-item">Manager fields</a>
                </div>
            </aside>

            <main class="main">
                <div class="main-header" id="main-header">
                    <h1>Products</h1>
                </div>

                <a href="${pageContext.request.contextPath}/home">
                    <button type="button">Home</button>
                </a><br>
                <form action="${pageContext.request.contextPath}/products/filter" method="get" class="search-form">
                    <input type="text" name="keyword" placeholder="Search by name or code" value="${param.keyword}">
                    <button type="submit">Search</button>
                </form>

                <form action="${pageContext.request.contextPath}/products/filter" method="get">

                    <label>Price:</label>
                    <select name="price">
                        <option value="">-- Select Price --</option>
                        <c:forEach var="r" items="${priceRanges}">
                            <c:choose>
                                <c:when test="${empty r.max}">
                                    <option value="${r.min}+">${r.label}</option>
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

                <a href="${pageContext.request.contextPath}/order/list">
                    <button type="button">View Order List</button>
                </a>   

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
                                    <c:otherwise>
                                        <i>No image</i>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>
                                <form action="${pageContext.request.contextPath}/products/view" method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="${p.productId}">
                                    <button type="submit">View</button>
                                </form>
                                    
                                <form action="${pageContext.request.contextPath}/products/delete" method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="${p.productId}">
                                    <button type="submit" onclick="return confirm('Are you sure to delete this product?')">Delete</button>
                                </form>

                                <form action="${pageContext.request.contextPath}/order" method="get" style="display:inline;">
                                    <input type="hidden" name="id" value="${p.productId}">
                                    <button type="submit" ${p.qty == 0 ? 'disabled' : ''}>Order</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </table>

                <!-- ✅ Phân trang nâng cao -->
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
            </main>
        </div>

        <footer>
            <div class="container" style="max-width: 1100px">
                <div class="footer-grid">
                    <div>
                        <h4>StockPhone</h4>
                        <p class="small">
                            Hệ thống quản lý kho chuyên cho cửa hàng điện thoại. Quản lý tồn
                            kho, đơn nhập/xuất, báo cáo và người dùng.
                        </p>
                    </div>

                    <div>
                        <h4>Quick links</h4>
                        <a href="/home.html">Home</a>
                        <a href="/products">Products</a>
                        <a href="/reports">Reports</a>
                        <a href="/login">Đăng nhập</a>
                    </div>

                    <div>
                        <h4>Hỗ trợ & Policy</h4>
                        <a href="/policy">Privacy & Policy</a>
                        <a href="/terms">Terms of Service</a>
                        <a href="/help">Help Center</a>
                    </div>

                    <div>
                        <h4>Contact</h4>
                        <div class="small">Email: support@stockphone.example</div>
                        <div class="small" style="margin-top: 6px">
                            SĐT: +84 912 345 678
                        </div>
                        <div style="margin-top: 10px">
                            <a
                                href="#"
                                style="
                                margin-right: 8px;
                                text-decoration: none;
                                color: var(--muted);
                                "
                                >Twitter</a
                            >
                            <a
                                href="#"
                                style="
                                margin-right: 8px;
                                text-decoration: none;
                                color: var(--muted);
                                "
                                >Facebook</a
                            >
                            <a href="#" style="text-decoration: none; color: var(--muted)"
                               >LinkedIn</a
                            >
                        </div>
                    </div>
                </div>

                <div
                    style="
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-top: 18px;
                    flex-wrap: wrap;
                    "
                    >
                    <div class="small">© 2025 StockPhone. All rights reserved.</div>
                    <div class="small">Designed for warehouse management by Group 2</div>
                </div>
            </div>
        </footer>
    </body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Products</title>

        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>WMS Pro - Giải pháp Quản lý Kho Điện thoại Thông minh</title>

        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Tải Font Inter -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
            rel="stylesheet"
            />

        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar_filter.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board.css">

        <style>

            /* Sử dụng font Inter làm mặc định */
            body {
                font-family: "Inter", sans-serif;
            }

            /* Lớp CSS cho hiệu ứng cuộn */
            .reveal-on-scroll {
                opacity: 0;
                transform: translateY(30px);
                transition: opacity 0.6s ease-out, transform 0.6s ease-out;
            }

            .reveal-on-scroll.is-visible {
                opacity: 1;
                transform: translateY(0);
            }
        </style>
    </head>
    <body>
        <header
            class="fixed top-0 left-0 right-0 z-50 bg-white/90 backdrop-blur-md shadow-sm"
            >
            <div class="container mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
                <div class="flex h-16 items-center justify-between">
                    <!-- Logo -->
                    <a
                        href="#"
                        class="flex items-center gap-2 text-2xl font-bold text-gray-900"
                        >
                        <!-- Icon SVG đơn giản -->
                        <svg
                            class="h-8 w-8 text-indigo-600"
                            xmlns="http://www.w3.org/2000/svg"
                            fill="none"
                            viewBox="0 0 24 24"
                            stroke-width="1.5"
                            stroke="currentColor"
                            >
                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M3.75 6A2.25 2.25 0 0 1 6 3.75h2.25A2.25 2.25 0 0 1 10.5 6v2.25a2.25 2.25 0 0 1-2.25 2.25H6a2.25 2.25 0 0 1-2.25-2.25V6ZM3.75 15.75A2.25 2.25 0 0 1 6 13.5h2.25a2.25 2.25 0 0 1 2.25 2.25V18a2.25 2.25 0 0 1-2.25 2.25H6A2.25 2.25 0 0 1 3.75 18v-2.25ZM13.5 6a2.25 2.25 0 0 1 2.25-2.25H18A2.25 2.25 0 0 1 20.25 6v2.25A2.25 2.25 0 0 1 18 10.5h-2.25A2.25 2.25 0 0 1 13.5 8.25V6ZM13.5 15.75a2.25 2.25 0 0 1 2.25-2.25H18a2.25 2.25 0 0 1 2.25 2.25V18A2.25 2.25 0 0 1 18 20.25h-2.25A2.25 2.25 0 0 1 13.5 18v-2.25Z"
                            />
                        </svg>
                        <span>WMS Pro</span>
                    </a>

                    <!-- Menu Desktop -->
                    <nav class="hidden md:flex items-center space-x-6">
                        <c:choose>
                            <%-- 1. NẾU CHƯA ĐĂNG NHẬP (session "account" bị rỗng) --%>
                            <c:when test="${empty sessionScope.account}">
                                <a href="#gioi-thieu" class="font-medium text-gray-600 hover:text-indigo-600">Giới thiệu</a>
                                <a href="${pageContext.request.contextPath}/products" class="font-medium text-gray-600 hover:text-indigo-600">Sản phẩm</a>
                                <a href="#tinh-nang" class="font-medium text-gray-600 hover:text-indigo-600">Tính năng</a>
                                <a href="#lien-he" class="font-medium text-gray-600 hover:text-indigo-600">Liên hệ</a>
                                <a href="${pageContext.request.contextPath}/loginStaff"
                                   class="rounded-md bg-indigo-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-indigo-700">
                                    Đăng nhập
                                </a>
                            </c:when>

                            <%-- 2. NẾU ĐÃ ĐĂNG NHẬP --%>
                            <c:otherwise>
                                <a href="#gioi-thieu" class="font-medium text-gray-600 hover:text-indigo-600">Giới thiệu</a>
                                <a href="${pageContext.request.contextPath}/products" class="font-medium text-gray-600 hover:text-indigo-600">Sản phẩm</a>
                                <a href="#tinh-nang" class="font-medium text-gray-600 hover:text-indigo-600">Tính năng</a>
                                <a href="#lien-he" class="font-medium text-gray-600 hover:text-indigo-600">Liên hệ</a>

                                <div class="relative" id="user-menu-container">
                                    <button id="user-menu-button"
                                            class="flex items-center space-x-2 rounded-full p-1 hover:bg-gray-100 focus:outline-none">

                                        <img class="h-8 w-8 rounded-full object-cover"
                                             src="https://i.postimg.cc/c6m04fpn/default-avatar-icon-of-social-media-user-vector.jpg"
                                             alt="User Avatar" />
                                        <span class="hidden md:inline text-sm font-medium text-gray-700">
                                            ${sessionScope.account.fullname}
                                        </span>
                                        <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="m19.5 8.25-7.5 7.5-7.5-7.5" />
                                        </svg>
                                    </button>

                                    <div id="user-menu-dropdown"
                                         class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 hidden z-20">
                                        <a href="${pageContext.request.contextPath}/PersonalProfile"
                                           class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Hồ sơ</a>

                                        <c:if test="${sessionScope.account.role_id == 1}">
                                            <a href="${pageContext.request.contextPath}/account-management"
                                               class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                                Account Management
                                            </a>
                                        </c:if>

                                        <div class="border-t border-gray-100 my-1"></div>
                                        <a href="${pageContext.request.contextPath}/logout"
                                           class="block px-4 py-2 text-sm text-red-600 hover:bg-gray-100">Đăng xuất</a>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </nav>

                    <!-- Nút Menu Mobile -->
                    <div class="md:hidden">
                        <button
                            id="mobile-menu-button"
                            class="inline-flex items-center justify-center rounded-md p-2 text-gray-400 hover:bg-gray-100 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-indigo-500"
                            >
                            <span class="sr-only">Mở menu chính</span>
                            <svg
                                class="h-6 w-6"
                                xmlns="http://www.w3.org/2000/svg"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke-width="1.5"
                                stroke="currentColor"
                                >
                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5"
                                />
                            </svg>
                        </button>
                    </div>
                </div>

                <!-- Menu Mobile (Ẩn mặc định) -->
                <div id="mobile-menu" class="hidden md:hidden pb-4">
                    <div class="space-y-1">
                        <a
                            href="#gioi-thieu"
                            class="block rounded-md px-3 py-2 text-base font-medium text-gray-700 hover:bg-gray-50 hover:text-gray-900"
                            >Giới thiệu</a
                        >
                        <a
                            href="#tinh-nang"
                            class="block rounded-md px-3 py-2 text-base font-medium text-gray-700 hover:bg-gray-50 hover:text-gray-900"
                            >Tính năng</a
                        >
                        <a
                            href="#lien-he"
                            class="block rounded-md px-3 py-2 text-base font-medium text-gray-700 hover:bg-gray-50 hover:text-gray-900"
                            >Liên hệ</a
                        >
                        <a
                            href="${pageContext.request.contextPath}/loginStaff"
                            class="mt-2 block w-full rounded-md bg-indigo-600 px-4 py-2 text-center text-base font-medium text-white shadow-sm hover:bg-indigo-700"
                            >
                            Đăng nhập
                        </a>
                    </div>
                </div>
            </div>
        </header>

        <div class="layout">
            <aside class="sidebar" aria-label="Sidebaar">
                <h3 class="sidebar-title">Product Filters</h3>
                <form action="${pageContext.request.contextPath}/products/filter" method="get" class="sidebar-filter-form">
                    <!-- Giữ lại keyword nếu đang search -->
                    <input type="hidden" name="keyword" value="${param.keyword}">

                    <!-- Price -->
                    <div class="filter-group">
                        <label>Price</label>
                        <select name="price">
                            <option value="">All Prices</option>
                            <c:forEach var="r" items="${priceRanges}">
                                <c:choose>
                                    <c:when test="${empty r.max}">
                                        <option value="${r.min}+" ${param.price == r.min.toString().concat('+') ? 'selected' : ''}>${r.label}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${r.min}-${r.max}" ${param.price == r.min.toString().concat('-').concat(r.max.toString()) ? 'selected' : ''}>${r.label}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Brand -->
                    <div class="filter-group">
                        <label>Brand</label>
                        <select name="brand">
                            <option value="">All Brands</option>
                            <c:forEach var="b" items="${brandOptions}">
                                <option value="${b.brandName}" ${param.brand == b.brandName ? 'selected' : ''}>${b.brandName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- CPU -->
                    <div class="filter-group">
                        <label>CPU</label>
                        <select name="cpu">
                            <option value="">All CPUs</option>
                            <c:forEach var="c" items="${cpuOptions}">
                                <option value="${c.cpu}" ${param.cpu == c.cpu ? 'selected' : ''}>${c.cpu}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Memory -->
                    <div class="filter-group">
                        <label>Memory (RAM)</label>
                        <select name="memory">
                            <option value="">All Memory</option>
                            <c:forEach var="m" items="${memoryOptions}">
                                <option value="${m.memory}" ${param.memory == m.memory ? 'selected' : ''}>${m.memory}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Storage -->
                    <div class="filter-group">
                        <label>Storage</label>
                        <select name="storage">
                            <option value="">All Storage</option>
                            <c:forEach var="s" items="${storageOptions}">
                                <option value="${s.storage}" ${param.storage == s.storage ? 'selected' : ''}>${s.storage}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Color -->
                    <div class="filter-group">
                        <label>Color</label>
                        <select name="color">
                            <option value="">All Colors</option>
                            <c:forEach var="co" items="${colorOptions}">
                                <option value="${co.color}" ${param.color == co.color ? 'selected' : ''}>${co.color}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Battery -->
                    <div class="filter-group">
                        <label>Battery Capacity</label>
                        <select name="battery">
                            <option value="">All Batteries</option>
                            <c:forEach var="ba" items="${batteryOptions}">
                                <option value="${ba.battery}" ${param.battery == ba.battery ? 'selected' : ''}>${ba.battery} mAh</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Screen Size -->
                    <div class="filter-group">
                        <label>Screen Size</label>
                        <select name="screen_size">
                            <option value="">All Sizes</option>
                            <c:forEach var="ss" items="${ScreenSizeOptions}">
                                <option value="${ss.screenSize}" ${param.screen_size == ss.screenSize ? 'selected' : ''}>${ss.screenSize}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Screen Type -->
                    <div class="filter-group">
                        <label>Screen Type</label>
                        <select name="screen_type">
                            <option value="">All Types</option>
                            <c:forEach var="st" items="${ScreenTypeOptions}">
                                <option value="${st.screenType}" ${param.screen_type == st.screenType ? 'selected' : ''}>${st.screenType}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Camera -->
                    <div class="filter-group">
                        <label>Camera</label>
                        <select name="camera">
                            <option value="">All Cameras</option>
                            <c:forEach var="cam" items="${cameraOptions}">
                                <option value="${cam.camera}" ${param.camera == cam.camera ? 'selected' : ''}>${cam.camera} MP</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Buttons -->
                    <div class="filter-actions">
                        <button type="submit" class="btn-primary">Apply Filters</button>
                        <button type="button" class="btn-secondary" onclick="window.location.href = '${pageContext.request.contextPath}/products'">Clear All</button>
                    </div>
                </form>

                <!-- Quick Links -->

            </aside>

            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/products.css">        
            <main class="main">
                <div class="main-header" id="main-header">
                    <h1>Products</h1>
                </div>

                <a href="${pageContext.request.contextPath}/home"><button type="button">Home</button></a><a href="${pageContext.request.contextPath}/order/list"><button type="button">View Order List</button></a><br>

                <form action="${pageContext.request.contextPath}/products/filter" method="get" class="search-form">
                    <input type="text" name="keyword" placeholder="Search by name or code" value="${param.keyword}">
                    <button type="submit">Search</button>
                </form><br>


                <div class="table-container">
                    <table>
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
                                <td>${p.camera}MP</td>
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
                                        <input type="hidden" name="price" value="${p.price}">
                                        <button type="submit" class="action-btn">View</button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/order" method="post" style="display:inline;">
                                        <input type="hidden" name="id" value="${p.productId}">
                                        <input type="hidden" name="name" value="${p.productName}">
                                        <input type="hidden" name="qty" value="${p.qty}">
                                        <input type="hidden" name="code" value="${p.sku_code}">
                                        <input type="hidden" name="price" value="${p.price}">
                                        <input type="hidden" name="image" value="${p.imageUrl}">
                                        <button type="submit" class="action-btn" ${p.qty == 0 ? 'disabled' : ''}>Order</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>

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

        <script>
            const userMenuButton = document.getElementById('user-menu-button');
            const userMenuDropdown = document.getElementById('user-menu-dropdown');


            function toggleUserMenu() {
                userMenuDropdown.classList.toggle('hidden');
            }


            userMenuButton.addEventListener('click', function (e) {
                e.stopPropagation(); // Ngăn sự kiện lan ra ngoài
                toggleUserMenu();
            });


            document.addEventListener('click', function (e) {
                if (!userMenuButton.contains(e.target) && !userMenuDropdown.contains(e.target)) {
                    userMenuDropdown.classList.add('hidden');
                }
            });


            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape') {
                    userMenuDropdown.classList.add('hidden');
                }
            });
        </script>
    </body>


</html>

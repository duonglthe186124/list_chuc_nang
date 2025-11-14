<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Order List</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/order_list.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/view_order_lists.css">
        
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>WMS Pro - Giải pháp Quản lý Kho Điện thoại Thông minh</title>
        <!-- Tải Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Tải Font Inter -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
            rel="stylesheet"
            />
        <style>
            table {
                border-collapse: collapse;
                width: 100%;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
            .error {
                color: red;
                margin-top: 10px;
            }
            .no-data {
                color: #666;
                margin-top: 10px;
            }
            .success {
                color: green;
                margin-top: 10px;
                padding: 10px;
                background-color: #d4edda;
                border-radius: 5px;
                display: inline-block;
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
        <br>
        <br>
            <main class="main">
                <div class="main-header" id="main-header">
                    <h1>Order lists</h1>
                </div>
                <div style="margin: 20px 0; padding: 15px; background: #f8f9fa; border: 1px solid #dee2e6; border-radius: 8px;">
                    <h3 style="margin: 0 0 10px 0;">🔄 Sort Orders</h3>
                    <div style="display: flex; flex-wrap: wrap; gap: 10px;">
                        <form action="${pageContext.request.contextPath}/order/list" method="post" style="display:flex; flex-wrap:wrap; gap:6px;">
                            <input type="hidden" name="page" value="1">
                            <input type="hidden" name="userId" value="${param.userId}">

                            <button type="submit" name="sort" value="Lowest order price"
                                    style="padding:6px 12px; background:#e3f2fd; color:#1976d2; border:none; border-radius:5px; font-size:13px;">
                                💰 Giá thấp→cao
                            </button>

                            <button type="submit" name="sort" value="Highest order price"
                                    style="padding:6px 12px; background:#e3f2fd; color:#1976d2; border:none; border-radius:5px; font-size:13px;">
                                💰 Giá cao→thấp
                            </button>

                            <button type="submit" name="sort" value="Earliest orders"
                                    style="padding:6px 12px; background:#e8f5e8; color:#388e3c; border:none; border-radius:5px; font-size:13px;">
                                📅 Đơn cũ→mới
                            </button>

                            <button type="submit" name="sort" value="Latest orders"
                                    style="padding:6px 12px; background:#e8f5e8; color:#388e3c; border:none; border-radius:5px; font-size:13px;">
                                📅 Đơn mới→cũ
                            </button>

                            <button type="submit" name="sort" value="Lowest quantity"
                                    style="padding:6px 12px; background:#fff3e0; color:#f57c00; border:none; border-radius:5px; font-size:13px;">
                                📦 SL ít→nhiều
                            </button>

                            <button type="submit" name="sort" value="Highest quantity"
                                    style="padding:6px 12px; background:#fff3e0; color:#f57c00; border:none; border-radius:5px; font-size:13px;">
                                📦 SL nhiều→ít
                            </button>

                            <button type="submit" name="sort" value="PENDING"
                                    style="padding:6px 12px; background:#fff3cd; color:#856404; border:none; border-radius:5px; font-size:13px;">
                                ⏳ PENDING đầu
                            </button>

                            <button type="submit" name="sort" value="CONFIRMED"
                                    style="padding:6px 12px; background:#d1ecf1; color:#0c5460; border:none; border-radius:5px; font-size:13px;">
                                ✅ CONFIRMED đầu
                            </button>

                            <button type="submit" name="sort" value="SHIPPED"
                                    style="padding:6px 12px; background:#d4edda; color:#155724; border:none; border-radius:5px; font-size:13px;">
                                🚚 SHIPPED đầu
                            </button>

                            <button type="submit" name="sort" value="CANCELLED"
                                    style="padding:6px 12px; background:#f8d7da; color:#721c24; border:none; border-radius:5px; font-size:13px;">
                                ❌ CANCELLED đầu
                            </button>
                        </form>
                    </div>
                </div>

                <a href="${pageContext.request.contextPath}/products">
                    <button type="button">Back to Products</button>
                </a>

                <!--<div style="margin: 15px 0;">
                    <form action="${pageContext.request.contextPath}/order/list" method="post" style="display:inline-block;">
                        <label for="userFilter"><strong>Filter by User:</strong></label>
                        <select id="userFilter" name="userId" style="padding:6px; margin-left:10px; border-radius:4px;">
                            <option value="">-- All Users --</option>
                            <c:forEach var="u" items="${userList}">
                                <option value="${u.userId}" ${param.userId == u.userId ? 'selected' : ''}>
                                    ${u.fullname} (${u.rolename})
                                </option>
                            </c:forEach>
                        </select>
                        <button type="submit" style="margin-left:8px; padding:6px 12px; background:#007bff; color:white; border:none; border-radius:4px;">
                            Go
                        </button>
                    </form>
                </div> -->

                <!-- Hiển thị thông báo thành công nếu có -->
                <c:if test="${not empty successMessage}">
                    <p class="success">${successMessage}</p>
                </c:if>

                <!-- Hiển thị thông báo lỗi nếu có -->
                <c:if test="${not empty errorMessage}">
                    <p class="error">${errorMessage}</p>
                </c:if>

                <!-- Kiểm tra và hiển thị thông báo nếu không có đơn hàng -->
                <c:choose>
                    <c:when test="${empty orders}">
                        <p class="no-data">No orders found.</p>
                    </c:when>
                    <c:otherwise>
                        <table id="orderTable">
                            <tr>
                                <th>Order Number</th>
                                <th>Product Name</th>
                                <th>Order Quantity</th>
                                <th>Unit Price</th>
                                <th>Line Amount</th>
                                <th>Customer Name</th>
                                <th>Customer Email</th>
                                <th>Customer Phone</th>
                                <th>Customer Address</th>
                                <th>Order Date</th>
                                <th>Order Status</th>
                                <th>Action</th>
                            </tr>

                            <c:forEach var="order" items="${orders}" varStatus="loop">
                                <!-- Dòng chính -->
                                <tr id="row-${loop.index}">
                                    <td>${order.orderNumber}</td>
                                    <td>${order.productName}</td>
                                    <td>${order.orderQuantity}</td>
                                    <td><fmt:formatNumber value="${order.productUnitPrice}" type="currency" currencyCode="VND"/></td>
                                    <td><fmt:formatNumber value="${order.orderAmount}" type="currency" currencyCode="VND"/></td>
                                    <td>${order.cusName}</td>
                                    <td>${order.cusEmail}</td>
                                    <td>${order.cusPhone}</td>
                                    <td>${order.cusAddress}</td>
                                    <td><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
                                    <td><span class="order-status status-${order.orderStatus}">${order.orderStatus}</span></td>
                                    <td>
                                        <c:if test="${empty order.shipMentId || order.shipMentId == 0}">
                                            <form action="${pageContext.request.contextPath}/process/ship" method="post" style="display:inline;">
                                                <input type="hidden" name="orderId" value="${order.orderNumber}">
                                                <input type="hidden" name="userId" value="${selectedUserId}">
                                                <button type="submit" class="btn-process">Process</button>
                                            </form>
                                        </c:if>
                                        <button type="button" onclick="toggleDetail(${loop.index})">👁️ View Detail</button>
                                    </td>
                                </tr>

                                <!-- Dòng chi tiết (ẩn lúc đầu) -->
                                <tr id="detail-${loop.index}" class="detail-row" style="display:none; background:#fafafa;">
                                    <td colspan="12">
                                        <table style="width:100%; border:1px solid #ccc; border-collapse: collapse; margin-top:5px;">
                                            <tr style="background:#f1f1f1;">
                                                <th>Shipment ID</th>
                                                <th>Shipment Date</th>
                                                <th>Shipment Status</th>
                                                <th>Shipment Note</th>
                                                <th>Shipped Quantity</th>
                                                <th>Shipper Name</th>
                                                <th>Shipper Email</th>
                                                <th>Shipper Phone</th>
                                                <th>Action</th>
                                            </tr>
                                            <tr>
                                                <td>${order.shipMentId}</td>
                                                <td><fmt:formatDate value="${order.shipmentDate}" pattern="dd/MM/yyyy HH:mm:ss"/></td>
                                                <td>${order.shipmentStatus}</td>
                                                <td>${order.shipmentNote}</td>
                                                <td>${order.shippedQuantity}</td>
                                                <td>${order.shipperName}</td>
                                                <td>${order.shipperEmail}</td>
                                                <td>${order.shipperPhone}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${empty order.shipMentId or order.shipMentId == 0}">
                                                            <span style="color:orange;">⏳ Waiting shipment</span>
                                                        </c:when>

                                                        <c:when test="${order.shipmentStatus != 'SHIPPED' and order.shipmentStatus != 'CANCELLED'}">
                                                            <form action="${pageContext.request.contextPath}/ship/update" method="post" style="display:inline;">
                                                                <input type="hidden" name="shipmentId" value="${order.shipMentId}">
                                                                <input type="hidden" name="shipmentStatus" value="${order.shipmentStatus}">
                                                                <input type="hidden" name="shipmentQty" value="${order.shippedQuantity}">
                                                                <input type="hidden" name="shipmentNote" value="${order.shipmentNote}">
                                                                <button type="submit" class="btn-update">⚙️ delivery process update</button>
                                                            </form>
                                                        </c:when>

                                                        <c:otherwise>
                                                            <span style="color:green;">✔️ End of delivery process</span>
                                                        </c:otherwise>
                                                    </c:choose>


                                                </td>

                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                        <script>
                            function toggleDetail(index) {
                                const detailRow = document.getElementById("detail-" + index);
                                const btn = document.querySelector(`#row-${index} button`);

                                if (detailRow.style.display === "none") {
                                    detailRow.style.display = "table-row";
                                    btn.textContent = "🙈 Hide Detail";
                                } else {
                                    detailRow.style.display = "none";
                                    btn.textContent = "👁️ View Detail";
                                }
                            }
                        </script>

                        <div style="margin-top:20px; text-align:center;">
                            <c:if test="${totalPages > 1}">
                                <c:set var="maxPageDisplay" value="5" />
                                <c:set var="startPage" value="${((currentPage - 1) / maxPageDisplay) * maxPageDisplay + 1}" />
                                <c:set var="endPage" value="${startPage + maxPageDisplay - 1}" />
                                <c:if test="${endPage > totalPages}">
                                    <c:set var="endPage" value="${totalPages}" />
                                </c:if>

                                <c:if test="${currentPage > 1}">
                                    <a href="?page=${currentPage - 1}&sort=${currentSort}&userId=${param.userId}">Prev</a>
                                    &nbsp;
                                </c:if>

                                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                                    <c:choose>
                                        <c:when test="${i == currentPage}">
                                            <b>[${i}]</b>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="${pageContext.request.contextPath}/order/list" method="post" style="display:inline;">
                                                <input type="hidden" name="page" value="${i}">
                                                <input type="hidden" name="sort" value="${currentSort}">
                                                <input type="hidden" name="userId" value="${param.userId}">
                                                <button type="submit" style="background:none; border:none; color:#007bff; cursor:pointer;">
                                                    ${i}
                                                </button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                    &nbsp;
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <a href="?page=${currentPage + 1}&sort=${currentSort}&userId=${param.userId}">Next</a>
                                </c:if>
                            </c:if>
                        </div>


                        <div style="margin-top:15px;">
                            <label for="goToPage">Go to page:</label>
                            <input type="number" id="goToPage" min="1" max="${totalPages}" value="${currentPage}" style="width:60px;">
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

                                // Giữ nguyên sort và userId khi chuyển trang
                                window.location.href = "?page=" + page + "&sort=${currentSort}&userId=${param.userId}";
                            }
                        </script>
                    </c:otherwise>
                </c:choose>
            </main>
        </div>
        <script>
            // Lấy các phần tử
            const userMenuButton = document.getElementById('user-menu-button');
            const userMenuDropdown = document.getElementById('user-menu-dropdown');

            // Hàm mở/đóng dropdown
            function toggleUserMenu() {
                userMenuDropdown.classList.toggle('hidden');
            }

            // Khi click vào nút avatar → toggle dropdown
            userMenuButton.addEventListener('click', function (e) {
                e.stopPropagation(); // Ngăn sự kiện lan ra ngoài
                toggleUserMenu();
            });

            // Đóng dropdown khi click ra ngoài
            document.addEventListener('click', function (e) {
                if (!userMenuButton.contains(e.target) && !userMenuDropdown.contains(e.target)) {
                    userMenuDropdown.classList.add('hidden');
                }
            });

            // (Tùy chọn) Đóng khi nhấn ESC
            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape') {
                    userMenuDropdown.classList.add('hidden');
                }
            });
        </script>            
    </body>
</html>
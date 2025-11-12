<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Order List</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/order_list.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/view_order_lists.css">
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

                <div style="margin: 15px 0;">
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
                </div>

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
                                    <td><fmt:formatNumber value="${order.productUnitPrice}" type="currency" currencyCode="USD"/></td>
                                    <td><fmt:formatNumber value="${order.orderAmount}" type="currency" currencyCode="USD"/></td>
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
                                                                <input type="hidden" name="userId" value="${selectedUserId}">
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
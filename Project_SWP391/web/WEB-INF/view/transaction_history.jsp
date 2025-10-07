<%-- 
    Document   : transaction_history
    Created on : Oct 5, 2025, 1:09:57 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Document</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/transaction_history.css">
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
                <a href="/home.html">Home</a>
                <a href="/products">Products</a>
                <a href="/about">About</a>
                <a href="/policy">Policy</a>
                <a href="/reports">Reports</a>
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
                    <button class="menu-item">
                        <a href="managements.html">Overview</a>
                    </button>
                    <button class="menu-item active">Transaction history</button>
                    <button class="menu-item">Purchase Order History</button>
                    <button class="menu-item">Create purchase order</button>
                    <button class="menu-item">Create inbound inventory</button>
                    <button class="menu-item">Supplier managements</button>
                    <button class="menu-item">Inbound QC Reports</button>
                </div>
            </aside>

            <main class="main">
                <div class="main-header" id="main-header">
                    <h1>Overview</h1>
                </div>

                <div id="main-content">
                    <div class="transaction-actions">
                        <div class="search-bar-container">
                            <input type="text" placeholder="Search" class="search-input" />
                            <button class="search-btn">
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
                                    ></path>
                                <circle
                                    cx="11"
                                    cy="11"
                                    r="6"
                                    stroke="currentColor"
                                    stroke-width="1.4"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    ></circle>
                                </svg>
                            </button>
                        </div>
                        <select class="filter-dropdown">
                            <option>All</option>
                        </select>
                        <button class="filter-btn">Filter</button>
                        <div class="items-per-page">
                            <span>Number of fields</span>
                            <select id="page-size" class="filter-dropdown">
                                <option value="10">10</option>
                                <option value="20">20</option>
                                <option value="50">50</option>
                            </select>
                        </div>
                    </div>

                    <div class="table-container">
                        <table id="tx-table" class="transaction-table">
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>Product</th>
                                    <th>Quantity</th>
                                    <th>Type</th>
                                    <th>Transaction</th>
                                    <th>From</th>
                                    <th>To</th>
                                    <th>Employee</th>
                                    <th>Date</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody id="table-body"></tbody>
                        </table>
                    </div>

                    <div id="pagination" class="pagination">
                        <span>Page</span>
                        <span class="go-to-text">Go to</span>
                        <input type="number" class="page-input" />
                        <button class="go-btn">Go</button>
                    </div>
                </div>
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
            const data = [];
            <c:forEach var="l" items="${tx_list}">
            data.push({
                tx_id: ${l.tx_id},
                product_id: ${l.product_id},
                qty: ${l.qty},
                unit_id: ${l.unit_id},
                transaction: "${l.tx_type}",
                from_location: "${empty l.from_location ? l.related_inbound_id : l.from_location}",
                to_location: "${empty l.to_location ? l.related_outbound_id :  l.to_location}",
                employee_id: ${l.employee_id},
                tx_date: "${l.tx_date}" // yyyy-MM-dd
            });
            </c:forEach>

            let current_page = 1;
            function renderTable(page) {
                const pageSize = parseInt(document.getElementById("page-size").value);
                const tbody = document.querySelector("#table-body");
                tbody.innerHTML = "";
                const start = (page - 1) * pageSize;
                const end = start + pageSize;
                const pageData = data.slice(start, end);
                pageData.forEach((row) => {
                    tbody.innerHTML += `
            <tr>
              <td>` + row.tx_id + `</td>
              <td>` + row.product_id + `</td>
              <td>` + row.qty + `</td>
              <td>` + row.unit_id + `</td>
              <td>` + row.transaction + `</td>
              <td>` + row.from_location + `</td>
              <td>` + row.to_location + `</td>
              <td>` + row.employee_id + `</td>
              <td>` + row.tx_date + `</td>
              <td><a href="#" class="action-view">View</a></td>
              </tr>
          `;
                });
                renderPagination(page, pageSize);
            }

            function renderPagination(currentPage, pageSize) {
                const totalPages = Math.ceil(data.length / pageSize);
                const container = document.getElementById("pagination");
                // Xóa các nút trang cũ, chỉ giữ lại phần "Page" và "Go to"
                container.querySelectorAll(".page-btn").forEach((b) => b.remove());
                // Thêm tối đa 10 nút trang (để không bị quá dài)
                const maxButtons = 10;
                const startPage = Math.max(1, currentPage - Math.floor(maxButtons / 2));
                const endPage = Math.min(totalPages, startPage + maxButtons - 1);
                for (let i = startPage; i <= endPage; i++) {
                    const btn = document.createElement("button");
                    btn.className = "page-btn";
                    btn.textContent = i;
                    if (i === currentPage)
                        btn.classList.add("active");
                    btn.onclick = () => renderTable(i);
                    container.insertBefore(btn, container.querySelector(".go-to-text"));
                }

                // Thêm Prev / Next (nếu cần)
                if (currentPage > 1) {
                    const prev = document.createElement("button");
                    prev.className = "page-btn";
                    prev.textContent = "Prev";
                    prev.onclick = () => renderTable(currentPage - 1);
                    container.insertBefore(prev, container.querySelector(".page-btn"));
                }

                if (currentPage < totalPages) {
                    const next = document.createElement("button");
                    next.className = "page-btn";
                    next.textContent = "Next";
                    next.onclick = () => renderTable(currentPage + 1);
                    container.insertBefore(next, container.querySelector(".go-to-text"));
                }

                // Gán sự kiện nút Go
                const goBtn = container.querySelector(".go-btn");
                const pageInput = container.querySelector(".page-input");
                goBtn.onclick = () => {
                    const val = parseInt(pageInput.value);
                    if (!isNaN(val) && val >= 1 && val <= totalPages) {
                        renderTable(val);
                        pageInput.value = "";
                    } else {
                        alert('Trang không hợp lệ (1 - ' + totalPages + ')');
                    }
                };
            }

            // Khi đổi số phần tử/trang
            document
                    .getElementById("page-size")
                    .addEventListener("change", function () {
                        currentPage = 1; // quay lại trang đầu
                        renderTable(currentPage);
                    });
            // Load lần đầu
            renderTable(current_page);
        </script>
    </body>
</html>

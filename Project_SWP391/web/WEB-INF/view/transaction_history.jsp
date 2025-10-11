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
                        Overview
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
                    <h1>Transaction history</h1>
                </div>

                <form action="${pageContext.request.contextPath}/inbound/transaction" method="get">
                    <div class="transaction-actions">
                        <div class="search-bar-container">
                            <input type="text" name="searchInput" value="${param.searchInput}" placeholder="Search" class="search-input" />
                            <button type="submit" class="search-btn">
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
                        <select name="txType" class="filter-dropdown">
                            <option value="" ${txType == ""? 'selected' : ''}>All</option>
                            <option value="Inbound" ${txType == "Inbound"? 'selected' : ''}>Inbound</option>
                            <option value="Outbound" ${txType == "Outbound"? 'selected' : ''}>Outbound</option>
                            <option value="Moving" ${txType == "Moving"? 'selected' : ''}>Moving</option>
                            <option value="Destroy" ${txType == "Destroy"? 'selected' : ''}>Destroy</option>
                        </select>
                        <button type="submit" class="filter-btn">Filter</button>
                        <div class="items-per-page">
                            <span>Number of fields</span>

                            <select id="page-size" class="filter-dropdown" name="pageSize" onchange="this.form.submit()">
                                <option value="10" ${pageSize == 10? 'selected' : ''}>10</option>
                                <option value="20" ${pageSize == 20? 'selected' : ''}>20</option>
                                <option value="50" ${pageSize == 50? 'selected' : ''}>50</option>
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
                        <span id="pagination-info"></span>
                        <span class="go-to-text">Go to</span>
                        <input type="number" name="pageInput" class="page-input" />
                        <button type="submit" class="go-btn">Go</button>
                    </div>
                </form>
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
                product_name: "${l.product_name}",
                qty: ${l.qty},
                unit_name: "${l.unit_name}",
                tx_type: "${l.tx_type}",
                from_code: "${l.from_code}",
                to_code: "${l.to_code}",
                employee_code: "${l.employee_code}",
                tx_date: "${l.tx_date}"
            }
            );
            </c:forEach>

            let pageNo = parseInt("${pageNo != null ? pageNo - 1 : 0}");
            let pageSize = parseInt("${pageSize != null ? pageSize : 1}");
            let current_page = pageNo + 1;
            let index = (pageNo) * pageSize + 1;

            function renderTable(page) {
                const pageSize = parseInt(document.getElementById("page-size").value);
                const tbody = document.querySelector("#table-body");
                tbody.innerHTML = "";
                data.forEach((row) => {
                    tbody.innerHTML += `
                        <tr>
                            <td>` + index++ + `</td>
                            <td>` + row.product_name + `</td>
                            <td>` + row.qty + `</td>
                            <td>` + row.unit_name + `</td>
                            <td>` + row.tx_type + `</td>
                            <td>` + row.from_code + `</td>
                            <td>` + row.to_code + `</td>
                            <td>` + row.employee_code + `</td>
                            <td>` + row.tx_date + `</td>
                            <td><a href="${pageContext.request.contextPath}/inbound/transaction/view?id=${row.tx_id}" class="action-view">View</a></td>
                        </tr>`;
                });

                renderPagination(page, pageSize);
            }

            function renderPagination(currentPage, pageSize) {
                const totalPages = Math.ceil(${totalLines} / pageSize);
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
                    btn.name = "pageNo";
                    btn.textContent = i;
                    btn.value = i;
                    if (i === currentPage) {
                        btn.classList.add("active");
                    }
                    btn.onclick = () => {
                        this.form.submit();
                    };
                    container.insertBefore(btn, container.querySelector(".go-to-text"));
                }
                
                const info = document.querySelector("#pagination-info");
                info.innerHTML = `Page ` + currentPage + ` of ` + totalPages;

                // Thêm Prev / Next (nếu cần)
//                if (currentPage > 1) {
//                    const prev = document.createElement("button");
//                    prev.className = "page-btn";
//                    prev.textContent = "Prev";
//                    prev.onclick = () => renderTable(currentPage - 1);
//                    container.insertBefore(prev, container.querySelector(".page-btn"));
//                }
//
//                if (currentPage < totalPages) {
//                    const next = document.createElement("button");
//                    next.className = "page-btn";
//                    next.textContent = "Next";
//                    next.onclick = () => renderTable(currentPage + 1);
//                    container.insertBefore(next, container.querySelector(".go-to-text"));
//                }
            }
            
            renderTable(current_page);
        </script>
    </body>
</html>

<!-- 

    

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
-->
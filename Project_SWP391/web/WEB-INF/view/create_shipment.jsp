<%-- 
    Document   : create_shipment
    Created on : Oct 29, 2025, 5:47:08 PM
    Author     : ASUS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Tạo Phiếu Xuất Hàng - StockPhone</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/create_shipment.css" />

        <style>
            .form-group {
                margin-bottom: 18px;
            }
            .form-group label {
                display: block;
                font-weight: 600;
                margin-bottom: 6px;
                font-size: 14px;
            }
            .form-group input[type="text"],
            .form-group input[type="date"],
            .form-group select,
            .form-group textarea {
                width: 100%;
                padding: 10px 12px;
                border-radius: 6px;
                border: 1px solid var(--border, #f0f0f0);
                font-size: 14px;
                font-family: inherit;
                background: #fff;
            }
            .form-group textarea {
                min-height: 90px;
                resize: vertical;
            }

            .main-summary-grid {
                display: grid;
                grid-template-columns: 3fr 1fr;
                gap: var(--gap, 20px);
                margin-top: 20px;
            }

            .summary-card {
                background: #fdfdfd;
                border: 1px solid var(--border, #f0f0f0);
                border-radius: var(--card-radius, 8px);
                padding: 16px 18px;
            }

            .summary-card-title {
                font-size: 16px;
                font-weight: 600;
                margin: 0 0 12px 0;
                padding-bottom: 10px;
                border-bottom: 1px solid var(--border, #f0f0f0);
            }

            /* Danh sách chứa các mục thông tin */
            .info-list {
                display: flex;
                flex-direction: column;
                gap: 10px; /* Khoảng cách giữa các dòng */
            }

            /* Mỗi mục thông tin (hàng) */
            .info-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                font-size: 14px;
            }
            .info-item h5 {
                /* Nhãn (trái) */
                margin: 0;
                font-weight: 500;
                color: var(--muted, #94a3b8);
            }
            .info-item p {
                /* Giá trị (phải) */
                margin: 0;
                font-weight: 600;
                color: var(--text, #0b1220);
            }
            /* === HẾT CSS MỚI === */

            /* CSS cho Bảng (Giữ nguyên) */
            .shipment-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 16px;
            }
            .shipment-table th,
            .shipment-table td {
                border: 1px solid var(--border, #f0f0f0);
                padding: 10px 12px;
                text-align: left;
                font-size: 14px;
                vertical-align: middle;
            }
            .shipment-table th {
                background-color: #f8fafc;
                font-weight: 600;
            }
            .shipment-table th:first-child,
            .shipment-table td:first-child,
            .shipment-table th:nth-child(4),
            .shipment-table td:nth-child(4),
            .shipment-table th:nth-child(5),
            .shipment-table td:nth-child(5) {
                text-align: center;
            }
            .shipment-table .qty-input {
                width: 70px;
                padding: 6px;
                text-align: center;
                border: 1px solid var(--border, #f0f0f0);
                border-radius: 6px;
            }

            /* CSS cho Nút (Giữ nguyên) */
            .action-buttons {
                display: flex;
                justify-content: flex-end;
                gap: 12px;
                margin-top: 24px;
                border-top: 1px solid var(--border, #f0f0f0);
                padding-top: 20px;
            }
            .btn {
                padding: 10px 20px;
                border: none;
                border-radius: 6px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
            }
            .btn-primary {
                background: linear-gradient(
                    90deg,
                    var(--accent, #06b6d4),
                    var(--accent-2, #4f46e5)
                    );
                color: white;
            }
            .btn-primary:hover {
                opacity: 0.9;
            }
            .btn-secondary {
                background: #f1f5f9;
                color: #334155;
                border: 1px solid var(--border, #f0f0f0);
            }
            .btn-secondary:hover {
                background: #e2e8f0;
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

        <div class="layout">
            <aside class="sidebar" aria-label="Sidebaar">
                <h3 class="sidebar-title">Outbound Inventory</h3>

                <div class="sidebar-menu">
                    <a class="menu-item" href="">Overview</a>
                    <a class="menu-item" href="${pageContext.request.contextPath}">Outbound</a>
                    <a class="menu-item">View Shipment Transaction</a>
                    <a class="menu-item active" href="${pageContext.request.contextPath}/create-shipment">Create Shipment</a>
                    <a class="menu-item" href="${pageContext.request.contextPath}"></a>
                    <a class="menu-item">Manager fields</a>
                    <a class="menu-item">Manager fields</a>
                </div>
            </aside>

            <main class="main">
                <div class="main-header">
                    <h1>Tạo Phiếu Xuất Hàng Mới</h1>
                </div>

                <form action="${pageContext.request.contextPath}/create-shipment" method="get">
                    <div class="form-group">
                        <label for="order-id-select">Đơn hàng</label>

                        <select
                            id="order-id-select"
                            name="id"
                            onchange="this.form.submit()"
                            >
                            <option value="" ${id == selectedID? 'selected' : ''}>-- Vui lòng chọn một đơn hàng --</option>
                            <c:forEach var="id" items="${order_id}">
                                <option value="${id}" ${id == selectedID? 'selected' : ''}>Đơn hàng số ${id}</option>
                            </c:forEach>
                        </select>
                    </div>
                </form>
                <div class="main-summary-grid">
                    <div class="summary-card">
                        <h3 class="summary-card-title">
                            Thông tin Đơn hàng & Phiếu xuất
                        </h3>
                        <div class="info-list">
                            <div class="info-item">
                                <h5>Khách hàng:</h5>
                                <p id="customer-name">${orderInfo.fullname}</p>
                            </div>
                            <div class="info-item">
                                <h5>Ngày đặt hàng:</h5>
                                <p id="order-date">${orderInfo.order_date}</p>
                            </div>
                            <div class="info-item">
                                <h5>Trạng thái ĐH:</h5>
                                <p id="order-status">${orderInfo.status}</p>
                            </div>
                            <div
                                class="divider"
                                style="background: var(--border, #f0f0f0); margin: 4px 0"
                                ></div>
                            <div class="info-item">
                                <h5>Nhân viên tạo:</h5>
                                <p>Trần Văn Hùng (NV003)</p>
                            </div>
                            <div class="info-item">
                                <h5>Trạng thái phiếu:</h5>
                                <p>PENDING</p>
                            </div>
                        </div>
                    </div>

                    <div class="summary-card">
                        <h3 class="summary-card-title">Tổng quan Đơn hàng</h3>
                        <div class="info-list">
                            <div class="info-item">
                                <h5>Số dòng SP (SKU):</h5>
                                <p id="summary-sku">${orderInfo.line_count}</p>
                            </div>
                            <div class="info-item">
                                <h5>Tổng số lượng đặt:</h5>
                                <p id="summary-qty">${orderInfo.total_qty}</p>
                            </div>
                            <div class="info-item">
                                <h5>Số dòng SP hiên tại:</h5>
                                <p id="received-sku"></p>
                            </div>
                            <div class="info-item">
                                <h5>Tổng số lượng hiện tại:</h5>
                                <p id="received-qty"></p>
                            </div>
                            <div
                                class="divider"
                                style="background: var(--border, #f0f0f0); margin: 4px 0"
                                ></div>
                            <div class="info-item">
                                <h5>Tổng tiền ĐH:</h5>
                                <p id="order-total">${not empty orderInfo.total_value? orderInfo.total_value : 0} đ</p>
                            </div>
                            <div class="info-item">
                                <h5>Tổng tiền thực tế:</h5>
                                <p id="actual-total" style="color: #059669">0 đ</p>
                            </div>
                            <div class="info-item">
                                <h5>Chênh lệch:</h5>
                                <p id="difference-total" style="color: #dc2626">0 đ</p>
                            </div>
                        </div>
                    </div>
                </div>
                <h3 style="font-size: 18px; margin: 24px 0 10px 0">
                    Chi tiết sản phẩm xuất kho
                </h3>
                <table class="shipment-table">
                    <thead>
                        <tr>
                            <th>STT</th>
                            <th>Sản phẩm (product_id)</th>
                            <th>SL Đặt Hàng</th>
                            <th>SL Xuất Kho</th>
                            <th>Đơn giá</th>
                            <th>Tổng dòng hàng</th>
                        </tr>
                    </thead>
                    <tbody id="shipment-lines-body">
                        <c:forEach var="l" items="${orderDetail}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>
                                    ${l.sku_code}
                                    ${l.name}
                                </td>
                                <td class="ordered-qty">${l.qty_line}</td>
                                <td>
                                    <input type="number"
                                           form="postForm"
                                           class="qty-input"
                                           name="out_qty"
                                           value="0"
                                           min="0"
                                           max="${l.qty_line}"
                                           data-unit-price="${l.unit_price}"
                                           data-line-no="${loop.index}" />
                                    <input type="hidden" name="order_line_id[${loop.index}]" /></td>
                                <td>${l.unit_price}</td>
                                <td class="unit-price-cell">0 đ</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <div class="form-group" style="margin-top: 20px">
                    <label for="shipment-note">Ghi chú (Shipments.note)</label>
                    <textarea
                        id="shipment-note"
                        name="note"
                        form="postForm"
                        placeholder="Thêm ghi chú cho đơn vị vận chuyển hoặc lý do xuất kho..."
                        ></textarea>
                </div>

                <form id="postForm" action="${pageContext.request.contextPath}/create-shipment" method="post">
                    <div class="action-buttons">
                        <input type="hidden" value="${selectedID}" name="id">
                        <button type="button" class="btn btn-secondary">Hủy</button>
                        <button type="submit" class="btn btn-primary">
                            Xác nhận & Tạo Phiếu Xuất
                        </button>
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
            function formatCurrency(number) {
                const num = parseFloat(number);
                return Number.isFinite(num) ? num.toFixed(2) : '0.00';;
            }

            const summaryActualTotal = document.getElementById('actual-total');
            const summaryDifferenceTotal = document.getElementById('difference-total');
            const summaryOrderTotalElement = document.getElementById('order-total');
            const summarySkuCount = document.getElementById('received-sku');
            const summaryQtyCount = document.getElementById('received-qty');
            const qtyInputs = document.querySelectorAll('.qty-input');

            const initialOrderTotalTextWithCommas = summaryOrderTotalElement.textContent.replace(/\s*đ\s*/, '');
            const initialOrderTotalText = initialOrderTotalTextWithCommas.replace(/,/g, '');
            const initialOrderTotal = parseFloat(initialOrderTotalText) || 0;

            function updateTotals() {
                let totalActualValue = 0;
                let totalShippedQty = 0;
                let actualLineCount = 0;

                qtyInputs.forEach((input) => {
                    const unitPrice = parseFloat(input.getAttribute('data-unit-price')) || 0;
                    const maxQty = parseFloat(input.getAttribute('max')) || 0;
                    let outQty = parseFloat(input.value) || 0;

                    if (outQty > maxQty) {
                        outQty = maxQty;
                    } else if (outQty < 0) {
                        outQty = 0;
                    }
                    input.value = outQty;

                    const actualLineTotal = outQty * unitPrice;

                    const row = input.closest('tr');
                    const lineTotalCell = row.querySelector('.unit-price-cell');

                    if (lineTotalCell) {
                        lineTotalCell.textContent = formatCurrency(actualLineTotal);
                    }

                    totalActualValue += actualLineTotal;
                    totalShippedQty += outQty;

                    if (outQty > 0) {
                        actualLineCount++;
                    }
                });

                const difference = totalActualValue - initialOrderTotal;

                summaryActualTotal.textContent = formatCurrency(totalActualValue);
                summaryDifferenceTotal.textContent = formatCurrency(difference);

                // Cập nhật màu cho Chênh lệch
                if (difference > 0) {
                    summaryDifferenceTotal.style.color = '#059669'; // Xanh
                } else if (difference < 0) {
                    summaryDifferenceTotal.style.color = '#dc2626'; // Đỏ
                } else {
                    summaryDifferenceTotal.style.color = 'inherit'; // Mặc định
                }

                document.getElementById('received-sku').textContent = actualLineCount;
                document.getElementById('received-qty').textContent = totalShippedQty;
            }

            qtyInputs.forEach(input => {
                input.addEventListener('input', updateTotals);
                input.addEventListener('blur', updateTotals);
            });

            updateTotals();
        </script>
    </body>
</html>

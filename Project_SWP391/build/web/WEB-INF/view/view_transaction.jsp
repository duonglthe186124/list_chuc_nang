<%-- 
    Document   : view_transaction
    Created on : Oct 12, 2025, 2:57:23 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Transaction detail</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/view_transaction.css"/>
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

            <main class="main" id="receipt">
                <!-- Main header / Receipt No -->
                <div class="main-header" id="main-header">
                    <h3>
                        Transaction No
                        <span class="receipt-no">${view.receipt_no}</span>
                    </h3>
                </div>

                <div class="header-info">
                    <!-- Header block -->
                    <section class="header-card card">
                        <h4 class="block-title">Header Information</h4>
                        <div class="header-columns">
                            <div class="col">
                                <dl>
                                    <dt>PO No</dt>
                                    <dd><a href="#" class="link">${view.po_code}</a></dd>
                                    <dt>Received by</dt>
                                    <dd>${view.fullname} — <small>${view.employee_code}</small> — 0987 654 321</dd>
                                    <dt>Supplier</dt>
                                    <dd>${view.supplier_name}</dd>
                                    <dt>Note / Reason</dt>
                                    <c:if test="${not empty view.note}">
                                        <dd>${view.note}</dd>
                                    </c:if>
                                    <c:if test="${empty view.note}">
                                        <dd>There is no note here</dd>
                                    </c:if>
                                </dl>
                            </div>
                            <div class="col">
                                <dl>
                                    <dt>PO Date</dt>
                                    <dd>2025-10-15</dd>
                                    <dt>Received At</dt>
                                    <dd>${view.received_at}</dd>
                                    <dt>Warehouse / Location</dt>
                                    <dd>Kho A / Floor 2</dd>
                                    <dt>Status</dt>
                                    <dd>
                                        <span class="status status-received">${view.status}</span>
                                    </dd>
                                </dl>
                            </div>
                        </div>
                    </section>

                    <!-- Summary block -->
                    <section class="summary-card card">
                        <h4 class="block-title">Summary</h4>
                        <div class="summary-content">
                            <div class="summary-item">
                                <label>Tổng expected</label>
                                <div id="sum-expected">0</div>
                            </div>
                            <div class="summary-item">
                                <label>Tổng received</label>
                                <div id="sum-received">0</div>
                            </div>
                            <div class="summary-item">
                                <label>Tổng tiền</label>
                                <div id="sum-money">0.00</div>
                            </div>
                            <div class="summary-item">
                                <label>Tỉ lệ nhận</label>
                                <div id="pct-received">0%</div>
                            </div>
                            <div class="summary-item">
                                <label>Số dòng có discrepancy</label>
                                <div id="rows-discrep">0</div>
                            </div>
                        </div>
                    </section>
                </div>

                <!-- Line separator -->
                <hr class="separator" />

                <!-- Lines (table) -->
                <section class="lines card">
                    <h4 class="block-title">Lines (Chi tiết dòng)</h4>
                    <table class="lines-table" id="lines-table">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Product</th>
                                <th>Expected</th>
                                <th>Received</th>
                                <th>Unit Price</th>
                                <th>Line Total</th>
                                <th>Discrepancy</th>
                                <th>Bin</th>
                                <th>Note</th>
                                <th>Serials</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="l" items="${line}">
                                <tr class="line-row" data-line-id="1">
                                    <td class="center">1</td>
                                    <td>
                                        <div class="sku">${l.sku_code}</div>
                                        <div class="prod-name">${l.name}</div>
                                    </td>
                                    <td class="center qty-expected">${l.qty_expected}</td>
                                    <td class="center qty-received">${l.qty_received}</td>
                                    <td class="right unit-price">${l.unit_price}</td>
                                    <td class="right line-total"><fmt:formatNumber value="${l.qty_received * l.unit_price}" type="number" maxFractionDigits="2" /></td>
                                    <td class="center discrepancy">${l.qty_received - l.qty_expected}</td>
                                    <td class="center">${l.location}</td>
                                    <td class="small">${l.note}</td>
                                    <td class="center">
                                        <button class="btn small-btn toggle-serials">
                                            Show Serials (2)
                                        </button>
                                    </td>
                                </tr>
                                <!-- Serials row for dòng 1 -->
                                <tr class="serials-row" data-parent-line="1" hidden>
                                    <td colspan="10" class="serials-cell">
                                        <div class="serials-title">Serials for SKU-001</div>
                                        <table class="serial-table">
                                            <thead>
                                                <tr>
                                                    <th>IMEI</th>
                                                    <th>SERIAL</th>
                                                    <th>Warranty start</th>
                                                    <th>Warranty end</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>123456789012345</td>
                                                    <td>SN001</td>
                                                    <td>2025-10-19</td>
                                                    <td>2026-10-19</td>
                                                </tr>
                                                <tr>
                                                    <td>123456789012346</td>
                                                    <td>SN002</td>
                                                    <td>2025-10-19</td>
                                                    <td>2026-10-19</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </c:forEach>


                            <!-- Dòng 1 -->
                            <tr class="line-row" data-line-id="1">
                                <td class="center">1</td>
                                <td>
                                    <div class="sku">SKU-001</div>
                                    <div class="prod-name">Điện thoại mẫu A</div>
                                </td>
                                <td class="center qty-expected">10</td>
                                <td class="center qty-received">20</td>
                                <td class="right unit-price">200.00</td>
                                <td class="right line-total">2000.00</td>
                                <td class="center discrepancy">0</td>
                                <td class="center">A-01-01</td>
                                <td class="small">Giao nguyên hộp</td>
                                <td class="center">
                                    <button class="btn small-btn toggle-serials">
                                        Show Serials (2)
                                    </button>
                                </td>
                            </tr>
                            <!-- Serials row for dòng 1 -->
                            <tr class="serials-row" data-parent-line="1" hidden>
                                <td colspan="10" class="serials-cell">
                                    <div class="serials-title">Serials for SKU-001</div>
                                    <table class="serial-table">
                                        <thead>
                                            <tr>
                                                <th>IMEI</th>
                                                <th>SERIAL</th>
                                                <th>Warranty start</th>
                                                <th>Warranty end</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>123456789012345</td>
                                                <td>SN001</td>
                                                <td>2025-10-19</td>
                                                <td>2026-10-19</td>
                                            </tr>
                                            <tr>
                                                <td>123456789012346</td>
                                                <td>SN002</td>
                                                <td>2025-10-19</td>
                                                <td>2026-10-19</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <!-- Dòng 2 (có discrepancy) -->
                            <tr class="line-row" data-line-id="2">
                                <td class="center">2</td>
                                <td>
                                    <div class="sku">SKU-002</div>
                                    <div class="prod-name">Router mẫu B</div>
                                </td>
                                <td class="center qty-expected">5</td>
                                <td class="center qty-received">3</td>
                                <td class="right unit-price">150.00</td>
                                <td class="right line-total">450.00</td>
                                <td class="center discrepancy">-2</td>
                                <td class="center">B-02-05</td>
                                <td class="small">Thiếu 2</td>
                                <td class="center">
                                    <button class="btn small-btn toggle-serials">
                                        Show Serials (1)
                                    </button>
                                </td>
                            </tr>
                            <!-- Serials row for dòng 2 -->
                            <tr class="serials-row" data-parent-line="2" hidden>
                                <td colspan="10" class="serials-cell">
                                    <div class="serials-title">Serials for SKU-002</div>
                                    <table class="serial-table">
                                        <thead>
                                            <tr>
                                                <th>IMEI</th>
                                                <th>SERIAL</th>
                                                <th>Warranty start</th>
                                                <th>Warranty end</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>987654321098765</td>
                                                <td>SN100</td>
                                                <td>2025-10-19</td>
                                                <td>2026-10-19</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </section>

                <!-- Summary bottom + actions -->
                <section class="summary-bottom card">
                    <div class="actions-left">
                        <button class="btn ghost">Go to previous page</button>
                    </div>
                    <div class="actions-right">
                        <button class="btn">Print</button>
                        <button class="btn">Export PDF</button>
                        <button class="btn">Download CSV</button>
                    </div>
                </section>
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
<%-- 
    Document   : view_transaction
    Created on : Oct 12, 2025, 2:57:23 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

            <main class="main">
                <div class="main-header" id="main-header">
                    <h3>Transaction N<sup>o</sup>${param.id}</h3>
                    <div class="muted">Type: <strong>${view.tx_type}</strong>· Date: <strong>${view.tx_date}</strong></div>
                </div>

                <div class="grid">
                    <!-- Left column: General transaction + product/unit -->
                    <div class="card">
                        <h4>Transaction information</h4>
                        <div class="meta-row">
                            <div>Ref code</div>
                            <div><strong>${view.ref_code}</strong></div>
                        </div>
                        <div class="meta-row">
                            <div>Transaction type</div>
                            <div><strong>${view.tx_type}</strong></div>
                        </div>
                        <div class="meta-row">
                            <div>Người thực hiện</div>
                            <div>
                                ${view.employee_code} - ${view.fullname}
                            </div>
                        </div>

                        <h4 style="margin-top: 12px">Sản phẩm / Đơn vị</h4>
                        <div class="meta-row">
                            <div>Sản phẩm</div>
                            <div>
                                ${view.product_name}
                            </div>
                        </div>
                        <div class="meta-row">
                            <div>Trạng thái</div>
                            <div>${view.status}</div>
                        </div>

                        <c:if test="${not empty view.description}">
                            <div style="margin-top: 8px">
                                <strong>Mô tả:</strong>
                                <div class="note">${view.description}</div>
                            </div>
                        </c:if>
                    </div>

                    <!-- Right column: Locations, liên kết inbound/outbound -->
                    <div class="card">
                        <h4>Vị trí & Tham chiếu</h4>
                        <div class="meta-row">
                            <div>From</div>
                            <div>
                                ${view.from_code}
                            </div>
                        </div>

                        <div class="meta-row">
                            <div>To</div>
                            <div>
                                ${view.to_code}
                            </div>
                        </div>

                        <h4 style="margin-top: 12px">History location</h4>
                        <c:if test="${not empty view.tx_code}">
                            <div class="meta-row">
                                <div>Mã</div>
                                <div><strong>${view.tx_code}</strong></div>
                            </div>
                            <div class="meta-row">
                                <div>Nhà cung cấp</div>
                                <div>${view.tx_name}</div>
                            </div>
                            <div class="meta-row">
                                <div>Ngày nhận</div>
                                <div>
                                    ${view.date}
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${empty view.tx_code}">
                            <div class="muted" style="margin-top: 8px">
                                Không có bản ghi inbound/outbound liên quan.
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Lines / chi tiết hàng hóa (nếu có) -->
                <div class="card" style="margin-top: 12px">
                    <h4>Chi tiết dòng hàng</h4>

                    <c:choose>
                        <c:when test="${not empty view.name}">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th>Màu</th>
                                        <th>Dung lượng</th>
                                        <th>Unit</th>
                                        <th>Số lượng</th>
                                        <th>Đơn giá</th>
                                    </tr>
                                </thead>
                                <tbody>
                                        <tr>
                                            <td>${view.name}</td>
                                            <td>${view.color}</td>
                                            <td>${view.memory}</td>
                                            <td>${view.unit}</td>
                                            <td>${view.qty}</td>
                                            <td>${view.qty * view.price}</td>
                                        </tr>
                                </tbody>
                            </table>
                        </c:when>

                        <c:otherwise>
                            <div class="muted">
                                Không có dòng hàng chi tiết để hiển thị cho giao dịch này.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Ghi chú và hành động -->
                <div
                    style="
                    margin-top: 12px;
                    display: flex;
                    flex-direction: column;
                    gap: 8px;
                    "
                    >
                    <div class="actions">
                        <a
                            href="${pageContext.request.contextPath}/inbound/transaction"
                            class="btn"
                            >Quay về danh sách</a
                        >
                        <a
                            href="${pageContext.request.contextPath}/inbound/transaction/print?id=${tx.tx_id}"
                            class="btn btn-primary"
                            target="_blank"
                            >In</a
                        >
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
    </body>
</html>

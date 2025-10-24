<%--
    Document    : create_receipt.jsp
    Created on : Oct 19, 2025, 9:58:47 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Tạo Phiếu Nhập Kho</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/create_receipt.css" />

        <style>
            /* Bổ sung: Định dạng các thành phần của Form */
            .form-section {
                margin-bottom: 24px;
            }

            /* CSS ĐÃ CHỈNH SỬA: Bố cục 3 cột cho phần Header */
            .header-layout {
                display: grid;
                grid-template-columns: 1fr 1fr 1fr; /* 3 cột bằng nhau */
                gap: var(--gap, 20px);
                align-items: flex-start; /* căn trên */
                margin-bottom: 24px;
            }
            @media (max-width: 900px) {
                .header-layout {
                    grid-template-columns: 1fr; /* Stack lại trên màn hình nhỏ */
                }
            }
            /* END CSS CHỈNH SỬA */

            /* form-grid không cần thiết cho 3 cột dọc này nữa */
            .form-grid {
                display: grid;
                grid-template-columns: repeat(
                    auto-fit,
                    minmax(200px, 1fr)
                    ); /* Responsive grid */
                gap: var(--gap, 20px);
            }

            .form-group {
                display: flex;
                flex-direction: column;
                gap: 6px;
            }

            .form-group label {
                font-size: 14px;
                font-weight: 500;
                color: #334155;
            }

            .form-group input[type="text"],
            .form-group input[type="date"],
            .form-group input[type="number"],
            .form-group select,
            .form-group textarea {
                width: 100%;
                padding: 10px 12px;
                border: 1px solid var(--border, #f0f0f0);
                border-radius: 6px;
                font-size: 14px;
                font-family: inherit;
            }

            .form-group textarea {
                min-height: 80px;
                resize: vertical;
            }

            /* Bổ sung: Định dạng bảng chi tiết sản phẩm */
            .item-table {
                width: 100%;
                border-collapse: collapse;
                margin: 24px 0;
                font-size: 14px;
            }

            .item-table th,
            .item-table td {
                border: 1px solid var(--border, #f0f0f0);
                padding: 10px 12px;
                text-align: left;
            }

            .item-table th {
                background-color: #f8fafc; /* Màu từ footer của bạn */
                font-weight: 600;
            }

            .item-table .col-stt {
                width: 50px;
                text-align: center;
            }
            .col-qty_expected,
            .col-qty_received,
            .col-price,
            .col-total,
            .col-note{
                width: 120px;
                text-align: right;
            }
            .col-unit {
                width: 80px;
            }
            .col-actions {
                width: auto;
                text-align: center;
            }

            .item-table input[type="number"] {
                width: 100%;
                padding: 8px;
                border: 1px solid var(--border, #f0f0f0);
                border-radius: 4px;
                text-align: right;
            }

            .btn-add-item {
                padding: 8px 14px;
                font-size: 13px;
                font-weight: 500;
                border: 1px solid var(--border, #f0f0f0);
                background: #f8fafc;
                border-radius: 6px;
                cursor: pointer;
            }
            .btn-add-item:hover {
                background-color: #f0f0f0;
            }

            /* Bổ sung: Phần tóm tắt */
            .summary-section {
                background-color: rgb(250, 250, 250);
                margin-top: 0;
                padding: 15px; /* Thêm padding để trông như một block */
                border: 1px solid var(--border, #f0f0f0);
                border-radius: 6px;
            }

            .summary-section h4 {
                margin: 0 0 10px 0;
                font-size: 16px;
            }

            .summary-table {
                width: 100%;
                font-size: 14px;
            }
            .summary-table td {
                padding: 8px 0;
            }
            .summary-table td:last-child {
                text-align: right;
                font-weight: 700;
                min-width: 100px;
            }
            .summary-table .grand-total td {
                font-size: 16px;
                font-weight: 700;
                padding-top: 12px;
                border-top: 1px solid var(--border, #f0f0f0);
            }

            /* Bỏ signature-section */

            /* Bổ sung: Nút bấm */
            .action-buttons {
                display: flex;
                gap: 12px;
                justify-content: flex-end;
                margin-top: 32px;
                padding-top: 20px;
                border-top: 1px solid var(--border, #f0f0f0);
            }

            .btn {
                padding: 10px 20px;
                font-size: 14px;
                font-weight: 700;
                border: none;
                border-radius: 6px;
                cursor: pointer;
            }

            .btn-primary {
                background: linear-gradient(
                    90deg,
                    var(--accent, #06b6d4),
                    var(--accent-2, #4f46e5)
                    );
                color: white;
            }

            .btn-secondary {
                background: #f0f0f0;
                color: var(--text, #0b1220);
                border: 1px solid var(--border, #f0f0f0);
            }
            .btn-secondary:hover {
                background: #e5e5e5;
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
                        stroke-linejoin="round"
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
                <div class="main-header">
                    <h1>Tạo Phiếu Nhập Kho Mới</h1>
                </div>


                <div class="header-layout">
                    <section class="form-section" style="margin-bottom: 0;">
                        <div style="font-weight: 700; margin-bottom: 12px; font-size: 15px;">1. Thông tin Phiếu Nhập</div>

                        <div class="form-group" style="margin-bottom: 15px;">
                            <label for="receipt-id">Số Phiếu</label>
                            <input
                                type="text"
                                id="receipt-id"
                                value="PNK-2025-10-001"
                                disabled
                                />
                        </div>

                        <div class="form-group">
                            <form action="${pageContext.request.contextPath}/inbound/create-receipt" method="get">
                                <label for="po_select">Chọn phiếu đặt hàng</label>
                                <select name="po_id" id="po_select" onchange="this.form.submit()">
                                    <option value="" ${pl.po_id == selectedID ? 'selected' : ''}>---Choose purchase order---</option>
                                    <c:forEach var="pl" items="${poList}">
                                        <option value="${pl.po_id}" ${pl.po_id == selectedID? 'selected' : ''}>${pl.po_code}</option>
                                    </c:forEach>
                                </select>
                            </form>
                        </div>

                        <div class="form-group" style="margin-bottom: 15px;">
                            <label for="receipt-date">Ngày Nhập</label>
                            <input
                                type="date"
                                id="receipt-date"
                                value="2025-10-24"
                                />
                        </div>

                        <div class="form-group">
                            <label>Receipt Note</label>
                            <textarea  
                                placeholder="—"></textarea>
                        </div>

                    </section>

                    <section class="form-section" style="margin-bottom: 0;">
                        <div style="font-weight: 700; margin-bottom: 12px; font-size: 15px;">2. Thông tin Đơn Hàng PO</div>

                        <div class="form-group" style="margin-bottom: 15px;">
                            <label>Supplier</label>
                            <input 
                                type="text" 
                                value="${not empty poHeader ? poHeader.display_name : ''}" 
                                disabled 
                                placeholder="—"
                                />
                        </div>

                        <div class="form-group" style="margin-bottom: 15px;">
                            <label>Created at</label>
                            <input 
                                type="text" 
                                value="${not empty poHeader ? poHeader.created_at : ''}" 
                                disabled 
                                placeholder="—"
                                />
                        </div>

                        <div class="form-group">
                            <label>Purchase Order Note</label>
                            <textarea 
                                disabled 
                                placeholder="—">${not empty poHeader ? poHeader.note : ''}</textarea>
                        </div>
                    </section>

                    <section class="summary-section">
                        <h4>3. Tóm Tắt Chi Phí</h4>
                        <table class="summary-table">
                            <tr>
                                <td>Tổng tiền hàng:</td>
                                <td id="subtotal-display"></td>
                            </tr>
                            <tr class="grand-total">
                                <td>Tổng cộng:</td>
                                <td id="grand-total-display"></td>
                            </tr>
                        </table>
                    </section>
                </div>
                <div class="divider" style="background: var(--border)"></div>

                <form action="${pageContext.request.contextPath}/inbound/create-receipt" method="post">
                    <input type="hidden" name="po_id" value="${selectedID}">
                    <input type="hidden" name="received_no" value="REC102">
                    <section class="form-section">
                        <h2>Chi Tiết Hàng Hóa</h2>
                        <table class="item-table">
                            <thead>
                                <tr>
                                    <th class="col-stt">STT</th>
                                    <th>Tên Sản Phẩm / Dịch Vụ</th>
                                    <th class="col-qty_expected">Số Lượng Dự Tính</th>
                                    <th class="col-qty_received">Số lượng thực tế</th>
                                    <th class="col-price">Đơn Giá</th>
                                    <th class="col-total">Thành Tiền</th>
                                    <th class="col-note">Ghi chú</th>
                                    <th class="col-actions" style="width: 100px;">Thao Tác</th> 
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty poLine}">
                                        <c:forEach var="item" items="${poLine}" varStatus="loop">
                                            <tr data-product-id="${item.product_id}">
                                                <td class="col-stt">${loop.index + 1}</td>
                                                <td>
                                                    <div class="form-group">
                                                        <input
                                                            type="text"
                                                            name="product_name_${item.product_id}"
                                                            value="${item.product_name}"
                                                            style="border: none"
                                                            disabled
                                                            />
                                                    </div>
                                                    <input type="hidden" name="product_id" value="${item.product_id}" />
                                                </td>
                                                <td class="col-qty_expected">
                                                    <input type="number" name="expected_qty" value="${item.qty}" min="0" disabled>
                                                </td>
                                                <td class="col-qty_received">
                                                    <input
                                                        type="number"
                                                        name="received_qty"
                                                        class="item-received-qty"
                                                        data-unit-price="${item.unit_price}"
                                                        value="0"
                                                        min="0"
                                                        />
                                                </td>
                                                <td class="col-price">
                                                    <input
                                                        type="text"
                                                        name="unit_price"
                                                        value="${item.unit_price}"
                                                        disabled
                                                        style="text-align: right; border: none; background: transparent;"
                                                        />
                                                </td>

                                                <td class="col-total item-total-price"></td>

                                                <td class="col-note">
                                                    <div class="form-group">
                                                        <textarea name="note" style="background: transparent;"></textarea>
                                                    </div>
                                                </td>
                                                <td class="col-actions form-group">
                                                    <button
                                                        type="button"
                                                        class="btn-add-item" 
                                                        style="padding: 6px 8px; font-size: 11px; width: 100%;"
                                                        onclick="alert('Cập nhật ĐVT bằng CSV cho dòng này')"
                                                        >
                                                        Update Unit
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                </c:choose>
                            </tbody>
                        </table>
                    </section>

                    <div class="action-buttons">
                        <button type="submit" class="btn btn-primary">
                            Lưu & Hoàn Thành
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
            // JavaScript để tính toán Thành Tiền và Tổng Cộng động

            // JavaScript để tính toán Thành Tiền và Tổng Cộng động

            function formatCurrency(amount) {
                if (isNaN(amount) || amount === null)
                    return "0 đ";
                // Định dạng số với dấu phân cách hàng nghìn (Việt Nam) và thêm đơn vị 'đ'
                return amount.toLocaleString('vi-VN') + ' đ';
            }

            function recalculateItemTotal(inputElement) {
                const receivedQty = parseFloat(inputElement.value) || 0;
                // Lấy đơn giá từ thuộc tính data-unit-price của input đó
                const unitPrice = parseFloat(inputElement.dataset.unitPrice) || 0;

                // Thành tiền = Số lượng thực tế * Đơn giá
                const itemTotal = receivedQty * unitPrice;

                // Cập nhật ô Thành Tiền (col-total)
                const totalCell = inputElement.closest('tr').querySelector('.item-total-price');
                totalCell.innerText = formatCurrency(itemTotal);

                // Lưu trữ giá trị itemTotal vào dataset để tính tổng dễ dàng
                totalCell.dataset.rawTotal = itemTotal; // <-- Đảm bảo dòng này có

                recalculateGrandTotal(); // Luôn gọi tính tổng sau khi cập nhật 1 dòng
            }

            function recalculateGrandTotal() {
                let subTotal = 0;
                // Dùng querySelectorAll trên lớp .item-total-price
                const itemTotals = document.querySelectorAll('.item-total-price');

                itemTotals.forEach(cell => {
                    // Cộng dồn từ giá trị thô đã lưu trữ trong dataset.rawTotal
                    subTotal += parseFloat(cell.dataset.rawTotal) || 0;
                });

                const vatRate = 0.1; // 10%
                const vatAmount = subTotal * vatRate;
                const grandTotal = subTotal + vatAmount;

                // Cập nhật bảng tóm tắt
                document.getElementById('subtotal-display').innerText = formatCurrency(subTotal);
                // Cập nhật VAT display - (Sẽ hoạt động sau khi thêm #vat-display vào HTML)
                document.getElementById('grand-total-display').innerText = formatCurrency(grandTotal);
            }

// Khởi tạo sự kiện và tính toán ban đầu
            document.addEventListener('DOMContentLoaded', () => {
                const qtyInputs = document.querySelectorAll('.item-received-qty');

                qtyInputs.forEach(input => {
                    // Gán sự kiện input để tính toán lại mỗi khi giá trị thay đổi
                    input.addEventListener('input', (event) => {
                        // Đảm bảo giá trị không âm
                        if (parseFloat(event.target.value) < 0) {
                            event.target.value = 0;
                        }
                        recalculateItemTotal(event.target);
                    });

                    // **ĐIỂM QUAN TRỌNG:**
                    // Khi tải trang, cần gọi hàm tính toán cho từng dòng 
                    // để khởi tạo giá trị rawTotal và cập nhật tổng cộng ban đầu.
                    // Đây là cách đảm bảo tất cả các dòng được tính toán, không chỉ dòng đầu tiên.
                    recalculateItemTotal(input);
                });

                // Nếu không có bất kỳ dòng nào (poLine rỗng), vẫn đảm bảo tổng bằng 0
                if (qtyInputs.length === 0) {
                    recalculateGrandTotal();
                }
            });
        </script>
    </body>
</html>
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
                    <a class="menu-item" href="">Overview</a>
                    <a class="menu-item" href="${pageContext.request.contextPath}/inbound/transactions">Transaction history</a>
                    <a class="menu-item">Purchase Order History</a>
                    <a class="menu-item" href="${pageContext.request.contextPath}/inbound/createpo">Create purchase order</a>
                    <a class="menu-item active" href="${pageContext.request.contextPath}/inbound/create-receipt">Create inbound inventory</a>
                    <a class="menu-item">Supplier managements</a>
                    <a class="menu-item">Inbound QC Reports</a>
                </div>
            </aside>

            <main class="main">
                <div class="main-header">
                    <h1>Tạo Phiếu Nhập Kho Mới</h1>
                </div>


                <div class="header-layout">
                    <section class="form-section header-info-section-1">
                        <div class="header-section-title">1. Thông tin Phiếu Nhập</div>

                        <div class="form-group form-group-margin-bottom">
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

                        <div class="form-group form-group-margin-bottom">
                            <label for="receipt-date">Ngày Nhập</label>
                            <input
                                type="date"
                                id="receipt-date"
                                value="2025-10-24"
                                />
                        </div>

                        <div class="form-group">
                            <label>Receipt Note</label>
                            <textarea placeholder="—"></textarea>
                        </div>

                    </section>

                    <%-- Thay thế: style="margin-bottom: 0;" --%>
                    <section class="form-section header-info-section-2">
                        <div class="header-section-title">2. Thông tin Đơn Hàng PO</div>

                        <div class="form-group form-group-margin-bottom">
                            <label>Supplier</label>
                            <input
                                type="text"
                                value="${not empty poHeader ? poHeader.display_name : ''}"
                                disabled
                                placeholder="—"
                                />
                        </div>

                        <div class="form-group form-group-margin-bottom">
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
                <div class="divider"></div>

                <form action="${pageContext.request.contextPath}/inbound/create-receipt" method="post">
                    <input type="hidden" name="po_id" value="${selectedID}">
                    <input type="hidden" name="receipt_no" value="REC102">
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
                                                    <input type="hidden" name="product_id" value="${item.product_id}" />
                                                    <input
                                                        type="text"
                                                        class="product-name-display"
                                                        name="product_name_${item.product_id}"
                                                        value="${item.product_name}"
                                                        readonly=""
                                                        />
                                                    <%--<div class="product-sku">SKU: ${item.sku}</div>--%>
                                                </td>
                                                <td class="col-qty_expected">
                                                    <input 
                                                        type="text" 
                                                        name="expected_qty" 
                                                        value="${item.qty}"
                                                        readonly=""
                                                        />
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
                                                        readonly=""
                                                        />
                                                </td>
                                                <td class="col-total item-total-price">
                                                    <%-- JavaScript sẽ điền vào đây --%>
                                                </td>
                                                <td class="col-note">
                                                    <textarea 
                                                        name="note" 
                                                        rows="2"
                                                        placeholder="..."></textarea>
                                                </td>
                                                <td class="col-actions">
                                                    <button
                                                        type="button"
                                                        class="btn-add-item"
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
            function formatCurrency(amount) {
                if (isNaN(amount) || amount === null)
                    return "0 đ";
                // Định dạng số với dấu phân cách hàng nghìn (Việt Nam) và thêm đơn vị 'đ'
                return amount.toLocaleString('vi-VN') + 'đ';
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
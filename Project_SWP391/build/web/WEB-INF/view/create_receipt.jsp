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

        <script src="https://cdn.sheetjs.com/xlsx-0.20.1/package/dist/xlsx.full.min.js"></script>
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
                            <textarea form="form" name="receipt_note" placeholder="—"></textarea>
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

                <form id="form" action="${pageContext.request.contextPath}/inbound/create-receipt" method="post">
                    <input type="hidden" name="po_id" value="${selectedID}">
                    <input type="hidden" name="receipt_no" value="REC103">
                    <section class="form-section">
                        <h2>Chi Tiết Hàng Hóa</h2>
                        <table class="item-table">
                            <thead>
                                <tr>
                                    <th class="col-stt">STT</th>
                                    <th>Tên Sản Phẩm</th>
                                    <th class="col-qty_expected">SL Dự Tính</th>
                                    <th class="col-qty_received">SL Thực Tế</th>
                                    <th class="col-price">Đơn Giá</th>
                                    <th class="col-total">Thành Tiền</th>
                                    <th class="col-loc">Vị trí</th>
                                    <th class="col-note">Ghi chú</th>
                                    <th class="col-actions" style="width: 100px;">Thao Tác</th> 
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty poLine}">
                                        <c:forEach var="item" items="${poLine}" varStatus="loop">
                                            <tr class="item-main-row" data-product-id="${item.product_id}">
                                                <td class="col-stt">${loop.index + 1}</td>
                                                <td>
                                                    <input type="hidden" name="product_id" value="${item.product_id}" />
                                                    <div class="product-sku-main">
                                                        <input 
                                                            type="text" 
                                                            class="product-sku-display"
                                                            value="${item.sku_code}" 
                                                            readonly="" 
                                                            />
                                                    </div>
                                                    <div class="product-name-sub">
                                                        <input
                                                            type="text"
                                                            class="product-name-display"
                                                            name="product_name_${item.product_id}"
                                                            value="${item.product_name}"
                                                            readonly=""
                                                            />
                                                    </div>

                                                    <div class="unit-data-container" data-product-id="${item.product_id}">
                                                    </div>
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
                                                        id="received-qty-${item.product_id}"
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
                                                <th class="col-loc">
                                                    <select name="location">
                                                        <option value="">Choose locations</option>
                                                        <option value="loc123">loc123</option>
                                                        <option value="loc123">loc123</option>
                                                        <option value="loc123">loc123</option>
                                                        <option value="loc123">loc123</option>
                                                        <option value="loc123">loc123</option>
                                                    </select>
                                                </th>
                                                <td class="col-note">
                                                    <textarea 
                                                        name="note" 
                                                        rows="2"
                                                        placeholder="..."></textarea>
                                                </td>
                                                <td class="col-actions">
                                                    <button type="button" class="btn-toggle-unit-detail">Chi tiết đơn vị</button>
                                                </td>
                                            </tr>
                                            <tr class="unit-detail-row" data-product-id="${item.product_id}" style="display: none;">
                                                <td colspan="8" class="unit-detail-cell">
                                                    <%-- NỘI DUNG CHI TIẾT SẼ ĐƯỢC CHÈN VÀO ĐÂY BẰNG JS --%>
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
                return amount.toLocaleString('vi-VN') + 'đ';
            }

            function recalculateItemTotal(inputElement) {
                const receivedQty = parseFloat(inputElement.value) || 0;
                const unitPrice = parseFloat(inputElement.dataset.unitPrice) || 0;
                const itemTotal = receivedQty * unitPrice;
                const totalCell = inputElement.closest('tr').querySelector('.item-total-price');
                totalCell.innerText = formatCurrency(itemTotal);
                totalCell.dataset.rawTotal = itemTotal;
                recalculateGrandTotal();
            }

            function recalculateGrandTotal() {
                let subTotal = 0;
                const itemTotals = document.querySelectorAll('.item-total-price');

                itemTotals.forEach(cell => {
                    subTotal += parseFloat(cell.dataset.rawTotal) || 0;
                });
                const grandTotal = subTotal;
                // Giả định bạn có các phần tử này trong HTML
                const subtotalDisplay = document.getElementById('subtotal-display');
                const grandTotalDisplay = document.getElementById('grand-total-display');

                if (subtotalDisplay)
                    subtotalDisplay.innerText = formatCurrency(subTotal);
                if (grandTotalDisplay)
                    grandTotalDisplay.innerText = formatCurrency(grandTotal);
            }

            function generateDetailHtml(productId, data = []) {
                const rowsHtml = data.map((item, index) => {
                    return generateDetailRow(index + 1, item);
                }).join('');

                return `
                    <div class="unit-detail-content">
                        <div class="modal-import-section">
                            <label for="unit-file-input-` + productId + `">Import từ CSV/XLSX:</label>
                            <input type="file" id="unit-file-input-` + productId + `" class="unit-file-input" accept=".csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" data-product-id="` + productId + `"/>
                            <p style="font-size: 0.8rem; color: #555; margin: 0;">(Định dạng: IMEI, Serial, Ngày BH bắt đầu, Ngày BH kết thúc)</p>
                        </div>

                        <div class="modal-table-container">
                            <table class="unit-table">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>IMEI</th>
                                        <th>Serial Number</th>
                                        <th>Warranty Start</th>
                                        <th>Warranty End</th>
                                        <th class="col-action">Xóa</th>
                                    </tr>
                                </thead>
                                <tbody id="unit-table-body-` + productId + `">
                                    ` + rowsHtml + `
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer" style="padding: 10px 0; text-align: right;">
                            <button type="button" class="btn btn-secondary btn-add-row" data-product-id="` + productId + `">Thêm dòng</button>
                            <button type="button" class="btn btn-primary btn-save-unit-detail" data-product-id="` + productId + `">Lưu & Đóng</button>
                        </div>
                    </div>`;
            }

            function generateDetailRow(stt, data) {
                const imei = data.imei || '';
                const serial = data.serial || '';
                const warranty_start = data.warranty_start || '';
                const warranty_end = data.warranty_end || '';

                return `
                    <tr>
                        <td>` + stt + `</td>
                        <td><input type="text" name="imei" class="modal-input-imei" value="` + imei + `"></td>
                        <td><input type="text" name="serial_number" class="modal-input-serial" value="` + serial + `"></td>
                        <td><input type="date" name="warranty_start" class="modal-input-warranty-start" value="` + warranty_start + `"></td>
                        <td><input type="date" name="warranty_end" class="modal-input-warranty-end" value="` + warranty_end + `"></td>
                        <td class="col-action">
                            <button type="button" class="btn-danger btn-delete-row">Xóa</button>
                        </td>
                    </tr>
                `;
            }

            // Hàm thêm dòng mới vào bảng chi tiết
            function appendDetailRow(productId, data = {}) {
                const tableBody = document.getElementById('unit-table-body-' + productId); // Sửa lại từ Template Literal
                if (!tableBody)
                    return;

                const rowCount = tableBody.rows.length;
                const tr = document.createElement('tr');
                tr.innerHTML = generateDetailRow(rowCount + 1, data);

                tr.querySelector('.btn-delete-row').addEventListener('click', (e) => {
                    e.target.closest('tr').remove();
                    updateDetailRowNumbers(productId);
                });

                tableBody.appendChild(tr);
            }

            // Hàm cập nhật STT sau khi xóa
            function updateDetailRowNumbers(productId) {
                const tableBody = document.getElementById('unit-table-body-' + productId);
                if (!tableBody)
                    return;

                tableBody.querySelectorAll('tr').forEach((row, index) => {
                    row.cells[0].innerText = index + 1;
                });
            }

            // Hàm tải dữ liệu đã lưu (từ input hidden)
            function loadDataForProduct(productId) {
                // SỬ DỤNG NỐI CHUỖI VÀ TEMPLATE LITERALS
                const storageContainer = document.querySelector('.unit-data-container[data-product-id="' + productId + '"]');
                if (!storageContainer)
                    return [];

                const imeiInputs = storageContainer.querySelectorAll('input[name="unit_' + productId + '_imei"]');
                const serialInputs = storageContainer.querySelectorAll('input[name="unit_' + productId + '_serial"]');
                const startInputs = storageContainer.querySelectorAll('input[name="unit_' + productId + '_warranty_start"]');
                const endInputs = storageContainer.querySelectorAll('input[name="unit_' + productId + '_warranty_end"]');

                const data = [];
                for (let i = 0; i < imeiInputs.length; i++) {
                    data.push({
                        imei: imeiInputs[i].value,
                        serial: serialInputs[i].value,
                        warranty_start: startInputs[i].value,
                        warranty_end: endInputs[i].value
                    });
                }
                return data;
            }

            // Hàm LƯU dữ liệu từ detail row vào container ẩn
            function saveDetailData(productId, detailRowElement) {
                // SỬ DỤNG NỐI CHUỖI VÀ TEMPLATE LITERALS
                const storageContainer = document.querySelector('.unit-data-container[data-product-id="' + productId + '"]');
                const qtyInput = document.getElementById('received-qty-' + productId);
                const tableBody = detailRowElement.querySelector('#unit-table-body-' + productId);

                if (!storageContainer || !qtyInput || !tableBody)
                    return;

                storageContainer.innerHTML = ''; // Xóa sạch input hidden cũ
                let rowCount = 0;

                tableBody.querySelectorAll('tr').forEach(row => {
                    const imei = row.querySelector('.modal-input-imei').value;
                    const serial = row.querySelector('.modal-input-serial').value;
                    const warrantyStart = row.querySelector('.modal-input-warranty-start').value;
                    const warrantyEnd = row.querySelector('.modal-input-warranty-end').value;

                    // Chỉ lưu nếu có IMEI hoặc Serial
                    if (imei.trim() !== '' || serial.trim() !== '') {
                        rowCount++;

                        storageContainer.appendChild(createHiddenInput('unit_' + productId + '_imei', imei));
                        storageContainer.appendChild(createHiddenInput('unit_' + productId + '_serial', serial));
                        storageContainer.appendChild(createHiddenInput('unit_' + productId + '_warranty_start', warrantyStart));
                        storageContainer.appendChild(createHiddenInput('unit_' + productId + '_warranty_end', warrantyEnd));
                    }
                });

                // CẬP NHẬT SỐ LƯỢNG THỰC TẾ
                qtyInput.value = rowCount;

                // Kích hoạt tính toán lại tổng tiền cho dòng này
                recalculateItemTotal(qtyInput);
            }

            // Helper: tạo input hidden
            function createHiddenInput(name, value) {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = name;
                input.value = value;
                return input;
            }

            // --- CÁC HÀM XỬ LÝ FILE (Cần có thư viện XLSX/SheetJS) ---

            // Hàm gán sự kiện cho các nút trong detail row sau khi nó được chèn vào DOM
            function attachDetailRowListeners(productId) {
                const detailRow = document.querySelector('.unit-detail-row[data-product-id="' + productId + '"]');
                if (!detailRow)
                    return;

                // 1. Nút Thêm dòng
                const addRowBtn = detailRow.querySelector('.btn-add-row');
                if (addRowBtn) {
                    addRowBtn.addEventListener('click', () => {
                        appendDetailRow(productId);
                    });
                }

                // 2. Nút Lưu
                const saveBtn = detailRow.querySelector('.btn-save-unit-detail');
                if (saveBtn) {
                    saveBtn.addEventListener('click', () => {
                        saveDetailData(productId, detailRow);
                        // Sau khi lưu, đóng hàng chi tiết
                        const mainRow = document.querySelector('.item-main-row[data-product-id="' + productId + '"]');
                        const toggleButton = mainRow ? mainRow.querySelector('.btn-toggle-unit-detail') : null;
                        detailRow.style.display = 'none';
                        if (toggleButton)
                            toggleButton.innerText = 'Chi tiết Đơn vị';
                    });
                }

                // 3. Xử lý file input
                const fileInput = detailRow.querySelector('.unit-file-input');
                if (fileInput) {
                    fileInput.addEventListener('change', (event) => handleFileImportForProduct(event, productId));
                }

                // 4. Gán sự kiện cho nút xóa (nếu có dữ liệu cũ)
                detailRow.querySelectorAll('.btn-delete-row').forEach(button => {
                    button.addEventListener('click', (e) => {
                        e.target.closest('tr').remove();
                        updateDetailRowNumbers(productId);
                    });
                });
            }

            // Hàm xử lý file import TÁCH BIỆT cho từng sản phẩm
            function handleFileImportForProduct(event, productId) {
                const file = event.target.files[0];
                if (!file)
                    return;

                const reader = new FileReader();

                if (file.name.endsWith('.csv')) {
                    reader.onload = (e) => {
                        const text = e.target.result;
                        const data = parseCsv(text);
                        renderDetailTable(productId, data);
                    };
                    reader.readAsText(file);
                } else if (file.name.endsWith('.xlsx')) {
                    if (typeof XLSX === 'undefined') {
                        alert('Thư viện đọc file Excel (SheetJS) chưa được tải.');
                        return;
                    }
                    reader.onload = (e) => {
                        const data = new Uint8Array(e.target.result);
                        const jsonData = parseXlsx(data);
                        renderDetailTable(productId, jsonData);
                    };
                    reader.readAsArrayBuffer(file);
                }
            }

            // Hiển thị dữ liệu đã parse lên bảng chi tiết
            function renderDetailTable(productId, data) {
                const tableBody = document.getElementById('unit-table-body-' + productId);
                if (!tableBody)
                    return;

                tableBody.innerHTML = ''; // Xóa dữ liệu cũ
                data.forEach(item => {
                    appendDetailRow(productId, item);
                });
            }

            // Phân tích CSV (Giữ nguyên)
            function parseCsv(text) {
                const data = [];
                const lines = text.split(/\r?\n/).filter(line => line.trim() !== '');
                // Bỏ qua header nếu có
                for (const line of lines) {
                    const cols = line.split(',');
                    data.push({
                        imei: cols[0] ? cols[0].trim() : '',
                        serial: cols[1] ? cols[1].trim() : '',
                        warranty_start: cols[2] ? cols[2].trim() : '',
                        warranty_end: cols[3] ? cols[3].trim() : ''
                    });
                }
                return data;
            }

            // Phân tích XLSX (Giữ nguyên)
            function parseXlsx(data) {
                if (typeof XLSX === 'undefined')
                    return [];
                const workbook = XLSX.read(data, {type: 'array'});
                const sheetName = workbook.SheetNames[0];
                const worksheet = workbook.Sheets[sheetName];

                const jsonData = XLSX.utils.sheet_to_json(worksheet, {
                    header: ['imei', 'serial', 'warranty_start', 'warranty_end'],
                    defval: ''
                });

                // Định dạng lại ngày (SheetJS có thể đọc ngày thành số)
                jsonData.forEach(item => {
                    item.warranty_start = formatDateFromExcel(item.warranty_start);
                    item.warranty_end = formatDateFromExcel(item.warranty_end);
                });

                return jsonData;
            }

            // Helper: Chuyển đổi ngày từ Excel (Giữ nguyên)
            function formatDateFromExcel(excelDate) {
                if (typeof excelDate === 'number') {
                    if (typeof XLSX.SSF === 'undefined')
                        return ''; // Tránh lỗi nếu XLSX chưa load đủ
                    const date = XLSX.SSF.parse_date_code(excelDate);
                    const jsDate = new Date(Date.UTC(date.y, date.m - 1, date.d));
                    return jsDate.toISOString().split('T')[0];
                }
                return excelDate;
            }

            document.addEventListener('DOMContentLoaded', () => {

                // 1. Logic tính toán tổng tiền
                const qtyInputs = document.querySelectorAll('.item-received-qty');
                qtyInputs.forEach(input => {
                    input.addEventListener('input', (event) => {
                        if (parseFloat(event.target.value) < 0) {
                            event.target.value = 0;
                        }
                        recalculateItemTotal(event.target);
                    });
                    recalculateItemTotal(input);
                });

                if (qtyInputs.length === 0) {
                    recalculateGrandTotal();
                }

                // 2. Logic TOGGLE ROW DETAIL
                document.querySelectorAll('.btn-toggle-unit-detail').forEach(button => {
                    button.addEventListener('click', (e) => {
                        const mainRow = e.target.closest('tr.item-main-row');
                        const productId = mainRow.dataset.productId;

                        // Tìm hàng chi tiết
                        const detailRow = document.querySelector('.unit-detail-row[data-product-id="' + productId + '"]'); // SỬ DỤNG NỐI CHUỖI

                        if (!detailRow) {
                            console.error('Không tìm thấy detail row cho product ID: ' + productId);
                            return;
                        }

                        if (detailRow.style.display === 'none' || detailRow.style.display === '') {
                            // Hiển thị và tải dữ liệu
                            const savedData = loadDataForProduct(productId);
                            detailRow.querySelector('.unit-detail-cell').innerHTML = generateDetailHtml(productId, savedData);
                            detailRow.style.display = 'table-row';
                            e.target.innerText = 'Đóng chi tiết'; // Cập nhật text nút

                            // Gán lại sự kiện cho các nút mới được tạo
                            attachDetailRowListeners(productId);
                        } else {
                            // Ẩn hàng chi tiết
                            detailRow.style.display = 'none';
                            e.target.innerText = 'Chi tiết Đơn vị'; // Cập nhật text nút
                        }
                    });
                });
            });
        </script>
    </body>
</html>
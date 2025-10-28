<%-- 
    Document   : create_prurchase_order
    Created on : Oct 21, 2025, 9:58:47 AM
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/createpo.css" />
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
                <h3 class="sidebar-title">Role Pannel</h3>

                <div class="sidebar-menu">
                    <a class="menu-item" href="">Overview</a>
                    <a class="menu-item" href="${pageContext.request.contextPath}/inbound/transactions">Transaction history</a>
                    <a class="menu-item">Purchase Order History</a>
                    <a class="menu-item active" href="${pageContext.request.contextPath}/inbound/createpo">Create purchase order</a>
                    <a class="menu-item" href="${pageContext.request.contextPath}/inbound/create-receipt">Create inbound inventory</a>
                    <a class="menu-item">Supplier managements</a>
                    <a class="menu-item">Inbound QC Reports</a>
                </div>
            </aside>

            <main class="main">
                <div class="main-header" id="main-header">
                    <h1>Create Purchase Order</h1>
                </div>

                <form action="${pageContext.request.contextPath}/inbound/createpo" method="post">
                    <div class="form-container">
                        <div class="po-grid">
                            <div class="form-section">
                                <h3 class="form-section-title">General Information</h3>
                                <div class="form-grid">
                                    <div class="form-group">
                                        <label for="po-code">PO Code</label>
                                        <input
                                            type="text"
                                            id="po-code"
                                            name="po_code"
                                            value="${po_code}"
                                            readonly=""
                                            />
                                    </div>
                                    <div class="form-group">
                                        <label for="supplier">Supplier</label>
                                        <select id="supplier" name="supplier">
                                            <option value="">Select a supplier</option>
                                            <c:forEach var="sl" items="${sList}">
                                                <option value="${sl.supplier_id}">${sl.supplier_name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <%--
                                    <div class="form-group">
                                        <label for="delivery-date">Expected Delivery Date</label>
                                        <input type="date" id="delivery-date" name="delivery_date"/>
                                    </div>
                                    <div class="form-group">
                                        <label for="payment-terms">Payment Terms</label>
                                        <select id="payment-terms">
                                            <option>Net 30 (Pay within 30 days)</option>
                                            <option>Cash on Delivery (COD)</option>
                                            <option>Pay in Advance</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="currency">Currency</label>
                                        <select id="currency">
                                            <option>VND</option>
                                            <option>USD</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="delivery-location">Delivery Location</label>
                                        <input
                                            type="text"
                                            id="delivery-location"
                                            value="Main Warehouse - B2"
                                            />
                                    </div> --%>
                                </div>
                                <div class="form-group">
                                    <label for="po-note">Note</label>
                                    <textarea
                                        id="po-note"
                                        rows="3"
                                        placeholder="Add a note for this purchase order..."
                                        name="note"
                                        ></textarea>
                                </div>
                            </div>

                            <div class="form-section summary-card">
                                <h3 class="form-section-title">Summary</h3>
                                <div class="summary-line">
                                    <span>Subtotal</span>
                                    <span>$1,350.00</span>
                                </div>
                                <div class="summary-line">
                                    <span>Discount</span>
                                    <span>-$50.00</span>
                                </div>
                                <div class="summary-line">
                                    <span>Tax (10%)</span>
                                    <span>$135.00</span>
                                </div>
                                <hr class="summary-divider" />
                                <div class="summary-line total">
                                    <span>Total</span>
                                    <span>$1,435.00</span>
                                </div>
                            </div>
                        </div>

                        <div class="form-section">
                            <h3 class="form-section-title">Product Details</h3>
                            <div class="table-container">
                                <table class="line-items-table">
                                    <thead>
                                        <tr>
                                            <th>Product / Item</th>
                                            <th>Quantity</th>
                                            <th>Unit Price</th> 
                                            <th>Total</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div class="form-group">
                                                    <select name="product">
                                                        <option value="">Choose product</option>
                                                        <c:forEach var="pl" items="${pList}">
                                                            <option value="${pl.product_id}">${pl.sku_code}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </td>
                                            <td><input type="number" value="1" name="qty"/></td>
                                            <td><input type="text" value="0" name="unit_price"/></td>
                                            <td></td>
                                            <td class="action-cell"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <button type="button" class="btn-add-item">+ Add Product</button>
                        </div>

                        <div class="form-actions">
                            <p style="color: red; margin: 0; padding-top: 7px">${not empty error? error : ""}</p>
                            <button type="button" class="btn-cancel">Cancel</button>
                            <button type="submit" class="btn-create-po" id="create-po">Create Purchase Order</button>
                        </div>
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
            (function () {
                const table = document.querySelector('.line-items-table');
                if (!table)
                    return;
                const tbody = table.querySelector('tbody');

                const summaryCard = document.querySelector('.summary-card');
                const subtotalSpan = summaryCard?.querySelectorAll('.summary-line')[0]?.querySelectorAll('span')[1];
                const discountSpan = summaryCard?.querySelectorAll('.summary-line')[1]?.querySelectorAll('span')[1];
                // try find tax span (the line that contains "Tax")
                const taxLine = Array.from(summaryCard?.querySelectorAll('.summary-line') || [])
                        .find(l => /tax/i.test(l.textContent));
                const taxSpan = taxLine ? taxLine.querySelectorAll('span')[1] : null;
                const totalSpan = summaryCard?.querySelector('.summary-line.total')?.querySelectorAll('span')[1];

                function parseNumber(s) {
                    if (s === null || s === undefined)
                        return 0;
                    const cleaned = String(s).replace(/[^0-9.\-]+/g, '');
                    const n = parseFloat(cleaned);
                    return isNaN(n) ? 0 : n;
                }
                function formatNumber(n) {
                    return Number.isFinite(n) ? n.toFixed(2) : '0.00';
                }

                // get tax rate from label like "Tax (10%)"
                function getTaxRate() {
                    if (!taxLine)
                        return 0;
                    const m = taxLine.textContent.match(/\((\d+(\.\d+)?)\s*%\)/);
                    return m ? parseFloat(m[1]) / 100 : 0;
                }

                function computeRowTotal(row) {
                    const qtyInp = row.querySelector('td:nth-child(2) input');
                    const priceInp = row.querySelector('td:nth-child(3) input');
                    const totalCell = row.querySelector('td:nth-child(4)');

                    const q = parseNumber(qtyInp?.value) || 0;
                    const p = parseNumber(priceInp?.value) || 0;
                    const lineTotal = q * p;
                    if (totalCell)
                        totalCell.textContent = formatNumber(lineTotal);
                    return lineTotal;
                }

                function recalcAll() {
                    let subtotal = 0;
                    Array.from(tbody.querySelectorAll('tr')).forEach(r => subtotal += computeRowTotal(r));

                    if (subtotalSpan)
                        subtotalSpan.textContent = formatNumber(subtotal);
                    if (discountSpan)
                        discountSpan.textContent = formatNumber(0);
                    if (taxSpan)
                        taxSpan.textContent = formatNumber(0);
                    if (totalSpan)
                        totalSpan.textContent = formatNumber(subtotal);
                }

                // attach listeners to a row
                function attachRowListeners(row) {
                    ['input'].forEach(ev => {
                        row.querySelectorAll('input').forEach(inp => inp.addEventListener(ev, recalcAll));
                    });
                    const del = row.querySelector('.btn-delete-item');
                    if (del)
                        del.addEventListener('click', () => {
                            row.remove();
                            recalcAll();
                        });
                }

                // initial bind
                Array.from(tbody.querySelectorAll('tr')).forEach(attachRowListeners);

                // add product button (if present)
                const addBtn = document.querySelector('.btn-add-item');
                if (addBtn) {
                    addBtn.addEventListener('click', e => {
                        e.preventDefault();
                        const newRow = document.createElement('tr');
                        newRow.innerHTML = `
                            <td>
                                <div class="form-group">
                                    <select name="product">
                                        <option value="">Choose product</option>
                                        <c:forEach var="pl" items="${pList}">
                                            <option value="${pl.product_id}">${pl.sku_code}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </td>
                            <td><input type="number" value="1" name="qty"/></td>
                            <td><input type="text" value="0" name="unit_price"/></td>
                            <td>0.00</td>
                            <td class="action-cell"><button class="btn-delete-item">✕</button></td>
                        `;
                        tbody.appendChild(newRow);
                        attachRowListeners(newRow);
                        recalcAll();
                    });
                }

                // allow editing global discount in summary if user types into it (optional)
                if (discountSpan) {
                    // make it editable by double click
                    discountSpan.addEventListener('dblclick', () => {
                        const cur = parseNumber(discountSpan.textContent).toString();
                        const input = document.createElement('input');
                        input.type = 'text';
                        input.value = cur;
                        input.style.width = '80px';
                        discountSpan.replaceWith(input);
                        input.focus();
                        function commit() {
                            const v = Math.abs(parseNumber(input.value));
                            const span = document.createElement('span');
                            span.textContent = formatNumber(v);
                            input.replaceWith(span);
                            recalcAll();
                        }
                        input.addEventListener('blur', commit);
                        input.addEventListener('keydown', ev => {
                            if (ev.key === 'Enter')
                                commit();
                        });
                    });
                }

                recalcAll();
            })();
        </script>
    </body>
</html>

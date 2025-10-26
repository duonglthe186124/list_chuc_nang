<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Order</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css"/>
        <style>
/*            .container {
                max-width: 600px;
                margin: 20px auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }*/
            .product-info img {
                max-width: 150px;
                height: auto;
                border-radius: 5px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            .form-group label {
                display: block;
                margin-bottom: 5px;
            }
            .form-group input {
                width: 100%;
                padding: 8px;
                box-sizing: border-box;
            }
            .error {
                color: red;
                margin-bottom: 10px;
            }
            #totalAmount {
                font-weight: bold;
                color: green;
            }
        </style>
        <script>
            function updateTotalAmount() {
                // Lấy giá trị từ input qty và purchasePrice
                var qty = document.getElementById("qty").value;
                var purchasePrice = parseFloat("${productInfo.unitPrice}"); // Lấy giá trị BigDecimal từ JSP
                var totalAmountElement = document.getElementById("totalAmount");
                var maxQuantity = ${productInfo.quantity}; // Số lượng tối đa từ JSP

                // Kiểm tra nếu qty hợp lệ
                if (qty === "" || isNaN(qty) || qty <= 0) {
                    totalAmountElement.textContent = "0.00";
                    return;
                }

                // Kiểm tra nếu qty vượt quá số lượng tồn kho
                if (parseInt(qty) > maxQuantity) {
                    alert("Quantity exceeds available stock!");
                    document.getElementById("qty").value = maxQuantity;
                    qty = maxQuantity;
                }

                if (!Number.isInteger(parseFloat(qty))) {
                    alert("Please enter a whole number!");
                    document.getElementById("qty").value = "";
                    totalAmountElement.textContent = "0.00";
                    return;
                }

                // Tính total_amount
                var total = purchasePrice * qty;
                totalAmountElement.textContent = total.toFixed(2); // Hiển thị 2 chữ số thập phân
            }
        </script>
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
            <main class="main">
                <div class="main-header" id="main-header">
                    <h1>Create Order for ${productInfo.productName}</h1>
                </div>

                <div class="container">

                    <!-- Hiển thị thông tin sản phẩm -->
                    <div class="product-info">
                        <img src="${productInfo.imageUrl}" alt="${productInfo.productName}" />
                        <p><strong>Product Name:</strong> ${productInfo.productName}</p>
                        <p><strong>Purchase Price:</strong> <fmt:formatNumber value="${productInfo.unitPrice}" type="currency" currencySymbol="$" /></p>
                        <p><strong>Available Quantity:</strong> ${productInfo.quantity}</p>
                    </div>

                    <!-- Hiển thị thông báo lỗi nếu có -->
                    <c:if test="${not empty errorMessage}">
                        <div class="error">${errorMessage}</div>
                    </c:if>

                    <!-- Form tạo đơn -->
                    <form action="${pageContext.request.contextPath}/process/order" method="post">

                        <input type="hidden" name="product_id" value="${param.id}" />
                        <input type="hidden" name="unitPrice" value="${productInfo.unitPrice}" />

                        <div class="form-group">
                            <label for="fullname">Full Name:</label>
                            <input type="text" id="fullname" name="fullname" required />
                        </div>

                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" id="email" name="email" required />
                        </div>

                        <div class="form-group">
                            <label for="phone">Phone:</label>
                            <input type="text" id="phone" name="phone" required />
                        </div>

                        <div class="form-group">
                            <label for="address">Address:</label>
                            <input type="text" id="address" name="address" required />
                        </div>

                        <div class="form-group">
                            <label for="qty">Quantity:</label>
                            <input type="number" id="qty" name="qty" min="1" max="${productInfo.quantity}" 
                                   required oninput="updateTotalAmount()" onchange="updateTotalAmount()" />
                        </div>

                        <div class="form-group">
                            <label><strong>Total Amount:</strong></label>
                            <span id="totalAmount">0.00</span> USD
                        </div>

                        <button type="submit">Create Order</button>
                    </form>

                    <!-- Link quay lại -->
                    <p><a href="${pageContext.request.contextPath}/products">Back to Products</a></p>
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
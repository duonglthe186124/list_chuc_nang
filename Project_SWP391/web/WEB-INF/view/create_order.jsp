<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Order</title>
        <style>
            .container {
                max-width: 600px;
                margin: 20px auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
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
        <div class="container">
            <h1>Create Order for ${productInfo.productName}</h1>

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
    </body>
</html>
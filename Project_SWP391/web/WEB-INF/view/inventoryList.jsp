<%-- 
    Document   : inventoryList
    Created on : Oct 28, 2025, 10:47:08 PM
    Author     : Ha Trung KI
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi" class="scroll-smooth">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Quản lý Kho hàng - WMS Pro</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
            rel="stylesheet"
            />
        <style>
            body {
                font-family: "Inter", sans-serif;
            }
            #admin-sidebar::-webkit-scrollbar {
                display: none;
            }
            #admin-sidebar {
                -ms-overflow-style: none;
                scrollbar-width: none;
            }

            #admin-sidebar.is-collapsed {
                width: 5rem;
            }

            #admin-sidebar.is-collapsed .sidebar-text,
            #admin-sidebar.is-collapsed .sidebar-submenu,
            #admin-sidebar.is-collapsed .sidebar-arrow {
                display: none;
            }

            #admin-sidebar.is-collapsed .sidebar-item-button {
                justify-content: center;
            }

            #admin-sidebar.is-collapsed .icon-collapse {
                display: none;
            }
            #admin-sidebar:not(.is-collapsed) .icon-expand {
                display: none;
            }

            #main-content {
                transition: margin-left 0.3s ease-in-out;
                margin-left: 250px;
            }
            #main-content.sidebar-collapsed {
                margin-left: 5rem;
            }
            .filter-form {
                padding: 20px;
                background: #f9f9f9;
                border-radius: 8px;
                margin-bottom: 20px;
            }
            .filter-form form {
                display: flex;
                align-items: flex-end;
                gap: 15px;
            }
            .form-group {
                flex: 1;
            }
            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }
            .form-group input, .form-group select {
                width: 100%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .detail-table {
                font-size: 0.9em;
            }
            .detail-table th, .detail-table td {
                padding: 6px 8px;
            }
            .pagination {
                margin-top: 20px;
            }
            .pagination a, .pagination span {
                display: inline-block;
                padding: 8px 12px;
                margin: 0 2px;
                border: 1px solid #ccc;
                color: #337ab7;
                text-decoration: none;
            }
            .pagination span.current {
                background-color: #337ab7;
                color: white;
                border-color: #337ab7;
            }
            .pagination a:hover {
                background-color: #eee;
            }
        </style>
    </head>
    <body class="bg-gray-100 text-gray-800">
        <header
            class="fixed top-0 left-0 right-0 z-50 bg-white border-b border-gray-200"
            >
            <div
                class="mx-auto px-4 sm:px-6 lg:px-8 flex h-16 items-center justify-between"
                >
                <a
                    href="${pageContext.request.contextPath}/home"
                    class="flex items-center gap-2 text-2xl font-bold text-gray-900"
                    >
                    <svg
                        class="h-8 w-8 text-indigo-600"
                        xmlns="http://www.w3.org/2000/svg"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke-width="1.5"
                        stroke="currentColor"
                        >
                    <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        d="M3.75 6A2.25 2.25 0 0 1 6 3.75h2.25A2.25 2.25 0 0 1 10.5 6v2.25a2.25 2.25 0 0 1-2.25 2.25H6a2.25 2.25 0 0 1-2.25-2.25V6ZM3.75 15.75A2.25 2.25 0 0 1 6 13.5h2.25a2.25 2.25 0 0 1 2.25 2.25V18a2.25 2.25 0 0 1-2.25 2.25H6A2.25 2.25 0 0 1 3.75 18v-2.25ZM13.5 6a2.25 2.25 0 0 1 2.25-2.25H18A2.25 2.25 0 0 1 20.25 6v2.25A2.25 2.25 0 0 1 18 10.5h-2.25A2.25 2.25 0 0 1 13.5 8.25V6ZM13.5 15.75a2.25 2.25 0 0 1 2.25-2.25H18a2.25 2.25 0 0 1 2.25 2.25V18A2.25 2.25 0 0 1 18 20.25h-2.25A2.25 2.25 0 0 1 13.5 18v-2.25Z"
                        />
                    </svg>
                    <span>WMS Pro</span>
                </a>

                <nav class="flex items-center space-x-6">
                    <a
                        href="${pageContext.request.contextPath}/home"
                        class="font-medium text-gray-600 hover:text-indigo-600 transition-colors"
                        >Về trang chủ</a
                    >
                    <a
                        href="#"
                        class="font-medium text-gray-600 hover:text-indigo-600 transition-colors"
                        >Hỗ trợ</a
                    >

                    <div class="relative">
                        <button
                            id="user-menu-button"
                            class="flex items-center gap-2 rounded-full p-1 pr-2 text-sm font-medium text-gray-600 hover:bg-gray-100"
                            >
                            <img
                                class="h-8 w-8 rounded-full object-cover"
                                src="https://placehold.co/40x40/e2e8f0/64748b?text=User"
                                alt="Avatar"
                                />
                            <span>Admin</span>
                            <svg
                                class="h-4 w-4 text-gray-500"
                                xmlns="http://www.w3.org/2000/svg"
                                viewBox="0 0 20 20"
                                fill="currentColor"
                                >
                            <path
                                fill-rule="evenodd"
                                d="M5.23 7.21a.75.75 0 0 1 1.06.02L10 10.94l3.71-3.71a.75.75 0 1 1 1.06 1.06l-4.25 4.25a.75.75 0 0 1-1.06 0L5.23 8.29a.75.75 0 0 1 .02-1.06Z"
                                clip-rule="evenodd"
                                />
                            </svg>
                        </button>

                        <div
                            id="user-menu-dropdown"
                            class="absolute right-0 mt-2 w-48 origin-top-right rounded-md bg-white py-1 shadow-lg ring-1 ring-black ring-opacity-5 z-50 hidden transition ease-out duration-100 transform opacity-0 scale-95"
                            >
                            <a
                                href="#"
                                class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                                >Thông tin cá nhân</a
                            >
                            <a
                                href="#"
                                class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                                >Quản lý</a
                            >
                            <div class="my-1 border-t border-gray-100"></div>
                            <a
                                href="${pageContext.request.contextPath}/logout"
                                class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                                >Đăng xuất</a
                            >
                        </div>
                    </div>
                </nav>
            </div>
        </header>

        <div class="flex" style="padding-top: 64px">
            <aside
                id="admin-sidebar"
                class="w-64 bg-white shadow-lg fixed top-16 left-0 h-[calc(100vh-64px)] overflow-y-auto transition-all duration-300 ease-in-out z-40 flex flex-col justify-between"
                >
                <nav class="py-4 px-3 space-y-1.5">
                    <a
                        href="${pageContext.request.contextPath}/inbound/dashboard"
                        class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors sidebar-item-button"
                        >
                        <svg
                            class="h-5 w-5 flex-shrink-0"
                            xmlns="http://www.w3.org/2000/svg"
                            fill="none"
                            viewBox="0 0 24 24"
                            stroke-width="1.5"
                            stroke="currentColor"
                            >
                        <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="m2.25 12 8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25"
                            />
                        </svg>
                        <span class="sidebar-text">Tổng quan</span>
                    </a>

                    <a
                        href="${pageContext.request.contextPath}/warehouse/inventory"
                        class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors sidebar-item-button"
                        >
                        <svg class="h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M20.25 7.5l-.625 10.632a2.25 2.25 0 0 1-2.247 2.118H6.622a2.25 2.25 0 0 1-2.247-2.118L3.75 7.5M10.5 11.25h3M12 15V7.5m-6.75 4.5l.625 10.632a2.25 2.25 0 0 0 2.247 2.118h11.25a2.25 2.25 0 0 0 2.247-2.118l.625-10.632M3.75 7.5h16.5" /></svg>
                        <span class="sidebar-text">Danh sách sản phẩm</span>
                    </a>

                    <a
                        href="${pageContext.request.contextPath}/warehouse/inspections"
                        class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors sidebar-item-button"
                        >
                        <svg class="h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75 11.25 15 15 9.75M21 12c0 1.268-.63 2.4-1.593 3.068a3.745 3.745 0 0 1-1.043 3.296 3.745 3.745 0 0 1-3.296 1.043A3.745 3.745 0 0 1 12 21c-1.268 0-2.4-.63-3.068-1.593a3.746 3.746 0 0 1-3.296-1.043 3.745 3.745 0 0 1-1.043-3.296A3.745 3.745 0 0 1 3 12c0-1.268.63-2.4 1.593-3.068a3.745 3.745 0 0 1 1.043-3.296 3.746 3.746 0 0 1 3.296-1.043A3.745 3.745 0 0 1 12 3c1.268 0 2.4.63 3.068 1.593a3.746 3.746 0 0 1 3.296 1.043 3.746 3.746 0 0 1 1.043 3.296A3.745 3.745 0 0 1 21 12Z" /></svg>
                        <span class="sidebar-text">Kiểm định sản phẩm</span>
                    </a>

                    <a
                        href="${pageContext.request.contextPath}/warehouse/locations"
                        class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors sidebar-item-button"
                        >
                        <svg class="h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" /><path stroke-linecap="round" stroke-linejoin="round" d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1 1 15 0Z" /></svg>
                        <span class="sidebar-text">Vị trí kho hàng</span>
                    </a>
                    <div>
                        <button
                            type="button"
                            class="flex items-center justify-between w-full gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors sidebar-item-button"
                            >
                            <div class="flex items-center gap-3">
                                <%-- Icon Hàng trả (Return) --%>
                                <svg class="h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M9 15 3 9m0 0 6-6M3 9h12a6 6 0 0 1 0 12h-3" />
                                </svg>
                                <span class="sidebar-text">Hàng trả về</span>
                            </div>
                            <svg class="h-4 w-4 sidebar-arrow transition-transform" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M7.21 14.77a.75.75 0 0 1 .02-1.06L11.168 10 7.23 6.29a.75.75 0 1 1 1.04-1.08l4.5 4.25a.75.75 0 0 1 0 1.08l-4.5 4.25a.75.75 0 0 1-1.06-.02Z" clip-rule="evenodd" />
                            </svg>
                        </button>

                        <%-- Menu con --%>
                        <div class="mt-1.5 space-y-1 pl-7 sidebar-submenu hidden">
                            <a
                                href="${pageContext.request.contextPath}/warehouse/returnsList"
                                class="block px-3 py-2 rounded-lg text-sm font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-900"
                                >
                                <span class="sidebar-text">Lịch sử Trả hàng</span>
                            </a>
                            <a
                                href="${pageContext.request.contextPath}/warehouse/returns"
                                class="block px-3 py-2 rounded-lg text-sm font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-900"
                                >
                                <span class="sidebar-text">Tạo Phiếu Trả</span>
                            </a>
                        </div>
                    </div>
                    <a
                        href="${pageContext.request.contextPath}/warehouse/transfer"
                        class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors sidebar-item-button"
                        >
                        <%-- Icon Điều chuyển (Switch) --%>
                        <svg class="h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M7.5 21 3 16.5m0 0L7.5 12M3 16.5h13.5m0-13.5L21 7.5m0 0L16.5 12M21 7.5H7.5" />
                        </svg>
                        <span class="sidebar-text">Điều chuyển kho</span>
                    </a>
                    <a
                        href="${pageContext.request.contextPath}/warehouse/history"
                        class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors sidebar-item-button"
                        >
                        <%-- Icon Lịch sử (Clock) --%>
                        <svg class="h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 6v6h4.5m4.5 0a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
                        </svg>
                        <span class="sidebar-text">Lịch sử Điều chỉnh</span>
                    </a>
                    <!-- Nút Thu gọn/Mở rộng (chỉ cho desktop) -->
                    <div class="py-3 px-3 border-t border-gray-200">
                        <button
                            id="sidebar-toggle"
                            class="flex items-center justify-center w-full gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors sidebar-item-button"
                            >
                            <!-- Icon Thu gọn -->
                            <svg
                                class="h-5 w-5 flex-shrink-0 icon-collapse"
                                xmlns="http://www.w3.org/2000/svg"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke-width="1.5"
                                stroke="currentColor"
                                >
                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M18.75 19.5l-7.5-7.5 7.5-7.5m-6 15L5.25 12l7.5-7.5"
                                />
                            </svg>
                            <!-- Icon Mở rộng -->
                            <svg
                                class="h-5 w-5 flex-shrink-0 icon-expand"
                                xmlns="http://www.w3.org/2000/svg"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke-width="1.5"
                                stroke="currentColor"
                                >
                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M5.25 4.5l7.5 7.5-7.5 7.5m6-15l7.5 7.5-7.5 7.5"
                                />
                            </svg>
                            <span class="sidebar-text">Thu gọn</span>
                        </button>
                    </div>
            </aside>
            <!-- 
                    ===== MAIN CONTENT (N?I DUNG CHÍNH) =====
            -->
            <main id="main-content" class="flex-1 ml-64 bg-white p-6 lg:p-8 transition-all duration-300 ease-in-out">
                <h2>Danh sách Chi tiết Tồn kho</h2>
                <hr>

                <c:if test="${not empty errorMessage}">
                    <div class="error-message">${errorMessage}</div>
                </c:if>

                <div class="filter-form">
                    <form action="${pageContext.request.contextPath}/warehouse/inventory" method="GET">
                        <div class="form-group">
                            <label>Tìm theo Tên Sản phẩm:</label>
                            <input type="text" name="productName" value="${selectedProductName}">
                        </div>
                        <div class="form-group">
                            <label>Lọc theo Nhãn hàng:</label>
                            <select name="brandId">
                                <option value="0">-- Tất cả Nhãn hàng --</option>
                                <c:forEach items="${brandList}" var="brand">
                                    <option value="${brand.brand_id}" ${brand.brand_id == selectedBrandId ? 'selected' : ''}>
                                        ${brand.brand_name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">Lọc</button>
                    </form>
                </div>

                <h2>Kết quả</h2>
                <table class="data-table detail-table">
                    <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th>IMEI</th>
                            <th>Tình trạng</th>
                            <th>Vị trí kho</th>
                            <th>Giá nhập</th>
                            <th>Ngày nhập</th>
                            <th>Nhà cung cấp</th>
                            <th>Ngày kiểm kê cuối</th>
                            <th>Nhân viên kiểm kê</th>
                            <th>Ngày xuất</th>
                            <th>Chỉnh sửa</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%-- Dùng "stockList" nhưng chứa DTO chi tiết --%>
                        <c:forEach items="${requestScope.stockList}" var="item">
                            <tr>
                                <td>${item.productName}</td>
                                <td>${item.imei}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.status == 'AVAILABLE'}">AVAILABLE</c:when>
                                        <c:when test="${item.status == 'SOLD'}">SOLD</c:when>
                                        <c:when test="${item.status == 'DAMAGED'}">DAMAGED</c:when>
                                        <c:when test="${item.status == 'RESERVED'}">RESERVED</c:when>
                                        <c:when test="${item.status == 'RETURNED'}">RETURNED</c:when>
                                        <c:otherwise>${item.status}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${item.locationCode}</td>
                                <td><fmt:formatNumber value="${item.purchasePrice}" type="currency" currencySymbol="đ" maxFractionDigits="0"/></td>
                                <td><fmt:formatDate value="${item.receiptDate}" pattern="dd-MM-yyyy"/></td>
                                <td>${item.supplierName}</td>
                                <td><fmt:formatDate value="${item.lastInspectionDate}" pattern="dd-MM-yyyy HH:mm"/></td>
                                <td>${item.inspectorName}</td>
                                <td><fmt:formatDate value="${item.issueDate}" pattern="dd-MM-yyyy"/></td>
                                <td>
                                    <a href="#">Sửa</a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty requestScope.stockList}">
                            <tr><td colspan="11" style="text-align: center;">Không tìm thấy IMEI nào khớp.</td></tr>
                        </c:if>
                    </tbody>
                </table>
                <div class="pagination">
                    <%-- Link về trang TRƯỚC --%>
                    <c:if test="${currentPage > 1}">
                        <a href="${pageContext.request.contextPath}/warehouse/inventory?page=${currentPage - 1}&productName=${selectedProductName}&brandId=${selectedBrandId}">&laquo;</a>
                    </c:if>

                    <%-- Hiển thị các số trang --%>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <span class="current">${i}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/warehouse/inventory?page=${i}&productName=${selectedProductName}&brandId=${selectedBrandId}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <%-- Link đến trang SAU --%>
                    <c:if test="${currentPage < totalPages}">
                        <a href="${pageContext.request.contextPath}/warehouse/inventory?page=${currentPage + 1}&productName=${selectedProductName}&brandId=${selectedBrandId}">&raquo;</a>
                    </c:if>
                </div>
            </main>
        </div>

        <!-- 
              ===== JAVASCRIPT =====
              Sửa đổi script từ file home.html
        -->
        <script>
            document.addEventListener("DOMContentLoaded", () => {
                // --- CÁC BIẾN TOÀN CỤC ---
                const sidebar = document.getElementById("admin-sidebar");
                const mainContent = document.getElementById("main-content");
                const sidebarToggle = document.getElementById("sidebar-toggle");
                const submenuButtons = document.querySelectorAll(
                        "#admin-sidebar nav > div > button"
                        );
                // *** THÊM MỚI: Biến cho menu người dùng ***
                const userMenuButton = document.getElementById("user-menu-button");
                const userMenuDropdown = document.getElementById("user-menu-dropdown");

                // Biến trạng thái (lấy từ localStorage)
                let isSidebarCollapsed =
                        localStorage.getItem("sidebarCollapsed") === "true";

                // --- HÀM CHỨC NĂNG ---

                // Hàm Bật/Tắt Sidebar Desktop (Thu gọn)
                function toggleDesktopSidebar(collapse) {
                    isSidebarCollapsed = collapse;
                    sidebar.classList.toggle("is-collapsed", isSidebarCollapsed);
                    mainContent.classList.toggle("sidebar-collapsed", isSidebarCollapsed);
                    // Lưu trạng thái vào localStorage
                    localStorage.setItem("sidebarCollapsed", isSidebarCollapsed);
                }

                // --- KHỞI TẠO KHI TẢI TRANG ---

                // 1. Áp dụng trạng thái thu gọn đã lưu cho desktop
                if (sidebarToggle) {
                    toggleDesktopSidebar(isSidebarCollapsed);
                }

                // --- GẮN SỰ KIỆN ---

                // 1. Nút thu gọn/mở rộng Desktop
                if (sidebarToggle) {
                    sidebarToggle.addEventListener("click", () => {
                        toggleDesktopSidebar(!isSidebarCollapsed);
                    });
                }

                // 4. Các nút menu con (accordion)
                submenuButtons.forEach((button) => {
                    button.addEventListener("click", () => {
                        const submenu = button.nextElementSibling;
                        const arrow = button.querySelector(".sidebar-arrow");

                        if (submenu && submenu.classList.contains("sidebar-submenu")) {
                            submenu.classList.toggle("hidden");
                            arrow.classList.toggle("rotate-90");
                        }
                    });
                });

                // 5. Xử lý hiệu ứng cuộn (giữ nguyên từ file cũ)
                const revealElements = document.querySelectorAll(".reveal-on-scroll");
                const revealObserver = new IntersectionObserver(
                        (entries) => {
                    entries.forEach((entry) => {
                        if (entry.isIntersecting) {
                            entry.target.classList.add("is-visible");
                        }
                    });
                },
                        {root: null, threshold: 0.1}
                );
                revealElements.forEach((el) => {
                    revealObserver.observe(el);
                });

                // --- *** THÊM MỚI: Sự kiện cho User Menu Dropdown *** ---

                // 6. Bấm vào nút User Menu để Bật/Tắt
                if (userMenuButton && userMenuDropdown) {
                    userMenuButton.addEventListener("click", (e) => {
                        // Ngăn sự kiện click lan ra ngoài (xem sự kiện 7)
                        e.stopPropagation();

                        if (userMenuDropdown.classList.contains("hidden")) {
                            // --- Hiển thị Dropdown ---
                            userMenuDropdown.classList.remove("hidden");
                            // Đợi 1 frame để trình duyệt nhận ra sự thay đổi từ display:none
                            setTimeout(() => {
                                userMenuDropdown.classList.remove("opacity-0", "scale-95");
                                userMenuDropdown.classList.add("opacity-100", "scale-100");
                            }, 10);
                        } else {
                            // --- Ẩn Dropdown ---
                            userMenuDropdown.classList.remove("opacity-100", "scale-100");
                            userMenuDropdown.classList.add("opacity-0", "scale-95");
                            // Đợi transition (100ms) kết thúc rồi mới thêm class "hidden"
                            setTimeout(() => {
                                userMenuDropdown.classList.add("hidden");
                            }, 100); // 100ms này khớp với "duration-100" của Tailwind
                        }
                    });
                }

                // 7. Bấm ra ngoài để Tắt Dropdown
                document.documentElement.addEventListener("click", (e) => {
                    if (
                            userMenuDropdown &&
                            !userMenuDropdown.classList.contains("hidden")
                            ) {
                        const isClickInsideButton = userMenuButton.contains(e.target);
                        const isClickInsideDropdown = userMenuDropdown.contains(e.target);

                        // Nếu click không nằm trong nút VÀ không nằm trong dropdown
                        if (!isClickInsideButton && !isClickInsideDropdown) {
                            // --- Ẩn Dropdown ---
                            userMenuDropdown.classList.remove("opacity-100", "scale-100");
                            userMenuDropdown.classList.add("opacity-0", "scale-95");
                            setTimeout(() => {
                                userMenuDropdown.classList.add("hidden");
                            }, 100);
                        }
                    }
                });
            });
        </script>
    </body>
</html>

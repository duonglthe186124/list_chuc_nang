<%--
    Document    : create_receipt.jsp
    Created on : Oct 19, 2025, 9:58:47 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- Đổi Title để khớp với nội dung mới -->
        <title>Tạo Phiếu Nhập Kho - WMS PHONE</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
            rel="stylesheet"
            />
        <!-- Thêm thư viện SheetJS -->
        <script src="https://cdn.sheetjs.com/xlsx-0.20.1/package/dist/xlsx.full.min.js"></script>

        <style>
            /* --- CSS Gốc từ transactions.html (Layout) --- */
            body {
                font-family: "Inter", sans-serif;
            }
            ::-webkit-scrollbar {
                width: 6px;
                height: 6px;
            }
            ::-webkit-scrollbar-thumb {
                background: #cbd5e1;
                border-radius: 10px;
            }
            ::-webkit-scrollbar-thumb:hover {
                background: #94a3b8;
            }

            /* Sidebar & layout adjustments */
            #sidebar {
                z-index: 50;
                transition: width 300ms ease-in-out;
            }
            #sidebar {
                width: 256px;
            }
            body.sidebar-collapsed #sidebar {
                width: 80px;
            }
            #main-content {
                margin-left: 256px;
                width: calc(100% - 256px);
                transition: margin-left 300ms ease-in-out, width 300ms ease-in-out;
            }
            body.sidebar-collapsed #main-content {
                margin-left: 80px;
                width: calc(100% - 80px);
            }
            body.sidebar-collapsed .sidebar-text {
                display: none;
            }
            body.sidebar-collapsed .sidebar-link {
                justify-content: center;
                padding-left: 0.75rem;
                padding-right: 0.75rem;
            }
            body.sidebar-collapsed #collapse-text {
                display: none;
            }
            body.sidebar-collapsed #sidebar-toggle {
                justify-content: center;
            }
            .submenu-toggle-icon {
                transition: transform 300ms;
            }
            .submenu-expanded .submenu-toggle-icon {
                transform: rotate(90deg);
            }
            /* --- Hết CSS Gốc --- */

            /* --- CSS cho Bảng Chi tiết --- */
            .item-table {
                width: 100%;
                border-collapse: collapse;
                table-layout: fixed;
                min-width: 900px;
            }
            .item-table th,
            .item-table td {
                padding: 6px 8px; /* Giảm padding */
                text-align: left;
                border-bottom: 1px solid #e5e7eb;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                font-size: 0.8rem; /* Giảm font size cho bảng */
            }
            .item-table th {
                background-color: #f9fafb;
                font-weight: 600;
                color: #374151;
                text-transform: uppercase;
                font-size: 0.65rem; /* Rất nhỏ */
                letter-spacing: 0.05em;
            }
            .item-table tbody tr:hover {
                background-color: #f3f4f6;
                transition: background-color 0.2s;
            }
            /* Style cho các input trong bảng */
            .item-table input,
            .item-table select,
            .item-table textarea {
                width: 100%;
                font-size: 0.8rem; /* Giảm font size cho input */
                padding: 3px 5px; /* Giảm padding input */
                border-radius: 4px;
                border: 1px solid #d1d5db;
            }
            .item-table input[readonly] {
                background-color: #f9fafb;
                border: none;
                padding-left: 0;
            }
            .item-table .product-sku-display {
                font-weight: 600;
                color: #1f2937;
                font-size: 0.8rem;
            }
            .item-table .product-name-display {
                font-size: 0.75rem; /* Rất nhỏ */
                color: #6b7280;
            }
            /* Cập nhật lại tỉ lệ cột */
            .item-table .col-stt {
                width: 4%;
            }
            .item-table .col-qty_expected {
                width: 8%;
                text-align: right;
            }
            .item-table .col-qty_received {
                width: 9%;
                text-align: right;
            }
            .item-table .col-price {
                width: 12%;
                text-align: right;
            }
            .item-table .col-total {
                width: 12%;
                text-align: right;
                font-weight: 600;
            }
            .item-table .col-loc {
                width: 12%;
            }
            .item-table .col-note {
                width: 15%;
            }
            .item-table .col-actions {
                width: 10%;
                text-align: center;
            }

            /* Style cho hàng chi tiết (giống modal) */
            .unit-detail-cell {
                padding: 12px !important; /* Giảm padding */
                background-color: #f9fafb;
                border-bottom: 2px solid #6366f1;
            }
            .unit-table {
                width: 100%;
                font-size: 0.8rem;
                border: 1px solid #e5e7eb;
                border-collapse: collapse;
            }
            .unit-table th, .unit-table td {
                border: 1px solid #e5e7eb;
                padding: 5px 6px; /* Giảm padding */
                text-align: left;
            }
            .unit-table input {
                padding: 3px 5px; /* Giảm padding input */
            }
        </style>
    </head>
    <body class="bg-gray-100">
        <div class="flex h-screen bg-gray-100 overflow-hidden">
            <aside
                id="sidebar"
                class="bg-gray-900 text-gray-300 flex-shrink-0 fixed h-full"
                >
                <div class="flex flex-col h-full">
                    <nav class="flex-1 overflow-y-auto overflow-x-hidden pt-4">
                        <ul class="space-y-1">
                            <li>
                                <a
                                    href="${pageContext.request.contextPath}/inbound/dashboard"
                                    class="sidebar-link flex items-center px-6 py-3 hover:bg-gray-700 hover:text-white rounded-r-full"
                                    >
                                    <svg
                                        class="h-6 w-6"
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
                                    <span class="ml-4 sidebar-text font-semibold">Tổng quan</span>
                                </a>
                            </li>

                            <!-- PO menu -->
                            <li>
                                <div class="sidebar-item">
                                    <button
                                        class="sidebar-link w-full flex items-center justify-between px-6 py-3 hover:bg-gray-700 text-gray-300 hover:text-white"
                                        data-target="submenu-po"
                                        >
                                        <span class="flex items-center">
                                            <svg
                                                class="h-6 w-6"
                                                xmlns="http://www.w3.org/2000/svg"
                                                fill="none"
                                                viewBox="0 0 24 24"
                                                stroke-width="1.5"
                                                stroke="currentColor"
                                                >
                                            <path
                                                stroke-linecap="round"
                                                stroke-linejoin="round"
                                                d="M2.25 18.75c0-1.036.84-1.875 1.875-1.875h15c1.035 0 1.875.84 1.875 1.875v.75c0 1.036-.84 1.875-1.875 1.875h-15a1.875 1.875 0 0 1-1.875-1.875v-.75ZM4.5 13.5A1.875 1.875 0 0 0 2.625 15v-1.5c0-1.036.84-1.875 1.875-1.875h15c1.035 0 1.875.84 1.875 1.875V15a1.875 1.875 0 0 0 1.875 1.875h-15ZM4.5 7.5A1.875 1.875 0 0 0 2.625 9v-1.5c0-1.036.84-1.875 1.875-1.875h15c1.035 0 1.875.84 1.875 1.875V9a1.875 1.875 0 0 0 1.875 1.875h-15Z"
                                                />
                                            </svg>
                                            <span class="ml-4 sidebar-text">Phiếu mua hàng</span>
                                        </span>
                                        <svg
                                            class="h-5 w-5 sidebar-text submenu-toggle-icon"
                                            xmlns="http://www.w3.org/2000/svg"
                                            fill="none"
                                            viewBox="0 0 24 24"
                                            stroke-width="1.5"
                                            stroke="currentColor"
                                            >
                                        <path
                                            stroke-linecap="round"
                                            stroke-linejoin="round"
                                            d="m8.25 4.5 7.5 7.5-7.5 7.5"
                                            />
                                        </svg>
                                    </button>
                                    <ul id="submenu-po" class="submenu hidden space-y-1 pl-4">
                                        <li>
                                            <a
                                                href="#"
                                                class="block py-2 px-6 text-sm text-gray-400 hover:text-white hover:bg-gray-700/50 rounded-r-full sidebar-text"
                                                >Danh sách PO</a
                                            >
                                        </li>
                                        <li>
                                            <a
                                                href="${pageContext.request.contextPath}/inbound/createpo"
                                                class="block py-2 px-6 text-sm text-gray-400 hover:text-white hover:bg-gray-700/50 rounded-r-full sidebar-text"
                                                >Tạo PO mới</a
                                            >
                                        </li>
                                    </ul>
                                </div>
                            </li>

                            <!-- INBOUND menu (NOT active) -->
                            <li>
                                <div class="sidebar-item">
                                    <button
                                        class="sidebar-link w-full flex items-center justify-between px-6 py-3 hover:bg-gray-700 text-gray-300 hover:text-white"
                                        data-target="submenu-inbound"
                                        >
                                        <span class="flex items-center">
                                            <svg
                                                class="h-6 w-6"
                                                xmlns="http://www.w3.org/2000/svg"
                                                fill="none"
                                                viewBox="0 0 24 24"
                                                stroke-width="1.5"
                                                stroke="currentColor"
                                                >
                                            <path
                                                stroke-linecap="round"
                                                stroke-linejoin="round"
                                                d="M9 8.25H7.5a2.25 2.25 0 0 0-2.25 2.25v9a2.25 2.25 0 0 0 2.25 2.25h9a2.25 2.25 0 0 0 2.25-2.25v-9a2.25 2.25 0 0 0-2.25-2.25H15M9 12l3 3m0 0 3-3m-3 3V2.25"
                                                />
                                            </svg>
                                            <span class="ml-4 sidebar-text">Quản lý nhập hàng</span>
                                        </span>
                                        <svg
                                            class="h-5 w-5 sidebar-text submenu-toggle-icon"
                                            xmlns="http://www.w3.org/2000/svg"
                                            fill="none"
                                            viewBox="0 0 24 24"
                                            stroke-width="1.5"
                                            stroke="currentColor"
                                            >
                                        <path
                                            stroke-linecap="round"
                                            stroke-linejoin="round"
                                            d="m8.25 4.5 7.5 7.5-7.5 7.5"
                                            />
                                        </svg>
                                    </button>

                                    <ul id="submenu-inbound" class="submenu hidden space-y-1 pl-4">
                                        <li>
                                            <a
                                                href="${pageContext.request.contextPath}/inbound/transactions"
                                                class="block py-2 px-6 text-sm text-gray-400 hover:text-white hover:bg-gray-700/50 rounded-r-full sidebar-text"
                                                >Danh sách phiếu nhập</a
                                            >
                                        </li>
                                        <li>
                                            <a
                                                href="${pageContext.request.contextPath}/inbound/create-receipt"
                                                class="block py-2 px-6 text-sm text-white bg-indigo-700 rounded-r-full shadow-lg sidebar-text"
                                                >Tạo phiếu nhập mới</a
                                            >
                                        </li>
                                    </ul>
                                </div>
                            </li>

                            <!-- OUTBOUND menu -->
                            <li>
                                <div class="sidebar-item">
                                    <button
                                        class="sidebar-link w-full flex items-center justify-between px-6 py-3 hover:bg-gray-700 text-gray-300 hover:text-white"
                                        data-target="submenu-outbound"
                                        >
                                        <span class="flex items-center">
                                            <svg
                                                class="h-6 w-6"
                                                xmlns="http://www.w3.org/2000/svg"
                                                fill="none"
                                                viewBox="0 0 24 24"
                                                stroke-width="1.5"
                                                stroke="currentColor"
                                                >
                                            <path
                                                stroke-linecap="round"
                                                stroke-linejoin="round"
                                                d="M15 15l-6 6m0 0l-6-6m6 6V9a6 6 0 0 1 12 0v3"
                                                />
                                            </svg>
                                            <span class="ml-4 sidebar-text">Quản lý xuất hàng</span>
                                        </span>
                                        <svg
                                            class="h-5 w-5 sidebar-text submenu-toggle-icon"
                                            xmlns="http://www.w3.org/2000/svg"
                                            fill="none"
                                            viewBox="0 0 24 24"
                                            stroke-width="1.5"
                                            stroke="currentColor"
                                            >
                                        <path
                                            stroke-linecap="round"
                                            stroke-linejoin="round"
                                            d="m8.25 4.5 7.5 7.5-7.5 7.5"
                                            />
                                        </svg>
                                    </button>
                                    <ul
                                        id="submenu-outbound"
                                        class="submenu hidden space-y-1 pl-4"
                                        >
                                        <li>
                                            <a
                                                href="#"
                                                class="block py-2 px-6 text-sm text-gray-400 hover:text-white hover:bg-gray-700/50 rounded-r-full sidebar-text"
                                                >Danh sách phiếu xuất</a
                                            >
                                        </li>
                                        <li>
                                            <a
                                                href="${pageContext.request.contextPath}/create-shipment"
                                                class="block py-2 px-6 text-sm text-gray-400 hover:text-white hover:bg-gray-700/50 rounded-r-full sidebar-text"
                                                >Tạo phiếu xuất mới</a
                                            >
                                        </li>
                                    </ul>
                                </div>
                            </li>

                            <!-- Tồn kho (ACTIVE) -->
                            <li>
                                <a
                                    href="${pageContext.request.contextPath}/warehouse/locations"
                                    class="sidebar-link flex items-center px-6 py-3 hover:bg-gray-700 hover:text-white rounded-r-full"
                                    aria-current="page"
                                    ><svg
                                        class="h-6 w-6"
                                        xmlns="http://www.w3.org/2000/svg"
                                        fill="none"
                                        viewBox="0 0 24 24"
                                        stroke-width="1.5"
                                        stroke="currentColor"
                                        >
                                    <path
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        d="m20.25 7.5-.625 10.632a2.25 2.25 0 0 1-2.247 2.118H6.622a2.25 2.25 0 0 1-2.247-2.118L3.75 7.5M10 11.25h4M3.375 7.5h17.25c.621 0 1.125-.504 1.125-1.125v-1.5c0-.621-.504-1.125-1.125-1.125H3.375c-.621 0-1.125.504-1.125 1.125v1.5c0 .621.504 1.125 1.125 1.125Z"
                                        /></svg
                                    ><span class="ml-4 sidebar-text">Tồn kho</span></a
                                >
                            </li>
                            <li>
                                <a
                                    href="#"
                                    class="sidebar-link flex items-center px-6 py-3 hover:bg-gray-700 hover:text-white rounded-r-full"
                                    ><svg
                                        class="h-6 w-6"
                                        xmlns="http://www.w3.org/2000/svg"
                                        fill="none"
                                        viewBox="0 0 24 24"
                                        stroke-width="1.5"
                                        stroke="currentColor"
                                        >
                                    <path
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        d="M10.343 3.94c.09-.542.56-1.002 1.118-1.002h1.078c.558 0 1.028.46 1.118 1.002l.143.861c.42.247.85.534 1.258.857l.808-.29c.52-.188 1.066.143 1.258.641l.54 1.08c.192.387.098.854-.23 1.159l-.65.641a11.01 11.01 0 0 1 0 1.662l.65.641c.328.305.422.772.23 1.159l-.54 1.08c-.192.498-.738.83-1.258.641l-.808-.29a11.053 11.053 0 0 1-1.258.857l-.143.861c-.09.542-.56 1.002-1.118 1.002h-1.078c-.558 0-1.028-.46-1.118-1.002l-.143-.861a11.053 11.053 0 0 1-1.258-.857l-.808.29c-.52.188-1.066-.143-1.258-.641l-.54-1.08c-.192-.387-.098-.854.23-1.159l.65-.641a11.01 11.01 0 0 1 0 1.662l-.65-.641c-.328-.305-.422-.772-.23-1.159l.54-1.08c.192-.498.738.83 1.258.641l.808.29c.408-.323.838-.61 1.258-.857l.143-.861Z"
                                        />
                                    <path
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z"
                                        /></svg
                                    ><span class="ml-4 sidebar-text">Cấu hình</span></a
                                >
                            </li>
                        </ul>
                    </nav>

                    <div class="border-t border-gray-700">
                        <button
                            id="sidebar-toggle"
                            class="flex items-center w-full px-6 py-4 text-gray-400 hover:bg-gray-700 hover:text-white"
                            >
                            <svg
                                class="h-6 w-6"
                                xmlns="http://www.w3.org/2000/svg"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke-width="1.5"
                                stroke="currentColor"
                                >
                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M15.75 19.5 8.25 12l7.5-7.5"
                                />
                            </svg>
                            <span id="collapse-text" class="ml-4">Thu gọn</span>
                        </button>
                    </div>
                </div>
            </aside>

            <!-- MAIN CONTENT (Giữ nguyên Header) -->
            <div id="main-content" class="flex-1 flex flex-col overflow-hidden">
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
                            <c:choose>
                                <c:when test="${not empty sessionScope.account.avatar_url}">
                                    <c:url value="/${sessionScope.account.avatar_url}" var="avatarHeaderSrc">
                                        <c:param name="v" value="${date.time}" />
                                    </c:url>
                                    <img class="h-8 w-8 rounded-full object-cover" src="${avatarHeaderSrc}" alt="User Avatar" />
                                </c:when>
                                <c:otherwise>
                                    <c:url value="https://i.postimg.cc/c6m04fpn/default-avatar-icon-of-social-media-user-vector.jpg" var="avatarHeaderSrc" />
                                        <img class="h-8 w-8 rounded-full object-cover" src="${avatarHeaderSrc}" alt="User Avatar" />
                                </c:otherwise>
                            </c:choose>
                            <span>${sessionScope.account.fullname}</span>
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
                                href="${pageContext.request.contextPath}/PersonalProfile"
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

                <!-- NỘI DUNG CHÍNH -->
                <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-100 p-3">

                    <!-- Header chính của trang -->
                    <header
                        class="main-header bg-white p-3 mb-3 border-b border-gray-200 rounded-lg shadow-sm"
                        >
                        <div>
                            <h1 class="text-xl font-bold text-gray-800">
                                Tạo Phiếu Nhập Kho Mới
                            </h1>
                            <p class="text-xs text-gray-500 mt-1">
                                Tạo phiếu nhập kho dựa trên Phiếu mua hàng (PO) đã chọn.
                            </p>
                        </div>
                    </header>

                    <!-- Layout 3 cột trên cùng (Giảm padding/margin) -->
                    <!-- Layout 3 cột trên cùng (đã điều chỉnh: phần 1 & 2 rộng hơn, phần 3 nhỏ hơn) -->
                    <div class="grid grid-cols-1 lg:grid-cols-5 gap-3 mb-3">

                        <!-- Cột 1: Thông tin Phiếu Nhập (chiếm 2/5 trên lg, chiều cao lớn hơn) -->
                        <section class="bg-white p-3 rounded-lg shadow-sm border border-gray-200 space-y-3 text-sm lg:col-span-2"
                                 style="min-height: 220px;">
                            <h3 class="text-base font-semibold border-b pb-2 text-gray-800">1. Thông tin Phiếu Nhập</h3>
                            <!-- ... nội dung phần 1 giữ nguyên ... -->
                            <div class="form-group">
                                <label for="receipt-id" class="block mb-1 font-medium text-gray-700">Số Phiếu</label>
                                <input
                                    type="text"
                                    id="receipt-id"
                                    form="form"
                                    name="receipt_code"
                                    value="${receipt_code}"
                                    readonly
                                    class="w-full py-1.5 px-3 bg-gray-100 border border-gray-300 rounded-lg focus:outline-none text-sm"
                                    />
                            </div>

                            <div class="form-group">
                                <form action="${pageContext.request.contextPath}/inbound/create-receipt" method="get">
                                    <label for="po_select" class="block mb-1 font-medium text-gray-700">Chọn phiếu đặt hàng (PO)</label>
                                    <select name="po_id" id="po_select" onchange="this.form.submit()" class="w-full py-1.5 px-3 border border-gray-300 rounded-lg focus:ring-indigo-500 focus:border-indigo-500 bg-white text-sm">
                                        <option value="" ${pl.po_id == selectedID ? 'selected' : ''}>---Chọn purchase order---</option>
                                        <c:forEach var="pl" items="${poList}">
                                            <option value="${pl.po_id}" ${pl.po_id == selectedID? 'selected' : ''}>${pl.po_code}</option>
                                        </c:forEach>
                                    </select>
                                </form>
                            </div>

                            <div class="form-group">
                                <label for="receipt-date" class="block mb-1 font-medium text-gray-700">Ngày Nhập</label>
                                <input
                                    type="date"
                                    id="receipt-date"
                                    class="w-full py-1.5 px-3 border border-gray-300 rounded-lg focus:ring-indigo-500 focus:border-indigo-500 bg-white text-sm"
                                    />
                            </div>

                            <div class="form-group">
                                <label class="block mb-1 font-medium text-gray-700">Ghi chú Phiếu Nhập</label>
                                <textarea form="form" name="receipt_note" placeholder="—" rows="2" class="w-full py-1.5 px-3 border border-gray-300 rounded-lg focus:ring-indigo-500 focus:border-indigo-500 text-sm"></textarea>
                            </div>
                        </section>

                        <!-- Cột 2: Thông tin Đơn Hàng PO (chiếm 2/5 trên lg, chiều cao lớn hơn) -->
                        <section class="bg-white p-3 rounded-lg shadow-sm border border-gray-200 space-y-3 text-sm lg:col-span-2"
                                 style="min-height: 220px;">
                            <h3 class="text-base font-semibold border-b pb-2 text-gray-800">2. Thông tin Đơn Hàng PO</h3>
                            <!-- ... nội dung phần 2 giữ nguyên ... -->
                            <div class="form-group">
                                <label class="block mb-1 font-medium text-gray-700">Nhà cung cấp</label>
                                <input
                                    type="text"
                                    value="${not empty poHeader ? poHeader.display_name : ''}"
                                    disabled
                                    placeholder="—"
                                    class="w-full py-1.5 px-3 bg-gray-100 border border-gray-300 rounded-lg focus:outline-none text-sm"
                                    />
                            </div>

                            <div class="form-group">
                                <label class="block mb-1 font-medium text-gray-700">Ngày tạo PO</label>
                                <input
                                    type="text"
                                    value="${not empty poHeader ? poHeader.created_at : ''}"
                                    disabled
                                    placeholder="—"
                                    class="w-full py-1.5 px-3 bg-gray-100 border border-gray-300 rounded-lg focus:outline-none text-sm"
                                    />
                            </div>

                            <div class="form-group">
                                <label class="block mb-1 font-medium text-gray-700">Ghi chú PO</label>
                                <textarea
                                    disabled
                                    placeholder="—"
                                    rows="3"
                                    class="w-full py-1.5 px-3 bg-gray-100 border border-gray-300 rounded-lg focus:outline-none text-sm"
                                    >${not empty poHeader ? poHeader.note : ''}</textarea>
                            </div>
                        </section>

                        <!-- Cột 3: Tóm Tắt Chi Phí (chiếm 1/5 trên lg, chiều cao nhỏ hơn) -->
                        <section class="bg-gray-50 p-3 rounded-lg shadow-inner border border-gray-200 h-fit text-sm lg:col-span-1"
                                 style="min-height: 110px;">
                            <h3 class="text-base font-semibold border-b pb-2 text-gray-800">3. Tóm Tắt Chi Phí</h3>
                            <table class="w-full mt-3">
                                <tbody class="space-y-1">
                                    <tr class="flex justify-between">
                                        <td class="text-gray-700">Tổng tiền hàng:</td>
                                        <td id="subtotal-display" class="font-medium text-gray-800">0 đ</td>
                                    </tr>
                                    <tr class="flex justify-between text-lg font-bold border-t mt-3 pt-3">
                                        <td class="text-gray-900">Tổng cộng:</td>
                                        <td id="grand-total-display" class="text-indigo-600">0 đ</td>
                                    </tr>
                                </tbody>
                            </table>
                        </section>
                    </div>

                    <!-- Form chính chứa Bảng chi tiết hàng hóa -->
                    <form id="form" action="${pageContext.request.contextPath}/inbound/create-receipt" method="post">
                        <!-- Truyền PO ID đã chọn -->
                        <input type="hidden" name="po_id" value="${selectedID}">

                        <section class="bg-white p-3 rounded-lg shadow-sm border border-gray-200">
                            <h2 class="text-base font-semibold mb-3 border-b pb-2 text-gray-800">Chi Tiết Hàng Hóa</h2>

                            <!-- Bảng chi tiết hàng hóa -->
                            <div class="table-container overflow-x-auto border rounded-lg">
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
                                            <th class="col-actions">Thao Tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty poLine}">
                                                <c:forEach var="item" items="${poLine}" varStatus="loop">
                                                    <!-- Hàng chính -->
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
                                                            <!-- Container để lưu data unit (IMEI/Serial) -->
                                                            <div class="unit-data-container" data-product-id="${item.product_id}"></div>
                                                        </td>
                                                        <td class="col-qty_expected">
                                                            <input 
                                                                type="text" 
                                                                name="expected_qty"
                                                                value="${item.qty}"
                                                                readonly=""
                                                                class="text-right"
                                                                />
                                                        </td>
                                                        <td class="col-qty_received">
                                                            <input
                                                                type="number"
                                                                name="received_qty"
                                                                class="item-received-qty text-right"
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
                                                                value="<fmt:formatNumber value='${item.unit_price}' pattern='#,##0.00'/>"
                                                                readonly=""
                                                                class="text-right"
                                                                />
                                                        </td>
                                                        <td class="col-total item-total-price text-right" data-raw-total="0">0 đ</td>
                                                        <th class="col-loc">
                                                            <select name="location">
                                                                <option value="">---Chọn vị trí---</option>
                                                                <c:forEach var="loc" items="${locations}">
                                                                    <option value="${loc.location_id}">${loc.location_name}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </th>
                                                        <td class="col-note">
                                                            <textarea name="note" rows="2" placeholder="..."></textarea>
                                                        </td>
                                                        <td class="col-actions">
                                                            <!-- Giảm kích thước nút -->
                                                            <button type="button" class="btn-toggle-unit-detail text-indigo-600 hover:text-indigo-800 font-medium text-xs">Chi tiết đơn vị</button>
                                                        </td>
                                                    </tr>
                                                    <!-- Hàng chi tiết (ẩn ban đầu) -->
                                                    <tr class="unit-detail-row" data-product-id="${item.product_id}" style="display: none;">
                                                        <td colspan="9" class="unit-detail-cell">
                                                            <%-- NỘI DUNG CHI TIẾT SẼ ĐƯỢC CHÈN VÀO ĐÂY BẰNG JS --%>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:when>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </section>

                        <!-- Nút Action cuối form -->
                        <div class="flex justify-end mt-3 p-3 bg-white rounded-lg shadow-sm border border-gray-200">
                            <button type="submit" class="bg-green-600 text-white p-2 px-5 rounded-xl hover:bg-green-700 transition duration-150 font-semibold flex items-center space-x-2 text-sm">
                                Lưu & Hoàn Thành
                            </button>
                        </div>
                    </form>
                </main>
                <!-- /KẾT THÚC NỘI DUNG MỚI -->

            </div>
            <!-- /MAIN CONTENT -->
        </div>

        <!-- JAVASCRIPT -->
        <script>
            // Logic Form
            function formatCurrency(amount) {
                if (isNaN(amount) || amount === null)
                    return "0 đ";
                return amount.toLocaleString('vi-VN') + ' đ';
            }

            function recalculateItemTotal(inputElement) {
                const receivedQty = parseFloat(inputElement.value) || 0;
                // Lấy đơn giá từ data attribute để đảm bảo giá trị số chính xác
                const unitPrice = parseFloat(inputElement.dataset.unitPrice) || 0;

                const itemTotal = receivedQty * unitPrice;
                const totalCell = inputElement.closest('tr').querySelector('.item-total-price');

                totalCell.innerText = formatCurrency(itemTotal);
                totalCell.dataset.rawTotal = itemTotal; // Cập nhật raw total

                recalculateGrandTotal();
            }

            function recalculateGrandTotal() {
                let subTotal = 0;
                const itemTotals = document.querySelectorAll('.item-total-price');

                itemTotals.forEach(cell => {
                    // Lấy giá trị số từ data-raw-total
                    subTotal += parseFloat(cell.dataset.rawTotal) || 0;
                });

                const grandTotal = subTotal;
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
                // Áp dụng các lớp Tailwind cho nút
                const btnSecondary = "py-1.5 px-3 bg-gray-200 text-gray-800 rounded-lg hover:bg-gray-300 font-medium text-xs";
                const btnPrimary = "py-1.5 px-3 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 font-medium text-xs";

                return `
                  <div class="unit-detail-content">
                      <div class="modal-import-section bg-gray-100 p-3 rounded-md border border-gray-200 mb-3">
                          <label for="unit-file-input-` + productId + `" class="block mb-1 text-sm font-medium text-gray-700">Import từ CSV/XLSX:</label>
                          <input type="file" id="unit-file-input-` + productId + `" class="unit-file-input text-xs" accept=".csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" data-product-id="` + productId + `"/>
                          <p class="text-xs text-gray-500 mt-1">(Định dạng: IMEI, Serial, Ngày BH bắt đầu, Ngày BH kết thúc)</p>
                      </div>

                      <div class="modal-table-container overflow-auto border rounded-lg" style="max-height: 250px;">
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
                      <div class="modal-footer flex justify-end items-center mt-3 pt-3 border-t border-gray-200">
                          <button type="button" class="` + btnSecondary + ` btn-add-row" data-product-id="` + productId + `">Thêm dòng</button>
                          <button type="button" class="` + btnPrimary + ` btn-save-unit-detail ml-2" data-product-id="` + productId + `">Lưu & Đóng</button>
                      </div>
                  </div>`;
            }

            // Hàm này cũng sử dụng NỐI CHUỖI an toàn.
            function generateDetailRow(stt, data) {
                const imei = data.imei || '';
                const serial = data.serial || '';
                const warranty_start = data.warranty_start || '';
                const warranty_end = data.warranty_end || '';

                // Áp dụng lớp Tailwind cho nút
                const btnDanger = "text-red-600 hover:text-red-800 font-medium text-xs";

                return `
                  <tr>
                      <td>` + stt + `</td>
                      <td><input type="text" name="imei" class="modal-input-imei" value="` + imei + `"></td>
                      <td><input type="text" name="serial_number" class="modal-input-serial" value="` + serial + `"></td>
                      <td><input type="date" name="warranty_start" class="modal-input-warranty-start" value="` + warranty_start + `"></td>
                      <td><input type="date" name="warranty_end" class="modal-input-warranty-end" value="` + warranty_end + `"></td>
                      <td class="col-action text-center">
                          <button type="button" class="` + btnDanger + ` btn-delete-row">Xóa</button>
                      </td>
                  </tr>
              `;
            }

            function appendDetailRow(productId, data = {}) {
                const tableBody = document.getElementById('unit-table-body-' + productId);
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

            function updateDetailRowNumbers(productId) {
                const tableBody = document.getElementById('unit-table-body-' + productId);
                if (!tableBody)
                    return;
                tableBody.querySelectorAll('tr').forEach((row, index) => {
                    row.cells[0].innerText = index + 1;
                });
            }

            function loadDataForProduct(productId) {
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

            function saveDetailData(productId, detailRowElement) {
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

                    if (imei.trim() !== '' || serial.trim() !== '') {
                        rowCount++;
                        storageContainer.appendChild(createHiddenInput('unit_' + productId + '_imei', imei));
                        storageContainer.appendChild(createHiddenInput('unit_' + productId + '_serial', serial));
                        storageContainer.appendChild(createHiddenInput('unit_' + productId + '_warranty_start', warrantyStart));
                        storageContainer.appendChild(createHiddenInput('unit_' + productId + '_warranty_end', warrantyEnd));
                    }
                });
                qtyInput.value = rowCount;
                recalculateItemTotal(qtyInput); // Cập nhật tổng tiền ngay sau khi lưu
            }

            function createHiddenInput(name, value) {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = name;
                input.value = value;
                return input;
            }

            function attachDetailRowListeners(productId) {
                const detailRow = document.querySelector('.unit-detail-row[data-product-id="' + productId + '"]');
                if (!detailRow)
                    return;

                const addRowBtn = detailRow.querySelector('.btn-add-row');
                if (addRowBtn) {
                    addRowBtn.addEventListener('click', () => {
                        appendDetailRow(productId);
                    });
                }

                const saveBtn = detailRow.querySelector('.btn-save-unit-detail');
                if (saveBtn) {
                    saveBtn.addEventListener('click', () => {
                        saveDetailData(productId, detailRow);
                        const mainRow = document.querySelector('.item-main-row[data-product-id="' + productId + '"]');
                        const toggleButton = mainRow ? mainRow.querySelector('.btn-toggle-unit-detail') : null;
                        detailRow.style.display = 'none';
                        if (toggleButton)
                            toggleButton.innerText = 'Chi tiết đơn vị';
                    });
                }

                const fileInput = detailRow.querySelector('.unit-file-input');
                if (fileInput) {
                    fileInput.addEventListener('change', (event) => handleFileImportForProduct(event, productId));
                }

                // Gán lại sự kiện xóa cho các dòng hiện tại
                detailRow.querySelectorAll('.btn-delete-row').forEach(button => {
                    button.addEventListener('click', (e) => {
                        e.target.closest('tr').remove();
                        updateDetailRowNumbers(productId);
                    });
                });
            }

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

            function renderDetailTable(productId, data) {
                const tableBody = document.getElementById('unit-table-body-' + productId);
                if (!tableBody)
                    return;
                tableBody.innerHTML = ''; // Xóa dữ liệu cũ
                data.forEach(item => {
                    appendDetailRow(productId, item);
                });
            }

            function parseCsv(text) {
                const data = [];
                const lines = text.split(/\r?\n/).filter(line => line.trim() !== '');
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
                jsonData.forEach(item => {
                    item.warranty_start = formatDateFromExcel(item.warranty_start);
                    item.warranty_end = formatDateFromExcel(item.warranty_end);
                });
                return jsonData;
            }

            function formatDateFromExcel(excelDate) {
                if (typeof excelDate === 'number') {
                    if (typeof XLSX.SSF === 'undefined')
                        return '';
                    const date = XLSX.SSF.parse_date_code(excelDate);
                    const jsDate = new Date(Date.UTC(date.y, date.m - 1, date.d));
                    return jsDate.toISOString().split('T')[0];
                }
                return excelDate;
            }

            // --- Gộp DOMContentLoaded ---
            document.addEventListener('DOMContentLoaded', () => {
                // Sidebar toggle
                const sidebarToggleBtn = document.getElementById("sidebar-toggle");
                if (sidebarToggleBtn) {
                    sidebarToggleBtn.addEventListener("click", () => {
                        document.body.classList.toggle("sidebar-collapsed");
                    });
                }

                // Submenu toggle
                document.querySelectorAll(".sidebar-item > button").forEach((btn) => {
                    btn.addEventListener("click", (e) => {
                        const target = btn.getAttribute("data-target");
                        if (!target)
                            return;
                        const submenu = document.getElementById(target);
                        if (!submenu)
                            return;
                        submenu.classList.toggle("hidden");
                        btn.parentElement.classList.toggle("submenu-expanded");
                    });
                });

                // User menu dropdown
                const userMenuButton = document.getElementById("user-menu-button");
                const userMenuDropdown = document.getElementById("user-menu-dropdown");
                if (userMenuButton && userMenuDropdown) {
                    userMenuButton.addEventListener("click", () => {
                        userMenuDropdown.classList.toggle("hidden");
                    });
                    document.addEventListener('click', (event) => {
                        const container = document.getElementById('user-menu-container');
                        if (container && !container.contains(event.target)) {
                            userMenuDropdown.classList.add('hidden');
                        }
                    });
                }

                // Logic tính toán tổng tiền
                const qtyInputs = document.querySelectorAll('.item-received-qty');
                qtyInputs.forEach(input => {
                    // Khởi tạo data-unit-price nếu chưa có (dù JSP đã set, đây là fallback an toàn)
                    if (!input.dataset.unitPrice) {
                        const unitPriceInput = input.closest('tr').querySelector('input[name="unit_price"]');
                        input.dataset.unitPrice = parseFloat(unitPriceInput.value) || 0;
                    }

                    input.addEventListener('input', (event) => {
                        if (parseFloat(event.target.value) < 0 || isNaN(parseFloat(event.target.value))) {
                            event.target.value = 0;
                        }
                        recalculateItemTotal(event.target);
                    });

                    // Tính toán lần đầu khi tải trang
                    recalculateItemTotal(input);
                });

                if (qtyInputs.length === 0) {
                    recalculateGrandTotal();
                }

                // Logic TOGGLE ROW DETAIL
                document.querySelectorAll('.btn-toggle-unit-detail').forEach(button => {
                    button.addEventListener('click', (e) => {
                        const mainRow = e.target.closest('tr.item-main-row');
                        const productId = mainRow.dataset.productId;

                        const detailRow = document.querySelector('.unit-detail-row[data-product-id="' + productId + '"]');

                        if (!detailRow) {
                            console.error('Không tìm thấy detail row cho product ID: ' + productId);
                            return;
                        }

                        if (detailRow.style.display === 'none' || detailRow.style.display === '') {
                            const savedData = loadDataForProduct(productId);
                            detailRow.querySelector('.unit-detail-cell').innerHTML = generateDetailHtml(productId, savedData);
                            detailRow.style.display = 'table-row';
                            e.target.innerText = 'Đóng chi tiết';
                            attachDetailRowListeners(productId);
                        } else {
                            detailRow.style.display = 'none';
                            e.target.innerText = 'Chi tiết đơn vị';
                        }
                    });
                });
            });
        </script>
    </body>
</html>

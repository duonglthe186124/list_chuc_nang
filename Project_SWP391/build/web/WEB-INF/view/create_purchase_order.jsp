<%-- 
    Document   : create_prurchase_order
    Created on : Oct 21, 2025, 9:58:47 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Tạo Phiếu Mua Hàng - WMS PHONE</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
            rel="stylesheet"
            />
        <style>
            /* --- CSS Gốc (Giữ nguyên) --- */
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

            /* ĐIỀU CHỈNH KÍCH THƯỚC (FEEDBACK 3)
              Giảm padding của bảng cho nhỏ gọn hơn 
            */
            .line-items-table {
                width: 100%;
                border-collapse: collapse;
                table-layout: fixed;
                min-width: 600px;
            }
            .line-items-table th,
            .line-items-table td {
                /* Giảm padding từ 10px 12px xuống 8px 10px */
                padding: 8px 10px;
                text-align: left;
                border-bottom: 1px solid #e5e7eb;
            }
            .line-items-table th {
                background-color: #f9fafb;
                font-weight: 600;
                color: #374151;
                text-transform: uppercase;
                font-size: 0.72rem;
                letter-spacing: 0.05em;
            }
            .line-items-table tbody tr:hover {
                background-color: #f3f4f6;
                transition: background-color 0.2s;
            }
            .line-items-table .action-cell {
                width: 70px;
                text-align: center;
            }
        </style>
    </head>
    <body class="bg-gray-100">
        <div class="flex h-screen bg-gray-100 overflow-hidden">
            <!-- SIDEBAR -->
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
                                                class="block py-2 px-6 text-sm text-white bg-indigo-700 rounded-r-full shadow-lg sidebar-text"
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
                                                class="block py-2 px-6 text-sm text-gray-400 hover:text-white hover:bg-gray-700/50 rounded-r-full sidebar-text"
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

            <div id="main-content" class="flex-1 flex flex-col overflow-hidden">
                <header
                    class="h-16 bg-white shadow-sm flex items-center justify-between px-6 flex-shrink-0"
                    >
                    <div class="flex items-center">
                        <a
                            href="#"
                            class="flex items-center gap-2 text-xl font-bold text-gray-900"
                            >
                            <svg class="h-7 w-7 text-indigo-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6A2.25 2.25 0 0 1 6 3.75h2.25A2.25 2.25 0 0 1 10.5 6v2.25a2.25 2.25 0 0 1-2.25 2.25H6a2.25 2.25 0 0 1-2.25-2.25V6ZM3.75 15.75A2.25 2.25 0 0 1 6 13.5h2.25a2.25 2.25 0 0 1 2.25 2.25V18a2.25 2.25 0 0 1-2.25 2.25H6A2.25 2.25 0 0 1 3.75 18v-2.25ZM13.5 6a2.25 2.25 0 0 1 2.25-2.25H18A2.25 2.25 0 0 1 20.25 6v2.25A2.25 2.25 0 0 1 18 10.5h-2.25A2.25 2.25 0 0 1 13.5 8.25V6ZM13.5 15.75a2.25 2.25 0 0 1 2.25-2.25H18a2.25 2.25 0 0 1 2.25 2.25V18A2.25 2.25 0 0 1 18 20.25h-2.25A2.25 2.25 0 0 1 13.5 18v-2.25Z"/>
                            </svg>
                            <span>WMS PHONE</span>
                        </a>
                    </div>

                    <div class="flex items-center space-x-4">
                        <button
                            class="p-2 rounded-full text-gray-500 hover:text-gray-700 hover:bg-gray-100 focus:outline-none"
                            >
                            <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M14.857 17.082a23.848 23.848 0 0 0 5.454-1.31A8.967 8.967 0 0 1 18 9.75V9A6 6 0 0 0 6 9v.75a8.967 8.967 0 0 1-2.312 6.022c1.733.64 3.56 1.085 5.455 1.31m5.714 0a24.255 24.255 0 0 1-5.714 0m5.714 0a3 3 0 1 1-5.714 0"/>
                            </svg>
                        </button>
                        <div class="relative" id="user-menu-container">
                            <button
                                id="user-menu-button"
                                class="flex items-center space-x-2 rounded-full p-1 hover:bg-gray-100 focus:outline-none"
                                >
                                <img class="h-8 w-8 rounded-full object-cover" src="https://placehold.co/100x100/e2e8f0/64748b?text=A" alt="User"/>
                                <span class="hidden md:inline text-sm font-medium text-gray-700">Admin Kho</span>
                                <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" d="m19.5 8.25-7.5 7.5-7.5-7.5"/>
                                </svg>
                            </button>
                            <div
                                id="user-menu-dropdown"
                                class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 hidden z-20"
                                >
                                <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Hồ sơ</a>
                                <a href="/login" class="block px-4 py-2 text-sm text-red-600 hover:bg-gray-100">Đăng xuất</a>
                            </div>
                        </div>
                    </div>
                </header>

                <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-100 p-4">

                    <header
                        class="main-header bg-white p-4 mb-4 border-b border-gray-200 rounded-lg shadow-sm"
                        >
                        <div>
                            <h1 class="text-2xl font-bold text-gray-800">
                                Tạo Phiếu Mua Hàng
                            </h1>
                            <p class="text-sm text-gray-500 mt-1">
                                Điền thông tin chi tiết để tạo một đơn đặt hàng mới.
                            </p>
                        </div>
                    </header>

                    <form action="${pageContext.request.contextPath}/inbound/createpo" method="post">
                        <div class="bg-white p-4 rounded-lg shadow-sm">

                            <div class="grid grid-cols-1 lg:grid-cols-3 gap-4">

                                <div class="lg:col-span-2 space-y-4">
                                    <div class="border border-gray-200 rounded-lg p-4">
                                        <h3 class="text-lg font-semibold mb-4 border-b pb-2 text-gray-800">
                                            Thông tin chung
                                        </h3>

                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                            <div class="form-group">
                                                <label for="po-code" class="block mb-1 text-sm font-medium text-gray-700">Mã PO</label>
                                                <input
                                                    type="text"
                                                    id="po-code"
                                                    name="po_code"
                                                    value="${po_code}"
                                                    readonly
                                                    class="w-full py-2 px-3 bg-gray-100 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-300"
                                                    />
                                            </div>

                                            <div class="form-group">
                                                <label for="supplier" class="block mb-1 text-sm font-medium text-gray-700">Nhà cung cấp</label>
                                                <select 
                                                    id="supplier" 
                                                    name="supplier" 
                                                    class="w-full py-2 px-3 border border-gray-300 rounded-lg focus:ring-indigo-500 focus:border-indigo-500 bg-white"
                                                    >
                                                    <option value="">Chọn nhà cung cấp</option>
                                                    <c:forEach var="sl" items="${sList}">
                                                        <option value="${sl.supplier_id}">${sl.supplier_name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="form-group mt-4">
                                            <label for="po-note" class="block mb-1 text-sm font-medium text-gray-700">Ghi chú</label>
                                            <textarea
                                                id="po-note"
                                                name="note"
                                                rows="3"
                                                placeholder="Thêm ghi chú cho đơn đặt hàng này..."
                                                class="w-full py-2 px-3 border border-gray-300 rounded-lg focus:ring-indigo-500 focus:border-indigo-500"
                                                ></textarea>
                                        </div>
                                    </div>
                                </div>

                                <div id="summary-card" class="lg:col-span-1 bg-gray-50 p-4 rounded-lg shadow-inner border border-gray-200 h-fit">
                                    <h3 class="text-lg font-semibold mb-4 border-b pb-2 text-gray-800">
                                        Tóm tắt
                                    </h3>
                                    <div class="space-y-3">
                                        <div class="flex justify-between items-center text-gray-700">
                                            <span>Tổng phụ</span>
                                            <span class="font-medium" id="summary-subtotal">0.00 VND</span>
                                        </div>
                                        <div class="flex justify-between items-center text-gray-700">
                                            <span>Giảm giá</span>
                                            <span class="font-medium" id="summary-discount">0.00 VND</span>
                                        </div>
                                        <div class="flex justify-between items-center text-gray-700" id="tax-line-container">
                                            <span>Thuế (10%)</span>
                                            <span class="font-medium" id="summary-tax">0.00 VND</span>
                                        </div>
                                        <hr class="my-2 border-t border-gray-300" />
                                        <div class="flex justify-between items-center text-lg font-bold text-gray-900">
                                            <span>Tổng cộng</span>
                                            <span id="summary-total">0.00 VND</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="mt-4 border border-gray-200 rounded-lg p-4">
                                <h3 class="text-lg font-semibold mb-4 border-b pb-2 text-gray-800">
                                    Chi tiết sản phẩm
                                </h3>

                                <div class="table-container overflow-x-auto border rounded-lg">
                                    <table class="line-items-table">
                                        <thead>
                                            <tr>
                                                <th style="width: 40%">Sản phẩm / Item</th>
                                                <th style="width: 15%">Số lượng</th>
                                                <th style="width: 20%">Đơn giá</th>
                                                <th style="width: 20%">Tổng</th>
                                                <th class="action-cell">Xóa</th>
                                            </tr>
                                        </thead>
                                        <tbody id="line-items-body">
                                            <tr>
                                                <td>
                                                    <div class="form-group">
                                                        <select 
                                                            name="product" 
                                                            class="w-full py-2 px-3 border border-gray-300 rounded-lg focus:ring-indigo-500 focus:border-indigo-500 bg-white"
                                                            >
                                                            <option value="">Chọn sản phẩm</option>
                                                            <c:forEach var="pl" items="${pList}">
                                                                <option value="${pl.product_id}">${pl.sku_code}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </td>
                                                <td>
                                                    <input 
                                                        type="number" 
                                                        value="1" 
                                                        name="qty" 
                                                        class="w-full py-2 px-3 border border-gray-300 rounded-lg focus:ring-indigo-500 focus:border-indigo-500 text-right"
                                                        />
                                                </td>
                                                <td>
                                                    <input 
                                                        type="text" 
                                                        value="0" 
                                                        name="unit_price" 
                                                        class="w-full py-2 px-3 border border-gray-300 rounded-lg focus:ring-indigo-500 focus:border-indigo-500 text-right"
                                                        />
                                                </td>
                                                <td class="text-right font-medium">0.00 VND</td>
                                                <td class="action-cell">
                                                    <button type="button" class="text-gray-400" disabled>✕</button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <button 
                                    type="button" 
                                    class="btn-add-item mt-4 bg-indigo-100 text-indigo-700 p-2 px-4 rounded-lg hover:bg-indigo-200 font-medium text-sm"
                                    >
                                    + Thêm sản phẩm
                                </button>
                            </div>

                            <div class="flex justify-between items-center mt-4 pt-4 border-t">
                                <div>
                                    <p style="color: red; margin: 0;">
                                        ${not empty error? error : ""}
                                    </p>
                                </div>
                                <div class="flex space-x-3">
                                    <button 
                                        type="button" 
                                        class="btn-cancel bg-gray-200 text-gray-800 py-2 px-5 rounded-lg hover:bg-gray-300 font-semibold"
                                        >
                                        Hủy bỏ
                                    </button>
                                    <button 
                                        type="submit" 
                                        class="btn-create-po bg-green-600 text-white py-2 px-5 rounded-lg hover:bg-green-700 font-semibold" 
                                        id="create-po"
                                        >
                                        Tạo Phiếu Mua Hàng
                                    </button>
                                </div>
                            </div>

                        </div>
                    </form>
                </main>

            </div>
        </div>

        <script>
            const pList = [
            <c:forEach var="pl" items="${pList}" varStatus="status">
            { id: '${pl.product_id}', sku: '${pl.sku_code}' }<c:if test="${not status.last}">,</c:if>
            </c:forEach>
            ];

            document.addEventListener("DOMContentLoaded", () => {
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
            });
        </script>

        <script>
            (function () {
                const tableBody = document.getElementById("line-items-body");
                if (!tableBody)
                    return;

                // Định dạng tiền tệ VND
                const currencyFormatter = new Intl.NumberFormat("vi-VN", {
                    style: "currency",
                    currency: "VND",
                });

                function formatVND(n) {
                    return currencyFormatter.format(n);
                }

                // ĐIỀU CHỈNH TÍNH TOÁN: Sử dụng ID để chọn chính xác
                const subtotalSpan = document.getElementById("summary-subtotal");
                const discountSpan = document.getElementById("summary-discount");
                const taxSpan = document.getElementById("summary-tax");
                const totalSpan = document.getElementById("summary-total");
                const taxLine = document.getElementById("tax-line-container"); // Vùng chứa text Thuế(%)

                function parseNumber(s) {
                    if (s === null || s === undefined)
                        return 0;
                    // Xóa tất cả trừ số, dấu chấm (cho số thập phân) và dấu trừ
                    const cleaned = String(s).replace(/[^0-9.\-]+/g, "");
                    const n = parseFloat(cleaned);
                    return isNaN(n) ? 0 : n;
                }

                function formatNumber(n) {
                    return formatVND(n);
                }

                function getTaxRate() {
                    if (!taxLine)
                        return 0;
                    // Trích xuất số % từ text, ví dụ "Thuế (10%)"
                    const m = taxLine.textContent.match(/\((\d+(\.\d+)?)\s*%\)/);
                    return m ? parseFloat(m[1]) / 100 : 0; // Trả về 0.1
                }

                function computeRowTotal(row) {
                    const qtyInp = row.querySelector('input[name="qty"]');
                    const priceInp = row.querySelector('input[name="unit_price"]');
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
                    Array.from(tableBody.querySelectorAll("tr")).forEach(
                            (r) => (subtotal += computeRowTotal(r))
                    );

                    // Lấy giá trị giảm giá từ text (vì nó có thể được chỉnh sửa)
                    const discount = parseNumber(discountSpan?.textContent || 0);

                    const taxRate = getTaxRate(); // Ví dụ: 0.1
                    // Thuế được tính trên giá trị sau khi giảm giá
                    const tax = (subtotal - discount) * taxRate;

                    const total = subtotal;

                    if (subtotalSpan)
                        subtotalSpan.textContent = formatNumber(subtotal);
                    // Không ghi đè 'discountSpan' ở đây, chỉ cập nhật khi người dùng chỉnh sửa
                    if (taxSpan)
                        taxSpan.textContent = formatNumber(tax);
                    if (totalSpan)
                        totalSpan.textContent = formatNumber(total);
                }

                function attachRowListeners(row) {
                    // Lắng nghe cả 'input' (khi gõ) và 'change'
                    ["input", "change"].forEach((ev) => {
                        row
                                .querySelectorAll("input, select")
                                .forEach((inp) => inp.addEventListener(ev, recalcAll));
                    });

                    const del = row.querySelector(".btn-delete-item");
                    if (del) {
                        del.addEventListener("click", () => {
                            row.remove();
                            recalcAll();
                        });
                    }
                }

                // Gắn listener cho hàng ban đầu
                Array.from(tableBody.querySelectorAll("tr")).forEach(attachRowListeners);

                // Nút thêm sản phẩm
                const addBtn = document.querySelector(".btn-add-item");
                if (addBtn) {
                    addBtn.addEventListener("click", (e) => {
                        e.preventDefault();
                        const newRow = document.createElement("tr");

                        // Tạo các <option> từ mảng pList (an toàn, không xung đột EL)
                        let optionsHtml = '<option value="">Chọn sản phẩm</option>';
                        if (typeof pList !== 'undefined' && Array.isArray(pList)) {
                            for (const product of pList) {
                                optionsHtml += '<option value="' + product.id + '">' + product.sku + '</option>';
                            }
                        }

                        // Lấy các lớp CSS từ input/select đã được thu nhỏ
                        const formSelectClass = "w-full py-2 px-3 border border-gray-300 rounded-lg focus:ring-indigo-500 focus:border-indigo-500 bg-white";
                        const formInputClass = "w-full py-2 px-3 border border-gray-300 rounded-lg focus:ring-indigo-500 focus:border-indigo-500 text-right";
                        const deleteBtnClass = "text-red-500 hover:text-red-700 font-semibold btn-delete-item";

                        newRow.innerHTML =
                                "<td>" +
                                '  <div class="form-group">' +
                                '    <select name="product" class="' + formSelectClass + '">' + optionsHtml + "</select>" +
                                "  </div>" +
                                "</td>" +
                                '<td><input type="number" value="1" name="qty" class="' + formInputClass + '"/></td>' +
                                '<td><input type="text" value="0" name="unit_price" class="' + formInputClass + '"/></td>' +
                                '<td class="text-right font-medium">0.00 VND</td>' +
                                '<td class="action-cell"><button type="button" class="' + deleteBtnClass + '">✕</button></td>';

                        tableBody.appendChild(newRow);
                        attachRowListeners(newRow); // Gắn listener cho hàng mới
                        recalcAll();
                    });
                }

                // Cho phép chỉnh sửa giảm giá bằng cách nhấp đúp
                if (discountSpan) {
                    discountSpan.style.cursor = 'pointer'; // Thêm gợi ý
                    discountSpan.title = 'Nhấp đúp để sửa';

                    discountSpan.addEventListener('dblclick', () => {
                        const cur = parseNumber(discountSpan.textContent).toString();
                        const input = document.createElement('input');
                        input.type = 'text';
                        input.value = cur;
                        input.className = 'w-24 text-right font-medium py-1 px-2 border rounded';
                        discountSpan.replaceWith(input);
                        input.focus();

                        function commit() {
                            const v = Math.abs(parseNumber(input.value));
                            const newSpan = document.createElement('span');
                            newSpan.className = 'font-medium';
                            newSpan.id = 'summary-discount'; // Đặt lại ID
                            newSpan.style.cursor = 'pointer';
                            newSpan.title = 'Nhấp đúp để sửa';
                            newSpan.textContent = formatNumber(v);

                            input.replaceWith(newSpan);
                            // Gắn lại sự kiện dblclick cho span mới
                            newSpan.addEventListener('dblclick', discountSpan.dispatchEvent(new Event('dblclick')));

                            recalcAll(); // Tính toán lại toàn bộ
                        }

                        input.addEventListener('blur', commit);
                        input.addEventListener('keydown', ev => {
                            if (ev.key === 'Enter')
                                commit();
                            if (ev.key === 'Escape')
                                input.blur(); // Hủy bỏ
                        });
                    });
                }

                // Chạy tính toán lần đầu khi tải trang
                recalcAll();
            })();
        </script>
    </body>
</html>
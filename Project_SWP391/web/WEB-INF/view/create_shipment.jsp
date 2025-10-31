<%-- 
    Document   : create_shipment
    Created on : Oct 29, 2025, 5:47:08 PM
    Author     : ASUS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Tạo Phiếu Xuất Hàng - WMS PHONE</title>

        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>

        <!-- Google Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
            rel="stylesheet"
            />

        <style>
            /* --- CSS TỪ LAYOUT (transactions.html) --- */
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

            /* --- CSS TỪ NỘI DUNG (create_shipment.jsp) --- */
            /* Biến CSS (giả lập) cho các style cũ */
            :root {
                --border: #e5e7eb; /* tailwind gray-200 */
                --gap: 20px;
                --card-radius: 8px;
                --muted: #64748b; /* tailwind slate-500 */
                --text: #0f172a; /* tailwind slate-900 */
            }

            .form-group {
                margin-bottom: 18px;
            }
            .form-group label {
                display: block;
                font-weight: 600;
                margin-bottom: 6px;
                font-size: 14px;
                color: #374151; /* Thêm màu text cho dễ đọc */
            }
            .form-group input[type="text"],
            .form-group input[type="date"],
            .form-group select,
            .form-group textarea {
                width: 100%;
                padding: 10px 12px;
                border-radius: 6px;
                border: 1px solid var(--border, #e5e7eb);
                font-size: 14px;
                font-family: inherit;
                background: #fff;
                /* Thêm focus style cho nhất quán */
                transition: border-color 0.2s, box-shadow 0.2s;
            }
            .form-group input:focus,
            .form-group select:focus,
            .form-group textarea:focus {
                border-color: #4f46e5; /* indigo-600 */
                box-shadow: 0 0 0 1px #4f46e5;
                outline: none;
            }

            .form-group textarea {
                min-height: 90px;
                resize: vertical;
            }

            /* Grid layout cho 2 card tóm tắt */
            .main-summary-grid {
                display: grid;
                /* Sử dụng media query của tailwind */
                grid-template-columns: 1fr; /* Mặc định 1 cột */
            }
            @media (min-width: 1024px) { /* lg: */
                .main-summary-grid {
                    grid-template-columns: 3fr 1fr; /* 2 cột trên desktop */
                }
            }
            .main-summary-grid {
                gap: var(--gap, 20px);
                margin-top: 20px;
            }

            /* Card tóm tắt */
            .summary-card {
                background: #ffffff; /* Đổi sang trắng */
                border: 1px solid var(--border, #e5e7eb);
                border-radius: var(--card-radius, 8px);
                padding: 16px 18px;
                box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.05); /* Thêm shadow nhẹ */
            }

            .summary-card-title {
                font-size: 16px;
                font-weight: 600;
                margin: 0 0 12px 0;
                padding-bottom: 10px;
                border-bottom: 1px solid var(--border, #e5e7eb);
                color: #1f2937; /* Thêm màu text */
            }

            .info-list {
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .info-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                font-size: 14px;
            }
            .info-item h5 {
                margin: 0;
                font-weight: 500;
                color: var(--muted, #64748b);
            }
            .info-item p {
                margin: 0;
                font-weight: 600;
                color: var(--text, #1f2937);
            }

            .divider {
                background: var(--border, #e5e7eb);
                margin: 4px 0;
                height: 1px;
            }

            /* Bảng chi tiết sản phẩm */
            .shipment-table-container {
                overflow-x: auto; /* Cho phép cuộn ngang trên mobile */
                border: 1px solid var(--border, #e5e7eb);
                border-radius: 8px;
                margin-top: 16px;
                background: #fff;
            }
            .shipment-table {
                width: 100%;
                border-collapse: collapse;
            }
            .shipment-table th,
            .shipment-table td {
                border-bottom: 1px solid var(--border, #e5e7eb);
                padding: 10px 12px;
                text-align: left;
                font-size: 14px;
                vertical-align: middle;
                white-space: nowrap; /* Chống vỡ dòng */
            }
            .shipment-table tr:last-child td {
                border-bottom: none; /* Bỏ border dòng cuối */
            }
            .shipment-table th {
                background-color: #f9fafb; /* gray-50 */
                font-weight: 600;
                color: #374151; /* gray-700 */
                text-transform: uppercase;
                font-size: 12px;
            }
            .shipment-table th:first-child,
            .shipment-table td:first-child,
            .shipment-table th:nth-child(4),
            .shipment-table td:nth-child(4),
            .shipment-table th:nth-child(5),
            .shipment-table td:nth-child(5),
            .shipment-table th:nth-child(3),
            .shipment-table td:nth-child(3),
            .shipment-table th:nth-child(6),
            .shipment-table td:nth-child(6) {
                text-align: center;
            }
            .shipment-table td:nth-child(5),
            .shipment-table td:nth-child(6) {
                text-align: right;
                font-family: 'Menlo', 'Consolas', monospace;
            }

            .shipment-table .qty-input {
                width: 70px;
                padding: 6px;
                text-align: center;
                border: 1px solid var(--border, #e5e7eb);
                border-radius: 6px;
            }
            .shipment-table .qty-input:focus {
                border-color: #4f46e5;
                box-shadow: 0 0 0 1px #4f46e5;
                outline: none;
            }

            /* Nút actions */
            .action-buttons {
                display: flex;
                justify-content: flex-end;
                gap: 12px;
                margin-top: 24px;
                border-top: 1px solid var(--border, #e5e7eb);
                padding-top: 20px;
            }
            /* Style nút dùng class Tailwind cho nhất quán */
            .btn {
                padding: 10px 20px;
                border: none;
                border-radius: 6px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
                transition: all 0.2s;
            }
            .btn-primary {
                background-color: #4f46e5; /* indigo-600 */
                color: white;
            }
            .btn-primary:hover {
                background-color: #4338ca; /* indigo-700 */
            }
            .btn-secondary {
                background: #f1f5f9; /* slate-100 */
                color: #334155; /* slate-700 */
                border: 1px solid var(--border, #e5e7eb);
            }
            .btn-secondary:hover {
                background: #e2e8f0; /* slate-200 */
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
                                                class="block py-2 px-6 text-sm text-white bg-indigo-700 rounded-r-full shadow-lg sidebar-text"
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

            <!-- MAIN CONTENT WRAPPER (Từ transactions.html) -->
            <div id="main-content" class="flex-1 flex flex-col overflow-hidden">

                <!-- HEADER (Từ transactions.html) -->
                <header
                    class="h-16 bg-white shadow-sm flex items-center justify-between px-6 flex-shrink-0"
                    >
                    <div class="flex items-center">
                        <a
                            href="#"
                            class="flex items-center gap-2 text-xl font-bold text-gray-900"
                            >
                            <svg
                                class="h-7 w-7 text-indigo-500"
                                xmlns="http://www.w3.org/2000/svg"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke-width="2"
                                stroke="currentColor"
                                >
                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M3.75 6A2.25 2.25 0 0 1 6 3.75h2.25A2.25 2.25 0 0 1 10.5 6v2.25a2.25 2.25 0 0 1-2.25 2.25H6a2.25 2.25 0 0 1-2.25-2.25V6ZM3.75 15.75A2.25 2.25 0 0 1 6 13.5h2.25a2.25 2.25 0 0 1 2.25 2.25V18a2.25 2.25 0 0 1-2.25 2.25H6A2.25 2.25 0 0 1 3.75 18v-2.25ZM13.5 6a2.25 2.25 0 0 1 2.25-2.25H18A2.25 2.25 0 0 1 20.25 6v2.25A2.25 2.25 0 0 1 18 10.5h-2.25A2.25 2.25 0 0 1 13.5 8.25V6ZM13.5 15.75a2.25 2.25 0 0 1 2.25-2.25H18a2.25 2.25 0 0 1 2.25 2.25V18A2.25 2.25 0 0 1 18 20.25h-2.25A2.25 2.25 0 0 1 13.5 18v-2.25Z"
                                />
                            </svg>
                            <span>WMS PHONE</span>
                        </a>
                    </div>

                    <div class="relative hidden md:block">
                        <span class="absolute inset-y-0 left-0 flex items-center pl-3"
                              ><svg
                                class="h-5 w-5 text-gray-400"
                                xmlns="http://www.w3.org/2000/svg"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke-width="1.5"
                                stroke="currentColor"
                                >
                            <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z"
                                /></svg
                            ></span>
                        <input
                            type="text"
                            placeholder="Tìm kiếm IMEI, Model, Mã phiếu..."
                            class="w-80 rounded-md border border-gray-300 py-2 pl-10 pr-4 text-sm focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500"
                            />
                    </div>

                    <div class="flex items-center space-x-4">
                        <button
                            class="p-2 rounded-full text-gray-500 hover:text-gray-700 hover:bg-gray-100 focus:outline-none"
                            >
                            <span class="sr-only">Thông báo</span
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
                                d="M14.857 17.082a23.848 23.848 0 0 0 5.454-1.31A8.967 8.967 0 0 1 18 9.75V9A6 6 0 0 0 6 9v.75a8.967 8.967 0 0 1-2.312 6.022c1.733.64 3.56 1.085 5.455 1.31m5.714 0a24.255 24.255 0 0 1-5.714 0m5.714 0a3 3 0 1 1-5.714 0"
                                />
                            </svg>
                        </button>

                        <div class="relative" id="user-menu-container">
                            <button
                                id="user-menu-button"
                                class="flex items-center space-x-2 rounded-full p-1 hover:bg-gray-100 focus:outline-none"
                                >
                                <img
                                    class="h-8 w-8 rounded-full object-cover"
                                    src="https://placehold.co/100x100/e2e8f0/64748b?text=A"
                                    alt="User"
                                    /><span
                                    class="hidden md:inline text-sm font-medium text-gray-700"
                                    >Admin Kho</span
                                ><svg
                                    class="h-5 w-5 text-gray-400"
                                    xmlns="http://www.w3.org/2000/svg"
                                    fill="none"
                                    viewBox="0 0 24 24"
                                    stroke-width="1.5"
                                    stroke="currentColor"
                                    >
                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="m19.5 8.25-7.5 7.5-7.5-7.5"
                                    />
                                </svg>
                            </button>
                            <div
                                id="user-menu-dropdown"
                                class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 hidden z-20"
                                >
                                <a
                                    href="#"
                                    class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                                    >Hồ sơ</a
                                ><a
                                    href="#"
                                    class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                                    >Cài đặt</a
                                >
                                <div class="border-t border-gray-100 my-1"></div>
                                <a
                                    href="/login"
                                    class="block px-4 py-2 text-sm text-red-600 hover:bg-gray-100"
                                    >Đăng xuất</a
                                >
                            </div>
                        </div>
                    </div>
                </header>

                <!-- NỘI DUNG CHÍNH (Đã chuyển từ create_shipment.jsp) -->
                <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-100 p-6">

                    <!-- Đây là nội dung từ <main class="main"> của file create_shipment.jsp -->

                    <!-- Header của trang -->
                    <div class="main-header bg-white p-6 rounded-t-lg border-b border-gray-200 shadow-sm">
                        <h1 class="text-3xl font-bold text-gray-800">Tạo Phiếu Xuất Hàng Mới</h1>
                        <p class="text-sm text-gray-500 mt-1">
                            Chọn một đơn hàng để bắt đầu tạo phiếu xuất kho.
                        </p>
                    </div>

                    <!-- Toàn bộ nội dung form được bọc trong card trắng -->
                    <div class="main-content bg-white p-6 rounded-b-lg shadow-sm">

                        <form action="${pageContext.request.contextPath}/create-shipment" method="get">
                            <div class="form-group">
                                <label for="order-id-select">Đơn hàng</label>
                                <select
                                    id="order-id-select"
                                    name="id"
                                    onchange="this.form.submit()"
                                    >
                                    <option value="" ${id == selectedID? 'selected' : ''}>-- Vui lòng chọn một đơn hàng --</option>
                                    <c:forEach var="id" items="${order_id}">
                                        <option value="${id}" ${id == selectedID? 'selected' : ''}>Đơn hàng số ${id}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </form>

                        <div class="main-summary-grid">
                            <div class="summary-card">
                                <h3 class="summary-card-title">
                                    Thông tin Đơn hàng & Phiếu xuất
                                </h3>
                                <div class="info-list">
                                    <div class="info-item">
                                        <h5>Khách hàng:</h5>
                                        <p id="customer-name">${orderInfo.fullname}</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>Ngày đặt hàng:</h5>
                                        <p id="order-date">${orderInfo.order_date}</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>Trạng thái ĐH:</h5>
                                        <p id="order-status">${orderInfo.status}</p>
                                    </div>
                                    <div class="divider"></div>
                                    <div class="info-item">
                                        <h5>Nhân viên tạo:</h5>
                                        <p>Trần Văn Hùng (NV003)</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>Trạng thái phiếu:</h5>
                                        <p>PENDING</p>
                                    </div>
                                </div>
                            </div>

                            <div class="summary-card">
                                <h3 class="summary-card-title">Tổng quan Đơn hàng</h3>
                                <div class="info-list">
                                    <div class="info-item">
                                        <h5>Số dòng SP (SKU):</h5>
                                        <p id="summary-sku">${orderInfo.line_count}</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>Tổng số lượng đặt:</h5>
                                        <p id="summary-qty">${orderInfo.total_qty}</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>Số dòng SP hiên tại:</h5>
                                        <p id="received-sku">0</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>Tổng số lượng hiện tại:</h5>
                                        <p id="received-qty">0</p>
                                    </div>
                                    <div class="divider"></div>
                                    <div class="info-item">
                                        <h5>Tổng tiền ĐH:</h5>
                                        <p id="order-total">${not empty orderInfo.total_value? orderInfo.total_value : 0} đ</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>Tổng tiền thực tế:</h5>
                                        <p id="actual-total" style="color: #059669">0 đ</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>Chênh lệch:</h5>
                                        <p id="difference-total" style="color: #dc2626">0 đ</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <h3 style="font-size: 18px; margin: 24px 0 10px 0; color: #1f2937; font-weight: 600;">
                            Chi tiết sản phẩm xuất kho
                        </h3>

                        <div class="shipment-table-container">
                            <table class="shipment-table">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Sản phẩm (product_id)</th>
                                        <th>SL Đặt Hàng</th>
                                        <th>SL Xuất Kho</th>
                                        <th>Đơn giá</th>
                                        <th>Tổng dòng hàng</th>
                                    </tr>
                                </thead>
                                <tbody id="shipment-lines-body">
                                    <c:forEach var="l" items="${orderDetail}" varStatus="loop">
                                        <tr>
                                            <td>${loop.index + 1}</td>
                                            <td>
                                                ${l.sku_code}
                                                ${l.name}
                                            </td>
                                            <td class="ordered-qty">${l.qty_line}</td>
                                            <td>
                                                <input type="number"
                                                       form="postForm"
                                                       class="qty-input"
                                                       name="out_qty"
                                                       value="0"
                                                       min="0"
                                                       max="${l.qty_line}"
                                                       data-unit-price="${l.unit_price}"
                                                       data-line-no="${loop.index}" />
                                                <input type="hidden" name="order_line_id[${loop.index}]" />
                                            </td>
                                            <td class="unit-price-cell">${l.unit_price} đ</td>
                                            <td class="line-total-cell">0 đ</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div class="form-group" style="margin-top: 20px">
                            <label for="shipment-note">Ghi chú (Shipments.note)</label>
                            <textarea
                                id="shipment-note"
                                name="note"
                                form="postForm"
                                placeholder="Thêm ghi chú cho đơn vị vận chuyển hoặc lý do xuất kho..."
                                ></textarea>
                        </div>

                        <form id="postForm" action="${pageContext.request.contextPath}/create-shipment" method="post">
                            <div class="action-buttons">
                                <input type="hidden" value="${selectedID}" name="id">
                                <button type="button" class="btn btn-secondary">Hủy</button>
                                <button type="submit" class="btn btn-primary">
                                    Xác nhận & Tạo Phiếu Xuất
                                </button>
                            </div>
                        </form>
                    </div>
                    <!-- Hết nội dung từ create_shipment.jsp -->

                </main>
            </div>
        </div>

        <script>
            // --- LOGIC GỘP (Layout + Form) ---

            // --- Logic from create_shipment.jsp (Form Calculations) ---

            /**
             * Định dạng một số thành chuỗi tiền tệ VND.
             * @param {number | string} number - Số cần định dạng
             * @returns {string} Chuỗi đã định dạng (ví dụ: "1.250.000 ₫")
             */
            function formatCurrency(number) {
                const num = parseFloat(number);
                if (!isFinite(num)) {
                    // Trả về "0 ₫" nếu không phải là số
                    return new Intl.NumberFormat("vi-VN", {
                        style: "currency",
                        currency: "VND",
                    }).format(0);
                }

                // Sử dụng Intl.NumberFormat để định dạng tiền tệ VND
                return new Intl.NumberFormat("vi-VN", {
                    style: "currency",
                    currency: "VND",
                }).format(num);
            }

            // Lấy các element DOM
            const summaryActualTotal = document.getElementById('actual-total');
            const summaryDifferenceTotal = document.getElementById('difference-total');
            const summaryOrderTotalElement = document.getElementById('order-total');
            const summarySkuCount = document.getElementById('received-sku');
            const summaryQtyCount = document.getElementById('received-qty');
            const qtyInputs = document.querySelectorAll('.qty-input');

            // Lấy tổng tiền đơn hàng ban đầu một cách an toàn
            let initialOrderTotal = 0;
            if (summaryOrderTotalElement) {
                // Xóa ký tự 'đ', dấu phẩy, và mọi khoảng trắng
                const initialOrderTotalText = summaryOrderTotalElement.textContent
                        .replace(/\s*đ\s*/, '')
                        .replace(/,/g, '')
                        .trim();
                initialOrderTotal = parseFloat(initialOrderTotalText) || 0;
            }

            /**
             * Cập nhật tất cả các ô tổng tóm tắt dựa trên giá trị input
             */
            function updateTotals() {
                let totalActualValue = 0;
                let totalShippedQty = 0;
                let actualLineCount = 0;

                qtyInputs.forEach((input) => {
                    const unitPrice = parseFloat(input.getAttribute('data-unit-price')) || 0;
                    const maxQty = parseFloat(input.getAttribute('max')) || 0;
                    let outQty = parseFloat(input.value) || 0;

                    // Ràng buộc giá trị
                    if (outQty > maxQty) {
                        outQty = maxQty;
                        input.value = outQty; // Cập nhật lại input nếu vượt max
                    } else if (outQty < 0) {
                        outQty = 0;
                        input.value = outQty; // Cập nhật lại input nếu < 0
                    }

                    const actualLineTotal = outQty * unitPrice;

                    const row = input.closest('tr');
                    // Sửa selector để khớp với class đã thêm
                    const lineTotalCell = row.querySelector('.line-total-cell');

                    if (lineTotalCell) {
                        lineTotalCell.textContent = formatCurrency(actualLineTotal);
                    }

                    totalActualValue += actualLineTotal;
                    totalShippedQty += outQty;

                    if (outQty > 0) {
                        actualLineCount++;
                    }
                });

                const difference = totalActualValue - initialOrderTotal;

                // Cập nhật tóm tắt (kiểm tra element tồn tại)
                if (summaryActualTotal)
                    summaryActualTotal.textContent = formatCurrency(totalActualValue);
                if (summaryDifferenceTotal)
                    summaryDifferenceTotal.textContent = formatCurrency(difference);

                // Cập nhật màu cho Chênh lệch
                if (summaryDifferenceTotal) {
                    if (difference > 0) {
                        summaryDifferenceTotal.style.color = '#059669'; // Xanh
                    } else if (difference < 0) {
                        summaryDifferenceTotal.style.color = '#dc2626'; // Đỏ
                    } else {
                        summaryDifferenceTotal.style.color = 'inherit'; // Mặc định
                    }
                }

                if (summarySkuCount)
                    summarySkuCount.textContent = actualLineCount;
                if (summaryQtyCount)
                    summaryQtyCount.textContent = totalShippedQty;
            }

            // Thêm trình xử lý sự kiện cho tất cả input số lượng
            qtyInputs.forEach(input => {
                input.addEventListener('input', updateTotals);
                input.addEventListener('blur', updateTotals); // Dùng blur để validate lần cuối
            });


            // --- Logic from transactions.html (Layout) ---

            // Chạy JS layout và JS form (updateTotals) khi DOM đã sẵn sàng
            document.addEventListener('DOMContentLoaded', (event) => {

                // --- Chạy logic form ---
                // Chạy lần đầu khi tải trang để tính toán giá trị mặc định (0)
                updateTotals();

                // --- Chạy logic layout ---

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

                    // Đóng dropdown khi click bên ngoài
                    document.addEventListener("click", (e) => {
                        const container = document.getElementById("user-menu-container");
                        if (container && !container.contains(e.target)) {
                            if (userMenuDropdown) {
                                userMenuDropdown.classList.add("hidden");
                            }
                        }
                    }, true);
                }
            });

        </script>
    </body>
</html>

<%-- 
    Document   : transaction_history
    Created on : Oct 5, 2025, 1:09:57 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Danh sách Phiếu Nhập - WMS PHONE</title>
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

            /* transaction table styles: fixed layout + ellipsis to avoid stretching */
            .transaction-table {
                width: 100%;
                border-collapse: collapse;
                table-layout: fixed;
                min-width: 800px;
            }
            .transaction-table th,
            .transaction-table td {
                padding: 8px 10px;
                text-align: left;
                border-bottom: 1px solid #e5e7eb;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
            .transaction-table th {
                background-color: #f9fafb;
                font-weight: 600;
                color: #374151;
                text-transform: uppercase;
                font-size: 0.72rem;
                letter-spacing: 0.05em;
            }
            .transaction-table tbody tr:hover {
                background-color: #f3f4f6;
                transition: background-color 0.2s;
            }
            .table-container {
                overflow: auto;
                width: 100%;
                border: 1px solid #e5e7eb;
            }

            /* smaller right-aligned numbers */
            .text-right {
                text-align: right;
            }
            .action-cell {
                white-space: nowrap;
                width: 70px;
            }
            .receipt-cell {
                max-width: 140px;
            }
            .supplier-cell {
                max-width: 120px;
            }
            .received-by-cell {
                max-width: 120px;
            }

            /* Compact form elements for search, filter, and pagination */
            .search-input,
            .filter-dropdown,
            .filter-btn,
            .search-btn,
            #page-size,
            .page-input,
            .go-btn {
                padding-top: 0.375rem !important; /* 6px */
                padding-bottom: 0.375rem !important;
            }
            .filter-btn,
            .search-btn,
            .go-btn {
                font-size: 0.875rem !important;
                line-height: 1rem !important;
            }
            .pagination button,
            .pagination .go-btn,
            .pagination .page-input {
                height: 2rem !important;
            }
            .filter-dropdown,
            .search-input,
            .page-input {
                font-size: 0.875rem !important;
            }

            /* Responsive: allow table to scroll horizontally on small screens */
            @media (max-width: 1024px) {
                .transaction-table {
                    min-width: 900px;
                }
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
                                                class="block py-2 px-6 text-sm text-white bg-indigo-700 rounded-r-full shadow-lg sidebar-text"
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
                            href="${pageContext.request.contextPath}/home"
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

                <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-100 p-6">
                    <div class="w-full p-0 sm:p-0">
                        <header
                            class="main-header bg-white p-6 mb-0 border-b border-gray-200 flex flex-col sm:flex-row justify-between items-start sm:items-center"
                            >
                            <div>
                                <h1 class="text-3xl font-bold text-gray-800">
                                    Danh sách Phiếu Nhập
                                </h1>
                                <p class="text-sm text-gray-500 mt-1">
                                    Danh sách các giao dịch nhập kho.
                                </p>
                            </div>
                            <button
                                onclick="handleCreateNew()"
                                class="mt-4 sm:mt-0 bg-green-600 text-white p-3 px-6 rounded-xl hover:bg-green-700 transition duration-150 font-semibold flex items-center space-x-2"
                                >
                                <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    class="h-5 w-5"
                                    viewBox="0 0 20 20"
                                    fill="currentColor"
                                    >
                                <path
                                    fill-rule="evenodd"
                                    d="M10 5a1 1 0 011 1v3h3a1 1 0 110 2h-3v3a1 1 0 11-2 0v-3H6a1 1 0 110-2h3V6a1 1 0 011-1z"
                                    clip-rule="evenodd"
                                    />
                                </svg>
                                <span>Tạo Phiếu Nhập Kho Mới</span>
                            </button>
                        </header>

                        <main class="main bg-white p-6">
                            <%-- 
                              Form này giờ sẽ submit về server. 
                              Đã XÓA: onsubmit="handleFormSubmit(event)"
                              ĐÃ THÊM: action="..." method="get"
                            --%>
                            <form 
                                id="transaction-form" 
                                action="${pageContext.request.contextPath}/inbound/transactions" 
                                method="get"
                                >
                                <div
                                    class="flex flex-col lg:flex-row items-stretch lg:items-center justify-between space-y-4 lg:space-y-0 lg:space-x-4 mb-6"
                                    >
                                    <div
                                        class="flex flex-grow max-w-sm border border-gray-300 rounded-xl overflow-hidden"
                                        >
                                        <input
                                            type="text"
                                            name="searchInput"
                                            value="${param.searchInput}"
                                            placeholder="Search Receipt No, Supplier, or User..."
                                            class="search-input w-full p-3 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 border-none"
                                            />
                                        <button
                                            type="submit"
                                            name="action"
                                            value="search"
                                            class="search-btn p-3 bg-indigo-600 text-white hover:bg-indigo-700 transition duration-150 flex items-center justify-center"
                                            >
                                            <svg
                                                width="18"
                                                height="18"
                                                viewBox="0 0 24 24"
                                                fill="none"
                                                stroke="currentColor"
                                                stroke-width="2"
                                                stroke-linecap="round"
                                                stroke-linejoin="round"
                                                >
                                            <path d="M21 21l-4.35-4.35"></path>
                                            <circle cx="11" cy="11" r="6"></circle>
                                            </svg>
                                        </button>
                                    </div>

                                    <div
                                        class="flex flex-col sm:flex-row space-y-3 sm:space-y-0 sm:space-x-3 items-stretch"
                                        >
                                        <select
                                            name="status"
                                            class="filter-dropdown p-3 border border-gray-300 rounded-xl focus:ring-indigo-500 focus:border-indigo-500"
                                            >
                                            <option value="" ${empty param.status or param.status == ""? 'selected' : ''}>All Statuses</option>
                                            <option value="Pending" ${param.status == "Pending" ? 'selected' : ''}>Pending</option>
                                            <option value="Received" ${param.status == "Received" ? 'selected' : ''}>Received</option>
                                            <option value="Partial" ${param.status == "Partial" ? 'selected' : ''}>Partial</option>
                                            <option value="Cancelled" ${param.status == "Cancelled" ? 'selected' : ''}>Cancelled</option>
                                        </select>

                                        <button
                                            type="submit"
                                            name="action"
                                            value="filter"
                                            class="filter-btn bg-indigo-600 text-white p-3 rounded-xl hover:bg-indigo-500 transition duration-150 font-semibold"
                                            >
                                            Apply Filter
                                        </button>

                                        <div class="flex items-center space-x-2">
                                            <span class="text-gray-600 whitespace-nowrap text-sm"
                                                  >Rows:</span
                                            >
                                            <%-- Thêm name="pageSize" và onchange="this.form.submit()" --%>
                                            <select
                                                id="page-size"
                                                name="pageSize"
                                                onchange="this.form.submit()"
                                                class="filter-dropdown p-3 border border-gray-300 rounded-xl focus:ring-indigo-500 focus:border-indigo-500"
                                                >
                                                <option value="10" ${empty param.pageSize or param.pageSize == 10 ? 'selected' : ''}>10</option>
                                                <option value="20" ${param.pageSize == 20 ? 'selected' : ''}>20</option>
                                                <option value="50" ${param.pageSize == 50 ? 'selected' : ''}>50</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="table-container mb-6">
                                    <table id="tx-table" class="transaction-table">
                                        <thead>
                                            <tr>
                                                <th style="width: 5%">No.</th>
                                                <th class="receipt-cell">Receipt No</th>
                                                <th class="supplier-cell">Supplier</th>
                                                <th style="width: 8%">Total</th>
                                                <th style="width: 8%">Received</th>
                                                <th style="width: 12%">Cost received</th>
                                                <th class="received-by-cell">Received by</th>
                                                <th style="width: 14%">Received at</th>
                                                <th style="width: 10%">Status</th>
                                                <th class="action-cell">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody id="table-body">
                                            <%-- Body sẽ được render bởi JavaScript --%>
                                        </tbody>
                                    </table>
                                </div>

                                <div
                                    id="pagination"
                                    class="pagination flex flex-col sm:flex-row items-center justify-between space-y-4 sm:space-y-0"
                                    >
                                    <div class="flex items-center space-x-4 text-sm">
                                        <span id="pagination-info" class="text-gray-600"></span>
                                    </div>

                                    <div
                                        class="flex flex-wrap items-center justify-center space-x-1 sm:space-x-3"
                                        >
                                        <button
                                            type="button"
                                            id="prev-page-btn"
                                            onclick="goToPage(currentPage - 1)"
                                            class="p-2 border border-gray-300 rounded-lg hover:bg-gray-100 transition duration-150 disabled:cursor-not-allowed"
                                            >
                                            <svg
                                                xmlns="http://www.w3.org/2000/svg"
                                                class="h-5 w-5 text-gray-600"
                                                viewBox="0 0 20 20"
                                                fill="currentColor"
                                                >
                                            <path
                                                fill-rule="evenodd"
                                                d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z"
                                                clip-rule="evenodd"
                                                />
                                            </svg>
                                        </button>
                                        <div id="page-number-links" class="flex space-x-1"></div>
                                        <button
                                            type="button"
                                            id="next-page-btn"
                                            onclick="goToPage(currentPage + 1)"
                                            class="p-2 border border-gray-300 rounded-lg hover:bg-gray-100 transition duration-150 disabled:cursor-not-allowed"
                                            >
                                            <svg
                                                xmlns="http://www.w3.org/2000/svg"
                                                class="h-5 w-5 text-gray-600"
                                                viewBox="0 0 20 20"
                                                fill="currentColor"
                                                >
                                            <path
                                                fill-rule="evenodd"
                                                d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z"
                                                clip-rule="evenodd"
                                                />
                                            </svg>
                                        </button>
                                        <div class="flex items-center space-x-2 ml-4">
                                            <span class="go-to-text text-gray-600 hidden sm:inline"
                                                  >Go to page</span
                                            >
                                            <%-- 
                                              Đổi name="pageInput" thành name="pageNo" để thống nhất.
                                              Đặt giá trị value="${pageNo}"
                                            --%>
                                            <input
                                                type="number"
                                                name="pageInput"
                                                value=""
                                                class="page-input w-16 p-2 border border-gray-300 rounded-lg text-center focus:ring-indigo-500 focus:border-indigo-500"
                                                min="1"
                                                />
                                            <button
                                                type="submit"
                                                class="go-btn ml-2 bg-indigo-600 hover:bg-indigo-500 text-white p-2 px-4 rounded-lg font-medium"
                                                >
                                                Go
                                            </button>
                                            <p id="error-pageInput" class="text-red-500 text-sm mt-1">${not empty errorPageInput? errorPageInput : ''}</p>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </main>
                    </div>

                    <div
                        id="custom-modal"
                        class="fixed inset-0 bg-black bg-opacity-30 hidden items-center justify-center z-30"
                        >
                        <div class="bg-white rounded-lg shadow-lg max-w-lg w-full p-6">
                            <div class="flex justify-between items-center">
                                <h3 id="modal-title" class="text-lg font-semibold">
                                    Modal title
                                </h3>
                                <button
                                    onclick="closeModal()"
                                    class="text-gray-500 hover:text-gray-700"
                                    >
                                    Đóng
                                </button>
                            </div>
                            <div id="modal-body" class="mt-4"></div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <script>
            // --- DỮ LIỆU TỪ SERVER ---
            // 1. Tải dữ liệu từ server (chỉ trang hiện tại) vào mảng JS
            const transactions = [];
            <c:forEach var="l" items="${tx_list}">
            transactions.push({
                id: ${l.receipt_id},
                receiptNo: "${l.receipt_no}",
                supplier: "${l.supplier}",
                totalLines: ${l.total_line},
                received: ${l.total_received},
                costReceived: ${l.total},
                receivedBy: "${l.received_by}",
                receivedAt: "${l.received_at}",
                status: "${l.status}"
            });
            </c:forEach>

            // 2. Lấy thông tin phân trang từ server
            let currentPage = ${pageNo != null ? pageNo : 1};
            let pageSize = ${param.pageSize != null ? param.pageSize : 10};
            let totalItems = ${totalLines != null ? totalLines : 0};
            let totalPages = Math.ceil(totalItems / pageSize);
            // --- CÁC HÀM TIỆN ÍCH (Giữ nguyên) ---
            function createStatusBadge(status) {
                let colorClasses = "";
                switch (status) {
                    case "PENDING":
                        colorClasses = "bg-yellow-50 text-yellow-800";
                        break;
                    case "RECEIVED":
                        colorClasses = "bg-green-50 text-green-800";
                        break;
                    case "PARTIAL":
                        colorClasses = "bg-blue-50 text-blue-800";
                        break;
                    case "CANCELLED":
                        colorClasses = "bg-red-50 text-red-800";
                        break;
                    default:
                        colorClasses = "bg-gray-100 text-gray-800";
                }
                // Thay thế template literal bằng nối chuỗi
                return '<div class="text-xs font-semibold px-2 py-0.5 inline-block ' + colorClasses + ' rounded-lg">' + status + '</div>';
            }

            function formatCurrency(amount) {
                return new Intl.NumberFormat("vi-VN", {
                    style: "currency",
                    currency: "VND",
                }).format(amount);
            }

            // --- HÀM GỬI FORM (Đã sửa) ---
            // Hàm này sẽ submit form với số trang mới
            function goToPage(targetPage) {
                let newPage = parseInt(targetPage, 10);

                // Validate trang
                if (isNaN(newPage) || newPage < 1)
                    newPage = 1;
                if (newPage > totalPages && totalPages > 0)
                    newPage = totalPages;

                const form = document.getElementById('transaction-form');
                const pageNoInput = form.querySelector('input[name="pageInput"]');

                // Cập nhật giá trị của input "pageNo" và submit
                if (pageNoInput) {
                    pageNoInput.value = newPage;
                }
                form.submit();
            }

            // --- HÀM TẠO NÚT BẤM TRANG (Đã sửa) ---
            // Sửa onclick để gọi goToPage(page) thay vì hàm JS client-side
            function createPageButton(page, text) {
                const isActive = page === currentPage;
                const classes = isActive
                        ? "bg-indigo-600 text-white border-indigo-600"
                        : "bg-white text-gray-700 border-gray-300 hover:bg-gray-50";
                // Thay thế template literal và sửa onclick
                return '<button type="button" onclick="goToPage(' + page + ')" class="w-8 h-8 flex items-center justify-center border rounded-lg font-medium ' + classes + ' transition duration-150">' + text + '</button>';
            }

            // --- HÀM RENDER BẢNG (Đã sửa) ---
            // Xóa logic lọc/phân trang client-side
            // Sửa để dùng nối chuỗi
            function renderTable() {
                const tableBody = document.getElementById("table-body");

                // Dữ liệu (transactions) đã được lọc và phân trang bởi server
                const currentData = transactions;
                const start = (currentPage - 1) * pageSize;

                let rowsHtml = "";
                if (currentData.length === 0) {
                    rowsHtml = '<tr><td colspan="10" class="text-center py-8 text-gray-500">Không tìm thấy giao dịch nào.</td></tr>';
                } else {
                    currentData.forEach((tx, index) => {
                        const rowNumber = start + index + 1;

                        // Sử dụng nối chuỗi thay vì template literals
                        rowsHtml += '\n<tr>\n' +
                                '<td class="text-sm">' + rowNumber + '</td>\n' +
                                '<td class="receipt-cell text-sm">' + tx.receiptNo + '</td>\n' +
                                '<td class="supplier-cell text-sm">' + tx.supplier + '</td>\n' +
                                '<td class="text-sm text-right">' + tx.totalLines + '</td>\n' +
                                '<td class="text-sm text-right">' + tx.received + '</td>\n' +
                                '<td class="text-sm text-right">' + formatCurrency(tx.costReceived) + '</td>\n' +
                                '<td class="received-by-cell text-sm">' + tx.receivedBy + '</td>\n' +
                                '<td class="text-sm">' + tx.receivedAt + '</td>\n' +
                                '<td class="text-sm">' + createStatusBadge(tx.status) + '</td>\n' +
                                // Sửa nút "View" để trỏ đến trang chi tiết, giống như logic của JSP
                                '<td class="action-cell"><a href="${pageContext.request.contextPath}/inbound/transactions/view?id=' + tx.id + '" class="text-indigo-600 hover:text-indigo-900 font-medium">View</a></td>\n' +
                                '</tr>';
                    });
                }

                tableBody.innerHTML = rowsHtml;
                updatePaginationInfo();
            }

            // --- HÀM CẬP NHẬT PHÂN TRANG (Đã sửa) ---
            // Lấy totalItems từ biến server
            // Sửa để dùng nối chuỗi
            function updatePaginationInfo() {
                const infoSpan = document.getElementById("pagination-info");
                const goInput = document.querySelector('input[name="pageInput"]');
                const pageNumberLinksContainer =
                        document.getElementById("page-number-links");
                pageNumberLinksContainer.innerHTML = "";

                if (totalItems === 0) {
                    infoSpan.textContent = 'Hiển thị 0 trên 0 mục.';
                } else {
                    const startItem = (currentPage - 1) * pageSize + 1;
                    const endItem = Math.min(currentPage * pageSize, totalItems);
                    // Sử dụng nối chuỗi
                    infoSpan.textContent = 'Hiển thị ' + startItem + '-' + endItem + ' trên ' + totalItems + ' mục.';
                }

                // Sử dụng nối chuỗi
                goInput.placeholder = '1 - ' + totalPages;
                // Đã set value bằng JSTL, nhưng giữ lại dòng này để đảm bảo
                goInput.value = currentPage;

                const prevBtn = document.getElementById("prev-page-btn");
                const nextBtn = document.getElementById("next-page-btn");
                if (prevBtn) {
                    prevBtn.disabled = currentPage === 1;
                    prevBtn.classList.toggle("opacity-50", currentPage === 1);
                }
                if (nextBtn) {
                    nextBtn.disabled =
                            currentPage === totalPages || totalItems === 0;
                    nextBtn.classList.toggle(
                            "opacity-50",
                            currentPage === totalPages || totalItems === 0
                            );
                }

                // Logic tạo nút bấm trang giữ nguyên, vì nó dùng createPageButton đã sửa
                if (totalPages >= 1) {
                    let startPage = Math.max(1, currentPage - 2);
                    let endPage = Math.min(totalPages, currentPage + 2);
                    if (currentPage <= 3)
                        endPage = Math.min(totalPages, 5);
                    else if (currentPage > totalPages - 2)
                        startPage = Math.max(1, totalPages - 4);
                    if (startPage > 1) {
                        pageNumberLinksContainer.innerHTML += createPageButton(1, 1);
                        if (startPage > 2)
                            pageNumberLinksContainer.innerHTML += '<span class="px-1 text-gray-500">...</span>';
                    }
                    for (let i = startPage; i <= endPage; i++)
                        pageNumberLinksContainer.innerHTML += createPageButton(i, i);
                    if (endPage < totalPages) {
                        if (endPage < totalPages - 1)
                            pageNumberLinksContainer.innerHTML += '<span class="px-1 text-gray-500">...</span>';
                        pageNumberLinksContainer.innerHTML += createPageButton(
                                totalPages,
                                totalPages
                                );
                    }
                }
            }

            // --- XÓA: handleFormSubmit(event) ---
            // Logic submit form giờ đã được xử lý bởi server-side

            // --- SỰ KIỆN ONLOAD (Đã sửa) ---
            window.onload = () => {
                // Xóa các event listener cho form submit và page-size,
                // vì chúng đã được xử lý bằng submit() và onchange=""

                // Chỉ cần gọi renderTable để hiển thị dữ liệu đã tải
                renderTable();

                // Sidebar toggle (Giữ nguyên)
                const sidebarToggleBtn = document.getElementById("sidebar-toggle");
                sidebarToggleBtn.addEventListener("click", () => {
                    document.body.classList.toggle("sidebar-collapsed");
                });

                // submenu toggle (Giữ nguyên)
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

                // User menu toggle (Giữ nguyên từ HTML gốc)
                const userMenuButton = document.getElementById("user-menu-button");
                const userMenuDropdown = document.getElementById("user-menu-dropdown");
                if (userMenuButton) {
                    userMenuButton.addEventListener("click", () => {
                        userMenuDropdown.classList.toggle("hidden");
                    });
                    // Đóng menu khi click ra ngoài
                    document.addEventListener("click", (event) => {
                        const container = document.getElementById("user-menu-container");
                        if (container && !container.contains(event.target)) {
                            userMenuDropdown.classList.add("hidden");
                        }
                    });
                }
            };
        </script>
    </body>
</html>
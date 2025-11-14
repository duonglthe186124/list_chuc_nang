<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Sơ đồ Vị trí Kho - WMS PHONE</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
            rel="stylesheet"
            />
        <style>
            /* --- Base Dashboard Styles (từ transactions.html) --- */
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

            /* --- New Styles for Warehouse Location Map --- */

            .aisle-container {
                border: 1px solid #e5e7eb; /* gray-200 */
                border-radius: 8px;
                background: #ffffff;
                overflow: visible;
                box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.05);
            }
            .aisle-header {
                font-size: 1.125rem; /* text-lg */
                font-weight: 600;
                padding: 0.75rem 1rem; /* py-3 px-4 */
                background: #f9fafb; /* gray-50 */
                border-bottom: 1px solid #e5e7eb;
                color: #374151; /* gray-700 */
            }

            /* Grid cho các vị trí (ô) */
            .aisle-grid {
                display: grid;
                grid-template-columns: repeat(5, minmax(0, 1fr));
                gap: 6px;
                padding: 1rem;
                position: relative;
            }
            @media (min-width: 768px) { /* md */
                .aisle-grid {
                    grid-template-columns: repeat(8, minmax(0, 1fr));
                }
            }
            @media (min-width: 1280px) { /* xl */
                .aisle-grid {
                    grid-template-columns: repeat(12, minmax(0, 1fr));
                }
            }

            /* Kiểu cho 1 ô vị trí */
            .location-cell {
                position: relative;
                aspect-ratio: 1 / 1; /* Giữ ô vuông */
                border: 1px solid #cbd5e1; /* slate-300 */
                border-radius: 4px;
                cursor: pointer;
                transition: all 0.2s ease-in-out;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            /* Hiệu ứng hover cho ô */
            .location-cell:hover {
                transform: scale(1.15);
                z-index: 999; /* đảm bảo nằm trên */
                border-color: #4f46e5;
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            }

            /* Mã vị trí (text bên trong) */
            .location-id {
                font-size: 0.65rem; /* text-xs */
                font-weight: 500;
                color: #475569; /* slate-600 */
                pointer-events: none; /* Cho phép hover xuyên qua */
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
                padding: 0 2px;
            }
            /* Đổi màu text trên nền tối */
            .location-cell.status-full .location-id,
            .location-cell.status-almost-full .location-id,
            .location-cell.status-available .location-id {
                color: #1e293b; /* slate-800 */
                font-weight: 600;
            }

            /* Tooltip (hiển thị khi hover) */
            .location-tooltip {
                visibility: hidden;
                opacity: 0;
                position: absolute;
                bottom: 105%;
                left: 50%;
                transform: translateX(-50%);
                background-color: #27272a;
                color: white;
                padding: 6px 10px;
                border-radius: 6px;
                font-size: 0.8rem;
                white-space: nowrap;
                z-index: 1200; /* cao hơn z-index của ô để chồng lên */
                transition: opacity 0.2s, visibility 0.2s;
                pointer-events: none;
            }
            /* Dùng 'group' của Tailwind để kích hoạt tooltip */
            .group:hover .location-tooltip {
                visibility: visible;
                opacity: 1;
            }

            /* --- 4 Trạng thái màu sắc --- */
            /* 1. Trống */
            .status-empty {
                background-color: #f3f4f6; /* gray-100 */
                border: 1px dashed #9ca3af; /* gray-400 */
            }
            .status-empty .location-id {
                color: #6b7280;
            } /* gray-500 */
            .status-empty:hover {
                background-color: #e5e7eb;
            }

            /* 2. Còn nhiều (Available) */
            .status-available {
                background-color: #86efac;
            } /* green-300 */
            .status-available:hover {
                background-color: #4ade80;
            } /* green-400 */

            /* 3. Còn ít (Almost Full) */
            .status-almost-full {
                background-color: #fde047;
            } /* yellow-300 */
            .status-almost-full:hover {
                background-color: #facc15;
            } /* yellow-400 */

            /* 4. Đầy (Full) */
            .status-full {
                background-color: #fca5a5;
            } /* red-300 */
            .status-full:hover {
                background-color: #f87171;
            } /* red-400 */

        </style>
    </head>
    <body class="bg-gray">
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
                                    class="sidebar-link flex items-center px-6 py-3 text-white bg-indigo-700 rounded-r-full shadow-lg"
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

            <!-- MAIN CONTENT -->
            <div id="main-content" class="flex-1 flex flex-col overflow-hidden">
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
                                <span class="hidden md:inline text-sm font-medium text-gray-700">
                                            ${sessionScope.account.fullname}
                                        </span>
                                        <svg
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
                                    href="${pageContext.request.contextPath}/PersonalProfile"
                                    class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                                    >Hồ sơ</a
                                ><a
                                    href="#"
                                    class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                                    >Cài đặt</a
                                >
                                <div class="border-t border-gray-100 my-1"></div>
                                <a
                                    href="${pageContext.request.contextPath}/logout"
                                    class="block px-4 py-2 text-sm text-red-600 hover:bg-gray-100"
                                    >Đăng xuất</a
                                >
                            </div>
                        </div>
                    </div>
                </header>

                <!-- Main transactions content -->
                <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-100 p-6">

                    <!-- Page Header -->
                    <div class="bg-white p-6 rounded-t-lg shadow-sm border-b border-gray-200">
                        <h1 class="text-3xl font-bold text-gray-800">Sơ đồ Vị trí Kho</h1>
                        <p class="text-sm text-gray-500 mt-1">Trạng thái và dung lượng của các vị trí trong kho.</p>
                    </div>

                    <!-- Main Content Area -->
                    <div class="bg-white p-6 rounded-b-lg shadow-sm">

                        <!-- Chú giải (Legend) -->
                        <div class="mb-6 flex flex-wrap gap-x-6 gap-y-2 items-center">
                            <h3 class="text-lg font-semibold text-gray-700 mr-4">Chú giải:</h3>
                            <div class="flex items-center">
                                <div class="w-4 h-4 rounded border-2 border-dashed border-gray-400 bg-gray-100 mr-2"></div>
                                <span class="text-sm text-gray-600">Trống (0%)</span>
                            </div>
                            <div class="flex items-center">
                                <div class="w-4 h-4 rounded bg-green-300 mr-2"></div>
                                <span class="text-sm text-gray-600">Còn nhiều (1-50%)</span>
                            </div>
                            <div class="flex items-center">
                                <div class="w-4 h-4 rounded bg-yellow-300 mr-2"></div>
                                <span class="text-sm text-gray-600">Còn ít (51-99%)</span>
                            </div>
                            <div class="flex items-center">
                                <div class="w-4 h-4 rounded bg-red-300 mr-2"></div>
                                <span class="text-sm text-gray-600">Đầy (100%)</span>
                            </div>
                        </div>

                        <!-- Warehouse Grid: Dynamic Content -->
                        <div class="space-y-8">

                            <%-- 
                              BẮT ĐẦU LOGIC NHÓM (GROUP BY) BẰNG JSTL
                              
                              YÊU CẦU: Servlet PHẢI truyền một List<Location> tên là "locationList"
                              VÀ danh sách này PHẢI được SẮP XẾP (sorted) theo 'area' và 'aisle'.
                            --%>

                            <c:if test="${empty locationList}">
                                <div class="text-center p-8 text-gray-500">
                                    Không có dữ liệu vị trí kho để hiển thị.
                                </div>
                            </c:if>

                            <%-- Biến này dùng để theo dõi xem 'Dãy' (aisle) đã thay đổi chưa --%>
                            <c:set var="currentAisle" value="" />

                            <c:forEach items="${locationList}" var="loc" varStatus="loop">

                                <%-- 1. Tạo một mã định danh nhóm duy nhất (ví dụ: "A-01") --%>
                                <c:set var="groupKey" value="${loc.area}-${loc.aisle}" />

                                <%-- 2. Kiểm tra xem đây có phải là một nhóm (dãy) mới không --%>
                                <c:if test="${groupKey != currentAisle}">

                                    <%-- 3a. Nếu đây KHÔNG phải là item đầu tiên, hãy đóng thẻ của nhóm TRƯỚC ĐÓ --%>
                                    <c:if test="${!loop.first}">
                                    </div> <!-- Đóng .aisle-grid -->
                                </div> <!-- Đóng .aisle-container -->
                            </c:if>

                            <%-- 3b. Cập nhật biến theo dõi --%>
                            <c:set var="currentAisle" value="${groupKey}" />

                            <%-- 3c. Bắt đầu một nhóm (dãy) MỚI --%>
                            <div class="aisle-container">
                                <%-- Dùng loc.area và loc.aisle để đặt tên cho Dãy --%>
                                <h2 class="aisle-header">Khu ${loc.area} - Dãy ${loc.aisle}</h2>
                                <div class="aisle-grid">
                                    <%-- Dòng <c:forEach> tiếp theo sẽ render ô đầu tiên của nhóm này --%>

                                </c:if>

                                <%-- 4. LUÔN LUÔN render ô vị trí hiện tại --%>

                                <%-- 4a. Tính toán % và xử lý chia cho 0 --%>
                                <c:set var="percent" value="0" />
                                <c:if test="${loc.capacity > 0}">
                                    <c:set var="percent" value="${loc.current_capacity / loc.capacity * 100}" />
                                </c:if>

                                <%-- 4b. Quyết định class màu (statusClass) --%>
                                <c:choose>
                                    <c:when test="${loc.current_capacity <= 0}">
                                        <c:set var="statusClass" value="status-empty" />
                                    </c:when>
                                    <c:when test="${percent > 0 && percent <= 50}">
                                        <c:set var="statusClass" value="status-available" />
                                    </c:when>
                                    <c:when test="${percent > 50 && percent < 100}">
                                        <c:set var="statusClass" value="status-almost-full" />
                                    </c:when>
                                    <c:when test="${percent >= 100}">
                                        <c:set var="statusClass" value="status-full" />
                                        <c:set var="percent" value="100" /> <%-- Không cho hiển thị > 100% --%>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="statusClass" value="status-empty" />
                                    </c:otherwise>
                                </c:choose>

                                <%-- 
                                  4c. Render ô <div> động
                                  - loc.code là mã vị trí đầy đủ (ví dụ: A-01-01)
                                --%>
                                <div class="location-cell ${statusClass} group">
                                    <div class="flex flex-col gap-1">
                                        <span class="location-id">${loc.code}</span>
                                        <span class="location-id">${loc.current_capacity} / ${loc.capacity}</span>
                                    </div>
                                    <div class="location-tooltip">
                                        <strong>Vị trí:</strong> ${loc.code}<br>
                                        <strong>Chi tiết:</strong> ${loc.area} / ${loc.aisle} / ${loc.slot}<br>
                                        <strong>SL:</strong> ${loc.current_capacity} / ${loc.capacity}
                                        (<fmt:formatNumber value="${percent}" maxFractionDigits="0" />%)
                                    </div>
                                </div>

                                <%-- 5. Nếu đây là item CUỐI CÙNG, hãy đóng thẻ của nhóm cuối cùng --%>
                                <c:if test="${loop.last}">
                                </div> <!-- Đóng .aisle-grid -->
                            </div> <!-- Đóng .aisle-container -->
                        </c:if>

                    </c:forEach> <%-- Kết thúc vòng lặp chính (loc) --%>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", () => {
                // --- Sidebar Toggle ---
                const sidebarToggleBtn = document.getElementById("sidebar-toggle");
                if (sidebarToggleBtn) {
                    sidebarToggleBtn.addEventListener("click", () => {
                        document.body.classList.toggle("sidebar-collapsed");
                    });
                }

                // --- Submenu Toggle ---
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

                // --- User Menu Dropdown ---
                const userMenuButton = document.getElementById("user-menu-button");
                const userMenuDropdown = document.getElementById("user-menu-dropdown");

                if (userMenuButton && userMenuDropdown) {
                    userMenuButton.addEventListener("click", () => {
                        userMenuDropdown.classList.toggle("hidden");
                    });

                    // Click outside to close
                    document.addEventListener("click", (e) => {
                        const container = document.getElementById("user-menu-container");
                        if (container && !container.contains(e.target)) {
                            if (userMenuDropdown) {
                                userMenuDropdown.classList.add("hidden");
                            }
                        }
                    });
                }
            });
        </script>
    </body>
</html>


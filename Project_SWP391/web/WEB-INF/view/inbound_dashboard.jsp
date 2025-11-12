<%-- 
    Document   : inbound_dashboard
    Created on : Oct 30, 2025, 3:22:42 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Dashboard - WMS Pro</title>
        <!-- Tải Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Tải Font Inter -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
            rel="stylesheet"
            />
        <!-- Tải Chart.js -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <style>
            body {
                font-family: "Inter", sans-serif;
            }
            /* Custom scrollbar */
            ::-webkit-scrollbar {
                width: 6px;
                height: 6px;
            }
            ::-webkit-scrollbar-thumb {
                background: #cbd5e1; /* gray-300 */
                border-radius: 10px;
            }
            ::-webkit-scrollbar-thumb:hover {
                background: #94a3b8; /* gray-400 */
            }

            /* Tăng Z-index cho Sidebar để nó luôn nằm trên Topbar (khi thu gọn) */
            #sidebar {
                z-index: 50;
                transition: width 300ms ease-in-out;
            }

            /* Ẩn chữ khi sidebar thu gọn */
            #sidebar.collapsed .sidebar-text {
                display: none;
            }
            /* Căn giữa icon khi sidebar thu gọn */
            #sidebar.collapsed .sidebar-link {
                justify-content: center;
                padding-left: 0.75rem; /* px-3 */
                padding-right: 0.75rem; /* px-3 */
            }
            /* Ẩn nút thu gọn khi sidebar thu gọn */
            #sidebar.collapsed #collapse-text {
                display: none;
            }
            /* Căn giữa nút toggle khi sidebar thu gọn */
            #sidebar.collapsed #sidebar-toggle {
                justify-content: center;
            }
            /* Cập nhật chiều rộng Main Content khi sidebar thu gọn */
            #main-content {
                margin-left: 256px; /* Chiều rộng mặc định của w-64 */
                width: calc(100% - 256px);
                transition: margin-left 300ms ease-in-out, width 300ms ease-in-out;
            }
            #sidebar.collapsed ~ #main-content {
                margin-left: 80px; /* Chiều rộng khi thu gọn */
                width: calc(100% - 80px);
            }

            /* Cấu trúc cho Submenu */
            .submenu-toggle-icon {
                transition: transform 300ms;
            }
            .submenu-expanded .submenu-toggle-icon {
                transform: rotate(90deg);
            }
        </style>
    </head>
    <body class="bg-gray-100">
        <div class="flex h-screen bg-gray-100 overflow-hidden">
            <!-- ===== SIDEBAR (Thanh điều hướng bên trái) ===== -->
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
                                    class="sidebar-link flex items-center px-6 py-3 text-white bg-indigo-700 rounded-r-full shadow-lg"
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
                                                href="${pageContext.request.contextPath}/inbound/purchase-orders"
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

            <!-- ===== MAIN CONTENT (Nội dung chính) ===== -->
            <div id="main-content" class="flex-1 flex flex-col overflow-hidden">
                <!-- ===== TOPBAR (Thanh trên cùng) - CHỨA LOGO ===== -->
                <header
                    class="h-16 bg-white shadow-sm flex items-center justify-between px-6 flex-shrink-0"
                    >
                    <!-- Logo -->
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

                    <!-- Ô tìm kiếm nhanh -->
                    <div class="relative hidden md:block">
                        <span class="absolute inset-y-0 left-0 flex items-center pl-3">
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
                                d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z"
                                />
                            </svg>
                        </span>
                        <input
                            type="text"
                            placeholder="Tìm kiếm IMEI, Model, Mã phiếu..."
                            class="w-80 rounded-md border border-gray-300 py-2 pl-10 pr-4 text-sm focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500"
                            />
                    </div>

                    <!-- Thông báo & User Menu -->
                    <div class="flex items-center space-x-4">
                        <!-- Nút Thông báo -->
                        <button
                            class="p-2 rounded-full text-gray-500 hover:text-gray-700 hover:bg-gray-100 focus:outline-none"
                            >
                            <span class="sr-only">Thông báo</span>
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
                                d="M14.857 17.082a23.848 23.848 0 0 0 5.454-1.31A8.967 8.967 0 0 1 18 9.75V9A6 6 0 0 0 6 9v.75a8.967 8.967 0 0 1-2.312 6.022c1.733.64 3.56 1.085 5.455 1.31m5.714 0a24.255 24.255 0 0 1-5.714 0m5.714 0a3 3 0 1 1-5.714 0"
                                />
                            </svg>
                        </button>

                        <!-- User Menu Dropdown -->
                        <div class="relative" id="user-menu-container">
                            <button
                                id="user-menu-button"
                                class="flex items-center space-x-2 rounded-full p-1 hover:bg-gray-100 focus:outline-none"
                                >
                                <img
                                    class="h-8 w-8 rounded-full object-cover"
                                    src="https://placehold.co/100x100/e2e8f0/64748b?text=A"
                                    alt="User Avatar"
                                    />
                                <span class="hidden md:inline text-sm font-medium text-gray-700"
                                      >Admin Kho</span
                                >
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
                            <!-- Dropdown Menu (Ẩn) -->
                            <div
                                id="user-menu-dropdown"
                                class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 hidden z-20"
                                >
                                <a
                                    href="#"
                                    class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                                    >Hồ sơ</a
                                >
                                <a
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

                <!-- ===== Nội dung Trang Tổng quan ===== -->
                <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-100 p-6">
                    <h1 class="text-3xl font-bold text-gray-900 mb-6">
                        Tổng quan Quy trình
                    </h1>

                    <!-- 1. Thống kê nhanh (Stats Cards) - TẬP TRUNG VÀO PHIẾU CHỜ -->
                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                        <!-- Card 1: Phiếu PO Chờ Duyệt -->
                        <div
                            class="bg-white p-6 rounded-xl shadow-md flex items-center justify-between border-b-4 border-indigo-500"
                            >
                            <div>
                                <span class="text-sm font-medium text-gray-500"
                                      >Phiếu PO Chờ Duyệt</span
                                >
                                <p class="text-3xl font-bold text-indigo-600">12</p>
                            </div>
                            <div
                                class="h-12 w-12 rounded-full bg-indigo-100 flex items-center justify-center"
                                >
                                <svg
                                    class="h-6 w-6 text-indigo-600"
                                    xmlns="http://www.w3.org/2000/svg"
                                    fill="none"
                                    viewBox="0 0 24 24"
                                    stroke-width="1.5"
                                    stroke="currentColor"
                                    >
                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M12 6v6h4.5m4.5 0a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"
                                    />
                                </svg>
                            </div>
                        </div>
                        <!-- Card 2: Phiếu Nhập Draft/Tạo mới -->
                        <div
                            class="bg-white p-6 rounded-xl shadow-md flex items-center justify-between border-b-4 border-yellow-500"
                            >
                            <div>
                                <span class="text-sm font-medium text-gray-500"
                                      >Phiếu Nhập Draft</span
                                >
                                <p class="text-3xl font-bold text-yellow-600">5</p>
                            </div>
                            <div
                                class="h-12 w-12 rounded-full bg-yellow-100 flex items-center justify-center"
                                >
                                <svg
                                    class="h-6 w-6 text-yellow-600"
                                    xmlns="http://www.w3.org/2000/svg"
                                    fill="none"
                                    viewBox="0 0 24 24"
                                    stroke-width="1.5"
                                    stroke="currentColor"
                                    >
                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931ZM18.75 6.75l-4.5-4.5"
                                    />
                                </svg>
                            </div>
                        </div>
                        <!-- Card 3: Phiếu Xuất Chờ Xử Lý -->
                        <div
                            class="bg-white p-6 rounded-xl shadow-md flex items-center justify-between border-b-4 border-red-500"
                            >
                            <div>
                                <span class="text-sm font-medium text-gray-500"
                                      >Phiếu Xuất Chờ Xử Lý</span
                                >
                                <p class="text-3xl font-bold text-red-600">8</p>
                            </div>
                            <div
                                class="h-12 w-12 rounded-full bg-red-100 flex items-center justify-center"
                                >
                                <svg
                                    class="h-6 w-6 text-red-600"
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
                            </div>
                        </div>
                        <!-- Card 4: Tổng Phiếu Hoàn Thành (Hôm nay) -->
                        <div
                            class="bg-white p-6 rounded-xl shadow-md flex items-center justify-between border-b-4 border-green-500"
                            >
                            <div>
                                <span class="text-sm font-medium text-gray-500"
                                      >Phiếu Hoàn Thành (Hôm nay)</span
                                >
                                <p class="text-3xl font-bold text-green-600">75</p>
                            </div>
                            <div
                                class="h-12 w-12 rounded-full bg-green-100 flex items-center justify-center"
                                >
                                <svg
                                    class="h-6 w-6 text-green-600"
                                    xmlns="http://www.w3.org/2000/svg"
                                    fill="none"
                                    viewBox="0 0 24 24"
                                    stroke-width="1.5"
                                    stroke="currentColor"
                                    >
                                <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M9 12.75 11.25 15 15 9.75M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"
                                    />
                                </svg>
                            </div>
                        </div>
                    </div>

                    <!-- 2. Biểu đồ Nhập/Xuất Hàng (Bar Chart) - Có bộ chọn thời gian -->
                    <div class="bg-white p-6 rounded-xl shadow-md mt-6">
                        <div class="flex justify-between items-center mb-4">
                            <h3 class="text-lg font-medium text-gray-900">
                                Biểu đồ Lượng Phiếu Nhập - Xuất
                            </h3>
                            <div class="inline-flex rounded-md shadow-sm" role="group">
                                <button
                                    type="button"
                                    data-period="week"
                                    class="period-selector px-4 py-2 text-sm font-medium text-white bg-indigo-600 border border-indigo-600 rounded-l-lg hover:bg-indigo-700"
                                    >
                                    Theo Tuần
                                </button>
                                <button
                                    type="button"
                                    data-period="month"
                                    class="period-selector px-4 py-2 text-sm font-medium text-gray-900 bg-white border-t border-b border-gray-200 hover:bg-gray-100"
                                    >
                                    Theo Tháng
                                </button>
                                <button
                                    type="button"
                                    data-period="year"
                                    class="period-selector px-4 py-2 text-sm font-medium text-gray-900 bg-white border border-gray-200 rounded-r-md hover:bg-gray-100"
                                    >
                                    Theo Năm
                                </button>
                            </div>
                        </div>

                        <div class="relative h-80">
                            <canvas id="nhapXuatChart"></canvas>
                        </div>
                    </div>

                    <!-- 3. Bảng Phiếu đang chờ xử lý -->
                    <div class="bg-white p-6 rounded-xl shadow-md mt-6">
                        <h3 class="text-lg font-medium text-gray-900 mb-4">
                            Phiếu đang chờ xử lý (Draft/Chờ duyệt)
                        </h3>
                        <div class="overflow-x-auto rounded-lg border border-gray-200">
                            <table class="min-w-full table-fixed text-left text-sm">
                                <thead class="bg-gray-50 border-b border-gray-200">
                                    <tr>
                                        <th
                                            class="w-1/12 py-3 px-4 text-xs font-medium text-gray-600 uppercase tracking-wider"
                                            >
                                            Loại Phiếu
                                        </th>
                                        <th
                                            class="w-2/12 py-3 px-4 text-xs font-medium text-gray-600 uppercase tracking-wider"
                                            >
                                            Mã Phiếu
                                        </th>
                                        <th
                                            class="w-2/12 py-3 px-4 text-xs font-medium text-gray-600 uppercase tracking-wider"
                                            >
                                            Trạng thái
                                        </th>
                                        <th
                                            class="w-4/12 py-3 px-4 text-xs font-medium text-gray-600 uppercase tracking-wider"
                                            >
                                            Mô tả/Đối tác
                                        </th>
                                        <th
                                            class="w-2/12 py-3 px-4 text-xs font-medium text-gray-600 uppercase tracking-wider"
                                            >
                                            Ngày tạo
                                        </th>
                                        <th
                                            class="w-1/12 py-3 px-4 text-xs font-medium text-gray-600 uppercase tracking-wider text-right"
                                            >
                                            Thao tác
                                        </th>
                                    </tr>
                                </thead>
                                <tbody
                                    class="divide-y divide-gray-100"
                                    id="pending-documents-table"
                                    >
                                    <!-- Dữ liệu mẫu sẽ được chèn ở đây -->
                                    <tr class="hover:bg-gray-50">
                                        <td class="py-3 px-4 text-blue-600 font-semibold">PO</td>
                                        <td class="py-3 px-4 font-medium text-gray-700 truncate">
                                            #PO20251025-001
                                        </td>
                                        <td class="py-3 px-4">
                                            <span
                                                class="inline-flex items-center justify-center rounded-lg bg-yellow-100 px-3 py-1 text-xs font-medium text-yellow-800 min-w-[90px] text-center"
                                                >Chờ duyệt</span
                                            >
                                        </td>
                                        <td class="py-3 px-4 text-gray-600 truncate">
                                            Mua 100 iPhone 16 từ FPT Trading
                                        </td>
                                        <td class="py-3 px-4 text-gray-600">25/10/2025</td>
                                        <td class="py-3 px-4 text-right">
                                            <button
                                                class="text-indigo-600 hover:text-indigo-900 font-medium"
                                                >
                                                Chi tiết
                                            </button>
                                        </td>
                                    </tr>
                                    <tr class="hover:bg-gray-50">
                                        <td class="py-3 px-4 text-green-600 font-semibold">
                                            Nhập hàng
                                        </td>
                                        <td class="py-3 px-4 font-medium text-gray-700 truncate">
                                            #PN20251030-003
                                        </td>
                                        <td class="py-3 px-4">
                                            <span
                                                class="inline-flex items-center justify-center rounded-lg bg-gray-100 px-3 py-1 text-xs font-medium text-gray-800 min-w-[90px] text-center"
                                                >Draft</span
                                            >
                                        </td>
                                        <td class="py-3 px-4 text-gray-600 truncate">
                                            Phiếu nhập linh kiện từ Nhà cung cấp A
                                        </td>
                                        <td class="py-3 px-4 text-gray-600">30/10/2025</td>
                                        <td class="py-3 px-4 text-right">
                                            <button
                                                class="text-indigo-600 hover:text-indigo-900 font-medium"
                                                >
                                                Chi tiết
                                            </button>
                                        </td>
                                    </tr>
                                    <tr class="hover:bg-gray-50">
                                        <td class="py-3 px-4 text-red-600 font-semibold">
                                            Xuất hàng
                                        </td>
                                        <td class="py-3 px-4 font-medium text-gray-700 truncate">
                                            #PX20251029-010
                                        </td>
                                        <td class="py-3 px-4">
                                            <span
                                                class="inline-flex items-center justify-center rounded-lg bg-red-100 px-3 py-1 text-xs font-medium text-red-800 min-w-[90px] text-center"
                                                >Chờ lấy hàng</span
                                            >
                                        </td>
                                        <td class="py-3 px-4 text-gray-600 truncate">
                                            Đơn hàng bán lẻ online (5 sản phẩm)
                                        </td>
                                        <td class="py-3 px-4 text-gray-600">29/10/2025</td>
                                        <td class="py-3 px-4 text-right">
                                            <button
                                                class="text-indigo-600 hover:text-indigo-900 font-medium"
                                                >
                                                Chi tiết
                                            </button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- 4. Hoạt động gần nhất (Giữ lại để theo dõi chi tiết) -->
                    <div class="bg-white p-6 rounded-xl shadow-md mt-6">
                        <h3 class="text-lg font-medium text-gray-900 mb-4">
                            Hoạt động hoàn thành gần nhất
                        </h3>
                        <div class="overflow-x-auto rounded-lg border border-gray-200">
                            <table class="min-w-full table-fixed text-left text-sm">
                                <thead class="bg-gray-50 border-b border-gray-200">
                                    <tr>
                                        <th
                                            class="w-2/24 py-3 px-4 text-xs font-medium text-gray-600 uppercase tracking-wider"
                                            >
                                            Loại
                                        </th>
                                        <th
                                            class="w-2/24 py-3 px-4 text-xs font-medium text-gray-600 uppercase tracking-wider"
                                            >
                                            Mã phiếu
                                        </th>
                                        <th
                                            class="w-8/24 py-3 px-4 text-xs font-medium text-gray-600 uppercase tracking-wider"
                                            >
                                            Sản phẩm
                                        </th>
                                        <th
                                            class="w-2/24 py-3 px-4 text-xs font-medium text-gray-600 uppercase tracking-wider text-right"
                                            >
                                            Số lượng
                                        </th>
                                        <th
                                            class="w-4/24 py-3 px-4 text-xs font-medium text-gray-600 uppercase tracking-wider"
                                            >
                                            Người thực hiện
                                        </th>
                                        <th
                                            class="w-2/12 py-3 px-4 text-xs font-medium text-gray-600 uppercase tracking-wider"
                                            >
                                            Thời gian
                                        </th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-100">
                                    <tr class="hover:bg-gray-50">
                                        <td class="py-3 px-4">
                                            <span
                                                class="inline-flex items-center justify-center rounded-lg bg-green-100 px-3 py-1 text-xs font-medium text-green-800 min-w-[90px] text-center"
                                                >Nhập hàng</span
                                            >
                                        </td>
                                        <td class="py-3 px-4 font-medium text-gray-700 truncate">
                                            #PN00123
                                        </td>
                                        <td class="py-3 px-4 text-gray-600 truncate">
                                            20 x iPhone 15 Pro Max (256GB, Đen)
                                        </td>
                                        <td class="py-3 px-4 text-gray-600 text-right">20</td>
                                        <td class="py-3 px-4 text-gray-600 truncate">
                                            Văn A (NV Kho)
                                        </td>
                                        <td class="py-3 px-4 text-gray-500">10:32, 30/10/2025</td>
                                    </tr>
                                    <tr class="hover:bg-gray-50">
                                        <td class="py-3 px-4">
                                            <span
                                                class="inline-flex items-center justify-center rounded-lg bg-blue-100 px-3 py-1 text-xs font-medium text-blue-800 min-w-[90px] text-center"
                                                >Xuất hàng</span
                                            >
                                        </td>
                                        <td class="py-3 px-4 font-medium text-gray-700 truncate">
                                            #PX00111
                                        </td>
                                        <td class="py-3 px-4 text-gray-600 truncate">
                                            5 x Samsung S24 Ultra (512GB, Bạc)
                                        </td>
                                        <td class="py-3 px-4 text-gray-600 text-right">5</td>
                                        <td class="py-3 px-4 text-gray-600 truncate">
                                            Thị B (NV Bán hàng)
                                        </td>
                                        <td class="py-3 px-4 text-gray-500">09:47, 30/10/2025</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <script>
            // Dữ liệu giả lập cho biểu đồ nhập/xuất theo thời gian
            const chartData = {
                week: {
                    labels: ["T2", "T3", "T4", "T5", "T6", "T7", "CN"],
                    inbound: [120, 150, 80, 200, 130, 90, 50], // Số lượng phiếu nhập
                    outbound: [90, 110, 140, 180, 100, 120, 70], // Số lượng phiếu xuất
                },
                month: {
                    labels: ["Tuần 1", "Tuần 2", "Tuần 3", "Tuần 4"],
                    inbound: [550, 620, 480, 710],
                    outbound: [450, 580, 600, 550],
                },
                year: {
                    labels: ["Q1", "Q2", "Q3", "Q4"],
                    inbound: [6500, 7800, 7200, 8500],
                    outbound: [5800, 7000, 8100, 9000],
                },
            };

            let currentChart;

            function renderChart(period) {
                const data = chartData[period];
                const ctx = document.getElementById("nhapXuatChart").getContext("2d");

                if (currentChart) {
                    currentChart.destroy();
                }

                currentChart = new Chart(ctx, {
                    type: "bar",
                    data: {
                        labels: data.labels,
                        datasets: [
                            {
                                label: "Phiếu Nhập",
                                data: data.inbound,
                                backgroundColor: "rgba(79, 70, 229, 0.7)", // Màu Indigo
                                borderWidth: 0,
                                borderRadius: 4,
                            },
                            {
                                label: "Phiếu Xuất",
                                data: data.outbound,
                                backgroundColor: "rgba(59, 130, 246, 0.7)", // Màu Blue
                                borderWidth: 0,
                                borderRadius: 4,
                            },
                        ],
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true,
                                title: {
                                    display: true,
                                    text: "Số lượng phiếu",
                                },
                                grid: {color: "rgba(203, 213, 225, 0.3)"},
                            },
                            x: {
                                grid: {display: false},
                            },
                        },
                        plugins: {
                            legend: {
                                position: "top",
                                labels: {usePointStyle: true, padding: 20},
                            },
                            tooltip: {
                                callbacks: {
                                    label: function (context) {
                                        let label = context.dataset.label || "";
                                        if (label) {
                                            label += ": ";
                                        }
                                        if (context.parsed.y !== null) {
                                            label += context.parsed.y.toLocaleString("vi-VN");
                                        }
                                        return label;
                                    },
                                },
                            },
                        },
                    },
                });
            }

            document.addEventListener("DOMContentLoaded", () => {
                // Mặc định load biểu đồ theo Tuần
                renderChart("week");

                // ===== 1. LOGIC THU GỌN SIDEBAR =====
                const sidebar = document.getElementById("sidebar");
                const mainContent = document.getElementById("main-content");
                const sidebarToggle = document.getElementById("sidebar-toggle");
                const collapseIcon = sidebarToggle.querySelector("svg");

                mainContent.style.marginLeft = "256px";

                sidebarToggle.addEventListener("click", () => {
                    sidebar.classList.toggle("collapsed");

                    if (sidebar.classList.contains("collapsed")) {
                        sidebar.style.width = "80px";
                        mainContent.style.marginLeft = "80px";
                        collapseIcon.innerHTML = `<path stroke-linecap="round" stroke-linejoin="round" d="m8.25 4.5 7.5 7.5-7.5 7.5" />`;
                    } else {
                        sidebar.style.width = "256px";
                        mainContent.style.marginLeft = "256px";
                        collapseIcon.innerHTML = `<path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5 8.25 12l7.5-7.5" />`;
                    }
                });

                // ===== 2. LOGIC USER MENU DROPDOWN =====
                const userMenuButton = document.getElementById("user-menu-button");
                const userMenuDropdown = document.getElementById("user-menu-dropdown");
                const userMenuContainer = document.getElementById(
                        "user-menu-container"
                        );

                userMenuButton.addEventListener("click", () => {
                    userMenuDropdown.classList.toggle("hidden");
                });

                document.addEventListener("click", (event) => {
                    if (!userMenuContainer.contains(event.target)) {
                        userMenuDropdown.classList.add("hidden");
                    }
                });

                // ===== 3. LOGIC SUBMENU (Mục con) =====
                document
                        .querySelectorAll(".sidebar-item button[data-target]")
                        .forEach((button) => {
                            button.addEventListener("click", () => {
                                const targetId = button.getAttribute("data-target");
                                const submenu = document.getElementById(targetId);

                                submenu.classList.toggle("hidden");
                                button.parentElement.classList.toggle("submenu-expanded");
                            });
                        });

                // ===== 4. LOGIC CHỌN KHOẢNG THỜI GIAN BIỂU ĐỒ =====
                document.querySelectorAll(".period-selector").forEach((button) => {
                    button.addEventListener("click", function () {
                        const period = this.getAttribute("data-period");

                        // Cập nhật trạng thái Active cho nút
                        document.querySelectorAll(".period-selector").forEach((btn) => {
                            btn.classList.remove("bg-indigo-600", "text-white");
                            btn.classList.add("bg-white", "text-gray-900", "border-gray-200");
                        });

                        this.classList.remove(
                                "bg-white",
                                "text-gray-900",
                                "border-gray-200"
                                );
                        this.classList.add(
                                "bg-indigo-600",
                                "text-white",
                                "border-indigo-600"
                                );

                        // Xử lý border đặc biệt cho nút giữa (Tháng)
                        if (period === "month") {
                            this.classList.remove("border-indigo-600");
                            this.classList.add("border-t", "border-b", "border-indigo-600");
                        } else if (period === "week") {
                            this.classList.add("rounded-l-lg");
                            this.classList.remove("rounded-r-md");
                        } else if (period === "year") {
                            this.classList.add("rounded-r-md");
                            this.classList.remove("rounded-l-lg");
                        }

                        // Tải lại biểu đồ
                        renderChart(period);
                    });
                });
            });
        </script>
    </body>
</html>


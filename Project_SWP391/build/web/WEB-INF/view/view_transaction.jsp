<%-- 
    Document   : view_transaction
    Created on : Oct 12, 2025, 2:57:23 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Transaction detail</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
            rel="stylesheet"
            />
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/view_transaction.css"/>

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
                width: 256px;
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

            /* Ghi đè CSS của layout.css để tương thích với Tailwind layout */
            .layout {
                display: block; /* Vô hiệu hóa grid của layout.css */
            }
            .main {
                margin-left: 0; /* Vô hiệu hóa margin của layout.css */
                padding: 0; /* Reset padding để main content của dashboard xử lý */
            }
            aside.sidebar {
                display: none; /* Ẩn sidebar cũ từ layout.css */
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

                    <div class="flex items-center space-x-4">
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

                <main class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-100 p-6" id="receipt">
                    <div class="main-header" id="main-header">
                        <h3>
                            Transaction No
                            <span class="receipt-no">${view.receipt_no}</span>
                        </h3>
                    </div>

                    <div class="header-info">
                        <section class="header-card card">
                            <h4 class="block-title">Header Information</h4>
                            <div class="header-columns">
                                <div class="col">
                                    <dl>
                                        <dt>PO No</dt>
                                        <dd><a href="#" class="link">${view.po_code}</a></dd>
                                        <dt>Received by</dt>
                                        <dd>${view.fullname} — ${view.employee_code}</dd>
                                        <dt>Supplier</dt>
                                        <dd>${view.supplier_name}</dd>
                                        <dt>Note / Reason</dt>
                                        <c:if test="${not empty view.note}">
                                            <dd>${view.note}</dd>
                                        </c:if>
                                        <c:if test="${empty view.note}">
                                            <dd>There is no note here</dd>
                                        </c:if>
                                    </dl>
                                </div>
                                <div class="col">
                                    <dl>
                                        <dt>PO Date</dt>
                                        <dd>${view.po_date}</dd>
                                        <dt>Received At</dt>
                                        <dd>${view.received_at}</dd>
                                        <dt>Status</dt>
                                        <dd>
                                            <span class="status">${view.status}</span>
                                        </dd>
                                    </dl>
                                </div>
                            </div>
                        </section>

                        <section class="summary-card card">
                            <h4 class="block-title">Summary</h4>
                            <div class="summary-content">
                                <div class="summary-item">
                                    <label>Tổng expected</label>
                                    <div id="sum-expected">0</div>
                                </div>
                                <div class="summary-item">
                                    <label>Tổng received</label>
                                    <div id="sum-received">0</div>
                                </div>
                                <div class="summary-item">
                                    <label>Tổng tiền</label>
                                    <div id="sum-money">0.00</div>
                                </div>
                                <div class="summary-item">
                                    <label>Tỉ lệ nhận</label>
                                    <div id="pct-received">0%</div>
                                </div>
                                <div class="summary-item">
                                    <label>Số dòng có discrepancy</label>
                                    <div id="rows-discrep">0</div>
                                </div>
                            </div>
                        </section>
                    </div>

                    <hr class="separator" />

                    <section class="lines card">
                        <h4 class="block-title">Lines (Chi tiết dòng)</h4>
                        <table class="lines-table" id="lines-table">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Product</th>
                                    <th>Expected</th>
                                    <th>Received</th>
                                    <th>Unit Price</th>
                                    <th>Line Total</th>
                                    <th>Discrepancy</th>
                                    <th>Bin</th>
                                    <th>Note</th>
                                    <th>Serials</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="l" items="${line}">
                                    <tr class="line-row" data-line-id="${l.line_id}">
                                        <td class="center">1</td> <td>
                                            <div class="sku">${l.sku_code}</div>
                                            <div class="prod-name">${l.name}</div>
                                        </td>
                                        <td class="center qty-expected">${l.qty_expected}</td>
                                        <td class="center qty-received">${l.qty_received}</td>
                                        <td class="right unit-price">${l.unit_price}</td>
                                        <td class="right line-total"><fmt:formatNumber value="${l.qty_received * l.unit_price}" type="number" maxFractionDigits="2" /></td>
                                        <td class="center discrepancy">${l.qty_received - l.qty_expected}</td>
                                        <td class="center">${l.location}</td>
                                        <td class="small">${l.note}</td>
                                        <td class="center">
                                            <button class="btn small-btn toggle-serials">
                                                Show Serials (${l.qty_received})
                                            </button>
                                        </td>
                                    </tr>
                                    <tr class="serials-row" data-parent-line="${l.line_id}" hidden>
                                        <td colspan="10" class="serials-cell">
                                            <div class="serials-title">Serials for ${l.sku_code}</div>
                                            <table class="serial-table">
                                                <thead>
                                                    <tr>
                                                        <th>IMEI</th>
                                                        <th>SERIAL</th>
                                                        <th>Warranty start</th>
                                                        <th>Warranty end</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="u" items="${unit[l.product_id]}">
                                                        <tr>
                                                            <td>${u.imei}</td>
                                                            <td>${u.serial_number}</td>
                                                            <td>${u.warranty_start}</td>
                                                            <td>${u.warranty_end}</td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </section>

                    <section class="summary-bottom card">
                        <div class="actions-left">
                            <a class="btn ghost" href="${pageContext.request.contextPath}/inbound/transactions">Go to previous page</a>
                        </div>
                        <div class="actions-right">
                            <button class="btn">Print</button>
                            <button class="btn">Export PDF</button>
                            <button class="btn">Download CSV</button>
                        </div>
                    </section>
                </main>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", () => {

                // ===== 1. LOGIC THU GỌN SIDEBAR (Từ dashboard.html) =====
                const sidebar = document.getElementById("sidebar");
                const mainContent = document.getElementById("main-content");
                const sidebarToggle = document.getElementById("sidebar-toggle");
                const collapseIcon = sidebarToggle.querySelector("svg");

                // Đảm bảo trạng thái ban đầu nhất quán
                if (sidebar.classList.contains("collapsed")) {
                    mainContent.style.marginLeft = "80px";
                } else {
                    mainContent.style.marginLeft = "256px";
                }

                sidebarToggle.addEventListener("click", () => {
                    sidebar.classList.toggle("collapsed");

                    if (sidebar.classList.contains("collapsed")) {
                        sidebar.style.width = "80px";
                        mainContent.style.marginLeft = "80px";
                        // Sử dụng innerHTML với chuỗi đơn để tránh xung đột
                        collapseIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" d="m8.25 4.5 7.5 7.5-7.5 7.5" />';
                    } else {
                        sidebar.style.width = "256px";
                        mainContent.style.marginLeft = "256px";
                        // Sử dụng innerHTML với chuỗi đơn để tránh xung đột
                        collapseIcon.innerHTML = '<path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5 8.25 12l7.5-7.5" />';
                    }
                });

                // ===== 2. LOGIC USER MENU DROPDOWN (Từ dashboard.html) =====
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

                // ===== 3. LOGIC SUBMENU (Mục con) (Từ dashboard.html) =====
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

                // ===== 4. LOGIC TỪ view_transaction.jsp =====

                // Logic đổi màu status
                const statusEl = document.querySelector(".status");
                if (statusEl) {
                    const statusText = statusEl.textContent.trim().toLowerCase();
                    statusEl.classList.add("status-" + statusText);
                }

                // Logic tính toán
                function parseNumber(v) {
                    if (v === null || v === undefined)
                        return 0;
                    const s = String(v).replace(/[, ]+/g, "");
                    const n = parseFloat(s);
                    return isNaN(n) ? 0 : n;
                }
                function formatMoney(v) {
                    return Number(v).toFixed(2);
                }

                function recalcLine(tr) {
                    const qtyExpected = parseNumber(
                            tr.querySelector(".qty-expected")?.textContent
                            );
                    const qtyReceived = parseNumber(
                            tr.querySelector(".qty-received")?.textContent
                            );
                    const unitPrice = parseNumber(tr.querySelector(".unit-price")?.textContent);
                    const lineTotal = qtyReceived * unitPrice;

                    const lineTotalEl = tr.querySelector(".line-total");
                    lineTotalEl.textContent = formatMoney(lineTotal);
                    const discrepancy = qtyReceived - qtyExpected;
                    const discEl = tr.querySelector(".discrepancy");
                    discEl.textContent = discrepancy > 0 ?
                            "+" + discrepancy : discrepancy;
                    discEl.classList.remove("pos", "neg", "zero");
                    if (discrepancy === 0)
                        discEl.classList.add("zero");
                    else if (discrepancy > 0)
                        discEl.classList.add("pos");
                    else
                        discEl.classList.add("neg");
                    return {qtyExpected, qtyReceived, lineTotal, discrepancy};
                }

                function recalcAll() {
                    const rows = Array.from(
                            document.querySelectorAll("#lines-table tbody tr.line-row")
                            );
                    let sumExpected = 0,
                            sumReceived = 0,
                            sumMoney = 0,
                            rowsWithDisc = 0;

                    // Đánh số thứ tự
                    let lineNo = 1;

                    rows.forEach((tr) => {
                        // Đặt số thứ tự cho dòng
                        const lineNoEl = tr.querySelector("td:first-child");
                        if (lineNoEl) {
                            lineNoEl.textContent = lineNo++;
                        }

                        const r = recalcLine(tr);
                        sumExpected += r.qtyExpected;
                        sumReceived += r.qtyReceived;
                        sumMoney += r.lineTotal;
                        if (r.discrepancy !== 0)
                            rowsWithDisc++;
                    });
                    const pct = sumExpected === 0 ? 0 : (sumReceived / sumExpected) * 100;

                    document.getElementById("sum-expected").textContent = sumExpected;
                    document.getElementById("sum-received").textContent = sumReceived;
                    document.getElementById("sum-money").textContent = formatMoney(sumMoney);
                    document.getElementById("pct-received").textContent = pct.toFixed(1) + "%";
                    document.getElementById("rows-discrep").textContent = rowsWithDisc;
                }

                document.querySelectorAll(".toggle-serials").forEach((btn) => {
                    btn.addEventListener("click", function () {
                        // tìm dòng cha (closest .line-row)
                        const tr = btn.closest("tr.line-row");
                        if (!tr)
                            return;
                        const lineId = tr.dataset.lineId;

                        const serialsRow = document.querySelector(
                                'tr.serials-row[data-parent-line="' + lineId + '"]'
                                );

                        if (!serialsRow)
                            return;
                        const isHidden = serialsRow.hasAttribute("hidden");
                        if (isHidden) {
                            serialsRow.removeAttribute("hidden");
                            btn.textContent = btn.textContent.replace(/Show/i, "Hide");
                        } else {
                            serialsRow.setAttribute("hidden", "");
                            btn.textContent = btn.textContent.replace(/Hide/i, "Show");
                        }
                    });
                });

                recalcAll(); // Chạy tính toán lần đầu khi tải trang

                window.receiptRecalc = recalcAll;

            });
        </script>
    </body>
</html>
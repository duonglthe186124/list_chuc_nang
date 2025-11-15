<%-- 
    Document   : transaction_history
    Created on : Oct 5, 2025, 1:09:57 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi" class="scroll-smooth">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Danh sách Nhà Cung Cấp - WMS Pro</title>
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
            }
            #main-content.sidebar-collapsed {
                margin-left: 5rem;
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

            .text-right {
                text-align: right;
            }
            .action-cell {
                white-space: nowrap;
                width: 250px;
                text-align: right;
            }

            .action-cell a{
                display: inline-block;
                padding: 4px 10px;
                border-radius: 8px;
                font-size: 0.75rem;
                font-weight: 600;
                line-height: 1;
                text-decoration: none;
                transition: background-color 0.15s;
            }

            .action-view {
                color: #2563eb;
                background-color: #dbeafe;
                border: 1px solid #93c5fd;
            }
            .action-update {
                color: #15803d;
                background-color: #dcfce7;
                border: 1px solid #86efac;
            }
            .action-delete {
                color: #dc2626;
                background-color: #fee2e2;
                border: 1px solid #fca5a5;
            }
            .action-view:hover {
                background-color: #bfdbfe;
            }
            .action-update:hover {
                background-color: #a7f3d0;
            }
            .action-delete:hover {
                background-color: #fecaca;
            }

            .search-input,
            .filter-dropdown,
            .filter-btn,
            .search-btn,
            #page-size,
            .page-input,
            .go-btn {
                padding: 0.5rem 0.75rem;
                line-height: 1.25rem;
            }
            .search-input {
                border: 1px solid #d1d5db;
                border-right: none;
                border-top-left-radius: 0.5rem;
                border-bottom-left-radius: 0.5rem;
            }
            .search-btn {
                border-top-right-radius: 0.5rem;
                border-bottom-right-radius: 0.5rem;
                height: 2.5rem;
                width: 2.5rem;
                padding: 0.5rem;
            }
            .filter-dropdown {
                border: 1px solid #d1d5db;
                border-radius: 0.5rem;
            }
            .pagination button,
            .pagination .go-btn,
            .pagination .page-input {
                height: 2.5rem !important;
            }
            .page-input {
                padding: 0.5rem 0.75rem;
                border: 1px solid #d1d5db;
                border-radius: 0.5rem;
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

                    <div>
                        <button
                            type="button"
                            class="flex items-center justify-between w-full gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors sidebar-item-button"
                            >
                            <div class="flex items-center gap-3">
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
                                    d="M10.5 1.5H8.25A2.25 2.25 0 0 0 6 3.75v16.5a2.25 2.25 0 0 0 2.25 2.25h7.5A2.25 2.25 0 0 0 18 20.25V3.75a2.25 2.25 0 0 0-2.25-2.25H13.5m-3 0V3h3V1.5m-3 0h3m-3 18.75h3"
                                    />
                                </svg>
                                <span class="sidebar-text">Phiếu mua hàng</span>
                            </div>
                            <svg
                                class="h-4 w-4 sidebar-arrow transition-transform"
                                xmlns="http://www.w3.org/2000/svg"
                                viewBox="0 0 20 20"
                                fill="currentColor"
                                >
                            <path
                                fill-rule="evenodd"
                                d="M7.21 14.77a.75.75 0 0 1 .02-1.06L11.168 10 7.23 6.29a.75.75 0 1 1 1.04-1.08l4.5 4.25a.75.75 0 0 1 0 1.08l-4.5 4.25a.75.75 0 0 1-1.06-.02Z"
                                clip-rule="evenodd"
                                />
                            </svg>
                        </button>
                        <div class="mt-1.5 space-y-1 pl-7 sidebar-submenu hidden">
                            <a
                                href="${pageContext.request.contextPath}/inbound/purchase-orders"
                                class="block px-3 py-2 rounded-lg text-sm font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-900"
                                >
                                <span class="sidebar-text">Danh sách phiếu mua</span>
                            </a>
                            <a
                                href="${pageContext.request.contextPath}/inbound/createpo"
                                class="block px-3 py-2 rounded-lg text-sm font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-900"
                                >
                                <span class="sidebar-text">Tạo phiếu mua mới</span>
                            </a>
                        </div>
                    </div>

                    <div>
                        <button
                            type="button"
                            class="flex items-center justify-between w-full gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors sidebar-item-button"
                            >
                            <div class="flex items-center gap-3">
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
                                    d="M20.25 7.5l-.625 10.632a2.25 2.25 0 0 1-2.247 2.118H6.622a2.25 2.25 0 0 1-2.247-2.118L3.75 7.5M10.5 11.25h3M12 15V7.5m-6.75 4.5l.625 10.632a2.25 2.25 0 0 0 2.247 2.118h11.25a2.25 2.25 0 0 0 2.247-2.118l.625-10.632M3.75 7.5h16.5"
                                    />
                                </svg>
                                <span class="sidebar-text">Nhập kho</span>
                            </div>
                            <svg
                                class="h-4 w-4 sidebar-arrow transition-transform"
                                xmlns="http://www.w3.org/2000/svg"
                                viewBox="0 0 20 20"
                                fill="currentColor"
                                >
                            <path
                                fill-rule="evenodd"
                                d="M7.21 14.77a.75.75 0 0 1 .02-1.06L11.168 10 7.23 6.29a.75.75 0 1 1 1.04-1.08l4.5 4.25a.75.75 0 0 1 0 1.08l-4.5 4.25a.75.75 0 0 1-1.06-.02Z"
                                clip-rule="evenodd"
                                />
                            </svg>
                        </button>
                        <div class="mt-1.5 space-y-1 pl-7 sidebar-submenu hidden">
                            <a
                                href="${pageContext.request.contextPath}/inbound/transactions"
                                class="block px-3 py-2 rounded-lg text-sm font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-900"
                                >
                                <span class="sidebar-text">Danh sách phiếu nhập kho</span>
                            </a>
                            <a
                                href="${pageContext.request.contextPath}/inbound/create-receipt"
                                class="block px-3 py-2 rounded-lg text-sm font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-900"
                                >
                                <span class="sidebar-text">Tạo phiếu nhập mới</span>
                            </a>
                        </div>
                    </div>

                    <div>
                        <button
                            type="button"
                            class="flex items-center justify-between w-full gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors sidebar-item-button"
                            >
                            <div class="flex items-center gap-3">
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
                                    d="M9 8.25H7.5a2.25 2.25 0 0 0-2.25 2.25v9a2.25 2.25 0 0 0 2.25 2.25h9a2.25 2.25 0 0 0 2.25-2.25v-9a2.25 2.25 0 0 0-2.25-2.25H15M9 12l3 3m0 0 3-3m-3 3V2.25"
                                    />
                                </svg>
                                <span class="sidebar-text">Xuất hàng</span>
                            </div>
                            <svg
                                class="h-4 w-4 sidebar-arrow transition-transform"
                                xmlns="http://www.w3.org/2000/svg"
                                viewBox="0 0 20 20"
                                fill="currentColor"
                                >
                            <path
                                fill-rule="evenodd"
                                d="M7.21 14.77a.75.75 0 0 1 .02-1.06L11.168 10 7.23 6.29a.75.75 0 1 1 1.04-1.08l4.5 4.25a.75.75 0 0 1 0 1.08l-4.5 4.25a.75.75 0 0 1-1.06-.02Z"
                                clip-rule="evenodd"
                                />
                            </svg>
                        </button>
                        <div class="mt-1.5 space-y-1 pl-7 sidebar-submenu hidden">
                            <a
                                href="${pageContext.request.contextPath}/inbound/shipments"
                                class="block px-3 py-2 rounded-lg text-sm font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-900"
                                >
                                <span class="sidebar-text">Danh sách phiếu xuất kho</span>
                            </a>
                            <a
                                href="${pageContext.request.contextPath}/inbound/create-shipment"
                                class="block px-3 py-2 rounded-lg text-sm font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-900"
                                >
                                <span class="sidebar-text">Tạo phiếu xuất mới</span>
                            </a>
                        </div>
                    </div>

                    <div>
                        <button
                            type="button"
                            class="flex items-center justify-between w-full gap-3 px-3 py-2.5 rounded-lg text-sm font-semibold bg-indigo-100 text-indigo-700 sidebar-item-button"
                            >
                            <div class="flex items-center gap-3">
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
                                    d="M15 11.25l-3-3m0 0l-3 3m3-3v7.5M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"
                                    />
                                </svg>
                                <span class="sidebar-text">Nhà cung cấp</span>
                            </div>
                            <svg
                                class="h-4 w-4 sidebar-arrow rotate-90 transition-transform"
                                xmlns="http://www.w3.org/2000/svg"
                                viewBox="0 0 20 20"
                                fill="currentColor"
                                >
                            <path
                                fill-rule="evenodd"
                                d="M7.21 14.77a.75.75 0 0 1 .02-1.06L11.168 10 7.23 6.29a.75.75 0 1 1 1.04-1.08l4.5 4.25a.75.75 0 0 1 0 1.08l-4.5 4.25a.75.75 0 0 1-1.06-.02Z"
                                clip-rule="evenodd"
                                />
                            </svg>
                        </button>
                        <div class="mt-1.5 space-y-1 pl-7 sidebar-submenu">
                            <a
                                href="${pageContext.request.contextPath}/inbound/suppliers"
                                class="block px-3 py-2 rounded-lg text-sm font-medium text-indigo-700 bg-indigo-50"
                                >
                                <span class="sidebar-text">Danh sách NCC</span>
                            </a>
                            <a
                                href="${pageContext.request.contextPath}/inbound/create-supplier"
                                class="block px-3 py-2 rounded-lg text-sm font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-900"
                                >
                                <span class="sidebar-text">Tạo nhà cung cấp mới</span>
                            </a>
                        </div>
                    </div>
                </nav>

                <div class="py-3 px-3 border-t border-gray-200">
                    <button
                        id="sidebar-toggle"
                        class="flex items-center justify-center w-full gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors sidebar-item-button"
                        >
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

            <main
                id="main-content"
                class="flex-1 ml-64 bg-gray-100 p-6 lg:p-8 transition-all duration-300 ease-in-out"
                >
                <header
                    class="main-header bg-white p-6 mb-0 border-b border-gray-200 flex flex-col sm:flex-row justify-between items-start sm:items-center"
                    >
                    <div>
                        <h1 class="text-3xl font-bold text-gray-800">
                            Danh sách Nhà cung cấp
                        </h1>
                        <p class="text-sm text-gray-500 mt-1">
                            Danh sách các nhà cung cấp đã đăng ký
                        </p>
                    </div>

                    <button
                        onclick="handleCreateNew()"
                        class="mt-4 sm:mt-0 bg-indigo-600 text-white p-2.5 px-4 rounded-lg hover:bg-indigo-700 transition duration-150 font-semibold flex items-center space-x-2 text-sm"
                        >
                        <svg
                            xmlns="http://www.w3.org/2000/svg"
                            class="h-5 w-5"
                            viewBox="0 0 24 24"
                            stroke-width="2"
                            stroke="currentColor"
                            fill="none"
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            >
                        <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                        <path d="M12 5l0 14"></path>
                        <path d="M5 12l14 0"></path>
                        </svg>
                        <span>Tạo nhà cung cấp mới</span>
                    </button>
                </header>

                <main class="main bg-white p-6">
                    <form 
                        id="transaction-form" 
                        action="${pageContext.request.contextPath}/inbound/suppliers" 
                        method="get"
                        >
                        <div
                            class="flex flex-col lg:flex-row items-stretch lg:items-center justify-between space-y-3 lg:space-y-0 lg:space-x-4 mb-6"
                            >
                            <div
                                class="flex flex-grow max-w-lg"
                                >
                                <input
                                    type="text"
                                    name="searchInput"
                                    value="${param.searchInput}"
                                    placeholder="Tìm kiếm theo Tên, SĐT, Email..."
                                    class="search-input w-full p-2.5 text-sm focus:outline-none focus:ring-1 focus:ring-indigo-500 focus:border-indigo-500 border-gray-300 rounded-l-lg"
                                    />
                                <button
                                    type="submit"
                                    name="action"
                                    value="search"
                                    class="search-btn bg-indigo-600 text-white hover:bg-indigo-700 transition duration-150 flex items-center justify-center rounded-r-lg"
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
                                <div class="flex items-center space-x-2">
                                    <span class="text-gray-600 whitespace-nowrap text-sm"
                                          >Dòng / Trang:</span
                                    >
                                    <select
                                        id="page-size"
                                        name="pageSize"
                                        onchange="this.form.submit()"
                                        class="filter-dropdown p-2.5 text-sm border border-gray-300 rounded-lg focus:ring-indigo-500 focus:border-indigo-500"
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
                                        <th style="width: 8%">No.</th>
                                        <th style="width: 23%">Nhà cung cấp</th>
                                        <th style="width: 23%">Địa chỉ</th>
                                        <th style="width: 23%">Điện thoại</th>
                                        <th style="width: 23%">Email</th>
                                        <th class="action-cell">Action</th>
                                    </tr>
                                </thead>
                                <tbody id="table-body">
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
            </main>

        </div>

        <script>
            const transactions = [];
            <c:forEach var="l" items="${suppliers}">
            transactions.push({
                id: ${l.supplier_id},
                supplier_name: "${l.supplier_name}",
                address: "${l.address}",
                phone: "${l.phone}",
                email: "${l.email}",
            });
            </c:forEach>

            let currentPage = ${pageNo != null ? pageNo : 1};
            let pageSize = ${param.pageSize != null ? param.pageSize : 10};
            let totalItems = ${totalLines != null ? totalLines : 0};
            let totalPages = Math.ceil(totalItems / pageSize);

            function formatCurrency(amount) {
                return new Intl.NumberFormat("vi-VN", {
                    style: "currency",
                    currency: "VND",
                }).format(amount);
            }

            function goToPage(targetPage) {
                let newPage = parseInt(targetPage, 10);
                if (isNaN(newPage) || newPage < 1)
                    newPage = 1;
                if (newPage > totalPages && totalPages > 0)
                    newPage = totalPages;
                const form = document.getElementById('transaction-form');
                const pageNoInput = form.querySelector('input[name="pageInput"]');

                if (pageNoInput) {
                    pageNoInput.value = newPage;
                }
                form.submit();
            }

            function createPageButton(page, text) {
                const isActive = page === currentPage;
                const classes = isActive
                        ? "bg-indigo-600 text-white border-indigo-600"
                        : "bg-white text-gray-700 border-gray-300 hover:bg-gray-50";
                return '<button type="button" onclick="goToPage(' + page + ')" class="w-10 h-10 flex items-center justify-center border rounded-lg font-medium ' + classes + ' transition duration-150">' + text + '</button>';
            }

            function renderTable() {
                const tableBody = document.getElementById("table-body");
                const currentData = transactions;
                const start = (currentPage - 1) * pageSize;

                let rowsHtml = "";
                if (currentData.length === 0) {
                    rowsHtml = '<tr><td colspan="10" class="text-center py-8 text-gray-500">Không tìm thấy nhà cung cấp nào.</td></tr>';
                } else {
                    currentData.forEach((tx, index) => {
                        const rowNumber = start + index + 1;

                        rowsHtml += '\n<tr>\n' +
                                '<td class="text-sm">' + rowNumber + '</td>\n' +
                                '<td class="receipt-cell text-sm">' + tx.supplier_name + '</td>\n' +
                                '<td class="supplier-cell text-sm">' + tx.address + '</td>\n' +
                                '<td class="text-sm text-right">' + tx.phone + '</td>\n' +
                                '<td class="text-sm text-right">' + tx.email + '</td>\n' +
                                '<td class="action-cell"><a href="${pageContext.request.contextPath}/inbound/suppliers/view?id=' + tx.id + '" class="action-view mr-3">View</a>\n' +
                                '<a href="${pageContext.request.contextPath}/inbound/suppliers/update?id=' + tx.id + '" class="action-update mr-3">Update</a>\n' +
                                '<a href="${pageContext.request.contextPath}/inbound/suppliers/delete?id=' + tx.id + '" class="action-delete mr-3">Delete</a></td>\n' +
                                '</tr>';
                    });
                }

                tableBody.innerHTML = rowsHtml;
                updatePaginationInfo();
            }

            function handleCreateNew() {
                window.location.href = "${pageContext.request.contextPath}/inbound/create-supplier";
            }

            function closeModal() {
                document.getElementById("custom-modal").classList.add("hidden");
            }

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
                    infoSpan.textContent = 'Hiển thị ' + startItem + '-' + endItem + ' trên ' + totalItems + ' mục.';
                }

                goInput.placeholder = '1 - ' + totalPages;
                goInput.value = currentPage;
                const prevBtn = document.getElementById("prev-page-btn");
                const nextBtn = document.getElementById("next-page-btn");
                if (prevBtn) {
                    prevBtn.disabled = currentPage === 1;
                    prevBtn.classList.toggle("opacity-50", currentPage === 1);
                }
                if (nextBtn) {
                    nextBtn.disabled =
                            currentPage === totalPages ||
                            totalItems === 0;
                    nextBtn.classList.toggle(
                            "opacity-50",
                            currentPage === totalPages || totalItems === 0
                            );
                }

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

            document.addEventListener("DOMContentLoaded", () => {
                renderTable();

                const sidebar = document.getElementById("admin-sidebar");
                const mainContent = document.getElementById("main-content");
                const sidebarToggle = document.getElementById("sidebar-toggle");
                const submenuButtons = document.querySelectorAll(
                        "#admin-sidebar nav > div > button"
                        );
                const userMenuButton = document.getElementById("user-menu-button");
                const userMenuDropdown = document.getElementById("user-menu-dropdown");

                let isSidebarCollapsed =
                        localStorage.getItem("sidebarCollapsed") === "true";

                function toggleDesktopSidebar(collapse) {
                    isSidebarCollapsed = collapse;
                    sidebar.classList.toggle("is-collapsed", isSidebarCollapsed);
                    mainContent.classList.toggle("sidebar-collapsed", isSidebarCollapsed);
                    localStorage.setItem("sidebarCollapsed", isSidebarCollapsed);
                }

                if (sidebarToggle) {
                    toggleDesktopSidebar(isSidebarCollapsed);
                }

                if (sidebarToggle) {
                    sidebarToggle.addEventListener("click", () => {
                        toggleDesktopSidebar(!isSidebarCollapsed);
                    });
                }

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

                if (userMenuButton && userMenuDropdown) {
                    userMenuButton.addEventListener("click", (e) => {
                        e.stopPropagation();

                        if (userMenuDropdown.classList.contains("hidden")) {
                            userMenuDropdown.classList.remove("hidden");
                            setTimeout(() => {
                                userMenuDropdown.classList.remove("opacity-0", "scale-95");
                                userMenuDropdown.classList.add("opacity-100", "scale-100");
                            }, 10);
                        } else {
                            userMenuDropdown.classList.remove("opacity-100", "scale-100");
                            userMenuDropdown.classList.add("opacity-0", "scale-95");
                            setTimeout(() => {
                                userMenuDropdown.classList.add("hidden");
                            }, 100);
                        }
                    });
                }

                document.documentElement.addEventListener("click", (e) => {
                    if (
                            userMenuDropdown &&
                            !userMenuDropdown.classList.contains("hidden")
                            ) {
                        const isClickInsideButton = userMenuButton.contains(e.target);
                        const isClickInsideDropdown = userMenuDropdown.contains(e.target);

                        if (!isClickInsideButton && !isClickInsideDropdown) {
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
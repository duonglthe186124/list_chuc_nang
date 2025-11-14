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
            body {
                font-family: "Inter", sans-serif;
            }

            form{
                display: contents;
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

            :root {
                --border: #e5e7eb;
                --gap: 20px;
                --card-radius: 8px;
                --muted: #64748b;
                --text: #0f172a;
            }

            .form-group {
                margin-bottom: 18px;
            }
            .form-group label {
                display: block;
                font-weight: 600;
                margin-bottom: 6px;
                font-size: 14px;
                color: #374151
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
                transition: border-color 0.2s, box-shadow 0.2s;
            }
            .form-group input:focus,
            .form-group select:focus,
            .form-group textarea:focus {
                border-color: #4f46e5;
                box-shadow: 0 0 0 1px #4f46e5;
                outline: none;
            }

            .form-group textarea {
                min-height: 90px;
                resize: vertical;
            }

            .main-summary-grid {
                display: grid;
                grid-template-columns: 1fr;
            }
            @media (min-width: 1024px) {
                .main-summary-grid {
                    grid-template-columns: 3fr 1fr;
                }
            }
            .main-summary-grid {
                gap: var(--gap, 20px);
                margin-top: 20px;
            }

            .summary-card {
                background: #ffffff;
                border: 1px solid var(--border, #e5e7eb);
                border-radius: var(--card-radius, 8px);
                padding: 16px 18px;
                box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.05);
            }

            .summary-card-title {
                font-size: 16px;
                font-weight: 600;
                margin: 0 0 12px 0;
                padding-bottom: 10px;
                border-bottom: 1px solid var(--border, #e5e7eb);
                color: #1f2937;
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

            .shipment-table-container {
                overflow-x: auto;
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
                white-space: nowrap;
            }
            .shipment-table tr:last-child td {
                border-bottom: none;
            }
            .shipment-table th {
                background-color: #f9fafb;
                font-weight: 600;
                color: #374151;
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
                background-color: #4f46e5;
                color: white;
            }
            .btn-primary:hover {
                background-color: #4338ca;
            }
            .btn-secondary {
                background: #f1f5f9;
                color: #334155;
                border: 1px solid var(--border, #e5e7eb);
            }
            .btn-secondary:hover {
                background: #e2e8f0;
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
                                class="block px-3 py-2 rounded-lg text-sm font-medium text-indigo-700 bg-indigo-50"
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
                        <div class="mt-1.5 space-y-1 pl-7 sidebar-submenu">
                            <a
                                href="${pageContext.request.contextPath}/inbound/shipments"
                                class="block px-3 py-2 rounded-lg text-sm font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-900"
                                >
                                <span class="sidebar-text">Danh sách phiếu xuất kho</span>
                            </a>
                            <a
                                href="${pageContext.request.contextPath}/create-shipment"
                                class="block px-3 py-2 rounded-lg text-sm font-medium text-indigo-700 bg-indigo-50"
                                >
                                <span class="sidebar-text">Tạo phiếu xuất mới</span>
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
                                    d="M15 11.25l-3-3m0 0l-3 3m3-3v7.5M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"
                                    />
                                </svg>
                                <span class="sidebar-text">Nhà cung cấp</span>
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
                                href="${pageContext.request.contextPath}/inbound/suppliers"
                                class="block px-3 py-2 rounded-lg text-sm font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-900"
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
                class="flex-1 ml-64 bg-white p-6 lg:p-8 transition-all duration-300 ease-in-out"
                >
                <div
                    class="flex flex-col justify-between items-start mb-6 gap-4"
                    >
                    <h1 class="text-3xl font-bold text-gray-900">
                        Tạo Phiếu Xuất Kho mới
                    </h1>
                    <p class="text-sm text-gray-500 mt-1">
                        Chọn một đơn hàng để bắt đầu tạo phiếu xuất kho.
                    </p>
                </div>

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
            </main>
        </div>
        <script>
            function formatCurrency(number) {
                const num = parseFloat(number);
                if (!isFinite(num)) {
                    return new Intl.NumberFormat("vi-VN", {
                        style: "currency",
                        currency: "VND"
                    }).format(0);
                }

                return new Intl.NumberFormat("vi-VN", {
                    style: "currency",
                    currency: "VND"
                }).format(num);
            }

            const summaryActualTotal = document.getElementById('actual-total');
            const summaryDifferenceTotal = document.getElementById('difference-total');
            const summaryOrderTotalElement = document.getElementById('order-total');
            const summarySkuCount = document.getElementById('received-sku');
            const summaryQtyCount = document.getElementById('received-qty');
            const qtyInputs = document.querySelectorAll('.qty-input');

            let initialOrderTotal = 0;
            if (summaryOrderTotalElement) {
                const initialOrderTotalText = summaryOrderTotalElement.textContent
                        .replace(/\s*đ\s*/, '')
                        .replace(/,/g, '')
                        .trim();
                initialOrderTotal = parseFloat(initialOrderTotalText) || 0;
            }

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
                        input.value = outQty;
                    } else if (outQty < 0) {
                        outQty = 0;
                        input.value = outQty;
                    }

                    const actualLineTotal = outQty * unitPrice;

                    const row = input.closest('tr');
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

                if (summaryActualTotal)
                    summaryActualTotal.textContent = formatCurrency(totalActualValue);
                if (summaryDifferenceTotal)
                    summaryDifferenceTotal.textContent = formatCurrency(difference);

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

            qtyInputs.forEach(input => {
                input.addEventListener('input', updateTotals);
                input.addEventListener('blur', updateTotals); // Dùng blur để validate lần cuối
            });
            document.addEventListener("DOMContentLoaded", () => {
                const sidebar = document.getElementById("admin-sidebar");
                const mainContent = document.getElementById("main-content");
                const sidebarToggle = document.getElementById("sidebar-toggle");
                const submenuButtons = document.querySelectorAll(
                        "#admin-sidebar nav > div > button"
                        );
                const userMenuButton = document.getElementById("user-menu-button");
                const userMenuDropdown = document.getElementById("user-menu-dropdown");

                function setTransitions(enabled) {
                    const value = enabled ? "all 0.3s ease-in-out" : "none";
                    if (sidebar)
                        sidebar.style.transition = value;
                    if (mainContent)
                        mainContent.style.transition = enabled ? "margin-left 0.3s ease-in-out" : "none";
                }

                let isSidebarCollapsed =
                        localStorage.getItem("sidebarCollapsed") === "true";

                function toggleDesktopSidebar(collapse) {
                    isSidebarCollapsed = collapse;
                    if (sidebar)
                        sidebar.classList.toggle("is-collapsed", isSidebarCollapsed);
                    if (mainContent)
                        mainContent.classList.toggle("sidebar-collapsed", isSidebarCollapsed);
                    localStorage.setItem("sidebarCollapsed", isSidebarCollapsed);
                }

                if (sidebarToggle && sidebar && mainContent) {
                    setTransitions(false);
                    toggleDesktopSidebar(isSidebarCollapsed);

                    setTimeout(() => {
                        setTransitions(true);
                    }, 100);
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
                            if (arrow)
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
                }, {
                    root: null,
                    threshold: 0.1
                }
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
                        const isClickInsideButton = userMenuButton ? userMenuButton.contains(e.target) : false;
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

                updateTotals();
            });
        </script>
    </body>
</html>

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

            .line-items-table {
                width: 100%;
                border-collapse: collapse;
                table-layout: fixed;
                min-width: 600px;
            }
            .line-items-table th,
            .line-items-table td {
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
                        <div class="mt-1.5 space-y-1 pl-7 sidebar-submenu">
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
                                href="${pageContext.request.contextPath}/create-shipment"
                                class="block px-3 py-2 rounded-lg text-sm font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-900"
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
                    class="flex flex-col md:flex-row justify-between items-start md:items-center mb-6 gap-4"
                    >
                    <h1 class="text-3xl font-bold text-gray-900">
                        Tạo Phiếu mua hàng
                    </h1>
                </div>

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
                                                value="${not empty poHeader? poHeader.po_code : po_code}"
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
                                                    <option value="${sl.supplier_id}" ${not empty poHeader and poHeader.supplier_name == sl.supplier_name? 'selected' : ''}>${sl.supplier_name}</option>
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
                                            >${not empty poHeader? poHeader.note : ''}</textarea>
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
                                <a  href="${pageContext.request.contextPath}/inbound/purchase-orders"
                                    class="btn-cancel bg-gray-200 text-gray-800 py-2 px-5 rounded-lg hover:bg-gray-300 font-semibold"
                                    >
                                    Hủy bỏ
                                </a>
                                <button 
                                    type="button" 
                                    class="btn-cancel bg-gray-200 text-gray-800 py-2 px-5 rounded-lg hover:bg-gray-300 font-semibold"
                                    >
                                    Lưu nháp
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

        <script>
            const pList = [
            <c:forEach var="pl" items="${pList}" varStatus="status">
            { id: '${pl.product_id}', sku: '${pl.sku_code}' }<c:if test="${not status.last}">,</c:if>
            </c:forEach>
            ];

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
                    sidebar.style.transition = value;
                    mainContent.style.transition = enabled ? "margin-left 0.3s ease-in-out" : "none";
                }

                let isSidebarCollapsed =
                        localStorage.getItem("sidebarCollapsed") === "true";

                function toggleDesktopSidebar(collapse) {
                    isSidebarCollapsed = collapse;
                    sidebar.classList.toggle("is-collapsed", isSidebarCollapsed);
                    mainContent.classList.toggle("sidebar-collapsed", isSidebarCollapsed);
                    localStorage.setItem("sidebarCollapsed", isSidebarCollapsed);
                }

                if (sidebarToggle) {
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

        <script>
            (function () {
                const tableBody = document.getElementById("line-items-body");
                if (!tableBody)
                    return;

                // Định dạng tiền tệ VND
                const currencyFormatter = new Intl.NumberFormat("vi-VN", {
                    style: "currency",
                    currency: "VND"
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
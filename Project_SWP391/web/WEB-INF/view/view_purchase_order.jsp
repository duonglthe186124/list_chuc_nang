<%-- 
    Document   : view_purchase_order
    Created on : Nov 1, 2025, 5:36:53 PM
    Author     : ASUS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi" class="scroll-smooth">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Quản lý Phiếu mua hàng - WMS Pro</title>
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
                                class="block px-3 py-2 rounded-lg text-sm font-medium text-indigo-700 bg-indigo-50"
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
                <div class="flex flex-wrap justify-between items-center mb-6 gap-4">
                    <div>
                        <h1 class="text-3xl font-bold text-gray-900">
                            Phiếu mua hàng #${poheader.po_code}
                        </h1>
                        <p class="text-sm text-gray-500 mt-1">
                            Quản lý chi tiết phiếu mua hàng và các hành động liên quan.
                        </p>
                    </div>
                    <div id="po-status">
                        <span
                            class="px-4 py-1.5 text-sm font-semibold rounded-full bg-blue-100 text-blue-800"
                            >${poheader.status}</span
                        >
                    </div>
                </div>

                <div class="space-y-8">
                    <div class="border border-gray-200 rounded-lg shadow-sm">
                        <div class="px-6 py-5 bg-gray-50 rounded-t-lg">
                            <h2 class="text-lg font-semibold text-gray-900">
                                Thông tin chung & Tổng hợp
                            </h2>
                        </div>
                        <div class="p-6 grid grid-cols-1 lg:grid-cols-3 gap-x-8 gap-y-6">
                            <dl class="space-y-4 col-span-1">
                                <div>
                                    <dt class="text-sm font-semibold text-gray-600">
                                        Mã phiếu (PO No.)
                                    </dt>
                                    <dd class="mt-1 text-sm text-gray-900">${poheader.po_code}</dd>
                                </div>
                                <div>
                                    <dt class="text-sm font-semibold text-gray-600">
                                        Trạng thái
                                    </dt>
                                    <dd id="status" class="mt-1">
                                        <span
                                            class="px-2.5 py-0.5 text-xs font-medium rounded-full bg-blue-100 text-blue-800"
                                            >${poheader.status}</span
                                        >
                                    </dd>
                                </div>
                                <div>
                                    <dt class="text-sm font-semibold text-gray-600">
                                        Nhà cung cấp
                                    </dt>
                                    <dd
                                        class="mt-1 text-sm font-medium text-indigo-600 hover:underline cursor-pointer"
                                        >
                                        ${poheader.supplier_name}
                                    </dd>
                                </div>
                            </dl>

                            <dl class="space-y-4 col-span-1">
                                <div>
                                    <dt class="text-sm font-semibold text-gray-600">Ngày tạo</dt>
                                    <dd class="mt-1 text-sm text-gray-900">${poheader.created_at}</dd>
                                </div>
                                <div>
                                    <dt class="text-sm font-semibold text-gray-600">Người tạo</dt>
                                    <dd class="mt-1 text-sm text-gray-900">
                                        ${poheader.created_by}
                                    </dd>
                                </div>
                                <div>
                                    <dt class="text-sm font-semibold text-gray-600">Ghi chú</dt>
                                    <dd class="mt-1 text-sm text-gray-900">
                                        ${poheader.note}
                                    </dd>
                                </div>
                            </dl>

                            <div
                                class="col-span-1 lg:border-l lg:pl-8 border-gray-200 pt-4 lg:pt-0"
                                >
                                <h3 class="text-base font-semibold text-gray-900 mb-4">
                                    Tổng hợp thanh toán
                                </h3>
                                <dl class="space-y-3">
                                    <div class="flex justify-between items-center">
                                        <dt class="text-sm font-semibold text-gray-600">
                                            Tổng phụ (Subtotal)
                                        </dt>
                                        <dd class="text-sm font-medium text-gray-900">
                                            ${poheader.total_amount} VND
                                        </dd>
                                    </div>
                                    <div class="flex justify-between items-center border-t pt-3">
                                        <dt class="text-base font-semibold text-gray-900">
                                            Tổng cộng (Grand Total)
                                        </dt>
                                        <dd class="text-base font-semibold text-indigo-600">
                                            ${poheader.total_amount} VND
                                        </dd>
                                    </div>
                                </dl>
                            </div>
                        </div>
                    </div>
                    <div class="border border-gray-200 rounded-lg shadow-sm">
                        <div class="px-6 py-5 bg-gray-50 rounded-t-lg">
                            <h2 class="text-lg font-semibold text-gray-900">
                                Danh sách hàng hoá
                            </h2>
                        </div>
                        <div class="overflow-x-auto">
                            <table class="min-w-full divide-y divide-gray-200">
                                <thead class="bg-gray-100">
                                    <tr>
                                        <th
                                            scope="col"
                                            class="pl-6 pr-3 py-3 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider w-12"
                                            >
                                            STT
                                        </th>
                                        <th
                                            scope="col"
                                            class="px-6 py-3 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider"
                                            >
                                            Sản phẩm
                                        </th>
                                        <th
                                            scope="col"
                                            class="px-6 py-3 text-right text-xs font-semibold text-gray-600 uppercase tracking-wider"
                                            >
                                            Qty Đặt
                                        </th>
                                        <th
                                            scope="col"
                                            class="px-6 py-3 text-right text-xs font-semibold text-gray-600 uppercase tracking-wider"
                                            >
                                            Qty Đã nhận
                                        </th>
                                        <th
                                            scope="col"
                                            class="px-6 py-3 text-right text-xs font-semibold text-gray-600 uppercase tracking-wider"
                                            >
                                            Qty Còn lại
                                        </th>
                                        <th
                                            scope="col"
                                            class="px-6 py-3 text-right text-xs font-semibold text-gray-600 uppercase tracking-wider"
                                            >
                                            Đơn giá
                                        </th>
                                        <th
                                            scope="col"
                                            class="px-6 py-3 text-right text-xs font-semibold text-gray-600 uppercase tracking-wider"
                                            >
                                            Thành tiền
                                        </th>
                                        <th
                                            scope="col"
                                            class="px-6 py-3 text-left text-xs font-semibold text-gray-600 uppercase tracking-wider"
                                            >
                                            Trạng thái
                                        </th>
                                    </tr>
                                </thead>
                                <tbody id="table-body" class="bg-white divide-y divide-gray-200">
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div id="nav-btn" class="pt-6 flex flex-wrap justify-end gap-3">
                        <a
                            href="${pageContext.request.contextPath}/inbound/purchase-orders"
                            class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                            >
                            Quay lại
                        </a>
                        <button
                            type="button"
                            class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                            >
                            In/Export
                        </button>
                        <button
                            type="button"
                            class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500"
                            >
                            Huỷ phiếu
                        </button>
                        <button
                            type="button"
                            class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                            >
                            Tạo phiếu nhập kho
                        </button>
                    </div>
                </div>
            </main>
        </div>

        <script>
            const poStatus = document.getElementById("po-status");
            const headstatus = document.getElementById("status");
            let status = "${poheader.status}";

            function poBadge(status) {
                let colorClasses = '';
                switch (status) {
                    case "DRAFT":
                        colorClasses = "bg-gray-100 text-gray-800";
                        break;
                    case "PENDING":
                        colorClasses = "bg-yellow-100 text-yellow-800";
                        break;
                    case "PARTIAL":
                        colorClasses = "bg-blue-100 text-blue-800";
                        break;
                    case "COMPLETED":
                        colorClasses = "bg-green-100 text-green-800";
                        break;
                    case "CANCELLED":
                        colorClasses = "bg-red-50 text-red-800";
                        break;
                    default:
                        colorClasses = "bg-gray-100 text-gray-800";
                }

                poStatus.innerHTML = '<span class="px-4 py-1.5 text-sm font-semibold rounded-full ' + colorClasses + '">' + status + '</span>';
                headstatus.innerHTML = '<span class="px-2.5 py-0.5 text-xs font-medium rounded-full ' + colorClasses + '">' + status + '</span>';
            }

            const order_lines = [];
            <c:forEach var="l" items="${poLines}">
            order_lines.push({
                product_name: "${l.product_name}",
                sku_code: "${l.sku_code}",
                unit_price: ${l.unit_price},
                qty_ordered: ${l.qty_ordered},
                qty_received: ${l.qty_received},
                qty_remaining: ${l.qty_remaining},
                total_line: ${l.total_line}
            });
            </c:forEach>

            function formatCurrency(amount) {
                return new Intl.NumberFormat("vi-VN", {
                    style: "currency",
                    currency: "VND"
                }).format(amount);
            }

            function createPOLineBadge(remaining, ordered) {
                let badge = "";
                if (remaining === 0) {
                    badge = '<span class="px-2.5 py-0.5 text-xs font-medium rounded-full bg-green-100 text-green-800">Nhận đủ</span>';
                } else if (0 < remaining && remaining < ordered) {
                    badge = '<span class="px-2.5 py-0.5 text-xs font-medium rounded-full bg-yellow-100 text-yellow-800">Nhận 1 phần</span>';
                } else
                    badge = '<span class="px-2.5 py-0.5 text-xs font-medium rounded-full bg-gray-100 text-gray-800">Chưa nhận</span>';

                return badge;
            }

            function renderTableLine() {
                const tableBody = document.getElementById("table-body");
                const data = order_lines;
                let rowsHTML = "";

                if (Array.isArray(data) && data.length > 0) {
                    data.forEach((row, index) => {
                        const rowNumber = index + 1;

                        rowsHTML += '\n<tr>\n' +
                                '<td class="pl-6 pr-3 py-4 whitespace-nowrap text-sm text-gray-500">' + rowNumber + '</td>\n' +
                                '<td class="px-6 py-4 whitespace-nowrap">' +
                                '<div class="text-sm font-medium text-gray-900">' + row.product_name + '</div>' +
                                '<div class="text-xs text-gray-500">' + row.sku_code + '</div>' +
                                '</td>\n' +
                                '<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-right">' + row.qty_ordered + '</td>\n' +
                                '<td class="px-6 py-4 whitespace-nowrap text-sm text-green-600 text-right">' + row.qty_received + '</td>\n' +
                                '<td class="px-6 py-4 whitespace-nowrap text-sm text-red-600 text-right font-semibold">' + row.qty_remaining + '</td>\n' +
                                '<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-right">' + formatCurrency(row.unit_price) + '</td>\n' +
                                '<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 font-medium text-right">' + formatCurrency(row.total_line) + '</td>\n' +
                                '<td class="px-6 py-4 whitespace-nowrap text-sm">' + createPOLineBadge(row.qty_remaining, row.qty_ordered) + '</td>\n' +
                                '</tr>';
                    });
                } else {
                    rowsHTML = '<tr><td colspan="9" class="px-6 py-4 text-center text-sm text-gray-500">No records found</td></tr>';
                }

                tableBody.innerHTML = rowsHTML;
            }

            document.addEventListener("DOMContentLoaded", () => {
                poBadge(status);
                renderTableLine();

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
    </body>
</html>

<%-- 
    Document   : purchase_orders
    Created on : Nov 1, 2025, 2:27:04 PM
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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

            <form id="form" action="${pageContext.request.contextPath}/inbound/purchase-orders">
                <main
                    id="main-content"
                    class="flex-1 ml-64 bg-white p-6 lg:p-8 transition-all duration-300 ease-in-out"
                    >
                    <div
                        class="flex flex-col md:flex-row justify-between items-start md:items-center mb-6 gap-4"
                        >
                        <h1 class="text-3xl font-bold text-gray-900">
                            Danh sách Phiếu mua hàng (Purchase Order)
                        </h1>
                        <a
                            href="${pageContext.request.contextPath}/inbound/createpo"
                            class="w-full md:w-auto flex-shrink-0 flex items-center justify-center gap-2 bg-green-600 text-white px-5 py-2.5 rounded-lg font-medium hover:bg-green-700 transition-colors"
                            >
                            <svg
                                class="h-5 w-5"
                                xmlns="http://www.w3.org/2000/svg"
                                viewBox="0 0 20 20"
                                fill="currentColor"
                                >
                            <path
                                d="M10.75 4.75a.75.75 0 0 0-1.5 0v4.5h-4.5a.75.75 0 0 0 0 1.5h4.5v4.5a.75.75 0 0 0 1.5 0v-4.5h4.5a.75.75 0 0 0 0-1.5h-4.5v-4.5Z"
                                />
                            </svg>
                            <span>Thêm sản phẩm mới</span>
                        </a>
                    </div>

                    <div
                        class="flex flex-col md:flex-row justify-between items-start md:items-center mb-6 gap-4 w-full"
                        >
                        <div class="flex-shrink-0 w-full md:w-auto">
                            <div class="relative flex w-full sm:w-128 flex-shrink-0">
                                <label for="search" class="sr-only">Tìm kiếm</label>
                                <input
                                    type="text"
                                    id="search"
                                    name="search"
                                    value="${not empty param.search ? search : ''}"
                                    placeholder="Tìm kiếm mã hoá đơn, NCC"
                                    class="w-full pl-4 pr-10 py-2 border border-r-0 border-gray-300 rounded-l-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-opacity-50"
                                    />
                                <button
                                    type="submit"
                                    class="bg-indigo-600 text-white px-3 py-2 border border-indigo-600 rounded-r-lg hover:bg-indigo-700 transition-colors flex-shrink-0"
                                    >
                                    <svg
                                        class="h-5 w-5"
                                        xmlns="http://www.w3.org/2000/svg"
                                        viewBox="0 0 20 20"
                                        fill="currentColor"
                                        >
                                    <path
                                        fill-rule="evenodd"
                                        d="M9 3.5a5.5 5.5 0 1 0 0 11a5.5 5.5 0 0 0 0-11ZM2 9a7 7 0 1 1 12.452 4.398l3.754 3.754a.75.75 0 1 1-1.06 1.06l-3.754-3.754A7 7 0 0 1 2 9Z"
                                        clip-rule="evenodd"
                                        />
                                    </svg>
                                    <span class="sr-only">Tìm kiếm</span>
                                </button>
                            </div>
                        </div>

                        <div
                            class="flex flex-wrap items-center justify-start md:justify-end gap-4 flex-shrink-0 w-full md:w-auto"
                            >
                            <div class="flex items-center gap-0 flex-shrink-0">
                                <label
                                    for="status-filter"
                                    class="text-sm font-medium text-gray-700 whitespace-nowrap mr-2"
                                    >Trạng thái:</label
                                >
                                <select
                                    id="status-filter"
                                    name="status"
                                    class="px-3 py-2 border border-gray-300 rounded-l-lg text-gray-700 focus:outline-none focus:ring-2 focus:ring-indigo-500"
                                    >
                                    <option value="" ${empty param.status or param.status == ""? 'selected' : ''}>Tất cả</option>
                                    <option value="Confirm" ${param.status == "Confirm" ? 'selected' : ''}>Confirm</option>
                                    <option value="Pending" ${param.status == "Pending" ? 'selected' : ''}>Pending</option>
                                    <option value="Partial" ${param.status == "Partial" ? 'selected' : ''}>Partial</option>
                                    <option value="Completed" ${param.status == "Completed" ? 'selected' : ''}>Complete</option>
                                    <option value="Cancelled" ${param.status == "Cancelled" ? 'selected' : ''}>Cancelled</option>
                                </select>
                                <button
                                    type="submit"
                                    class="px-3 py-2 text-sm font-medium rounded-r-lg text-white bg-indigo-600 border border-indigo-600 hover:bg-indigo-700 transition-colors"
                                    >
                                    Áp dụng
                                </button>
                            </div>

                            <div class="flex items-center gap-2 flex-shrink-0">
                                <label
                                    for="entries-control"
                                    class="text-sm font-medium text-gray-700 whitespace-nowrap"
                                    >Hiển thị:</label
                                >
                                <select
                                    id="entries-control"
                                    name="pageSize"
                                    onchange="this.form.submit()"
                                    class="w-full sm:w-auto px-3 py-2 border border-gray-300 rounded-lg text-gray-700 focus:outline-none focus:ring-2 focus:ring-indigo-500"
                                    >
                                    <option value="10" ${param.pageSize == 10 ? 'selected' : ''}>10 mục</option>
                                    <option value="20" ${param.pageSize == 20 ? 'selected' : ''}>20 mục</option>
                                    <option value="50" ${param.pageSize == 50 ? 'selected' : ''}>50 mục</option>
                                    <option value="100" ${param.pageSize == 100 ? 'selected' : ''}>100 mục</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="overflow-x-auto border border-gray-200 rounded-lg">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th scope="col" class="px-3 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        STT
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Mã phiếu
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Nhà cung cấp
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Nhận / Hoá đơn
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Tổng tiền
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Người tạo
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Ngày tạo
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Trạng thái
                                    </th>
                                    <th scope="col" class="relative px-6 py-3">
                                        <span class="sr-only">Hành động</span> <span class="text-xs font-medium text-gray-500 uppercase tracking-wider">Hành động</span>
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="table-body" class="bg-white divide-y divide-gray-200">
                            </tbody>
                        </table>
                    </div>
                    <div
                        id="pagination-container"
                        class="flex items-center justify-between border-t border-gray-200 bg-white px-4 py-3 sm:px-6 rounded-b-lg"
                        >
                        <div class="mb-3 sm:mb-0">
                            <p id="result-info" class="text-sm text-gray-700"></p>
                        </div>

                        <div class="flex items-center gap-4">
                            <nav
                                id="page-nav"
                                class="isolate inline-flex -space-x-px rounded-md shadow-sm"
                                aria-label="Pagination"
                                >
                            </nav>

                            <div class="flex items-center gap-1">
                                <label for="go-to-page" class="sr-only">Trang số</label>
                                <input
                                    type="number"
                                    id="page-input"
                                    name="pageInput"
                                    placeholder="Trang"
                                    min="1"
                                    value="1"
                                    class="w-16 px-3 py-2 border border-gray-300 rounded-md text-sm text-center focus:outline-none focus:ring-2 focus:ring-indigo-500"
                                    />
                                <button
                                    type="button"
                                    id="go-to-button"
                                    class="px-3 py-2 text-sm font-medium rounded-md text-white bg-indigo-600 border border-indigo-600 hover:bg-indigo-700 transition-colors focus:z-20 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
                                    >
                                    Đi đến
                                </button>
                            </div>
                        </div>
                    </div>
                </main>
            </form>
        </div>

        <script>
            const purchase_orders = [];
            <c:forEach var="l" items="${list}">
            purchase_orders.push({
                id: ${l.po_id},
                poNo: "${l.po_code}",
                supplier: "${l.supplier}",
                reveived: ${l.received},
                total: ${l.total},
                totalAmount: ${l.total_amount},
                createdBy: "${l.created_by}",
                createdAt: "${l.created_at}",
                status: "${l.status}"
            });
            </c:forEach>

            function formatCurreny(totalAmount) {
                return new Intl.NumberFormat("vi-VN", {
                    style: "currency",
                    currency: "VND"
                }).format(totalAmount);
            }

            function createStatusBadge(status) {
                let colorClasses = "";
                switch (status) {
                    case "CONFIRM":
                        colorClasses = "bg-green-50 text-green-800";
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

                return '<span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full ' + colorClasses + '">' + status + '</span>';
            }

            function actionBadge(id, status) {
                let badge = "";
                if (status === 'PENDING') {
                    badge = '<a href="${pageContext.request.contextPath}/inbound/purchase-orders/view?id=' + id + '" \n\
                               class="inline-flex items-center px-3 py-1 border border-indigo-300 text-xs font-medium rounded-md shadow-sm text-black-700 hover:bg-indigo-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">\n\
                                    Chi tiết\n\
                            </a>\n'
                            + '<a href="${pageContext.request.contextPath}/inbound/purchase-orders/cancel?id=' + id + '" \n\
                                class="inline-flex items-center px-3 py-1 border border-red-300 text-xs font-medium rounded-md text-red-700 bg-white hover:bg-red-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500" \n\
                                onclick="return confirm(\'Bạn có chắc chắn muốn huỷ phiếu mua hàng này không?\')">\n\
                                    Huỷ đơn\n\
                            </a>';
                } else {
                    badge = '<a href="${pageContext.request.contextPath}/inbound/purchase-orders/view?id=' + id + '" \n\
                               class="inline-flex items-center px-3 py-1 border border-indigo-300 text-xs font-medium rounded-md shadow-sm text-black-700 hover:bg-indigo-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">\n\
                                    Chi tiết\n\
                            </a>\n';
                }
                return badge;
            }

            function renderTable() {
                const tableBody = document.getElementById("table-body");
                const data = purchase_orders;
                const start = (currentPage - 1) * pageSize;
                let rowsHTML = "";

                if (Array.isArray(data) && data.length > 0) {
                    data.forEach((row, index) => {
                        const rowNumber = start + index + 1;

                        rowsHTML += '\n<tr>\n' +
                                '<td class="px-3 py-4 whitespace-nowrap text-sm font-medium text-gray-900">' + rowNumber + '</td>\n' +
                                '<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">' + row.poNo + '</td>\n' +
                                '<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">' + row.supplier + '</td>\n' +
                                '<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">' + row.reveived + ' / ' + row.total + '</td>\n' +
                                '<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 text-right">' + formatCurreny(row.totalAmount) + '</td>\n' +
                                '<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">' + row.createdBy + '</td>\n' +
                                '<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">' + row.createdAt + '</td>\n' +
                                '<td class="px-6 py-4 whitespace-nowrap text-sm">' + createStatusBadge(row.status) + '</td>\n' +
                                '<td class="px-6 py-4 whitespace-nowrap text-sm font-medium">' +
                                '<div class="flex items-center space-x-2">' + actionBadge(row.id, row.status) + '</div>' +
                                '</td>' +
                                '</tr>';
                    });
                } else {
                    rowsHTML = '<tr><td colspan="9" class="px-6 py-4 text-center text-sm text-gray-500">No records found</td></tr>';
                }

                tableBody.innerHTML = rowsHTML;
            }

            let currentPage = ${pageInput != null ? pageInput : 1};
            let pageSize = ${param.pageSize != null ? param.pageSize : 10};
            let totalItems = ${totalItems != null ? totalItems : 0};
            let totalPages = Math.ceil(totalItems / pageSize);

            const form = document.getElementById('form');
            const resultInfo = document.getElementById('result-info');
            const pageNav = document.getElementById('page-nav');
            const pageInput = document.getElementById('page-input');
            const goToButton = document.getElementById('go-to-button');

            function updateResultInfo() {
                const start = (currentPage - 1) * pageSize + 1;
                const end = Math.min(currentPage * pageSize, totalItems);
                resultInfo.innerHTML = "Hiển thị \n" +
                        '<span class="font - medium"> ' + start + '</span> ' +
                        'đến ' +
                        '<span class="font - medium"> ' + end + '</span> ' +
                        'trong ' +
                        '<span class="font - medium"> ' + totalItems + '</span> ' +
                        'kết quả';
            }

            function createPageButton(content, page, active, disabled) {
                let classes = "relative inline-flex items-center px-4 py-2 text-sm font-semibold ring-1 ring-inset ring-gray-300 transition-colors";
                let actionAttr = '';
                let nameAttr = '';

                if (page !== 'ellipsis') {
                    actionAttr = `data-page="` + page + `"`;
                    nameAttr = `name="pageInput"`;
                }

                if (active) {
                    classes += " active";
                    classes += " text-white bg-indigo-600 focus:z-20 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600";
                } else if (disabled) {
                    classes += " text-gray-400 bg-gray-100 disabled";
                } else if (page === 'ellipsis') {
                    classes += " text-gray-700 bg-white pointer-events-none cursor-default";
                } else {
                    classes += " text-gray-900 bg-white hover:bg-gray-50 focus:z-20 focus:outline-offset-0 cursor-pointer page-link";
                }

                if (page === 'prev') {
                    classes = classes.replace('px-4', 'px-2 rounded-l-md');
                    content = `
                    <span class="sr-only">Trang trước</span>
                    <svg class="h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M12.79 5.23a.75.75 0 0 1-.02 1.06L8.832 10l3.938 3.71a.75.75 0 1 1-1.04 1.08l-4.5-4.25a.75.75 0 0 1 0-1.08l4.5-4.25a.75.75 0 0 1 1.06.02Z" clip-rule="evenodd" />
                    </svg>
                `;
                } else if (page === 'next') {
                    classes = classes.replace('px-4', 'px-2 rounded-r-md');
                    content = `
                    <span class="sr-only">Trang sau</span>
                    <svg class="h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M7.21 14.77a.75.75 0 0 1 .02-1.06L11.168 10 7.23 6.29a.75.75 0 1 1 1.04-1.08l4.5 4.25a.75.75 0 0 1 0 1.08l-4.5 4.25a.75.75 0 0 1-1.06-.02Z" clip-rule="evenodd" />
                    </svg>
                `;
                }

                return '<a class="' + classes + '" ' + actionAttr + ' ' + nameAttr + '>' + content + '</a>';
            }


            function renderPagination() {
                let html = '';

                const prevDisabled = currentPage === 1;
                html += createPageButton('', 'prev', false, prevDisabled);

                let pages = [];
                const pageRange = 2;

                if (totalPages > 0)
                    pages.push(1);
                for (let i = currentPage - pageRange; i <= currentPage + pageRange; i++) {
                    if (i > 1 && i < totalPages) {
                        pages.push(i);
                    }
                }

                if (totalPages > 1)
                    pages.push(totalPages);
                pages = [...new Set(pages)].sort((a, b) => a - b);

                let lastPage = 0;
                for (const page of pages) {
                    if (page > lastPage + 1) {
                        html += createPageButton('...', 'ellipsis', false, false);
                    }

                    const active = page === currentPage;
                    html += createPageButton(page.toString(), page, active, false);
                    lastPage = page;
                }

                const nextDisabled = currentPage === totalPages;
                html += createPageButton('', 'next', false, nextDisabled);

                pageNav.innerHTML = html;
                pageInput.value = currentPage;

                updateResultInfo();
            }

            function changePage(newPage) {
                if (newPage >= 1 && newPage <= totalPages && newPage !== currentPage) {
                    currentPage = newPage;
                    renderPagination();
                    form.submit();
                }
            }

            pageNav.addEventListener('click', (e) => {
                const target = e.target.closest('a');
                if (!target || target.classList.contains('disabled') || target.hasAttribute('aria-current')) {
                    return;
                }

                const pageType = target.getAttribute('data-page');

                if (pageType === 'prev') {
                    changePage(currentPage - 1);
                } else if (pageType === 'next') {
                    changePage(currentPage + 1);
                } else if (pageType) {
                    const newPage = parseInt(pageType, 10);
                    changePage(newPage);
                }
            });

            const Toast = Swal.mixin({
                toast: true,
                position: 'top-start',
                showConfirmButton: false,
                showCloseButton: true,
                timer: 3000,
                timerProgressBar: true,

                customClass: {
                    popup: 'font-inter text-sm shadow-lg',
                    closeButton: 'text-current hover:text-opacity-80'
                },

                didOpen: (toast) => {
                    toast.addEventListener('mouseenter', Swal.stopTimer);
                    toast.addEventListener('mouseleave', Swal.resumeTimer);
                }
            });

            goToButton.addEventListener('click', () => {
                const pageValue = parseInt(pageInput.value.trim(), 10);
                const isValid = !isNaN(pageValue) && pageValue >= 1 && pageValue <= totalPages;

                if (isValid) {
                    changePage(pageValue);
                } else {
                    let errorMessage = 'Số trang không hợp lệ.';

                    if (totalPages > 0) {
                        errorMessage = 'Vui lòng nhập số trang từ 1 đến ' + totalPages + '.';
                        pageInput.value = currentPage;
                    } else {
                        errorMessage = 'Không có dữ liệu để hiển thị.';
                        pageInput.value = 1;
                    }

                    Toast.fire({
                        icon: 'error',
                        title: errorMessage,
                        customClass: {
                            popup: 'bg-red-50 text-red-800'
                        }
                    });
                }
            });

            document.addEventListener("DOMContentLoaded", () => {
                renderTable();
                if (totalItems !== 0)
                    renderPagination();

                const sidebar = document.getElementById("admin-sidebar");
                const mainContent = document.getElementById("main-content");
                const sidebarToggle = document.getElementById("sidebar-toggle");
                const submenuButtons = document.querySelectorAll(
                        "#admin-sidebar nav > div > button"
                        );
                const userMenuButton = document.getElementById("user-menu-button");
                const userMenuDropdown = document.getElementById("user-menu-dropdown");

            <c:if test="${not empty successMessage}">
                Toast.fire({
                    icon: 'success',
                    title: '${successMessage}',
                    customClass: {
                        popup: 'bg-green-50 text-green-800'
                    }
                });
            </c:if>

            <c:if test="${not empty errorMessage}">
                Toast.fire({
                    icon: 'error',
                    title: '${errorMessage}',
                    customClass: {
                        popup: 'bg-red-50 text-red-800'
                    }
                });
            </c:if>

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

<%-- 
    Document   : inbound_dashboard
    Created on : Oct 30, 2025, 3:22:42 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Dashboard - WMS Pro</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
            rel="stylesheet"
            />
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
                width: calc(100% - 16rem);
            }
            #main-content.sidebar-collapsed {
                margin-left: 5rem;
                width: calc(100% - 5rem);
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

                    <div class="relative" id = "user-menu-container">
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
                        class="flex items-center w-full gap-3 px-3 py-2.5 rounded-lg text-sm font-semibold bg-indigo-100 text-indigo-700 sidebar-item-button"
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
                renderChart("week");

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

                document.querySelectorAll(".period-selector").forEach((button) => {
                    button.addEventListener("click", function () {
                        const period = this.getAttribute("data-period");

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

                        renderChart(period);
                    });
                });
            });
        </script>
    </body>
</html>


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
        <title>Chi tiết phiếu nhập kho - WMS Pro</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
            rel="stylesheet"
            />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/view_transaction.css"/>

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
                        <div class="mt-1.5 space-y-1 pl-7 sidebar-submenu">
                            <a
                                href="${pageContext.request.contextPath}/inbound/transactions"
                                class="block px-3 py-2 rounded-lg text-sm font-medium text-indigo-700 bg-indigo-50"
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
                            d="M5.25 4.5l7.5 7.5-7.5 7.5"
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
                <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-6 gap-4">
                    <h1 class="text-3xl font-bold text-gray-900">
                        Chi tiết phiếu nhập kho
                    </h1>
                </div>

                <div class="main-header" id="main-header">
                    <h3>
                        Phiếu nhập kho #
                        <span class="receipt-no">${view.receipt_no}</span>
                    </h3>
                </div>

                <div class="header-info">
                    <section class="header-card card">
                        <h4 class="block-title">Thông tin tổng quan</h4>
                        <div class="header-columns">
                            <div class="col">
                                <dl>
                                    <dt>Phiếu mua#</dt>
                                    <dd>${view.po_code}</dd>
                                    <dt>Người tạo</dt>
                                    <dd>${view.fullname} — ${view.employee_code}</dd>
                                    <dt>Nhà cung cấp</dt>
                                    <dd>${view.supplier_name}</dd>
                                    <dt>Ghi chú / Reason</dt>
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
                                    <dt>Ngày tạo hoá đơn</dt>
                                    <dd>${view.po_date}</dd>
                                    <dt>Được nhận ngày</dt>
                                    <dd>${view.received_at}</dd>
                                    <dt>Trạng thái</dt>
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
                                    <td class="right unit-price"><fmt:formatNumber value="${l.unit_price}" type="number" maxFractionDigits="2" /></td>
                                    <td class="right line-total"><fmt:formatNumber value="${l.qty_received * l.unit_price}" type="number" maxFractionDigits="2" /></td>
                                    <td class="center discrepancy">${l.qty_received - l.qty_expected}</td>
                                    <td class="center">${l.location}</td>
                                    <td class="small">${l.note}</td>
                                    <td class="center">
                                        <button class="btn small-btn toggle-serials">
                                            Xem đơn vị (${l.qty_received})
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
                        <a class="btn ghost" href="${pageContext.request.contextPath}/inbound/transactions">Quay lại</a>
                    </div>
                </section>
            </main>
        </div>

        <script>
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

                // Logic from view_transaction
                const statusEl = document.querySelector(".status");
                if (statusEl) {
                    const statusText = statusEl.textContent.trim().toLowerCase();
                    statusEl.classList.add("status-" + statusText);
                }

                function parseNumber(v) {
                    if (v === null || v === undefined) return 0;
                    const s = String(v).replace(/[, ]+/g, "");
                    const n = parseFloat(s);
                    return isNaN(n) ? 0 : n;
                }
                function formatMoney(v) {
                    return Number(v).toFixed(2);
                }

                function recalcLine(tr) {
                    const qtyExpected = parseNumber(tr.querySelector(".qty-expected")?.textContent);
                    const qtyReceived = parseNumber(tr.querySelector(".qty-received")?.textContent);
                    const unitPrice = parseNumber(tr.querySelector(".unit-price")?.textContent);
                    const lineTotal = qtyReceived * unitPrice;

                    const lineTotalEl = tr.querySelector(".line-total");
                    lineTotalEl.textContent = formatMoney(lineTotal);
                    const discrepancy = qtyReceived - qtyExpected;
                    const discEl = tr.querySelector(".discrepancy");
                    discEl.textContent = discrepancy > 0 ? "+" + discrepancy : discrepancy;
                    discEl.classList.remove("pos", "neg", "zero");
                    if (discrepancy === 0) discEl.classList.add("zero");
                    else if (discrepancy > 0) discEl.classList.add("pos");
                    else discEl.classList.add("neg");
                    return {qtyExpected, qtyReceived, lineTotal, discrepancy};
                }

                function recalcAll() {
                    const rows = Array.from(document.querySelectorAll("#lines-table tbody tr.line-row"));
                    let sumExpected = 0, sumReceived = 0, sumMoney = 0, rowsWithDisc = 0;

                    let lineNo = 1;

                    rows.forEach((tr) => {
                        const lineNoEl = tr.querySelector("td:first-child");
                        if (lineNoEl) lineNoEl.textContent = lineNo++;

                        const r = recalcLine(tr);
                        sumExpected += r.qtyExpected;
                        sumReceived += r.qtyReceived;
                        sumMoney += r.lineTotal;
                        if (r.discrepancy !== 0) rowsWithDisc++;
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
                        const tr = btn.closest("tr.line-row");
                        if (!tr) return;
                        const lineId = tr.dataset.lineId;

                        const serialsRow = document.querySelector('tr.serials-row[data-parent-line="' + lineId + '"]');

                        if (!serialsRow) return;
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

                recalcAll();
                window.receiptRecalc = recalcAll;
            });
        </script>
    </body>
</html>
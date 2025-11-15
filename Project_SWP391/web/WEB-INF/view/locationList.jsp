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
                margin-left: 250px;
            }
            #main-content.sidebar-collapsed {
                margin-left: 5rem;
            }

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

                    <a
                        href="${pageContext.request.contextPath}/warehouse/inventory"
                        class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors sidebar-item-button"
                        >
                        <svg class="h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M20.25 7.5l-.625 10.632a2.25 2.25 0 0 1-2.247 2.118H6.622a2.25 2.25 0 0 1-2.247-2.118L3.75 7.5M10.5 11.25h3M12 15V7.5m-6.75 4.5l.625 10.632a2.25 2.25 0 0 0 2.247 2.118h11.25a2.25 2.25 0 0 0 2.247-2.118l.625-10.632M3.75 7.5h16.5" /></svg>
                        <span class="sidebar-text">Danh sách sản phẩm</span>
                    </a>

                    <a
                        href="${pageContext.request.contextPath}/warehouse/inspections"
                        class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors sidebar-item-button"
                        >
                        <svg class="h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75 11.25 15 15 9.75M21 12c0 1.268-.63 2.4-1.593 3.068a3.745 3.745 0 0 1-1.043 3.296 3.745 3.745 0 0 1-3.296 1.043A3.745 3.745 0 0 1 12 21c-1.268 0-2.4-.63-3.068-1.593a3.746 3.746 0 0 1-3.296-1.043 3.745 3.745 0 0 1-1.043-3.296A3.745 3.745 0 0 1 3 12c0-1.268.63-2.4 1.593-3.068a3.745 3.745 0 0 1 1.043-3.296 3.746 3.746 0 0 1 3.296-1.043A3.745 3.745 0 0 1 12 3c1.268 0 2.4.63 3.068 1.593a3.746 3.746 0 0 1 3.296 1.043 3.746 3.746 0 0 1 1.043 3.296A3.745 3.745 0 0 1 21 12Z" /></svg>
                        <span class="sidebar-text">Kiểm định sản phẩm</span>
                    </a>

                    <a
                        href="${pageContext.request.contextPath}/warehouse/locations"
                        class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors sidebar-item-button"
                        >
                        <svg class="h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" /><path stroke-linecap="round" stroke-linejoin="round" d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1 1 15 0Z" /></svg>
                        <span class="sidebar-text">Vị trí kho hàng</span>
                    </a>
                    <div>
                        <button
                            type="button"
                            class="flex items-center justify-between w-full gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors sidebar-item-button"
                            >
                            <div class="flex items-center gap-3">
                                <%-- Icon Hàng trả (Return) --%>
                                <svg class="h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M9 15 3 9m0 0 6-6M3 9h12a6 6 0 0 1 0 12h-3" />
                                </svg>
                                <span class="sidebar-text">Hàng trả về</span>
                            </div>
                            <svg class="h-4 w-4 sidebar-arrow transition-transform" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M7.21 14.77a.75.75 0 0 1 .02-1.06L11.168 10 7.23 6.29a.75.75 0 1 1 1.04-1.08l4.5 4.25a.75.75 0 0 1 0 1.08l-4.5 4.25a.75.75 0 0 1-1.06-.02Z" clip-rule="evenodd" />
                            </svg>
                        </button>

                        <%-- Menu con --%>
                        <div class="mt-1.5 space-y-1 pl-7 sidebar-submenu hidden">
                            <a
                                href="${pageContext.request.contextPath}/warehouse/returnsList"
                                class="block px-3 py-2 rounded-lg text-sm font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-900"
                                >
                                <span class="sidebar-text">Lịch sử Trả hàng</span>
                            </a>
                            <a
                                href="${pageContext.request.contextPath}/warehouse/returns"
                                class="block px-3 py-2 rounded-lg text-sm font-medium text-gray-500 hover:bg-gray-100 hover:text-gray-900"
                                >
                                <span class="sidebar-text">Tạo Phiếu Trả</span>
                            </a>
                        </div>
                    </div>
                    <a
                        href="${pageContext.request.contextPath}/warehouse/transfer"
                        class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors sidebar-item-button"
                        >
                        <%-- Icon Điều chuyển (Switch) --%>
                        <svg class="h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M7.5 21 3 16.5m0 0L7.5 12M3 16.5h13.5m0-13.5L21 7.5m0 0L16.5 12M21 7.5H7.5" />
                        </svg>
                        <span class="sidebar-text">Điều chuyển kho</span>
                    </a>
                    <a
                        href="${pageContext.request.contextPath}/warehouse/history"
                        class="flex items-center gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors sidebar-item-button"
                        >
                        <%-- Icon Lịch sử (Clock) --%>
                        <svg class="h-5 w-5 flex-shrink-0" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 6v6h4.5m4.5 0a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z" />
                        </svg>
                        <span class="sidebar-text">Lịch sử Điều chỉnh</span>
                    </a>
                    <!-- Nút Thu gọn/Mở rộng (chỉ cho desktop) -->
                    <div class="py-3 px-3 border-t border-gray-200">
                        <button
                            id="sidebar-toggle"
                            class="flex items-center justify-center w-full gap-3 px-3 py-2.5 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-100 hover:text-gray-900 transition-colors sidebar-item-button"
                            >
                            <!-- Icon Thu gọn -->
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
                            <!-- Icon Mở rộng -->
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
                </nav>
            </aside>

            <main id="main-content" class="flex-1 overflow-x-hidden overflow-y-auto bg-gray-100 p-6">

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
            </main>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", () => {
                // --- CÁC BIẾN TOÀN CỤC ---
                const sidebar = document.getElementById("admin-sidebar");
                const mainContent = document.getElementById("main-content");
                const sidebarToggle = document.getElementById("sidebar-toggle");
                const submenuButtons = document.querySelectorAll(
                        "#admin-sidebar nav > div > button"
                        );
                // *** THÊM MỚI: Biến cho menu người dùng ***
                const userMenuButton = document.getElementById("user-menu-button");
                const userMenuDropdown = document.getElementById("user-menu-dropdown");

                // Biến trạng thái (lấy từ localStorage)
                let isSidebarCollapsed =
                        localStorage.getItem("sidebarCollapsed") === "true";

                // --- HÀM CHỨC NĂNG ---

                // Hàm Bật/Tắt Sidebar Desktop (Thu gọn)
                function toggleDesktopSidebar(collapse) {
                    isSidebarCollapsed = collapse;
                    sidebar.classList.toggle("is-collapsed", isSidebarCollapsed);
                    mainContent.classList.toggle("sidebar-collapsed", isSidebarCollapsed);
                    // Lưu trạng thái vào localStorage
                    localStorage.setItem("sidebarCollapsed", isSidebarCollapsed);
                }

                // --- KHỞI TẠO KHI TẢI TRANG ---

                // 1. Áp dụng trạng thái thu gọn đã lưu cho desktop
                if (sidebarToggle) {
                    toggleDesktopSidebar(isSidebarCollapsed);
                }

                // --- GẮN SỰ KIỆN ---

                // 1. Nút thu gọn/mở rộng Desktop
                if (sidebarToggle) {
                    sidebarToggle.addEventListener("click", () => {
                        toggleDesktopSidebar(!isSidebarCollapsed);
                    });
                }

                // 4. Các nút menu con (accordion)
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

                // 5. Xử lý hiệu ứng cuộn (giữ nguyên từ file cũ)
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

                // --- *** THÊM MỚI: Sự kiện cho User Menu Dropdown *** ---

                // 6. Bấm vào nút User Menu để Bật/Tắt
                if (userMenuButton && userMenuDropdown) {
                    userMenuButton.addEventListener("click", (e) => {
                        // Ngăn sự kiện click lan ra ngoài (xem sự kiện 7)
                        e.stopPropagation();

                        if (userMenuDropdown.classList.contains("hidden")) {
                            // --- Hiển thị Dropdown ---
                            userMenuDropdown.classList.remove("hidden");
                            // Đợi 1 frame để trình duyệt nhận ra sự thay đổi từ display:none
                            setTimeout(() => {
                                userMenuDropdown.classList.remove("opacity-0", "scale-95");
                                userMenuDropdown.classList.add("opacity-100", "scale-100");
                            }, 10);
                        } else {
                            // --- Ẩn Dropdown ---
                            userMenuDropdown.classList.remove("opacity-100", "scale-100");
                            userMenuDropdown.classList.add("opacity-0", "scale-95");
                            // Đợi transition (100ms) kết thúc rồi mới thêm class "hidden"
                            setTimeout(() => {
                                userMenuDropdown.classList.add("hidden");
                            }, 100); // 100ms này khớp với "duration-100" của Tailwind
                        }
                    });
                }

                // 7. Bấm ra ngoài để Tắt Dropdown
                document.documentElement.addEventListener("click", (e) => {
                    if (
                            userMenuDropdown &&
                            !userMenuDropdown.classList.contains("hidden")
                            ) {
                        const isClickInsideButton = userMenuButton.contains(e.target);
                        const isClickInsideDropdown = userMenuDropdown.contains(e.target);

                        // Nếu click không nằm trong nút VÀ không nằm trong dropdown
                        if (!isClickInsideButton && !isClickInsideDropdown) {
                            // --- Ẩn Dropdown ---
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


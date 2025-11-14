<%-- 
    Document   : home_page
    Created on : Sep 25, 2025, 8:00:31 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi" class="scroll-smooth">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>WMS Pro - Giải pháp Quản lý Kho Điện thoại Thông minh</title>
        <!-- Tải Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Tải Font Inter -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
            rel="stylesheet"
            />

        <style>
            /* Sử dụng font Inter làm mặc định */
            body {
                font-family: "Inter", sans-serif;
            }

            /* Lớp CSS cho hiệu ứng cuộn */
            .reveal-on-scroll {
                opacity: 0;
                transform: translateY(30px);
                transition: opacity 0.6s ease-out, transform 0.6s ease-out;
            }

            .reveal-on-scroll.is-visible {
                opacity: 1;
                transform: translateY(0);
            }
        </style>
    </head>
    <body class="bg-white text-gray-800">
        <!-- ===== HEADER ===== -->
        <header
            class="fixed top-0 left-0 right-0 z-50 bg-white/90 backdrop-blur-md shadow-sm"
            >
            <div class="container mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
                <div class="flex h-16 items-center justify-between">
                    <!-- Logo -->
                    <a
                        href="#"
                        class="flex items-center gap-2 text-2xl font-bold text-gray-900"
                        >
                        <!-- Icon SVG đơn giản -->
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

                    <!-- Menu Desktop -->
                    <nav class="hidden md:flex items-center space-x-6">
                        <c:choose>
                            <%-- 1. NẾU CHƯA ĐĂNG NHẬP (session "account" bị rỗng) --%>
                            <c:when test="${empty sessionScope.account}">
                                <a href="#gioi-thieu" class="font-medium text-gray-600 hover:text-indigo-600">Giới thiệu</a>
                                <a href="${pageContext.request.contextPath}/products" class="font-medium text-gray-600 hover:text-indigo-600">Sản phẩm</a>
                                <a href="#tinh-nang" class="font-medium text-gray-600 hover:text-indigo-600">Tính năng</a>
                                <a href="#lien-he" class="font-medium text-gray-600 hover:text-indigo-600">Liên hệ</a>
                                <a href="${pageContext.request.contextPath}/loginStaff"
                                   class="rounded-md bg-indigo-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-indigo-700">
                                    Đăng nhập
                                </a>
                            </c:when>
                            
                            <%-- 2. NẾU ĐÃ ĐĂNG NHẬP --%>
                            <c:otherwise>
                                <a href="#gioi-thieu" class="font-medium text-gray-600 hover:text-indigo-600">Giới thiệu</a>
                                <a href="${pageContext.request.contextPath}/products" class="font-medium text-gray-600 hover:text-indigo-600">Sản phẩm</a>
                                <a href="#tinh-nang" class="font-medium text-gray-600 hover:text-indigo-600">Tính năng</a>
                                <a href="#lien-he" class="font-medium text-gray-600 hover:text-indigo-600">Liên hệ</a>
                                
                                <div class="relative" id="user-menu-container">
                                    <button id="user-menu-button"
                                            class="flex items-center space-x-2 rounded-full p-1 hover:bg-gray-100 focus:outline-none">
                                        
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
                                        <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="m19.5 8.25-7.5 7.5-7.5-7.5" />
                                        </svg>
                                    </button>
                                    
                                    <div id="user-menu-dropdown"
                                         class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 hidden z-20">
                                        <a href="${pageContext.request.contextPath}/PersonalProfile"
                                           class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Hồ sơ</a>
                                        
                                        <c:if test="${sessionScope.account.role_id == 1}">
                                            <a href="${pageContext.request.contextPath}/account-management"
                                               class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                                Account Management
                                            </a>
                                        </c:if>
                                        <c:if test="${sessionScope.account.role_id == 8}">
                                            <a href="${pageContext.request.contextPath}/inbound/dashboard"
                                               class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                                Quản lý nhập/xuất
                                            </a>
                                        </c:if>   
                                        <c:if test="${sessionScope.account.role_id == 9}">
                                            <a href="${pageContext.request.contextPath}/inbound/transactions"
                                               class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                                Quản lý nhập hàng
                                            </a>
                                        </c:if>     
                                        <c:if test="${sessionScope.account.role_id == 10}">
                                            <a href="${pageContext.request.contextPath}/inbound/shipments"
                                               class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                                Quản lý xuất hàng
                                            </a>
                                        </c:if>    
                                        
                                        <div class="border-t border-gray-100 my-1"></div>
                                        <a href="${pageContext.request.contextPath}/logout"
                                           class="block px-4 py-2 text-sm text-red-600 hover:bg-gray-100">Đăng xuất</a>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </nav>

                    <!-- Nút Menu Mobile -->
                    <div class="md:hidden">
                        <button
                            id="mobile-menu-button"
                            class="inline-flex items-center justify-center rounded-md p-2 text-gray-400 hover:bg-gray-100 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-indigo-500"
                            >
                            <span class="sr-only">Mở menu chính</span>
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
                                d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5"
                                />
                            </svg>
                        </button>
                    </div>
                </div>

                <!-- Menu Mobile (Ẩn mặc định) -->
                <div id="mobile-menu" class="hidden md:hidden pb-4">
                    <div class="space-y-1">
                        <a
                            href="#gioi-thieu"
                            class="block rounded-md px-3 py-2 text-base font-medium text-gray-700 hover:bg-gray-50 hover:text-gray-900"
                            >Giới thiệu</a
                        >
                        <a
                            href="#tinh-nang"
                            class="block rounded-md px-3 py-2 text-base font-medium text-gray-700 hover:bg-gray-50 hover:text-gray-900"
                            >Tính năng</a
                        >
                        <a
                            href="#lien-he"
                            class="block rounded-md px-3 py-2 text-base font-medium text-gray-700 hover:bg-gray-50 hover:text-gray-900"
                            >Liên hệ</a
                        >
                        <a
                            href="${pageContext.request.contextPath}/loginStaff"
                            class="mt-2 block w-full rounded-md bg-indigo-600 px-4 py-2 text-center text-base font-medium text-white shadow-sm hover:bg-indigo-700"
                            >
                            Đăng nhập
                        </a>
                    </div>
                </div>
            </div>
        </header>

        <!-- ===== HERO SECTION ===== -->
        <main>
            <section
                class="relative bg-gray-900 pt-24 pb-20 md:pt-32 md:pb-28 text-white overflow-hidden"
                >
                <!-- Lớp phủ mờ + ảnh nền kho hàng -->
                <div class="absolute inset-0">
                    <img
                        src="https://images.unsplash.com/photo-1565610222536-02758f3589e5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1770&q=80"
                        alt="Kho hàng điện thoại"
                        class="h-full w-full object-cover opacity-30"
                        onerror="this.style.display='none'"
                        />
                    <div
                        class="absolute inset-0 bg-gradient-to-t from-gray-900 via-gray-900/80 to-transparent"
                        ></div>
                </div>

                <div
                    class="container mx-auto max-w-7xl px-4 sm:px-6 lg:px-8 relative z-10"
                    >
                    <div class="max-w-3xl text-center mx-auto">
                        <h1
                            class="text-4xl font-extrabold tracking-tight text-white sm:text-5xl md:text-6xl reveal-on-scroll"
                            >
                            Quản lý kho điện thoại chính xác từng IMEI
                        </h1>
                        <p
                            class="mt-6 text-lg max-w-2xl mx-auto text-gray-300 reveal-on-scroll"
                            style="transition-delay: 200ms"
                            >
                            WMS Pro giúp bạn kiểm soát toàn bộ quy trình xuất – nhập – tồn kho
                            điện thoại, quản lý theo IMEI/Serial, giảm thất thoát và tối ưu
                            tốc độ xử lý đơn hàng.
                        </p>
                        <div
                            class="mt-10 flex flex-col sm:flex-row gap-4 justify-center reveal-on-scroll"
                            style="transition-delay: 400ms"
                            >
                            <c:if test="${empty sessionScope.account}">
                                <a
                                    href="${pageContext.request.contextPath}/loginStaff"
                                    class="rounded-md border border-transparent bg-indigo-600 px-6 py-3 text-base font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 focus:ring-offset-gray-900"
                                    >
                                    Đăng nhập hệ thống
                                </a>
                            </c:if>
                            <a
                                href="#tinh-nang"
                                class="rounded-md border border-indigo-400 bg-indigo-500/10 px-6 py-3 text-base font-medium text-indigo-300 shadow-sm hover:bg-indigo-500/20"
                                >
                                Xem tính năng
                            </a>
                        </div>
                    </div>
                </div>
            </section>

            <!-- ===== GIỚI THIỆU (ABOUT) ===== -->
            <section id="gioi-thieu" class="py-16 md:py-24 bg-white">
                <div class="container mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
                    <div
                        class="grid grid-cols-1 md:grid-cols-2 gap-12 md:gap-16 items-center"
                        >
                        <div class="reveal-on-scroll">
                            <span
                                class="text-base font-semibold uppercase tracking-wide text-indigo-600"
                                >Giới thiệu WMS Pro</span
                            >
                            <h2
                                class="mt-2 text-3xl font-extrabold tracking-tight text-gray-900 sm:text-4xl"
                                >
                                Hệ thống chuyên biệt cho ngành hàng điện tử
                            </h2>
                            <p class="mt-4 text-lg text-gray-600">
                                WMS Pro là hệ thống quản lý kho toàn diện, cho phép theo dõi tồn
                                kho theo thời gian thực, quản lý nghiêm ngặt theo từng số
                                <strong>IMEI/Serial</strong>, tự động hóa quy trình nhập/xuất và
                                cung cấp báo cáo chính xác.
                            </p>
                            <p class="mt-4 text-lg text-gray-600">
                                Hệ thống phù hợp cho mọi quy mô: từ cửa hàng nhỏ lẻ, chuỗi cửa
                                hàng, đến nhà phân phối và trung tâm bảo hành lớn.
                            </p>
                        </div>
                        <div class="reveal-on-scroll" style="transition-delay: 200ms">
                            <img
                                src="https://placehold.co/600x450/e2e8f0/64748b?text=Giao+diện+Quản+lý+IMEI"
                                alt="Giao diện Dashboard WMS Pro"
                                class="rounded-lg shadow-xl aspect-video object-cover"
                                />
                        </div>
                    </div>
                </div>
            </section>

            <!-- ===== TÍNH NĂNG NỔI BẬT (FEATURES) ===== -->
            <section id="tinh-nang" class="py-16 md:py-24 bg-gray-50">
                <div class="container mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
                    <div class="text-center max-w-3xl mx-auto">
                        <h2
                            class="text-3xl font-extrabold tracking-tight text-gray-900 sm:text-4xl reveal-on-scroll"
                            >
                            Tính năng cốt lõi
                        </h2>
                        <p
                            class="mt-4 text-lg text-gray-600 reveal-on-scroll"
                            style="transition-delay: 150ms"
                            >
                            Được thiết kế để giải quyết các vấn đề đặc thù của kho hàng điện
                            thoại, điện tử.
                        </p>
                    </div>

                    <div
                        class="mt-16 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8"
                        >
                        <!-- Tính năng 1: Quản lý IMEI -->
                        <div class="bg-white p-6 rounded-lg shadow-lg reveal-on-scroll">
                            <div class="flex-shrink-0">
                                <div
                                    class="inline-flex h-12 w-12 items-center justify-center rounded-md bg-indigo-100 text-indigo-600"
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
                                        d="M3.75 4.875c0-1.036.84-1.875 1.875-1.875h13.5c1.036 0 1.875.84 1.875 1.875v14.25c0 1.036-.84 1.875-1.875 1.875H5.625c-1.036 0-1.875-.84-1.875-1.875V4.875ZM3.75 18.75h16.5M7.5 12h9m-9 3.75h9M7.5 6.75h3"
                                        />
                                    </svg>
                                </div>
                            </div>
                            <h3 class="mt-4 text-xl font-bold text-gray-900">
                                Quản lý IMEI/Serial
                            </h3>
                            <p class="mt-2 text-base text-gray-600">
                                Theo dõi chính xác từng sản phẩm. Truy xuất lịch sử nhập, xuất,
                                bảo hành của từng IMEI chỉ trong vài giây.
                            </p>
                        </div>

                        <!-- Tính năng 2: Quản lý Vị trí -->
                        <div
                            class="bg-white p-6 rounded-lg shadow-lg reveal-on-scroll"
                            style="transition-delay: 100ms"
                            >
                            <div class="flex-shrink-0">
                                <div
                                    class="inline-flex h-12 w-12 items-center justify-center rounded-md bg-indigo-100 text-indigo-600"
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
                                        d="M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z"
                                        />
                                    <path
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1 1 15 0Z"
                                        />
                                    </svg>
                                </div>
                            </div>
                            <h3 class="mt-4 text-xl font-bold text-gray-900">
                                Tồn kho & Vị trí
                            </h3>
                            <p class="mt-2 text-base text-gray-600">
                                Biết chính xác sản phẩm đang ở đâu (kho, kệ, khu vực). Tối ưu
                                việc sắp xếp và tìm kiếm hàng hóa.
                            </p>
                        </div>

                        <!-- Tính năng 3: Nhập/Xuất kho -->
                        <div
                            class="bg-white p-6 rounded-lg shadow-lg reveal-on-scroll"
                            style="transition-delay: 200ms"
                            >
                            <div class="flex-shrink-0">
                                <div
                                    class="inline-flex h-12 w-12 items-center justify-center rounded-md bg-indigo-100 text-indigo-600"
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
                                        d="M7.5 21 3 16.5m0 0L7.5 12M3 16.5h13.5m0-13.5L21 7.5m0 0L16.5 12M21 7.5H7.5"
                                        />
                                    </svg>
                                </div>
                            </div>
                            <h3 class="mt-4 text-xl font-bold text-gray-900">
                                Phiếu Nhập/Xuất/Chuyển
                            </h3>
                            <p class="mt-2 text-base text-gray-600">
                                Tạo và quản lý phiếu tự động. Hỗ trợ quét Barcode/QR Code bằng
                                điện thoại hoặc máy quét chuyên dụng.
                            </p>
                        </div>

                        <!-- Tính năng 4: Báo cáo -->
                        <div
                            class="bg-white p-6 rounded-lg shadow-lg reveal-on-scroll"
                            style="transition-delay: 300ms"
                            >
                            <div class="flex-shrink-0">
                                <div
                                    class="inline-flex h-12 w-12 items-center justify-center rounded-md bg-indigo-100 text-indigo-600"
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
                                        d="M3.75 3v11.25A2.25 2.25 0 0 0 6 16.5h12M3.75 3h16.5v11.25c0 1.242-.99 2.25-2.25 2.25H6.75A2.25 2.25 0 0 1 4.5 14.25V3M3.75 21h16.5M16.5 3.75h.008v.008H16.5V3.75Z"
                                        />
                                    </svg>
                                </div>
                            </div>
                            <h3 class="mt-4 text-xl font-bold text-gray-900">
                                Báo cáo & Cảnh báo
                            </h3>
                            <p class="mt-2 text-base text-gray-600">
                                Báo cáo tồn kho real-time, hàng tồn lâu, hàng bán chạy. Cảnh báo
                                tự động khi tồn kho dưới mức an toàn.
                            </p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- ===== LỢI ÍCH (BENEFITS) ===== -->
            <section class="py-16 md:py-24 bg-white">
                <div class="container mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
                    <div class="text-center max-w-3xl mx-auto">
                        <h2
                            class="text-3xl font-extrabold tracking-tight text-gray-900 sm:text-4xl reveal-on-scroll"
                            >
                            Hiệu quả thực tế
                        </h2>
                    </div>
                    <div class="mt-16 grid grid-cols-1 md:grid-cols-3 gap-8 text-center">
                        <div class="p-6 reveal-on-scroll">
                            <span class="block text-5xl font-bold text-indigo-600"
                                  >99.9%</span
                            >
                            <span class="mt-2 block text-lg font-medium text-gray-700"
                                  >Giảm thất thoát</span
                            >
                            <p class="mt-1 text-gray-600">
                                Không còn tình trạng mất hàng, nhầm IMEI hay sai sót trong kiểm
                                kê.
                            </p>
                        </div>
                        <div class="p-6 reveal-on-scroll" style="transition-delay: 150ms">
                            <span class="block text-5xl font-bold text-indigo-600">50%</span>
                            <span class="mt-2 block text-lg font-medium text-gray-700"
                                  >Tăng tốc độ xử lý</span
                            >
                            <p class="mt-1 text-gray-600">
                                Giảm một nửa thời gian cho việc nhập hàng, xuất hàng và tìm kiếm
                                sản phẩm.
                            </p>
                        </div>
                        <div class="p-6 reveal-on-scroll" style="transition-delay: 300ms">
                            <span class="block text-5xl font-bold text-indigo-600">100%</span>
                            <span class="mt-2 block text-lg font-medium text-gray-700"
                                  >Minh bạch dữ liệu</span
                            >
                            <p class="mt-1 text-gray-600">
                                Tất cả nhân viên, quản lý đều làm việc trên một hệ thống dữ liệu
                                real-time.
                            </p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- ===== CALL TO ACTION (CTA) ===== -->
            <section id="lien-he" class="bg-gray-900">
                <div
                    class="container mx-auto max-w-7xl px-4 py-16 sm:px-6 lg:py-24 lg:px-8"
                    >
                    <div class="max-w-2xl mx-auto text-center">
                        <h2
                            class="text-3xl font-extrabold tracking-tight text-white sm:text-4xl reveal-on-scroll"
                            >
                            Sẵn sàng số hóa kho hàng điện thoại của bạn?
                        </h2>
                        <p
                            class="mt-4 text-lg text-gray-300 reveal-on-scroll"
                            style="transition-delay: 150ms"
                            >
                            Trải nghiệm giải pháp WMS Pro hoặc liên hệ với chúng tôi để được
                            tư vấn lộ trình triển khai.
                        </p>
                        <div
                            class="mt-10 flex flex-col sm:flex-row gap-4 justify-center reveal-on-scroll"
                            style="transition-delay: 300ms"
                            >
                            <c:if test="${empty sessionScope.account}">
                            <a
                                href="${pageContext.request.contextPath}/loginStaff"
                                class="rounded-md border border-transparent bg-indigo-600 px-6 py-3 text-base font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 focus:ring-offset-gray-900"
                                >
                                Dùng thử miễn phí
                            </a>
                            
                            <a
                                href="mailto:support@wms.vn"
                                class="rounded-md border border-indigo-400 bg-transparent px-6 py-3 text-base font-medium text-indigo-300 shadow-sm hover:bg-indigo-500/20"
                                >
                                Liên hệ tư vấn
                            </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </section>
        </main>

        <!-- ===== FOOTER ===== -->
        <footer class="bg-gray-800 text-gray-400">
            <div class="container mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
                <div
                    class="flex flex-col md:flex-row justify-between items-center text-center md:text-left"
                    >
                    <p class="text-sm">&copy; 2025 WMS Pro. Mọi quyền được bảo lưu.</p>
                    <div class="flex space-x-4 mt-4 md:mt-0">
                        <a href="#" class="text-sm hover:text-white transition-colors"
                           >Chính sách bảo mật</a
                        >
                        <a href="#" class="text-sm hover:text-white transition-colors"
                           >Điều khoản dịch vụ</a
                        >
                    </div>
                    <div class="mt-4 md:mt-0">
                        <p class="text-sm">
                            Hotline:
                            <a href="tel:19001234" class="hover:text-white">1900 1234</a>
                        </p>
                        <p class="text-sm">
                            Email:
                            <a href="mailto:support@wms.vn" class="hover:text-white"
                               >support@wms.vn</a
                            >
                        </p>
                    </div>
                </div>
            </div>
        </footer>

        <!-- ===== JAVASCRIPT ===== -->
        <script>
            document.addEventListener("DOMContentLoaded", () => {
                // Xử lý Mobile Menu
                const menuButton = document.getElementById("mobile-menu-button");
                const mobileMenu = document.getElementById("mobile-menu");

                if (menuButton) {
                    menuButton.addEventListener("click", () => {
                        mobileMenu.classList.toggle("hidden");
                    });
                }

                // Xử lý hiệu ứng cuộn (Intersection Observer)
                const revealElements = document.querySelectorAll(".reveal-on-scroll");

                const revealObserver = new IntersectionObserver(
                        (entries, observer) => {
                    entries.forEach((entry) => {
                        if (entry.isIntersecting) {
                            entry.target.classList.add("is-visible");
                            // Tùy chọn: Dừng quan sát sau khi đã hiển thị
                            // observer.unobserve(entry.target);
                        }
                        // Tùy chọn: Xóa lớp nếu cuộn ra khỏi tầm nhìn (để hiệu ứng lặp lại)
                        // else {
                        //     entry.target.classList.remove('is-visible');
                        // }
                    });
                },
                        {
                            root: null, // Quan sát so với viewport
                            threshold: 0.1, // Kích hoạt khi 10% phần tử hiển thị
                        }
                );

                revealElements.forEach((el) => {
                    revealObserver.observe(el);
                });
                const userMenuButton = document.getElementById('user-menu-button');
                const userDropdown = document.getElementById('user-menu-dropdown');

                if (userMenuButton && userDropdown) {
                    userMenuButton.addEventListener('click', function () {
                        userDropdown.classList.toggle('hidden');
                    });
                    // Tự động đóng khi nhấn ra ngoài
                    document.addEventListener('click', function (event) {
                        if (!userMenuButton.contains(event.target) && !userDropdown.contains(event.target)) {
                            userDropdown.classList.add('hidden');
                        }
                    });
                }
            });
        </script>
    </body>
</html>

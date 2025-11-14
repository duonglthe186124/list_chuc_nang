<%-- 
    Document   : login_page
    Created on : Sep 25, 2025, 8:02:45 AM
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
                        href="${pageContext.request.contextPath}/home"
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
                        <a
                            href="#gioi-thieu"
                            class="font-medium text-gray-600 hover:text-indigo-600 transition-colors"
                            >Giới thiệu</a
                        >
                        <a
                            href="${pageContext.request.contextPath}/products"
                            class="font-medium text-gray-600 hover:text-indigo-600 transition-colors"
                            >Sản phẩm</a
                        >
                        <a
                            href="#tinh-nang"
                            class="font-medium text-gray-600 hover:text-indigo-600 transition-colors"
                            >Tính năng</a
                        >
                        <a
                            href="#lien-he"
                            class="font-medium text-gray-600 hover:text-indigo-600 transition-colors"
                            >Liên hệ</a
                        >
                        <a
                            href="${pageContext.request.contextPath}/loginStaff"
                            class="rounded-md bg-indigo-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
                            >
                            Đăng nhập
                        </a>
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

        <main class="pt-24 pb-16">
            <div class="max-w-lg mx-auto mt-10 p-10 bg-white rounded-lg shadow-xl">
                
                <h2 class="text-3xl font-bold text-center mb-8 text-gray-900">Sign in</h2>

                <form id="loginForm" action="${pageContext.request.contextPath}/loginStaff" method="post" class="space-y-6">

                    <%-- Khu vực thông báo lỗi (nếu có) --%>
                    <div class="min-h-[40px]">
                        <c:if test="${not empty errorMessage}">
                            <span class="block w-full p-3 text-sm rounded-lg text-red-700 bg-red-100 border border-red-300">
                                ${errorMessage}
                            </span>
                        </c:if>
                    </div>

                    <%-- Ô Email --%>
                    <div>
                        <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                        <input type="email" id="email" name="email" required
                               class="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500">
                    </div>

                    <%-- Ô Password --%>
                    <div>
                        <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                        <input type="password" id="password" name="password" required
                               class="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500">
                    </div>

                    <%-- Hàng Remember me & Forgot password --%>
                    <div class="flex justify-between items-center text-sm">
                        <div class="flex items-center">
                            <input type="checkbox" id="remember" name="remember" class="h-4 w-4 text-indigo-600 border-gray-300 rounded focus:ring-indigo-500">
                            <label for="remember" class="ml-2 text-gray-700">Remember me</label>
                        </div>
                        <a href="${pageContext.request.contextPath}/forgot-password" class="font-medium text-indigo-600 hover:text-indigo-500">Forgot password?</a>
                    </div>

                    <%-- Link Đăng ký --%>
                    <p class="text-center text-sm text-gray-600">
                        You don't have an account? <a href="${pageContext.request.contextPath}/RegisterStaff" class="font-medium text-indigo-600 hover:text-indigo-500">Register</a>
                    </p>

                    <%-- Nút Đăng nhập --%>
                    <button type="submit" 
                            class="w-full py-3 px-6 bg-black text-white font-bold text-lg rounded-full hover:bg-gray-800 transition duration-200 focus:outline-none focus:ring-2 focus:ring-black focus:ring-offset-2">
                        Sign in
                    </button>
                </form>

                <%-- Dấu gạch ngang "OR" --%>
               <%-- <div class="flex items-center my-6">
                    <hr class="flex-1 border-t border-gray-300">
                    <span class="px-4 text-sm font-medium text-gray-500">OR</span>
                    <hr class="flex-1 border-t border-gray-300">
                </div>

                <%-- Đăng nhập mạng xã hội --%>
                <%--<div class="flex flex-col gap-4">
                    <a href="${pageContext.request.contextPath}/login-google" 
                       class="flex items-center justify-center gap-3 w-full py-3 px-4 border border-gray-300 rounded-lg bg-white hover:bg-gray-50 transition duration-200">
                        <img src="${pageContext.request.contextPath}/resources/img/google.webp" alt="Google Icon" class="w-5 h-5">
                        <span class="font-medium text-gray-700">Continue with Google</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/login-github" 
                       class="flex items-center justify-center gap-3 w-full py-3 px-4 border border-gray-300 rounded-lg bg-white hover:bg-gray-50 transition duration-200">
                        
                        <img src="${pageContext.request.contextPath}/resources/img/github.png" 
                             alt="GitHub Icon" class="w-11 h-7">
                        
                        <span class="font-medium text-gray-700">Continue with GitHub</span>
                    </a>
                </div>--%>
            </div>
        </main>
    </body>
</html>

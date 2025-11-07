<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi" class="scroll-smooth">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>WMS Pro - Đăng Ký Tài Khoản</title>
        <script src="https://cdn.tailwindcss.com"></script>
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

            /* LỚP CSS CHO HIỆU ỨNG CUỘN */
            .reveal-on-scroll {
                opacity: 0;
                transform: translateY(30px);
                transition: opacity 0.6s ease-out, transform 0.6s ease-out;
            }
            .reveal-on-scroll.is-visible {
                opacity: 1;
                transform: translateY(0);
            }
            
            .password-strength-indicator {
                height: 5px; background-color: #eee; margin-top: 5px;
                border-radius: 2.5px; overflow: hidden;
            }
            .password-strength-indicator div {
                height: 100%; width: 0%;
                transition: width 0.3s ease-in-out, background-color 0.3s ease-in-out;
            }
            .strength-text {
                font-size: 0.85em; margin-top: 5px; text-align: right; min-height: 1em;
            }
        </style>
    </head>
    <body class="bg-gray-100 text-gray-800">

        <header
            class="fixed top-0 left-0 right-0 z-50 bg-white/90 backdrop-blur-md shadow-sm"
            >
            <div class="container mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
                <div class="flex h-16 items-center justify-between">
                    <a
                        href="${pageContext.request.contextPath}/home"
                        class="flex items-center gap-2 text-2xl font-bold text-gray-900"
                        >
                        <svg class="h-8 w-8 text-indigo-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6A2.25 2.25 0 0 1 6 3.75h2.25A2.25 2.25 0 0 1 10.5 6v2.25a2.25 2.25 0 0 1-2.25 2.25H6a2.25 2.25 0 0 1-2.25-2.25V6ZM3.75 15.75A2.25 2.25 0 0 1 6 13.5h2.25a2.25 2.25 0 0 1 2.25 2.25V18a2.25 2.25 0 0 1-2.25 2.25H6A2.25 2.25 0 0 1 3.75 18v-2.25ZM13.5 6a2.25 2.25 0 0 1 2.25-2.25H18A2.25 2.25 0 0 1 20.25 6v2.25A2.25 2.25 0 0 1 18 10.5h-2.25A2.25 2.25 0 0 1 13.5 8.25V6ZM13.5 15.75a2.25 2.25 0 0 1 2.25-2.25H18a2.25 2.25 0 0 1 2.25 2.25V18A2.25 2.25 0 0 1 18 20.25h-2.25A2.25 2.25 0 0 1 13.5 18v-2.25Z" />
                        </svg>
                        <span>WMS Pro</span>
                    </a>

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

                    <div class="md:hidden">
                        <button
                            id="mobile-menu-button"
                            class="inline-flex items-center justify-center rounded-md p-2 text-gray-400 hover:bg-gray-100 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-indigo-500"
                            >
                            <span class="sr-only">Mở menu chính</span>
                            <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5" />
                            </svg>
                        </button>
                    </div>
                </div>

                <div id="mobile-menu" class="hidden md:hidden pb-4">
                    <div class="space-y-1">
                        <a
                            href="#gioi-thieu"
                            class="block rounded-md px-3 py-2 text-base font-medium text-gray-700 hover:bg-gray-50 hover:text-gray-900"
                            >Giới thiệu</a
                        >
                        <a
                            href="${pageContext.request.contextPath}/products"
                            class="block rounded-md px-3 py-2 text-base font-medium text-gray-700 hover:bg-gray-50 hover:text-gray-900"
                            >Sản phẩm</a
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
            
            <div class="max-w-xl mx-auto mt-10 p-8 bg-white shadow-lg rounded-lg reveal-on-scroll">
                <h2 class="text-3xl font-bold text-center mb-8 text-gray-900">
                    Register Account
                </h2>
                
                <form id="registerForm" action="${pageContext.request.contextPath}/RegisterStaff" method="post" class="space-y-6">
                    
                    <c:if test="${not empty errorMessage}">
                        <div class="p-3 text-sm rounded-lg text-red-700 bg-red-100 border border-red-300">
                            ${errorMessage}
                        </div>
                    </c:if>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label for="fullname" class="block text-sm font-medium text-gray-700">Fullname</label>
                            <input type="text" id="fullname" name="fullname" placeholder="John Doe" required
                                   class="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500">
                        </div>
                        <div>
                            <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                            <input type="email" id="email" name="email" placeholder="example@gmail.com" required
                                   class="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500">
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label for="phone" class="block text-sm font-medium text-gray-700">Phone Number</label>
                            <input type="tel" id="phone" name="phone" placeholder="+84912345678" required
                                   class="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500">
                        </div>
                        <div>
                            <label for="address" class="block text-sm font-medium text-gray-700">Contact Address</label>
                            <input type="text" id="address" name="address" required
                                   class="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500">
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label for="new_password" class="block text-sm font-medium text-gray-700">Password</label>
                            <input type="password" id="new_password" name="password" required
                                   class="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500">
                            
                            <div class="password-strength-indicator"><div id="strength-bar"></div></div>
                            <div id="strength-text" class="strength-text"></div>
                        </div>
                        <div>
                            <label for="confirm_password" class="block text-sm font-medium text-gray-700">Confirm new password</label>
                            <input type="password" id="confirm_password" name="confirm_password" required
                                   class="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500">
                        </div>
                    </div>

                    <div class="pt-4">
                        <button type="submit"
                                class="w-full py-3 px-6 bg-indigo-600 text-white font-bold text-lg rounded-lg hover:bg-indigo-700 transition duration-200">
                            Create Account
                        </button>
                    </div>
                    
                    <p class="text-center text-sm text-gray-600">
                        Already have an account? 
                        <a href="${pageContext.request.contextPath}/loginStaff" class="font-medium text-indigo-600 hover:text-indigo-500">
                            Sign in
                        </a>
                    </p>
                    
                </form>
            </div>
        </main>
        
        <script src="${pageContext.request.contextPath}/resources/js/password-strength.js"></script>
        
        <script>
            // JAVASCRIPT CHO HIỆU ỨNG CUỘN
            document.addEventListener('DOMContentLoaded', function () {
                const observer = new IntersectionObserver((entries) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            entry.target.classList.add('is-visible');
                        }
                    });
                }, {
                    threshold: 0.1
                });

                const elements = document.querySelectorAll('.reveal-on-scroll');
                elements.forEach(el => {
                    observer.observe(el);
                });
                
                // JAVASCRIPT CHO MENU MOBILE
                const menuButton = document.getElementById('mobile-menu-button');
                const mobileMenu = document.getElementById('mobile-menu');
                if (menuButton) {
                    menuButton.addEventListener('click', function() {
                        mobileMenu.classList.toggle('hidden');
                    });
                }
            });
        </script>
    </body>
</html>
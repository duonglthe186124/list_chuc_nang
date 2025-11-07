<%-- 
    Document   : reset_password
    Created on : Oct 27, 2025, 10:43:16 PM
    Author     : admin
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
            .password-strength-indicator {
                height: 5px;
                background-color: #eee;
                margin-top: 5px;
                border-radius: 2.5px;
                overflow: hidden;
            }
            .password-strength-indicator div {
                height: 100%;
                width: 0%;
                transition: width 0.3s ease-in-out, background-color 0.3s ease-in-out;
            }
            .strength-weak {
                background-color: #dc3545;
            }
            .strength-medium {
                background-color: #ffc107;
            }
            .strength-strong {
                background-color: #28a745;
            }
            .strength-text {
                font-size: 0.85em;
                margin-top: 5px;
                text-align: right;
                min-height: 1em;
            }
            .strength-text-weak {
                color: #dc3545;
            }
            .strength-text-medium {
                color: #ffc107;
            }
            .strength-text-strong {
                color: #28a745;
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
            <div class="max-w-md mx-auto mt-10 p-8 bg-white shadow-lg rounded-lg">
                <h2 class="text-3xl font-bold text-center mb-8 text-gray-900">
                    Reset password
                </h2>
                
                <form id="reset-form" action="${pageContext.request.contextPath}/reset-password" method="post" class="space-y-6">
                    
                    <div class="min-h-[40px]">
                        <c:if test="${not empty error}">
                            <span class="block w-full p-3 text-sm rounded-lg text-red-700 bg-red-100 border border-red-300">
                                ${error}
                            </span>
                        </c:if>
                        <c:if test="${not empty successMessage}">
                            <span class="block w-full p-3 text-sm rounded-lg text-green-700 bg-green-100 border border-green-300">
                                ${successMessage}
                            </span>
                        </c:if>
                    </div>
                    
                    <input type="hidden" name="email" value="${email}">

                    <div>
                        <label for="reset_code" class="block text-sm font-medium text-gray-700">Reset code (6 digits)</label>
                        <input type="text" id="reset_code" name="reset_code" required
                               class="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm ...">
                    </div>
                    
                    <div class="text-sm text-center">
                        <span id="timer-text">Code expires in: <strong id="countdown" class="text-indigo-600">02:00</strong></span>
                    </div>
                    
                    <div class="password-wrapper">
                        <label for="new_password" class="block text-sm font-medium text-gray-700">New password</label>
                        <input type="password" id="new_password" name="new_password" required
                               class="mt-1 block w-full px-4 py-3 border border-gray-300 ...">
                        <i class="fas fa-eye-slash toggle-password"></i>
                        <div class="password-strength-indicator"><div id="strength-bar"></div></div>
                        <div id="strength-text" class="strength-text"></div>
                    </div>

                    <div class="password-wrapper">
                        <label for="confirm_password" class="block text-sm font-medium text-gray-700">Confirm new password</label>
                        <input type="password" id="confirm_password" name="confirm_password" required
                               class="mt-1 block w-full px-4 py-3 border border-gray-300 ...">
                        <i class="fas fa-eye-slash toggle-password"></i>
                    </div>
                    
                    <div class="flex gap-4 pt-4">
                        <a href="${pageContext.request.contextPath}/forgot-password" class="flex-1 block py-3 px-4 bg-gray-200 ...">
                           Cancel
                        </a>
                        <button type="submit" id="change-button" class="flex-1 py-3 px-4 bg-black text-white ...">
                           Change
                        </button>
                    </div>
                </form> 
                           <div class="text-sm text-center mt-4">
                    <form id="resend-form" action="${pageContext.request.contextPath}/resend-code" method="post" class="hidden">
                        <input type="hidden" name="email" value="${email}">
                        <button type="submit" class="font-medium text-indigo-600 hover:text-indigo-500">
                            Resend code
                        </button>
                    </form>
                </div>
                
            </div>
        </main>
        <script src="${pageContext.request.contextPath}/resources/js/password-strength.js"></script>
        <script>
            // Lấy mốc thời gian hết hạn (dưới dạng số) mà ForgotPasswordServlet đã gửi
            const expiryTime = ${expiryTime}; 

            const countdownElement = document.getElementById('countdown');
            const timerTextElement = document.getElementById('timer-text');
            const resendForm = document.getElementById('resend-form');
            const changeButton = document.getElementById('change-button');

            // Cập nhật bộ đếm ngược mỗi giây
            const interval = setInterval(function() {
                const now = new Date().getTime();
                const distance = expiryTime - now;

                // Tính toán phút và giây
                const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                const seconds = Math.floor((distance % (1000 * 60)) / 1000);

                // Hiển thị kết quả
                if (distance > 0) {
                    countdownElement.innerHTML = (minutes < 10 ? '0' : '') + minutes + ":" + (seconds < 10 ? '0' : '') + seconds;
                } else {
                    // Nếu hết giờ
                    clearInterval(interval);
                    timerTextElement.innerHTML = "Your code has expired.";
                    resendForm.classList.remove('hidden'); // Hiện nút "Resend code"
                    changeButton.disabled = true; // Vô hiệu hóa nút "Change"
                    changeButton.classList.add('bg-gray-400', 'cursor-not-allowed');
                }
            }, 1000);
        </script>
    </body>
</html>

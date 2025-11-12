<%-- 
    Document   : forgot_password
    Created on : Oct 27, 2025, 10:42:06 PM
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
        <div class="max-w-md mx-auto mt-10 p-8 bg-white shadow-lg rounded-lg">
            <h2 class="text-3xl font-bold text-center mb-8 text-gray-900">Recover my account</h2>
            
            <form id="reset-form" action="${pageContext.request.contextPath}/forgot-password" method="POST" class="space-y-4">
                
                <div>
                    <input type="email" id="email-input" name="email" 
                           class="w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
                           placeholder="Enter your email" required>
                </div>

                <div id="error-message" class="p-3 text-sm rounded-lg text-red-700 bg-red-100 border border-red-300 hidden">
                    </div>
                
                <c:if test="${not empty message}">
                    <div class="p-3 text-sm rounded-lg text-red-700 bg-red-100 border border-red-300">
                        ${message}
                    </div>
                </c:if>

                <div id="account-info" class="p-4 bg-gray-50 rounded-lg border border-gray-200 hidden">
                    <p class="text-sm font-medium text-gray-700">Account found:</p>
                    <p class="text-lg font-bold text-gray-900" id="account-fullname"></p>
                    <p class="text-sm text-gray-600" id="account-role"></p>
                    <p class="mt-2 text-sm text-gray-600">Is this you?</p>
                </div>

                <div class="flex gap-4">
                    <a href="${pageContext.request.contextPath}/loginStaff" 
                       class="flex-1 text-center py-3 px-4 bg-gray-200 text-gray-700 font-medium rounded-lg transition duration-200 hover:bg-gray-300">
                        Cancel
                    </a>

                    <button type="button" id="find-account-btn" 
                            class="flex-1 py-3 px-4 bg-indigo-600 text-white font-medium rounded-lg transition duration-200 hover:bg-indigo-700">
                        Find my account
                    </button>

                    <button type="submit" id="send-reset-btn" 
                            class="flex-1 py-3 px-4 bg-indigo-600 text-white font-medium rounded-lg transition duration-200 hover:bg-indigo-700 hidden">
                        Send reset code
                    </button>
                </div>

            </form>
        </div>
        </main>
        <script>
            document.addEventListener('DOMContentLoaded', function () {

                // Lấy các phần tử (element)
                const findAccountBtn = document.getElementById('find-account-btn');
                const sendResetBtn = document.getElementById('send-reset-btn');
                const emailInput = document.getElementById('email-input');

                const accountInfoDiv = document.getElementById('account-info');
                const accountFullname = document.getElementById('account-fullname');
                const accountRole = document.getElementById('account-role');

                const errorDiv = document.getElementById('error-message');

                // 1. Khi người dùng nhấn nút "Find my account"
                findAccountBtn.addEventListener('click', async function () {
                    const email = emailInput.value;
                    if (!email) {
                        errorDiv.textContent = 'Please enter an email address.';
                        errorDiv.classList.remove('hidden');
                        return;
                    }

                    findAccountBtn.textContent = 'Finding...';
                    findAccountBtn.disabled = true;

                    try {
                        // 2. GỌI SERVLET MỚI (/findAccount)
                        const response = await fetch('${pageContext.request.contextPath}/findAccount', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: 'email=' + encodeURIComponent(email)
                        });

                        const data = await response.json(); // Đợi và đọc JSON

                        // 3. XỬ LÝ KẾT QUẢ JSON
                        if (data.found) {
                            // TÌM THẤY
                            accountFullname.textContent = data.fullname;
                            accountRole.textContent = '(' + data.roleName + ')';

                            accountInfoDiv.classList.remove('hidden'); // Hiện div thông tin
                            sendResetBtn.classList.remove('hidden');   // Hiện nút "Send reset code"

                            errorDiv.classList.add('hidden');          // Ẩn lỗi
                            findAccountBtn.classList.add('hidden');    // Ẩn nút "Find"
                        } else {
                            // KHÔNG TÌM THẤY
                            errorDiv.textContent = 'No account found with that email address.';
                            errorDiv.classList.remove('hidden');       // Hiện lỗi
                            accountInfoDiv.classList.add('hidden');    
                            sendResetBtn.classList.add('hidden');      
                        }

                    } catch (error) {
                        console.error('Error:', error);
                        errorDiv.textContent = 'An error occurred. Please try again.';
                        errorDiv.classList.remove('hidden');
                    } finally {
                        findAccountBtn.textContent = 'Find my account';
                        findAccountBtn.disabled = false;
                    }
                });

                // 4. Khi người dùng sửa lại email, reset lại form
                emailInput.addEventListener('input', function() {
                    accountInfoDiv.classList.add('hidden');
                    sendResetBtn.classList.add('hidden');
                    findAccountBtn.classList.remove('hidden');
                    errorDiv.classList.add('hidden');
                });
            });
        </script>               
    </body>
</html>

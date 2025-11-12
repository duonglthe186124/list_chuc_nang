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
                <h2 class="text-3xl font-bold text-center mb-8 text-gray-900">
                    Reset password
                </h2>

                <form id="reset-form" action="${pageContext.request.contextPath}/reset-password" method="post" class="space-y-6">

                    <div class="min-h-[40px]">
                        <c:if test="${not empty error}">
                            <div class="p-3 text-sm rounded-lg text-red-700 bg-red-100 border border-red-300">
                                ${error}
                            </div>
                        </c:if>
                    </div>

                    <input type="hidden" name="email" id="email-hidden" value="${email}">

                    <input type="hidden" name="reset_code" id="reset-code-hidden">

                    <div id="code-section" class="space-y-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700">Reset code (6 digits)</label>
                            <div id="otp-container" class="flex justify-center gap-2 mt-2">
                                <input type="text" class="otp-input w-12 h-14 text-center text-2xl font-semibold border border-gray-300 rounded-lg shadow-sm focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500" maxlength="1">
                                <input type="text" class="otp-input w-12 h-14 text-center text-2xl font-semibold border border-gray-300 rounded-lg shadow-sm focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500" maxlength="1">
                                <input type="text" class="otp-input w-12 h-14 text-center text-2xl font-semibold border border-gray-300 rounded-lg shadow-sm focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500" maxlength="1">
                                <input type="text" class="otp-input w-12 h-14 text-center text-2xl font-semibold border border-gray-300 rounded-lg shadow-sm focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500" maxlength="1">
                                <input type="text" class="otp-input w-12 h-14 text-center text-2xl font-semibold border border-gray-300 rounded-lg shadow-sm focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500" maxlength="1">
                                <input type="text" class="otp-input w-12 h-14 text-center text-2xl font-semibold border border-gray-300 rounded-lg shadow-sm focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500" maxlength="1">
                            </div>
                        </div>

                        <div id="verify-error-message" class="p-3 text-sm rounded-lg text-red-700 bg-red-100 border border-red-300 hidden">
                            </div>

                        <div class="text-sm text-center">
                            <span id="timer-text">Code expires in: <strong id="countdown" class="text-indigo-600">02:00</strong></span>
                        </div>

                        <button type="button" id="verify-code-btn" 
                                class="w-full py-3 px-4 bg-indigo-600 text-white font-medium rounded-lg transition duration-200 hover:bg-indigo-700">
                            Verify Code
                        </button>

                        <a href="${pageContext.request.contextPath}/forgot-password" class="w-full block py-3 px-4 bg-gray-200 text-gray-700 font-medium rounded-lg text-center transition duration-200 hover:bg-gray-300">
                            Cancel
                        </a>
                    </div>

                    <div id="password-section" class="hidden space-y-6 pt-4 border-t">

                        <div class="text-center">
                            <span class="font-medium text-green-600">Code verified successfully! Please set your new password.</span>
                        </div>

                        <div class="password-wrapper">
                            <label for="new_password" class="block text-sm font-medium text-gray-700">New password</label>
                            <input type="password" id="new_password" name="new_password" 
                                   class="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500">
                            <div class="password-strength-indicator"><div id="strength-bar"></div></div>
                            <div id="strength-text" class="strength-text"></div>
                        </div>

                        <div class="password-wrapper">
                            <label for="confirm_password" class="block text-sm font-medium text-gray-700">Confirm new password</label>
                            <input type="password" id="confirm_password" name="confirm_password" 
                                   class="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500">
                        </div>

                        <button type="submit" id="change-button" class="w-full py-3 px-4 bg-black text-white font-medium rounded-lg shadow-sm transition duration-200 hover:bg-gray-800">
                            Change
                        </button>
                    </div>
                </form>
                    <div class="text-sm text-center mt-4">
                        <form id="resend-form" action="${pageContext.request.contextPath}/forgot-password" method="post" class="hidden">
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
            document.addEventListener('DOMContentLoaded', function () {

                // === PHẦN 1: ĐỊNH NGHĨA TẤT CẢ BIẾN ===

                // (Biến cho 6 ô OTP)
                const otpContainer = document.getElementById('otp-container');
                const otpInputs = otpContainer ? otpContainer.querySelectorAll('.otp-input') : [];
                const hiddenOtpInput = document.getElementById('reset-code-hidden');

                // (Biến cho đếm ngược)
                const expiryTimeString = "${expiryTime}"; // Lấy an toàn dưới dạng chuỗi
                const countdownElement = document.getElementById('countdown');
                const timerTextElement = document.getElementById('timer-text');
                const resendForm = document.getElementById('resend-form');

                // (Biến cho Verify)
                const verifyBtn = document.getElementById('verify-code-btn'); // ĐỊNH NGHĨA Ở ĐÂY
                const verifyErrorDiv = document.getElementById('verify-error-message');
                const codeSection = document.getElementById('code-section');
                const hiddenEmail = document.getElementById('email-hidden');

                // (Biến cho khối Mật khẩu)
                const passwordSection = document.getElementById('password-section');
                const newPasswordInput = document.getElementById('new_password');
                const confirmPasswordInput = document.getElementById('confirm_password');
                const changeButton = document.getElementById('change-button');

                // === PHẦN 2: LOGIC 6 Ô OTP (Không đổi, chỉ đảm bảo an toàn) ===
                if (otpContainer) {
                    otpInputs.forEach((input, index) => {
                        // 1. Tự động nhảy ô
                        input.addEventListener('input', (e) => {
                            input.value = input.value.replace(/[^0-9]/g, '');
                            if (input.value.length === 1 && index < otpInputs.length - 1) {
                                otpInputs[index + 1].focus();
                            }
                            updateHiddenInput();
                        });

                        // 2. Xử lý Backspace
                        input.addEventListener('keydown', (e) => {
                            if (e.key === 'Backspace' && input.value.length === 0 && index > 0) {
                                otpInputs[index - 1].focus();
                            }
                            setTimeout(updateHiddenInput, 0);
                        });

                        // 3. Xử lý Paste
                        input.addEventListener('paste', (e) => {
                            e.preventDefault();
                            const pasteData = e.clipboardData.getData('text');
                            const digits = pasteData.split('').filter(d => /^\d$/.test(d));
                            digits.forEach((digit, i) => {
                                if (index + i < otpInputs.length) { otpInputs[index + i].value = digit; }
                            });
                            const lastFilledIndex = Math.min(index + digits.length, otpInputs.length) - 1;
                            if (lastFilledIndex < otpInputs.length - 1) {
                                otpInputs[lastFilledIndex + 1].focus();
                            } else {
                                otpInputs[lastFilledIndex].focus();
                            }
                            updateHiddenInput();
                        });
                    });

                    // Hàm gộp 6 ô
                    function updateHiddenInput() {
                        let otp = '';
                        otpInputs.forEach(input => { otp += input.value; });
                        hiddenOtpInput.value = otp;
                    }
                }

                // === PHẦN 3: LOGIC ĐẾM NGƯỢC (Đã sửa) ===
                if (expiryTimeString && expiryTimeString !== "null" && expiryTimeString !== "") {
                    const expiryTimeValue = parseInt(expiryTimeString); // SỬA: Chuyển chuỗi thành số

                    const interval = setInterval(function() {
                        const now = new Date().getTime();
                        const distance = expiryTimeValue - now; // SỬA: Dùng biến số để tính

                        if (distance > 0) {
                            const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                            const seconds = Math.floor((distance % (1000 * 60)) / 1000);
                            countdownElement.innerHTML = (minutes < 10 ? '0' : '') + minutes + ":" + (seconds < 10 ? '0' : '') + seconds;
                        } else {
                            clearInterval(interval);
                            timerTextElement.innerHTML = "Your code has expired.";
                            resendForm.classList.remove('hidden');
                            if (verifyBtn) { // Vô hiệu hóa nút Verify
                                verifyBtn.disabled = true;
                                verifyBtn.classList.add('bg-gray-400', 'cursor-not-allowed');
                            }
                            if (changeButton) { // Vô hiệu hóa nút Change
                                changeButton.disabled = true; 
                                changeButton.classList.add('bg-gray-400', 'cursor-not-allowed');
                            }
                        }
                    }, 1000);
                } else {
                    // Trường hợp không có thời gian (lỗi)
                    timerTextElement.innerHTML = "Error: Expiry time not set.";
                    if (verifyBtn) {
                        verifyBtn.disabled = true;
                        verifyBtn.classList.add('bg-gray-400', 'cursor-not-allowed');
                    }
                    if (changeButton) {
                        changeButton.disabled = true;
                        changeButton.classList.add('bg-gray-400', 'cursor-not-allowed');
                    }
                }

                // === PHẦN 4: LOGIC VERIFY CODE (Đã sửa) ===
                if (verifyBtn) {
                    verifyBtn.addEventListener('click', async function() {
                        const code = hiddenOtpInput.value;
                        const email = hiddenEmail.value;

                        if (code.length !== 6) {
                            verifyErrorDiv.textContent = 'Please enter all 6 digits.';
                            verifyErrorDiv.classList.remove('hidden');
                            return;
                        }

                        verifyBtn.textContent = 'Verifying...';
                        verifyBtn.disabled = true;

                        try {
                            const response = await fetch('${pageContext.request.contextPath}/verifyCode', {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                                body: 'email=' + encodeURIComponent(email) + '&reset_code=' + encodeURIComponent(code)
                            });
                            const data = await response.json();

                            if (data.valid) {
                                codeSection.classList.add('hidden');
                                passwordSection.classList.remove('hidden');
                                newPasswordInput.required = true;
                                confirmPasswordInput.required = true;
                            } else {
                                verifyErrorDiv.textContent = data.message;
                                verifyErrorDiv.classList.remove('hidden');
                                verifyBtn.textContent = 'Verify Code';
                                verifyBtn.disabled = false;
                            }
                        } catch (error) {
                            console.error('Error:', error);
                            verifyErrorDiv.textContent = 'An error occurred. Please try again.';
                            verifyErrorDiv.classList.remove('hidden');
                            verifyBtn.textContent = 'Verify Code';
                            verifyBtn.disabled = false;
                        }
                    });
                }

                // Vô hiệu hóa 'required' của 2 ô password ban đầu
                newPasswordInput.required = false;
                confirmPasswordInput.required = false;

            }); // <-- Dấu đóng của DOMContentLoaded (quan trọng!)
        </script>
    </body>
</html>

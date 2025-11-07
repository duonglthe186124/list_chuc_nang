<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi" class="scroll-smooth">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>WMS Pro - Hồ Sơ Cá Nhân</title>
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
            /* Ẩn nút Save ban đầu */
            #save-btn {
                display: none;
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
                        <c:choose>
                            <c:when test="${empty sessionScope.account}">
                                <a href="#gioi-thieu" class="font-medium text-gray-600 hover:text-indigo-600">Giới thiệu</a>
                                <a href="${pageContext.request.contextPath}/loginStaff"
                                   class="rounded-md bg-indigo-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-indigo-700">
                                    Đăng nhập
                                </a>
                            </c:when>
                            <c:otherwise>
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
                                <div class="relative" id="user-menu-container">
                                    <button id="user-menu-button"
                                            class="flex items-center space-x-2 rounded-full p-1 hover:bg-gray-100 focus:outline-none">
                                        
                                        <img class="h-8 w-8 rounded-full object-cover"
                                             src="${pageContext.request.contextPath}/${not empty sessionScope.account.avatar_url ? sessionScope.account.avatar_url : 'resources/img/default-avatar.png'}"
                                             alt="User Avatar" />
                                        <span class="hidden md:inline text-sm font-medium text-gray-700">
                                            ${sessionScope.account.fullname}
                                        </span>
                                        <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" d="m19.5 8.25-7.5 7.5-7.5-7.5" />
                                        </svg>
                                    </button>
                                    <div id="user-menu-dropdown"
                                         class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 hidden z-20">
                                        <a
                                        href="${pageContext.request.contextPath}/PersonalProfile"
                                        class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                                        >Hồ sơ</a>
                                        <c:if test="${sessionScope.account.role_id == 1}">
                                            <a href="${pageContext.request.contextPath}/account-management"
                                               class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                                                Account Management
                                            </a>
                                        </c:if>
                                        <a
                                            href="#"
                                            class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                                            >Cài đặt</a
                                        >
                                        <div class="border-t border-gray-100 my-1"></div>
                                        <a
                                            href="${pageContext.request.contextPath}/loginStaff"
                                            class="block px-4 py-2 text-sm text-red-600 hover:bg-gray-100"
                                            >Đăng xuất</a>                                   
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </nav>
                    <div class="md:hidden">
                        <%-- ... (Nút menu mobile của bạn) ... --%>
                    </div>
                </div>
            </div>
        </header>

        <main class="pt-24 pb-16">
            <div class="container mx-auto max-w-4xl px-4 sm:px-6 lg:px-8">
                
                <form id="profile-form" action="${pageContext.request.contextPath}/PersonalProfile" method="post" enctype="multipart/form-data">
                    
                    <div class="bg-white rounded-lg shadow-lg overflow-hidden md:flex">
                        
                        <aside class="md:w-1/3 p-8 bg-gray-50 border-r border-gray-200">
                            <div class="text-center">
                                <div class="w-36 h-36 mx-auto rounded-lg border-2 border-dashed border-gray-300 flex items-center justify-center mb-4 overflow-hidden">
                                    <img id="avatar-preview" 
                                         src="${pageContext.request.contextPath}/${not empty userProfile.avatar_url ? userProfile.avatar_url : 'resources/img/default-avatar.png'}"
                                         alt="Avatar" class="w-full h-full object-cover">
                                </div>
                                
                                <input type="file" id="avatar-input" name="avatar_file" accept="image/*" class="hidden">
                                
                                <button type="button" id="change-avatar-btn"
                                        class="w-full py-2 px-4 bg-gray-200 text-gray-700 font-medium rounded-lg transition duration-200 hover:bg-gray-300">
                                    Change avatar
                                </button>
                            </div>
                            
                            <a href="${pageContext.request.contextPath}/change-password" 
                               class="mt-6 w-full block py-2 px-4 bg-gray-200 text-gray-700 font-medium rounded-lg text-center transition duration-200 hover:bg-gray-300">
                                Change password
                            </a>
                        </aside>

                        <div class="md:w-2/3 p-8">
                            <h2 class="text-3xl font-bold text-gray-900 mb-6">
                                Personal Profile
                            </h2>

                            <div class="notification-area min-h-[40px] mb-4">
                                <c:if test="${not empty successMessage}">
                                    <div class="p-3 text-sm rounded-lg text-green-700 bg-green-100 border border-green-300">
                                        ${successMessage}
                                    </div>
                                </c:if>
                                <c:if test="${not empty errorMessage}">
                                    <div class="p-3 text-sm rounded-lg text-red-700 bg-red-100 border border-red-300">
                                        ${errorMessage}
                                    </div>
                                </c:if>
                            </div>

                            <div class="space-y-5">
                                <div class="flex items-center border-b border-gray-200 pb-4">
                                    <label for="fullname" class="w-28 text-sm font-medium text-gray-600">Fullname</label>
                                    <input type="text" id="fullname" name="fullname" value="${userProfile.fullname}" disabled
                                           class="flex-1 p-2 border border-transparent rounded-md bg-transparent focus:bg-white focus:border-gray-300 focus:outline-none transition duration-200">
                                </div>
                                <div class="flex items-center border-b border-gray-200 pb-4">
                                    <label for="email" class="w-28 text-sm font-medium text-gray-600">Email</label>
                                    <input type="email" id="email" name="email" value="${userProfile.email}" disabled
                                           class="flex-1 p-2 border border-transparent rounded-md bg-transparent text-gray-500 cursor-not-allowed">
                                </div>
                                <div class="flex items-center border-b border-gray-200 pb-4">
                                    <label for="phone" class="w-28 text-sm font-medium text-gray-600">Phone</label>
                                    <input type="tel" id="phone" name="phone" value="${userProfile.phone}" disabled
                                           class="flex-1 p-2 border border-transparent rounded-md bg-transparent focus:bg-white focus:border-gray-300 focus:outline-none transition duration-200">
                                </div>
                                <div class="flex items-center border-b border-gray-200 pb-4">
                                    <label for="address" class="w-28 text-sm font-medium text-gray-600">Address</label>
                                    <input type="text" id="address" name="address" value="${userProfile.address}" disabled
                                           class="flex-1 p-2 border border-transparent rounded-md bg-transparent focus:bg-white focus:border-gray-300 focus:outline-none transition duration-200">
                                </div>
                            </div>

                            <div class="flex justify-end gap-4 mt-8">
                                <button type="button" id="edit-btn" 
                                        class="py-2 px-6 bg-gray-200 text-gray-700 font-medium rounded-lg transition duration-200 hover:bg-gray-300">
                                    Edit
                                </button>
                                <button type="submit" id="save-btn" 
                                        class="py-2 px-6 bg-indigo-600 text-white font-medium rounded-lg transition duration-200 hover:bg-indigo-700">
                                    Save
                                </button>
                            </div>
                        </div> <%-- Đóng thẻ <div> (thay cho <main>) --%>
                        
                    </div>
                </form>
            </div>
        </main>
        
        <script src="${pageContext.request.contextPath}/resources/js/profile_script.js"></script>
        
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const menuButton = document.getElementById('user-menu-button');
                const dropdown = document.getElementById('user-menu-dropdown');

                if (menuButton && dropdown) {
                    menuButton.addEventListener('click', function () {
                        dropdown.classList.toggle('hidden');
                    });
                    document.addEventListener('click', function (event) {
                        if (!menuButton.contains(event.target) && !dropdown.contains(event.target)) {
                            dropdown.classList.add('hidden');
                        }
                    });
                }
            });
        </script>
    </body>
</html>
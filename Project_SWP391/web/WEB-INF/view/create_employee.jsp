<%-- 
    Document   : create_employee
    Created on : Nov 12, 2025, 1:38:27 AM
    Author     : admin
--%>

<%-- THAY THẾ TOÀN BỘ FILE BẰNG CODE NÀY --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi" class="scroll-smooth">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>WMS Pro - Create Account</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
        <style> body { font-family: "Inter", sans-serif; } </style>
    </head>
<body class="bg-gray-100 text-gray-800">

    <header class="fixed top-0 left-0 right-0 z-50 bg-white/90 backdrop-blur-md shadow-sm">
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
                                         src="https://i.postimg.cc/c6m04fpn/default-avatar-icon-of-social-media-user-vector.jpg"
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
                                        >Đăng xuất</a
                                    >
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
        <div class="container mx-auto max-w-2xl px-4">
            
            <h1 class="text-3xl font-bold text-gray-900 mb-6">Create New Staff Account</h1>
            
            <form action="${pageContext.request.contextPath}/createEmployee" method="POST" class="bg-white p-8 rounded-lg shadow-lg space-y-6">
                
                <c:if test="${not empty errorMessage}">
                    <div class="p-4 text-sm rounded-lg text-red-700 bg-red-100 border border-red-300">
                        ${errorMessage}
                    </div>
                </c:if>

                <div>
                    <label for="fullname" class="block text-sm font-medium text-gray-700">Fullname</label>
                    <input type="text" id="fullname" name="fullname" required
                           class="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500">
                </div>

                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                    <input type="email" id="email" name="email" required
                           class="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500">
                </div>
                
                <div>
                    <label for="role_id" class="block text-sm font-medium text-gray-700">Role</label>
                    <select id="role_id" name="role_id" required
                            class="mt-1 block w-full px-4 py-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500">
                        <option value="" disabled selected>-- Select a role --</option>
                        
                        <c:forEach var="role" items="${roleList}">
                            <%-- Không cho phép tạo thêm Admin hoặc Guest từ trang này --%>
                            <c:if test="${role.role_id != 1 && role.role_id != 2}">
                                <option value="${role.role_id}">${role.role_name}</option>
                            </c:if>
                        </c:forEach>
                        
                    </select>
                </div>
                
                <p class="text-sm text-gray-600">
                    A default password will be set: <strong class="font-mono">@Abcde12345</strong>. 
                    The employee can change it later.
                </p>

                <div class="flex justify-end gap-4 pt-4">
                    <a href="${pageContext.request.contextPath}/account-management"
                       class="py-2 px-6 bg-gray-200 text-gray-700 font-medium rounded-lg transition duration-200 hover:bg-gray-300">
                        Cancel
                    </a>
                    <button type="submit"
                            class="py-2 px-6 bg-indigo-600 text-white font-medium rounded-lg transition duration-200 hover:bg-indigo-700">
                        Create Account
                    </button>
                </div>
                
            </form>
        </div>
    </main>
    
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const menuButton = document.getElementById('user-menu-button');
            const dropdown = document.getElementById('user-menu-dropdown');

            if (menuButton && dropdown) {
                menuButton.addEventListener('click', function () {
                    dropdown.classList.toggle('hidden');
                });
                document.addEventListener('click', function (event) {
                    const container = document.getElementById('user-menu-container');
                    if (container && !container.contains(event.target)) {
                        dropdown.classList.add('hidden');
                    }
                });
            }
        });
    </script>
    
</body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi" class="scroll-smooth">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>WMS Pro - Quản Lý Tài Khoản</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
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
            <div class="container mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
                
                <div class="flex justify-between items-center mb-6">
                    <h1 class="text-3xl font-bold text-gray-900">Account Management</h1>
                    <a href="${pageContext.request.contextPath}/account-management" 
                       class="py-2 px-4 bg-indigo-600 text-white font-medium rounded-lg transition duration-200 hover:bg-indigo-700">
                        Update List Account
                    </a>
                </div>

                <div class="bg-white shadow-lg rounded-lg overflow-hidden">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Email</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Role</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Action</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <c:forEach var="user" items="${userList}">
                                <%-- Ngăn không cho admin tự xóa hoặc tự disable mình --%>
                                <c:set var="isSelf" value="${sessionScope.account.user_id == user.user_id}" />
                                
                                <tr class="hover:bg-gray-50">
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${user.fullname}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${user.email}</td>
                                    
                                    <td class="px-6 py-4 whitespace-nowrap text-sm">
                                        <c:choose>
                                            <c:when test="${!user.is_actived}">
                                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-200 text-gray-800">
                                                    Disabled
                                                </span>
                                            </c:when>
                                            <c:when test="${activeUserSet.contains(user.user_id)}">
                                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-200 text-green-800">
                                                    Active
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-200 text-yellow-800">
                                                    Deactive
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    
                                    <td class="px-6 py-4 whitespace-nowrap text-sm">
                                        <c:if test="${isSelf}">
                                            <%-- Nếu là chính Admin, chỉ hiển thị tên Role --%>
                                            <span class="font-medium">${user.roleName} (You)</span>
                                        </c:if>

                                        <c:if test="${!isSelf}">
                                            <%-- Nếu là user khác, hiển thị Dropdown --%>
                                            <form action="${pageContext.request.contextPath}/account-management" method="post">
                                                <input type="hidden" name="action" value="changeRole">
                                                <input type="hidden" name="userId" value="${user.user_id}">

                                                <select name="roleId" onchange="this.form.submit()" 
                                                        class="w-full p-2 border border-gray-300 rounded-md ...">

                                                    <%-- Lặp qua danh sách roleList mà Servlet đã gửi --%>
                                                    <c:forEach var="role" items="${roleList}">
                                                        <%-- Chọn (selected) vai trò hiện tại của người dùng --%>
                                                        <option value="${role.role_id}" ${role.role_id == user.role_id ? 'selected' : ''}>
                                                            ${role.role_name}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </form>
                                        </c:if>
                                    </td>
                                    
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium flex gap-2">
                                        <c:if test="${!isSelf}">
                                            <form action="${pageContext.request.contextPath}/account-management" method="post">
                                                <input type="hidden" name="userId" value="${user.user_id}">
                                                <c:choose>
                                                    <c:when test="${user.is_actived}">
                                                        <input type="hidden" name="action" value="disable">
                                                        <button type="submit" class="text-yellow-600 hover:text-yellow-900">Disable</button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input type="hidden" name="action" value="enable">
                                                        <button type="submit" class="text-green-600 hover:text-green-900">Enable</button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </form>
                                            
                                            <form action="${pageContext.request.contextPath}/account-management" method="post" 
                                                  onsubmit="return confirm('Are you sure you want to permanently delete user ${user.fullname}?');">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="userId" value="${user.user_id}">
                                                <button type="submit" class="text-red-600 hover:text-red-900">Delete</button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
        <script>
            window.onload = () => {
                const userMenuButton = document.getElementById("user-menu-button");
                const userMenuDropdown = document.getElementById("user-menu-dropdown");
                if (userMenuButton) {
                    userMenuButton.addEventListener("click", () => {
                        userMenuDropdown.classList.toggle("hidden");
                    });
                    // Đóng menu khi click ra ngoài
                    document.addEventListener("click", (event) => {
                        const container = document.getElementById("user-menu-container");
                        if (container && !container.contains(event.target)) {
                            userMenuDropdown.classList.add("hidden");
                        }
                    });
                }
            };
        </script>
    </body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Nhân sự - WMS Pro</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/employee_new.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar_new.css">
    </head>
    <body>
        <!-- Top Header -->
        <header class="top-header">
            <div class="header-content">
                <div class="header-left">
                    <a href="${pageContext.request.contextPath}/home" class="header-link">Về trang chủ</a>
                    <a href="#" class="header-link">Hỗ trợ</a>
                </div>
                <div class="header-right">
                    <div class="admin-dropdown">
                        <button class="admin-btn" id="adminBtn">
                            <div class="admin-avatar">A</div>
                            <span>Admin</span>
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <polyline points="6 9 12 15 18 9"></polyline>
                            </svg>
                        </button>
                        <div class="dropdown-menu" id="adminMenu">
                            <a href="${pageContext.request.contextPath}/PersonalProfile">Hồ sơ</a>
                            <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <!-- Main Layout -->
        <div class="main-layout">
            <!-- Sidebar -->
            <aside class="sidebar" id="sidebar">
                <div class="sidebar-header">
                    <div class="sidebar-logo">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M3.75 6A2.25 2.25 0 0 1 6 3.75h2.25A2.25 2.25 0 0 1 10.5 6v2.25a2.25 2.25 0 0 1-2.25 2.25H6a2.25 2.25 0 0 1-2.25-2.25V6ZM3.75 15.75A2.25 2.25 0 0 1 6 13.5h2.25a2.25 2.25 0 0 1 2.25 2.25V18a2.25 2.25 0 0 1-2.25 2.25H6A2.25 2.25 0 0 1 3.75 18v-2.25ZM13.5 6a2.25 2.25 0 0 1 2.25-2.25H18A2.25 2.25 0 0 1 20.25 6v2.25A2.25 2.25 0 0 1 18 10.5h-2.25A2.25 2.25 0 0 1 13.5 8.25V6ZM13.5 15.75a2.25 2.25 0 0 1 2.25-2.25H18a2.25 2.25 0 0 1 2.25 2.25V18A2.25 2.25 0 0 1 18 20.25h-2.25A2.25 2.25 0 0 1 13.5 18v-2.25Z"/>
                        </svg>
                        <span class="sidebar-brand">WMS Pro</span>
                    </div>
                </div>

                <nav class="sidebar-nav">
                    <ul class="nav-menu">
                        <li>
                            <a href="${pageContext.request.contextPath}/home" class="nav-item">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="m3 9 9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                                    <polyline points="9 22 9 12 15 12 15 22"></polyline>
                                </svg>
                                <span>Tổng quan</span>
                            </a>
                        </li>

                        <li class="nav-group">
                            <div class="nav-item nav-parent active" id="employeeMenu">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="9" cy="7" r="4"></circle>
                                    <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                    <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                                </svg>
                                <span>Quản lý Nhân sự</span>
                                <svg class="arrow-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <polyline points="6 9 12 15 18 9"></polyline>
                                </svg>
                            </div>
                            <ul class="nav-submenu" id="employeeSubmenu">
                                <li>
                                    <a href="${pageContext.request.contextPath}/employees" class="nav-subitem active">Danh sách nhân viên</a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/employees?action=add" class="nav-subitem">Thêm nhân viên mới</a>
                                </li>
                            </ul>
                        </li>

                        <li class="nav-group">
                            <div class="nav-item nav-parent" id="timekeepingMenu">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <circle cx="12" cy="12" r="10"></circle>
                                    <polyline points="12 6 12 12 16 14"></polyline>
                                </svg>
                                <span>Chấm công</span>
                                <svg class="arrow-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <polyline points="6 9 12 15 18 9"></polyline>
                                </svg>
                            </div>
                            <ul class="nav-submenu collapsed" id="timekeepingSubmenu">
                                <li><a href="${pageContext.request.contextPath}/timekeeping" class="nav-subitem">Chấm công</a></li>
                                <li><a href="${pageContext.request.contextPath}/timekeeping?action=history" class="nav-subitem">Lịch sử chấm công</a></li>
                            </ul>
                        </li>

                        <li class="nav-group">
                            <div class="nav-item nav-parent" id="salaryMenu">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <line x1="12" y1="1" x2="12" y2="23"></line>
                                    <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
                                </svg>
                                <span>Lương & Thưởng</span>
                                <svg class="arrow-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <polyline points="6 9 12 15 18 9"></polyline>
                                </svg>
                            </div>
                            <ul class="nav-submenu collapsed" id="salarySubmenu">
                                <li><a href="${pageContext.request.contextPath}/payrolls" class="nav-subitem">Danh sách lương</a></li>
                                <li><a href="${pageContext.request.contextPath}/payrolls?action=add" class="nav-subitem">Thêm bảng lương</a></li>
                            </ul>
                        </li>

                        <li class="nav-group">
                            <div class="nav-item nav-parent" id="scheduleMenu">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                    <line x1="16" y1="2" x2="16" y2="6"></line>
                                    <line x1="8" y1="2" x2="8" y2="6"></line>
                                    <line x1="3" y1="10" x2="21" y2="10"></line>
                                </svg>
                                <span>Lịch làm việc</span>
                                <svg class="arrow-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <polyline points="6 9 12 15 18 9"></polyline>
                                </svg>
                            </div>
                            <ul class="nav-submenu collapsed" id="scheduleSubmenu">
                                <li><a href="${pageContext.request.contextPath}/shifts" class="nav-subitem">Danh sách ca làm việc</a></li>
                                <li><a href="${pageContext.request.contextPath}/shifts?action=add" class="nav-subitem">Thêm ca làm việc</a></li>
                            </ul>
                        </li>
                    </ul>
                </nav>

                <div class="sidebar-footer">
                    <button class="collapse-btn" id="collapseBtn">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <polyline points="11 17 6 12 11 7"></polyline>
                            <polyline points="18 17 13 12 18 7"></polyline>
                        </svg>
                        <span id="collapseText">Thu gọn</span>
                    </button>
                </div>
            </aside>

            <!-- Main Content -->
            <main class="main-content">
                <!-- Page Header -->
                <div class="page-header">
                    <div class="page-title-section">
                        <h1 class="page-title">Quản lý Nhân sự</h1>
                        <p class="page-subtitle">Quản lý thông tin nhân viên, chấm công, lương thưởng và lịch làm việc</p>
                    </div>
                    <div class="page-actions">
                        <a href="${pageContext.request.contextPath}/employees?action=add" class="btn btn-primary">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <line x1="12" y1="5" x2="12" y2="19"></line>
                                <line x1="5" y1="12" x2="19" y2="12"></line>
                            </svg>
                            + Thêm nhân viên mới
                        </a>
                        <a href="${pageContext.request.contextPath}/payrolls" class="btn btn-info">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <line x1="12" y1="1" x2="12" y2="23"></line>
                                <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
                            </svg>
                            Lương & Thưởng
                        </a>
                        <a href="${pageContext.request.contextPath}/shifts" class="btn btn-secondary">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                <line x1="16" y1="2" x2="16" y2="6"></line>
                                <line x1="8" y1="2" x2="8" y2="6"></line>
                                <line x1="3" y1="10" x2="21" y2="10"></line>
                            </svg>
                            Lịch làm việc
                        </a>
                    </div>
                </div>

                <!-- Stats Cards -->
                <div class="stats-grid">
                    <div class="stat-card stat-blue">
                        <div class="stat-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                <circle cx="9" cy="7" r="4"></circle>
                                <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                            </svg>
                        </div>
                        <div class="stat-content">
                            <div class="stat-value">${employees.size()}</div>
                            <div class="stat-label">Tổng nhân viên</div>
                        </div>
                    </div>

                    <div class="stat-card stat-green">
                        <div class="stat-icon">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                                <polyline points="22 4 12 14.01 9 11.01"></polyline>
                            </svg>
                        </div>
                        <div class="stat-content">
                            <div class="stat-value">
                                <c:set var="activeCount" value="${0}"/>
                                <c:forEach var="e" items="${employees}">
                                    <c:if test="${e.is_actived}">
                                        <c:set var="activeCount" value="${activeCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${activeCount}
                            </div>
                            <div class="stat-label">Đang làm việc (trang này)</div>
                        </div>
                    </div>
                </div>

                <!-- Employee Table -->
                <div class="content-card">
                    <div class="card-header">
                        <h2 class="card-title">Danh sách nhân viên</h2>
                        <div class="card-info">
                            Tổng cộng: <strong>${totalEmployees}</strong> nhân viên
                        </div>
                    </div>

                    <div class="table-wrapper">
                        <table class="employee-table">
                            <thead>
                                <tr>
                                    <th>MÃ NV</th>
                                    <th>HỌ TÊN</th>
                                    <th>EMAIL</th>
                                    <th>ĐIỆN THOẠI</th>
                                    <th>CHỨC VỤ</th>
                                    <th>VAI TRÒ</th>
                                    <th>TRẠNG THÁI</th>
                                    <th>THAO TÁC</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="emp" items="${employees}">
                                    <tr>
                                        <td><strong class="emp-code">${emp.employee_code}</strong></td>
                                        <td>
                                            <div class="user-info">
                                                <div class="avatar">${emp.fullname.charAt(0)}</div>
                                                <span class="user-name">${emp.fullname}</span>
                                            </div>
                                        </td>
                                        <td>${emp.email}</td>
                                        <td>${emp.phone}</td>
                                        <td><span class="badge badge-default">${emp.position_name}</span></td>
                                        <td><span class="badge badge-gray">${emp.role_name}</span></td>
                                        <td>
                                            <span class="status-badge ${emp.is_actived ? 'status-active' : 'status-inactive'}">
                                                ${emp.is_actived ? 'ĐANG LÀM VIỆC' : 'NGHỈ VIỆC'}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <a href="${pageContext.request.contextPath}/employees?action=view&id=${emp.employee_id}" 
                                                   class="action-btn action-view" title="Xem chi tiết">
                                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                        <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                                        <circle cx="12" cy="12" r="3"></circle>
                                                    </svg>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/employees?action=edit&id=${emp.employee_id}" 
                                                   class="action-btn action-edit" title="Sửa">
                                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                        <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                                                        <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                                                    </svg>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/employees?action=delete&id=${emp.employee_id}" 
                                                   class="action-btn action-delete" 
                                                   title="Xóa"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa nhân viên ${emp.fullname}?')">
                                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                        <polyline points="3 6 5 6 21 6"></polyline>
                                                        <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                                    </svg>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty employees}">
                                    <tr>
                                        <td colspan="8" class="empty-state">
                                            <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1" opacity="0.3">
                                                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                                <circle cx="9" cy="7" r="4"></circle>
                                                <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                                <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                                            </svg>
                                            <p>Chưa có nhân viên nào trong hệ thống</p>
                                            <a href="${pageContext.request.contextPath}/employees?action=add" class="btn btn-primary">Thêm nhân viên đầu tiên</a>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <c:if test="${totalPages > 1}">
                    <div class="pagination-container">
                        <div class="pagination">
                            <c:if test="${pageIndex > 1}">
                                <a href="${pageContext.request.contextPath}/employees?page=${pageIndex - 1}" class="page-btn">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <polyline points="15 18 9 12 15 6"></polyline>
                                    </svg>
                                </a>
                            </c:if>
                            <c:if test="${pageIndex <= 1}">
                                <span class="page-btn disabled">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <polyline points="15 18 9 12 15 6"></polyline>
                                    </svg>
                                </span>
                            </c:if>

                            <c:choose>
                                <c:when test="${totalPages <= 7}">
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <a href="${pageContext.request.contextPath}/employees?page=${i}" 
                                           class="page-btn ${i == pageIndex ? 'active' : ''}">${i}</a>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <c:if test="${pageIndex > 3}">
                                        <a href="${pageContext.request.contextPath}/employees?page=1" class="page-btn">1</a>
                                        <span class="page-dots">...</span>
                                    </c:if>
                                    
                                    <c:choose>
                                        <c:when test="${pageIndex <= 3}">
                                            <c:forEach begin="1" end="5" var="i">
                                                <a href="${pageContext.request.contextPath}/employees?page=${i}" 
                                                   class="page-btn ${i == pageIndex ? 'active' : ''}">${i}</a>
                                            </c:forEach>
                                        </c:when>
                                        <c:when test="${pageIndex >= totalPages - 2}">
                                            <c:forEach begin="${totalPages - 4}" end="${totalPages}" var="i">
                                                <a href="${pageContext.request.contextPath}/employees?page=${i}" 
                                                   class="page-btn ${i == pageIndex ? 'active' : ''}">${i}</a>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach begin="${pageIndex - 2}" end="${pageIndex + 2}" var="i">
                                                <a href="${pageContext.request.contextPath}/employees?page=${i}" 
                                                   class="page-btn ${i == pageIndex ? 'active' : ''}">${i}</a>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                    <c:if test="${pageIndex < totalPages - 2}">
                                        <span class="page-dots">...</span>
                                        <a href="${pageContext.request.contextPath}/employees?page=${totalPages}" 
                                           class="page-btn">${totalPages}</a>
                                    </c:if>
                                </c:otherwise>
                            </c:choose>

                            <c:if test="${pageIndex < totalPages}">
                                <a href="${pageContext.request.contextPath}/employees?page=${pageIndex + 1}" class="page-btn">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <polyline points="9 18 15 12 9 6"></polyline>
                                    </svg>
                                </a>
                            </c:if>
                            <c:if test="${pageIndex >= totalPages}">
                                <span class="page-btn disabled">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <polyline points="9 18 15 12 9 6"></polyline>
                                    </svg>
                                </span>
                            </c:if>
                        </div>
                    </div>
                    </c:if>
                </div>
            </main>
        </div>

        <script>
            // Admin dropdown
            const adminBtn = document.getElementById('adminBtn');
            const adminMenu = document.getElementById('adminMenu');
            
            if (adminBtn && adminMenu) {
                adminBtn.addEventListener('click', (e) => {
                    e.stopPropagation();
                    adminMenu.classList.toggle('show');
                });
                
                document.addEventListener('click', () => {
                    adminMenu.classList.remove('show');
                });
            }

            // Sidebar collapse
            const collapseBtn = document.getElementById('collapseBtn');
            const sidebar = document.getElementById('sidebar');
            const collapseText = document.getElementById('collapseText');
            const mainContent = document.querySelector('.main-content');
            
            if (collapseBtn && sidebar && mainContent) {
                collapseBtn.addEventListener('click', () => {
                    sidebar.classList.toggle('collapsed');
                    if (sidebar.classList.contains('collapsed')) {
                        collapseText.textContent = '<< Thu gọn';
                        mainContent.style.marginLeft = '80px';
                    } else {
                        collapseText.textContent = 'Thu gọn';
                        mainContent.style.marginLeft = '260px';
                    }
                });
            }

            // Menu toggle
            const menuItems = document.querySelectorAll('.nav-parent');
            menuItems.forEach(item => {
                item.addEventListener('click', function(e) {
                    e.preventDefault();
                    const submenu = this.nextElementSibling;
                    if (submenu && submenu.classList.contains('nav-submenu')) {
                        submenu.classList.toggle('collapsed');
                        this.classList.toggle('active');
                    }
                });
            });

            // Auto-expand employee menu on page load
            document.addEventListener('DOMContentLoaded', function() {
                const employeeSubmenu = document.getElementById('employeeSubmenu');
                const employeeMenu = document.getElementById('employeeMenu');
                if (employeeSubmenu && employeeMenu) {
                    employeeSubmenu.classList.remove('collapsed');
                    employeeMenu.classList.add('active');
                }
            });
        </script>
    </body>
</html>
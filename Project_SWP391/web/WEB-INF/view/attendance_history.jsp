<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lịch sử chấm công - WMS Pro</title>
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
            <!-- Sidebar (same as timekeeping.jsp) -->
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
                            <div class="nav-item nav-parent" id="employeeMenu">
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
                            <ul class="nav-submenu collapsed" id="employeeSubmenu">
                                <li><a href="${pageContext.request.contextPath}/employees" class="nav-subitem">Danh sách nhân viên</a></li>
                                <li><a href="${pageContext.request.contextPath}/employees?action=add" class="nav-subitem">Thêm nhân viên mới</a></li>
                            </ul>
                        </li>

                        <li class="nav-group">
                            <div class="nav-item nav-parent active" id="timekeepingMenu">
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <circle cx="12" cy="12" r="10"></circle>
                                    <polyline points="12 6 12 12 16 14"></polyline>
                                </svg>
                                <span>Chấm công</span>
                                <svg class="arrow-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <polyline points="6 9 12 15 18 9"></polyline>
                                </svg>
                            </div>
                            <ul class="nav-submenu" id="timekeepingSubmenu">
                                <li><a href="${pageContext.request.contextPath}/timekeeping" class="nav-subitem">Chấm công</a></li>
                                <li><a href="${pageContext.request.contextPath}/timekeeping?action=history" class="nav-subitem active">Lịch sử chấm công</a></li>
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
                        <h1 class="page-title">Lịch sử chấm công</h1>
                        <p class="page-subtitle">Xem lịch sử chấm công vào/ra</p>
                    </div>
                    <div class="page-actions">
                        <a href="${pageContext.request.contextPath}/timekeeping" class="btn btn-primary">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <circle cx="12" cy="12" r="10"></circle>
                                <polyline points="12 6 12 12 16 14"></polyline>
                            </svg>
                            Chấm công
                        </a>
                    </div>
                </div>

                <!-- Attendance History Table -->
                <div class="content-card">
                    <div class="card-header">
                        <h2 class="card-title">Lịch sử chấm công</h2>
                        <div class="card-info">
                            Tổng cộng: <strong>${attendances.size()}</strong> bản ghi
                        </div>
                    </div>

                    <!-- Filter Section -->
                    <div style="padding: 20px; border-bottom: 1px solid #e5e7eb; background: #f9fafb;">
                        <form action="${pageContext.request.contextPath}/timekeeping" method="GET" style="display: flex; gap: 16px; align-items: flex-end; flex-wrap: wrap;">
                            <input type="hidden" name="action" value="history">
                            
                            <div style="flex: 1; min-width: 120px;">
                                <label style="display: block; margin-bottom: 8px; font-weight: 600; color: #374151; font-size: 14px;">Loại filter</label>
                                <select name="filter" id="filterType" style="width: 100%; padding: 8px 12px; border: 1px solid #d1d5db; border-radius: 6px; font-size: 14px; background: white;" onchange="updateFilterFields()">
                                    <option value="month" ${filterType == 'month' ? 'selected' : ''}>Theo tháng</option>
                                    <option value="week" ${filterType == 'week' ? 'selected' : ''}>Theo tuần</option>
                                </select>
                            </div>
                            
                            <div id="monthFilter" style="flex: 1; min-width: 120px; ${filterType == 'month' ? '' : 'display: none;'}">
                                <label style="display: block; margin-bottom: 8px; font-weight: 600; color: #374151; font-size: 14px;">Tháng</label>
                                <select name="month" style="width: 100%; padding: 8px 12px; border: 1px solid #d1d5db; border-radius: 6px; font-size: 14px; background: white;">
                                    <c:forEach var="m" begin="1" end="12">
                                        <option value="${m}" ${selectedMonth == m ? 'selected' : ''}>Tháng ${m}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div id="weekFilter" style="flex: 1; min-width: 120px; ${filterType == 'week' ? '' : 'display: none;'}">
                                <label style="display: block; margin-bottom: 8px; font-weight: 600; color: #374151; font-size: 14px;">Tuần</label>
                                <select name="week" style="width: 100%; padding: 8px 12px; border: 1px solid #d1d5db; border-radius: 6px; font-size: 14px; background: white;">
                                    <c:forEach var="w" begin="1" end="53">
                                        <option value="${w}" ${selectedWeek == w ? 'selected' : ''}>Tuần ${w}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div style="flex: 1; min-width: 120px;">
                                <label style="display: block; margin-bottom: 8px; font-weight: 600; color: #374151; font-size: 14px;">Năm</label>
                                <select name="year" style="width: 100%; padding: 8px 12px; border: 1px solid #d1d5db; border-radius: 6px; font-size: 14px; background: white;">
                                    <c:forEach var="y" begin="${currentYear - 2}" end="${currentYear + 1}">
                                        <option value="${y}" ${selectedYear == y ? 'selected' : ''}>${y}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div style="flex: 0 0 auto;">
                                <button type="submit" class="btn btn-primary" style="padding: 8px 24px; white-space: nowrap;">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="display: inline-block; vertical-align: middle; margin-right: 8px;">
                                        <circle cx="11" cy="11" r="8"></circle>
                                        <path d="m21 21-4.35-4.35"></path>
                                    </svg>
                                    Lọc
                                </button>
                            </div>
                        </form>
                    </div>

                    <div class="table-wrapper">
                        <table class="employee-table">
                            <thead>
                                <tr>
                                    <c:if test="${isAdmin}">
                                        <th>NHÂN VIÊN</th>
                                        <th>MÃ NV</th>
                                    </c:if>
                                    <th>NGÀY</th>
                                    <th>CA LÀM VIỆC</th>
                                    <th>CHECK IN</th>
                                    <th>CHECK OUT</th>
                                    <th>GIỜ LÀM VIỆC</th>
                                    <th>VỊ TRÍ</th>
                                    <th>VAI TRÒ</th>
                                    <th>GHI CHÚ</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="att" items="${attendances}">
                                    <tr>
                                        <c:if test="${isAdmin}">
                                            <td>
                                                <div style="font-weight: 600; color: #1e293b;">${att.employee_name}</div>
                                            </td>
                                            <td>
                                                <span class="badge badge-blue">${att.employee_code}</span>
                                            </td>
                                        </c:if>
                                        <td>
                                            <strong><fmt:formatDate value="${att.check_in}" pattern="dd/MM/yyyy" /></strong>
                                        </td>
                                        <td>
                                            <div>
                                                <div style="font-weight: 600; color: #1e293b;">${att.shift_name}</div>
                                                <div style="font-size: 12px; color: #64748b;">${att.start_time} - ${att.end_time}</div>
                                            </div>
                                        </td>
                                        <td>
                                            <span style="font-weight: 600; color: #3b82f6;">
                                                <fmt:formatDate value="${att.check_in}" pattern="HH:mm:ss" />
                                            </span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${att.check_out != null}">
                                                    <span style="font-weight: 600; color: #10b981;">
                                                        <fmt:formatDate value="${att.check_out}" pattern="HH:mm:ss" />
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: #94a3b8; font-style: italic;">Chưa check out</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${att.check_out != null}">
                                                    <span class="status-badge status-active">${att.hours_worked} giờ</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: #94a3b8;">-</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${att.location_code != null ? att.location_code : 'N/A'}</td>
                                        <td><span class="badge badge-gray">${att.role_in_shift}</span></td>
                                        <td>${att.note != null ? att.note : '-'}</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty attendances}">
                                    <tr>
                                        <td colspan="${isAdmin ? 10 : 8}" class="empty-state">
                                            <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1" opacity="0.3">
                                                <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                                <line x1="16" y1="2" x2="16" y2="6"></line>
                                                <line x1="8" y1="2" x2="8" y2="6"></line>
                                                <line x1="3" y1="10" x2="21" y2="10"></line>
                                            </svg>
                                            <p>Chưa có lịch sử chấm công</p>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
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

            // Auto-expand timekeeping menu on page load
            document.addEventListener('DOMContentLoaded', function() {
                const timekeepingSubmenu = document.getElementById('timekeepingSubmenu');
                const timekeepingMenu = document.getElementById('timekeepingMenu');
                if (timekeepingSubmenu && timekeepingMenu) {
                    timekeepingSubmenu.classList.remove('collapsed');
                    timekeepingMenu.classList.add('active');
                }
            });
            
            // Update filter fields based on filter type
            function updateFilterFields() {
                const filterType = document.getElementById('filterType').value;
                const monthFilter = document.getElementById('monthFilter');
                const weekFilter = document.getElementById('weekFilter');
                
                if (filterType === 'month') {
                    monthFilter.style.display = 'block';
                    weekFilter.style.display = 'none';
                } else if (filterType === 'week') {
                    monthFilter.style.display = 'none';
                    weekFilter.style.display = 'block';
                }
            }
            
            // Initialize filter fields on page load
            updateFilterFields();
        </script>
    </body>
</html>



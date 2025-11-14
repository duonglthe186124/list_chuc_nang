<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chấm công - WMS Pro</title>
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
                                <li>
                                    <a href="${pageContext.request.contextPath}/employees" class="nav-subitem">Danh sách nhân viên</a>
                                </li>
                                <li>
                                    <a href="${pageContext.request.contextPath}/employees?action=add" class="nav-subitem">Thêm nhân viên mới</a>
                                </li>
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
                                <li><a href="${pageContext.request.contextPath}/timekeeping" class="nav-subitem active">Chấm công</a></li>
                                <li><a href="${pageContext.request.contextPath}/timekeeping?action=admin" class="nav-subitem">Quản lý chấm công</a></li>
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
                        <h1 class="page-title">Chấm công</h1>
                        <p class="page-subtitle">Chấm công vào/ra ca làm việc</p>
                    </div>
                    <div class="page-actions">
                        <a href="${pageContext.request.contextPath}/timekeeping?action=history" class="btn btn-secondary">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                <line x1="16" y1="2" x2="16" y2="6"></line>
                                <line x1="8" y1="2" x2="8" y2="6"></line>
                                <line x1="3" y1="10" x2="21" y2="10"></line>
                            </svg>
                            Lịch sử chấm công
                        </a>
                    </div>
                </div>

                <!-- Messages -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success" style="margin: 0 0 24px 0; padding: 16px 20px; border-radius: 8px; background: #d1fae5; color: #065f46; border: 1px solid #10b981; display: flex; align-items: center; gap: 12px;">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <polyline points="20 6 9 17 4 12"></polyline>
                        </svg>
                        ${successMessage}
                    </div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-error" style="margin: 0 0 24px 0; padding: 16px 20px; border-radius: 8px; background: #fee2e2; color: #991b1b; border: 1px solid #ef4444; display: flex; align-items: center; gap: 12px;">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="12" cy="12" r="10"></circle>
                            <line x1="12" y1="8" x2="12" y2="12"></line>
                            <line x1="12" y1="16" x2="12.01" y2="16"></line>
                        </svg>
                        ${errorMessage}
                    </div>
                </c:if>

                <!-- Today's Shifts -->
                <div class="content-card">
                    <div class="card-header">
                        <h2 class="card-title">Ca làm việc hôm nay</h2>
                        <div class="card-info">
                            <jsp:useBean id="now" class="java.util.Date"/>
                            <fmt:formatDate value="${now}" pattern="dd/MM/yyyy" />
                        </div>
                    </div>

                    <c:choose>
                        <c:when test="${empty todayAssignments}">
                            <div class="empty-state" style="text-align: center; padding: 60px 20px;">
                                <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1" opacity="0.3" style="margin-bottom: 16px; color: #94a3b8;">
                                    <circle cx="12" cy="12" r="10"></circle>
                                    <polyline points="12 6 12 12 16 14"></polyline>
                                </svg>
                                <p style="color: #64748b; font-size: 16px; margin-bottom: 24px;">Bạn không có ca làm việc nào hôm nay</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div style="padding: 24px; display: grid; grid-template-columns: repeat(auto-fill, minmax(350px, 1fr)); gap: 20px;">
                                <c:forEach var="assign" items="${todayAssignments}">
                                    <c:set var="attendance" value="${null}"/>
                                    <c:forEach var="att" items="${todayAttendances}">
                                        <c:if test="${att.assign_id == assign.assign_id}">
                                            <c:set var="attendance" value="${att}"/>
                                        </c:if>
                                    </c:forEach>
                                    
                                    <div style="background: white; border: 2px solid ${attendance != null && attendance.check_out != null ? '#10b981' : attendance != null ? '#fbbf24' : '#e5e7eb'}; border-radius: 12px; padding: 20px; transition: all 0.2s; ${attendance != null && attendance.check_out != null ? 'background: #f0fdf4;' : attendance != null ? 'background: #fffbeb;' : ''}">
                                        <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 16px;">
                                            <div>
                                                <h3 style="margin: 0 0 4px 0; font-size: 18px; font-weight: 600; color: #1e293b;">${assign.shift_name}</h3>
                                                <p style="margin: 0; color: #64748b; font-size: 14px;">${assign.start_time} - ${assign.end_time}</p>
                                            </div>
                                            <c:if test="${attendance != null && attendance.check_out != null}">
                                                <span style="display: inline-block; padding: 6px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; background: #d1fae5; color: #065f46;">Đã hoàn thành</span>
                                            </c:if>
                                            <c:if test="${attendance != null && attendance.check_out == null}">
                                                <span style="display: inline-block; padding: 6px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; background: #fef3c7; color: #92400e;">Đang làm việc</span>
                                            </c:if>
                                            <c:if test="${attendance == null}">
                                                <span style="display: inline-block; padding: 6px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; background: #fee2e2; color: #991b1b;">Chưa chấm công</span>
                                            </c:if>
                                        </div>
                                        
                                        <div style="margin-bottom: 16px;">
                                            <div style="display: flex; justify-content: space-between; padding: 8px 0; border-bottom: 1px solid #f1f5f9;">
                                                <span style="font-weight: 500; color: #64748b;">Vị trí:</span>
                                                <span>${assign.location_code != null ? assign.location_code : 'N/A'}</span>
                                            </div>
                                            <div style="display: flex; justify-content: space-between; padding: 8px 0;">
                                                <span style="font-weight: 500; color: #64748b;">Vai trò:</span>
                                                <span>${assign.role_in_shift}</span>
                                            </div>
                                        </div>
                                        
                                        <c:if test="${attendance != null}">
                                            <div style="margin-bottom: 16px; padding: 12px; background: #f8fafc; border-radius: 8px;">
                                                <div style="display: flex; justify-content: space-between; padding: 6px 0;">
                                                    <span style="font-weight: 500; color: #64748b;">Check in:</span>
                                                    <span style="font-weight: 600;"><fmt:formatDate value="${attendance.check_in}" pattern="HH:mm:ss" /></span>
                                                </div>
                                                <c:if test="${attendance.check_out != null}">
                                                    <div style="display: flex; justify-content: space-between; padding: 6px 0; border-top: 1px solid #e5e7eb; margin-top: 8px;">
                                                        <span style="font-weight: 500; color: #64748b;">Check out:</span>
                                                        <span style="font-weight: 600;"><fmt:formatDate value="${attendance.check_out}" pattern="HH:mm:ss" /></span>
                                                    </div>
                                                    <div style="display: flex; justify-content: space-between; padding: 6px 0; border-top: 1px solid #e5e7eb; margin-top: 8px;">
                                                        <span style="font-weight: 500; color: #64748b;">Giờ làm việc:</span>
                                                        <span style="font-weight: 700; color: #3b82f6;">${attendance.hours_worked} giờ</span>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </c:if>
                                        
                                        <div style="margin-top: 16px; padding-top: 16px; border-top: 1px solid #e5e7eb;">
                                            <c:if test="${attendance == null}">
                                                <form action="${pageContext.request.contextPath}/timekeeping" method="POST" style="margin: 0;" class="checkin-form" onsubmit="return handleCheckIn(this);">
                                                    <input type="hidden" name="action" value="checkin">
                                                    <input type="hidden" name="assign_id" value="${assign.assign_id}">
                                                    <button type="submit" class="btn btn-primary" style="width: 100%;" id="checkin-btn-${assign.assign_id}">
                                                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="display: inline-block; vertical-align: middle; margin-right: 8px;">
                                                            <circle cx="12" cy="12" r="10"></circle>
                                                            <polyline points="12 6 12 12 16 14"></polyline>
                                                        </svg>
                                                        Check In
                                                    </button>
                                                </form>
                                            </c:if>
                                            <c:if test="${attendance != null && attendance.check_out == null}">
                                                <form action="${pageContext.request.contextPath}/timekeeping" method="POST" style="margin: 0;" class="checkout-form" onsubmit="return handleCheckOut(this);">
                                                    <input type="hidden" name="action" value="checkout">
                                                    <input type="hidden" name="attendance_id" value="${attendance.attendance_id}">
                                                    <button type="submit" class="btn btn-secondary" style="width: 100%;" id="checkout-btn-${attendance.attendance_id}">
                                                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="display: inline-block; vertical-align: middle; margin-right: 8px;">
                                                            <circle cx="12" cy="12" r="10"></circle>
                                                            <polyline points="12 6 12 12 16 14"></polyline>
                                                        </svg>
                                                        Check Out
                                                    </button>
                                                </form>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
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

            // Handle check-in form submission
            function handleCheckIn(form) {
                const button = form.querySelector('button[type="submit"]');
                const assignId = form.querySelector('input[name="assign_id"]').value;
                
                // Disable button and show loading state
                if (button) {
                    button.disabled = true;
                    button.innerHTML = '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="display: inline-block; vertical-align: middle; margin-right: 8px; animation: spin 1s linear infinite;"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>Đang xử lý...';
                }
                
                // Allow form to submit normally
                return true;
            }

            // Handle check-out form submission
            function handleCheckOut(form) {
                const button = form.querySelector('button[type="submit"]');
                const attendanceId = form.querySelector('input[name="attendance_id"]').value;
                
                // Disable button and show loading state
                if (button) {
                    button.disabled = true;
                    button.innerHTML = '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="display: inline-block; vertical-align: middle; margin-right: 8px; animation: spin 1s linear infinite;"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>Đang xử lý...';
                }
                
                // Allow form to submit normally
                return true;
            }

            // Add CSS animation for loading spinner
            const style = document.createElement('style');
            style.textContent = `
                @keyframes spin {
                    from { transform: rotate(0deg); }
                    to { transform: rotate(360deg); }
                }
                .btn:disabled {
                    opacity: 0.6;
                    cursor: not-allowed;
                }
            `;
            document.head.appendChild(style);
        </script>
    </body>
</html>


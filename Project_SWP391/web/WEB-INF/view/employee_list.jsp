<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý nhân viên - StockPhone</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/employee.css">
    </head>
    <body>
        <nav class="nav">
            <div class="brand">
                <a href="${pageContext.request.contextPath}/home">
                    <div class="logo">📱</div>
                </a>
                <div>
                    <h1>StockPhone</h1>
                    <p>Phone Stock Management System</p>
                </div>
            </div>
            <div class="navlinks">
                <a href="${pageContext.request.contextPath}/home">Home</a>
                <a href="${pageContext.request.contextPath}/employees" class="active">Nhân viên</a>
                <a href="${pageContext.request.contextPath}/products">Sản phẩm</a>
            </div>
        </nav>

        <main class="container">
            <div class="page-header">
                <div>
                    <h2><span class="icon">👥</span> Quản lý nhân viên</h2>
                    <p class="subtitle">Quản lý thông tin nhân viên trong hệ thống</p>
                </div>
                <div style="display: flex; gap: 12px; flex-wrap: wrap;">
                    <a href="${pageContext.request.contextPath}/payrolls" class="btn btn-info btn-icon">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <line x1="12" y1="1" x2="12" y2="23"></line>
                            <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
                        </svg>
                        Lương & Thưởng
                    </a>
                    <a href="${pageContext.request.contextPath}/shifts" class="btn btn-secondary btn-icon">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                            <line x1="16" y1="2" x2="16" y2="6"></line>
                            <line x1="8" y1="2" x2="8" y2="6"></line>
                            <line x1="3" y1="10" x2="21" y2="10"></line>
                        </svg>
                        Lịch làm việc
                    </a>
                    <a href="${pageContext.request.contextPath}/employees?action=add" class="btn btn-primary btn-icon">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <line x1="12" y1="5" x2="12" y2="19"></line>
                            <line x1="5" y1="12" x2="19" y2="12"></line>
                        </svg>
                        Thêm nhân viên
                    </a>
                </div>
            </div>

            <!-- Messages -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <polyline points="20 6 9 17 4 12"></polyline>
                    </svg>
                    ${successMessage}
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="12" cy="12" r="10"></circle>
                        <line x1="12" y1="8" x2="12" y2="12"></line>
                        <line x1="12" y1="16" x2="12.01" y2="16"></line>
                    </svg>
                    ${errorMessage}
                </div>
            </c:if>

            <!-- Stats Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon blue">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                            <circle cx="9" cy="7" r="4"></circle>
                            <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                            <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                        </svg>
                    </div>
                    <div class="stat-info">
                        <h3>${employees.size()}</h3>
                        <p>Tổng nhân viên</p>
                    </div>
                </div>
                <div class="stat-card green-card">
                    <div class="stat-icon green">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                            <polyline points="22 4 12 14.01 9 11.01"></polyline>
                        </svg>
                    </div>
                    <div class="stat-info">
                        <h3><c:set var="activeCount" value="${0}"/><c:forEach var="e" items="${employees}"><c:if test="${e.is_actived}"><c:set var="activeCount" value="${activeCount + 1}"/></c:if></c:forEach>${activeCount}</h3>
                        <p>Đang làm việc (trang này)</p>
                    </div>
                </div>
            </div>

            <!-- Employee table -->
            <div class="card">
                <div class="table-header">
                    <h3>Danh sách nhân viên</h3>
                    <div class="table-info">
                        Tổng cộng: <strong>${totalEmployees}</strong> nhân viên
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="employee-table">
                        <thead>
                            <tr>
                                <th>Mã NV</th>
                                <th>Họ tên</th>
                                <th>Email</th>
                                <th>Điện thoại</th>
                                <th>Chức vụ</th>
                                <th>Vai trò</th>
                                <th>Trạng thái</th>
                                <th class="text-center">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="emp" items="${employees}">
                                <tr>
                                    <td><strong class="emp-code">${emp.employee_code}</strong></td>
                                    <td>
                                        <div class="user-info">
                                            <div class="avatar">${emp.fullname.charAt(0)}</div>
                                            <div>
                                                <div class="name">${emp.fullname}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>${emp.email}</td>
                                    <td>${emp.phone}</td>
                                    <td><span class="tag">${emp.position_name}</span></td>
                                    <td><span class="tag tag-gray">${emp.role_name}</span></td>
                                    <td>
                                        <span class="badge ${emp.is_actived ? 'badge-success' : 'badge-danger'}">
                                            ${emp.is_actived ? 'Đang làm việc' : 'Nghỉ việc'}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/employees?action=view&id=${emp.employee_id}" 
                                               class="btn-action btn-view" title="Xem chi tiết">
                                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                    <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                                    <circle cx="12" cy="12" r="3"></circle>
                                                </svg>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/employees?action=edit&id=${emp.employee_id}" 
                                               class="btn-action btn-edit" title="Sửa">
                                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                    <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                                                    <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                                                </svg>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/employees?action=delete&id=${emp.employee_id}" 
                                               class="btn-action btn-delete" 
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
                        <!-- Previous Button -->
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

                        <!-- Page Numbers -->
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

                        <!-- Next Button -->
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
                    
                    <div class="pagination-info">
                        Trang ${pageIndex} / ${totalPages}
                        <span class="page-range">
                            (Hiển thị ${(pageIndex - 1) * pageSize + 1} - ${pageIndex * pageSize > totalEmployees ? totalEmployees : pageIndex * pageSize} trong ${totalEmployees})
                        </span>
                    </div>
                </div>
                </c:if>
            </div>
        </main>
    </body>
</html>

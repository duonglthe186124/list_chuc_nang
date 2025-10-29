<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lịch làm việc - StockPhone</title>
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
                <a href="${pageContext.request.contextPath}/employees">Nhân viên</a>
                <a href="${pageContext.request.contextPath}/shifts" class="active">Lịch làm việc</a>
                <a href="${pageContext.request.contextPath}/products">Sản phẩm</a>
            </div>
        </nav>

        <main class="container">
            <div class="page-header">
                <div>
                    <h2><span class="icon">📅</span> Lịch làm việc nhân viên</h2>
                    <p class="subtitle">Quản lý phân công ca làm việc cho nhân viên</p>
                </div>
                <a href="${pageContext.request.contextPath}/shifts?action=add" class="btn btn-primary btn-icon">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <line x1="12" y1="5" x2="12" y2="19"></line>
                        <line x1="5" y1="12" x2="19" y2="12"></line>
                    </svg>
                    Tạo lịch làm việc
                </a>
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

            <!-- Shift Table -->
            <div class="card">
                <div class="table-header">
                    <h3>Danh sách phân công ca làm việc</h3>
                </div>
                <div class="table-responsive">
                    <table class="employee-table">
                        <thead>
                            <tr>
                                <th>Ngày làm việc</th>
                                <th>Ca làm việc</th>
                                <th>Thời gian</th>
                                <th>Nhân viên</th>
                                <th>Vị trí</th>
                                <th>Vai trò ca</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="assign" items="${assignments}">
                                <tr>
                                    <td>
                                        <strong>
                                            <fmt:formatDate value="${assign.assign_date}" pattern="dd/MM/yyyy"/>
                                        </strong>
                                    </td>
                                    <td>
                                        <span class="shift-badge">${assign.shift_name}</span>
                                    </td>
                                    <td>
                                        <div class="time-range">
                                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="color: #10b981;">
                                                <circle cx="12" cy="12" r="10"></circle>
                                                <polyline points="12 6 12 12 16 14"></polyline>
                                            </svg>
                                            <span>${assign.start_time} - ${assign.end_time}</span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="user-info">
                                            <div class="avatar-small">${assign.employee_name.charAt(0)}</div>
                                            <div>
                                                <div class="name">${assign.employee_name}</div>
                                                <div class="emp-code-small">${assign.employee_code}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty assign.location_code}">
                                                <span class="tag">${assign.location_code}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="tag tag-gray">Chưa gán</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <span class="tag tag-gray">${assign.role_in_shift}</span>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/shifts?action=edit&id=${assign.assign_id}" 
                                               class="btn-action btn-edit" title="Sửa">
                                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                    <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                                                    <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                                                </svg>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/shifts?action=delete&id=${assign.assign_id}" 
                                               class="btn-action btn-delete" 
                                               title="Xóa"
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa phân công này?')">
                                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                    <polyline points="3 6 5 6 21 6"></polyline>
                                                    <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                                </svg>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty assignments}">
                                <tr>
                                    <td colspan="7" class="empty-state">
                                        <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1" opacity="0.3">
                                            <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                            <line x1="16" y1="2" x2="16" y2="6"></line>
                                            <line x1="8" y1="2" x2="8" y2="6"></line>
                                            <line x1="3" y1="10" x2="21" y2="10"></line>
                                        </svg>
                                        <p>Chưa có phân công ca làm việc nào</p>
                                        <a href="${pageContext.request.contextPath}/shifts?action=add" class="btn btn-primary">Tạo lịch làm việc đầu tiên</a>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </body>
</html>


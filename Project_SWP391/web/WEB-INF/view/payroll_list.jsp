<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý lương - StockPhone</title>
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
                <a href="${pageContext.request.contextPath}/shifts">Lịch làm việc</a>
                <a href="${pageContext.request.contextPath}/payrolls" class="active">Lương & Thưởng</a>
                <a href="${pageContext.request.contextPath}/products">Sản phẩm</a>
            </div>
        </nav>

        <main class="container">
            <div class="page-header">
                <div>
                    <h2><span class="icon">💰</span> Quản lý lương & thưởng</h2>
                    <p class="subtitle">Quản lý bảng lương và thưởng cho nhân viên</p>
                </div>
                <a href="${pageContext.request.contextPath}/payrolls?action=add" class="btn btn-primary btn-icon">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <line x1="12" y1="5" x2="12" y2="19"></line>
                        <line x1="5" y1="12" x2="19" y2="12"></line>
                    </svg>
                    Tạo bảng lương
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

            <!-- Payroll Table -->
            <div class="card">
                <div class="table-header">
                    <h3>Danh sách bảng lương</h3>
                </div>
                <div class="table-responsive">
                    <table class="employee-table">
                        <thead>
                            <tr>
                                <th>Nhân viên</th>
                                <th>Kỳ lương</th>
                                <th>Tổng thu</th>
                                <th>Thực lĩnh</th>
                                <th>Ngày tạo</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="payroll" items="${payrolls}">
                                <tr>
                                    <td>
                                        <div class="user-info">
                                            <div class="avatar-small">${payroll.employee_name.charAt(0)}</div>
                                            <div>
                                                <div class="name">${payroll.employee_name}</div>
                                                <div class="emp-code-small">${payroll.employee_code}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div>
                                            <fmt:formatDate value="${payroll.period_start}" pattern="dd/MM/yyyy"/>
                                            <span style="margin: 0 4px;">-</span>
                                            <fmt:formatDate value="${payroll.period_end}" pattern="dd/MM/yyyy"/>
                                        </div>
                                    </td>
                                    <td>
                                        <strong style="color: #10b981;">
                                            <fmt:formatNumber value="${payroll.gross_amount}" type="currency" currencyCode="VND"/>
                                        </strong>
                                    </td>
                                    <td>
                                        <strong style="color: #06b6d4; font-size: 16px;">
                                            <fmt:formatNumber value="${payroll.net_amount}" type="currency" currencyCode="VND"/>
                                        </strong>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${payroll.created_at}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/payrolls?action=view&id=${payroll.payroll_id}" 
                                               class="btn-action btn-view" title="Xem chi tiết">
                                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                    <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                                    <circle cx="12" cy="12" r="3"></circle>
                                                </svg>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/payrolls?action=delete&id=${payroll.payroll_id}" 
                                               class="btn-action btn-delete" 
                                               title="Xóa"
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa bảng lương này?')">
                                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                                    <polyline points="3 6 5 6 21 6"></polyline>
                                                    <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                                                </svg>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty payrolls}">
                                <tr>
                                    <td colspan="6" class="empty-state">
                                        <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1" opacity="0.3">
                                            <line x1="12" y1="1" x2="12" y2="23"></line>
                                            <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
                                        </svg>
                                        <p>Chưa có bảng lương nào</p>
                                        <a href="${pageContext.request.contextPath}/payrolls?action=add" class="btn btn-primary">Tạo bảng lương đầu tiên</a>
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


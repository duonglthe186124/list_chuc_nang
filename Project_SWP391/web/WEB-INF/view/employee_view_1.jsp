<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết nhân viên - StockPhone</title>
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
                <a href="${pageContext.request.contextPath}/products">Sản phẩm</a>
            </div>
        </nav>

        <main class="container">
            <div class="page-header">
                <h2>Chi tiết nhân viên: ${employee.employee_code}</h2>
                <a href="${pageContext.request.contextPath}/employees" class="btn btn-secondary">
                    ← Quay lại
                </a>
            </div>

            <div class="card">
                <div class="employee-detail">
                    <div class="detail-section">
                        <h3>📋 Thông tin cá nhân</h3>
                        <table class="detail-table">
                            <tr>
                                <td class="label">Mã nhân viên:</td>
                                <td><strong>${employee.employee_code}</strong></td>
                            </tr>
                            <tr>
                                <td class="label">Họ và tên:</td>
                                <td>${employee.fullname}</td>
                            </tr>
                            <tr>
                                <td class="label">Email:</td>
                                <td>${employee.email}</td>
                            </tr>
                            <tr>
                                <td class="label">Số điện thoại:</td>
                                <td>${employee.phone}</td>
                            </tr>
                            <tr>
                                <td class="label">Địa chỉ:</td>
                                <td>${employee.address}</td>
                            </tr>
                        </table>
                    </div>

                    <div class="detail-section">
                        <h3>💼 Thông tin công việc</h3>
                        <table class="detail-table">
                            <tr>
                                <td class="label">Chức vụ:</td>
                                <td>${employee.position_name}</td>
                            </tr>
                            <tr>
                                <td class="label">Vai trò:</td>
                                <td>${employee.role_name}</td>
                            </tr>
                            <tr>
                                <td class="label">Ngày tuyển dụng:</td>
                                <td><fmt:formatDate value="${employee.hire_date}" pattern="dd/MM/yyyy"/></td>
                            </tr>
                            <tr>
                                <td class="label">Người quản lý:</td>
                                <td>${employee.boss_name}</td>
                            </tr>
                            <tr>
                                <td class="label">Trạng thái:</td>
                                <td>
                                    <span class="badge ${employee.is_actived ? 'badge-success' : 'badge-danger'}">
                                        ${employee.is_actived ? 'Đang làm việc' : 'Nghỉ việc'}
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div class="detail-section">
                        <h3>💰 Thông tin tài chính</h3>
                        <table class="detail-table">
                            <tr>
                                <td class="label">Số tài khoản:</td>
                                <td>${employee.bank_account != null ? employee.bank_account : 'Chưa có'}</td>
                            </tr>
                        </table>
                    </div>

                    <div class="detail-actions">
                        <a href="${pageContext.request.contextPath}/employees?action=edit&id=${employee.employee_id}" 
                           class="btn btn-primary">✏️ Sửa thông tin</a>
                        <a href="${pageContext.request.contextPath}/employees?action=delete&id=${employee.employee_id}" 
                           class="btn btn-danger"
                           onclick="return confirm('Bạn có chắc chắn muốn xóa nhân viên này?')">🗑️ Xóa</a>
                    </div>
                </div>
            </div>
        </main>
    </body>
</html>


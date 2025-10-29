<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tạo lịch làm việc - StockPhone</title>
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
                    <h2><span class="icon">➕</span> Tạo lịch làm việc</h2>
                    <p class="subtitle">Phân công ca làm việc cho nhân viên</p>
                </div>
                <a href="${pageContext.request.contextPath}/shifts" class="btn btn-secondary btn-icon">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <line x1="19" y1="12" x2="5" y2="12"></line>
                        <polyline points="12 19 5 12 12 5"></polyline>
                    </svg>
                    Quay lại
                </a>
            </div>

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

            <div class="form-container">
                <form action="${pageContext.request.contextPath}/shifts" method="POST" class="employee-form">
                    <input type="hidden" name="action" value="add">

                    <div class="form-section">
                        <div class="section-header">
                            <div class="section-icon">📅</div>
                            <div>
                                <h3>Thông tin phân công</h3>
                                <p>Chọn nhân viên, ca làm việc và ngày</p>
                            </div>
                        </div>

                        <div class="form-grid-2">
                            <div class="form-group">
                                <label for="employee_id">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                        <circle cx="12" cy="7" r="4"></circle>
                                    </svg>
                                    Nhân viên *
                                </label>
                                <select id="employee_id" name="employee_id" required>
                                    <option value="">-- Chọn nhân viên --</option>
                                    <c:forEach var="emp" items="${employees}">
                                        <option value="${emp.employee_id}">${emp.employee_code} - ${emp.fullname}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="assign_date">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                        <line x1="16" y1="2" x2="16" y2="6"></line>
                                        <line x1="8" y1="2" x2="8" y2="6"></line>
                                        <line x1="3" y1="10" x2="21" y2="10"></line>
                                    </svg>
                                    Ngày làm việc *
                                </label>
                                <input type="date" id="assign_date" name="assign_date" required>
                            </div>
                        </div>

                        <div class="form-grid-2">
                            <div class="form-group">
                                <label for="shift_id">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <circle cx="12" cy="12" r="10"></circle>
                                        <polyline points="12 6 12 12 16 14"></polyline>
                                    </svg>
                                    Ca làm việc *
                                </label>
                                <select id="shift_id" name="shift_id" required>
                                    <option value="">-- Chọn ca làm việc --</option>
                                    <c:forEach var="shift" items="${shifts}">
                                        <option value="${shift.shift_id}">
                                            ${shift.name} (${shift.start_time} - ${shift.end_time})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="location_id">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
                                        <circle cx="12" cy="10" r="3"></circle>
                                    </svg>
                                    Vị trí (tùy chọn)
                                </label>
                                    <select id="location_id" name="location_id">
                                        <option value="null">-- Không có --</option>
                                        <c:forEach var="loc" items="${locations}">
                                            <option value="${loc.location_id}">${loc.code} - Khu vực ${loc.area} - Lối ${loc.aisle} - Vị trí ${loc.slot}</option>
                                        </c:forEach>
                                    </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="role_in_shift">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="9" cy="7" r="4"></circle>
                                    <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                    <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                                </svg>
                                Vai trò trong ca *
                            </label>
                            <input type="text" id="role_in_shift" name="role_in_shift" required 
                                   placeholder="Ví dụ: Trưởng ca, Nhân viên, Giám sát..."
                                   value="Nhân viên">
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary btn-icon">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <polyline points="20 6 9 17 4 12"></polyline>
                            </svg>
                            Tạo lịch làm việc
                        </button>
                        <a href="${pageContext.request.contextPath}/shifts" class="btn btn-secondary">
                            Hủy bỏ
                        </a>
                    </div>
                </form>
            </div>
        </main>

        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const today = new Date().toISOString().split('T')[0];
                document.getElementById('assign_date').value = today;
            });
        </script>
    </body>
</html>


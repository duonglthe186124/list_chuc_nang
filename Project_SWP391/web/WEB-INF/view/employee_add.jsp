<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thêm nhân viên - StockPhone</title>
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
                    <h2><span class="icon">➕</span> Thêm nhân viên mới</h2>
                    <p class="subtitle">Điền thông tin để thêm nhân viên vào hệ thống</p>
                </div>
                <a href="${pageContext.request.contextPath}/employees" class="btn btn-secondary btn-icon">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <line x1="19" y1="12" x2="5" y2="12"></line>
                        <polyline points="12 19 5 12 12 5"></polyline>
                    </svg>
                    Quay lại
                </a>
            </div>

            <!-- Error message -->
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
                <form action="${pageContext.request.contextPath}/employees" method="POST" class="employee-form">
                    <input type="hidden" name="action" value="add">

                    <!-- Section 1: Thông tin tài khoản -->
                    <div class="form-section">
                        <div class="section-header">
                            <div class="section-icon">🔐</div>
                            <div>
                                <h3>Thông tin tài khoản</h3>
                                <p>Thông tin đăng nhập và liên lạc</p>
                            </div>
                        </div>
                        
                        <div class="form-grid-2">
                            <div class="form-group">
                                <label for="email">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                                        <polyline points="22,6 12,13 2,6"></polyline>
                                    </svg>
                                    Email *
                                </label>
                                <input type="email" id="email" name="email" required placeholder="email@example.com">
                            </div>

                            <div class="form-group">
                                <label for="password">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                                        <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                                    </svg>
                                    Mật khẩu *
                                </label>
                                <input type="password" id="password" name="password" required placeholder="••••••••">
                            </div>
                        </div>

                        <div class="form-grid-2">
                            <div class="form-group">
                                <label for="fullname">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                        <circle cx="12" cy="7" r="4"></circle>
                                    </svg>
                                    Họ và tên *
                                </label>
                                <input type="text" id="fullname" name="fullname" required placeholder="Nguyễn Văn A">
                            </div>

                            <div class="form-group">
                                <label for="phone">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
                                    </svg>
                                    Số điện thoại *
                                </label>
                                <input type="text" id="phone" name="phone" required placeholder="0123456789">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="address">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
                                    <circle cx="12" cy="10" r="3"></circle>
                                </svg>
                                Địa chỉ *
                            </label>
                            <input type="text" id="address" name="address" required placeholder="123 Đường ABC, Quận XYZ, TP. Hồ Chí Minh">
                        </div>

                        <div class="form-group">
                            <label for="sec_address">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
                                </svg>
                                Địa chỉ phụ (tùy chọn)
                            </label>
                            <input type="text" id="sec_address" name="sec_address" placeholder="Số nhà, tên đường, ...">
                        </div>

                        <div class="form-grid-2">
                            <div class="form-group">
                                <label for="role_id">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                        <circle cx="9" cy="7" r="4"></circle>
                                        <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                        <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                                    </svg>
                                    Vai trò *
                                </label>
                                <select id="role_id" name="role_id" required>
                                    <option value="">-- Chọn vai trò --</option>
                                    <c:forEach var="role" items="${roles}">
                                        <option value="${role.role_id}">${role.role_name}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="is_actived">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <polyline points="22 12 18 12 15 21 9 3 6 12 2 12"></polyline>
                                    </svg>
                                    Trạng thái
                                </label>
                                <select id="is_actived" name="is_actived">
                                    <option value="true">✅ Đang làm việc</option>
                                    <option value="false">❌ Nghỉ việc</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <!-- Section 2: Thông tin nhân viên -->
                    <div class="form-section">
                        <div class="section-header">
                            <div class="section-icon">👔</div>
                            <div>
                                <h3>Thông tin nhân viên</h3>
                                <p>Thông tin chức vụ và công việc</p>
                            </div>
                        </div>

                        <div class="form-grid-2">
                            <div class="form-group">
                                <label for="employee_code">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <line x1="4" y1="9" x2="20" y2="9"></line>
                                        <line x1="4" y1="15" x2="20" y2="15"></line>
                                        <line x1="10" y1="3" x2="8" y2="21"></line>
                                        <line x1="16" y1="3" x2="14" y2="21"></line>
                                    </svg>
                                    Mã nhân viên *
                                </label>
                                <input type="text" id="employee_code" name="employee_code" required 
                                       value="${nextEmployeeCode}" placeholder="HRMA001" 
                                       pattern="[A-Z]{2,4}\d{3}" title="Format: Prefix + 3 số (ví dụ: HRMA001, IS003, ES001)">
                                <small class="helper-text">Format: Prefix (2-4 chữ cái) + 3 số (ví dụ: HRMA001, IS003, ES001, AD002)</small>
                            </div>

                            <div class="form-group">
                                <label for="hire_date">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                        <line x1="16" y1="2" x2="16" y2="6"></line>
                                        <line x1="8" y1="2" x2="8" y2="6"></line>
                                        <line x1="3" y1="10" x2="21" y2="10"></line>
                                    </svg>
                                    Ngày tuyển dụng *
                                </label>
                                <input type="date" id="hire_date" name="hire_date" required>
                            </div>
                        </div>

                        <div class="form-grid-2">
                            <div class="form-group">
                                <label for="position_id">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path>
                                    </svg>
                                    Chức vụ *
                                </label>
                                <select id="position_id" name="position_id" required>
                                    <option value="">-- Chọn chức vụ --</option>
                                    <c:forEach var="pos" items="${positions}">
                                        <option value="${pos.position_id}">${pos.position_name}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="boss_id">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                        <circle cx="9" cy="7" r="4"></circle>
                                        <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                        <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                                    </svg>
                                    Người quản lý (tùy chọn)
                                </label>
                                <select id="boss_id" name="boss_id">
                                    <option value="null">-- Không có --</option>
                                    <c:forEach var="emp" items="${existingEmployees}">
                                        <option value="${emp.employee_id}">${emp.employee_code} - ${emp.fullname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="bank_account">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <rect x="1" y="4" width="22" height="16" rx="2" ry="2"></rect>
                                    <line x1="1" y1="10" x2="23" y2="10"></line>
                                </svg>
                                Số tài khoản ngân hàng (tùy chọn)
                            </label>
                            <input type="text" id="bank_account" name="bank_account" placeholder="1234567890">
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary btn-icon">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <polyline points="20 6 9 17 4 12"></polyline>
                            </svg>
                            Thêm nhân viên
                        </button>
                        <a href="${pageContext.request.contextPath}/employees" class="btn btn-secondary">
                            Hủy bỏ
                        </a>
                    </div>
                </form>
            </div>
        </main>

        <script>
            // Set default date to today
            document.addEventListener('DOMContentLoaded', function() {
                const today = new Date().toISOString().split('T')[0];
                document.getElementById('hire_date').value = today;
                
                // Auto-generate employee code when role is selected
                const roleSelect = document.getElementById('role_id');
                const employeeCodeInput = document.getElementById('employee_code');
                
                if (roleSelect && employeeCodeInput) {
                    // Convert input to uppercase automatically
                    employeeCodeInput.addEventListener('input', function() {
                        this.value = this.value.toUpperCase();
                    });
                    
                    roleSelect.addEventListener('change', function() {
                        const roleId = this.value;
                        if (roleId && roleId !== '') {
                            // Fetch new employee code from server
                            fetch('${pageContext.request.contextPath}/employees?action=generateCode&role_id=' + roleId)
                                .then(response => response.json())
                                .then(data => {
                                    if (data.code) {
                                        employeeCodeInput.value = data.code.toUpperCase();
                                    } else if (data.error) {
                                        console.error('Error generating code:', data.error);
                                    }
                                })
                                .catch(error => {
                                    console.error('Error:', error);
                                });
                        }
                    });
                }
            });
        </script>
    </body>
</html>

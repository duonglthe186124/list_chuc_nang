<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tạo bảng lương - StockPhone</title>
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
                    <h2><span class="icon">➕</span> Tạo bảng lương</h2>
                    <p class="subtitle">Tạo bảng lương và các khoản thu nhập cho nhân viên</p>
                </div>
                <a href="${pageContext.request.contextPath}/payrolls" class="btn btn-secondary btn-icon">
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
                <form action="${pageContext.request.contextPath}/payrolls" method="POST" class="employee-form" id="payrollForm">
                    <input type="hidden" name="action" value="add">

                    <div class="form-section">
                        <div class="section-header">
                            <div class="section-icon">👤</div>
                            <div>
                                <h3>Thông tin nhân viên & kỳ lương</h3>
                                <p>Chọn nhân viên và thời kỳ tính lương</p>
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
                                <label for="period_start">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                        <line x1="16" y1="2" x2="16" y2="6"></line>
                                        <line x1="8" y1="2" x2="8" y2="6"></line>
                                        <line x1="3" y1="10" x2="21" y2="10"></line>
                                    </svg>
                                    Từ ngày *
                                </label>
                                <input type="date" id="period_start" name="period_start" required>
                            </div>

                            <div class="form-group">
                                <label for="period_end">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
                                        <line x1="16" y1="2" x2="16" y2="6"></line>
                                        <line x1="8" y1="2" x2="8" y2="6"></line>
                                        <line x1="3" y1="10" x2="21" y2="10"></line>
                                    </svg>
                                    Đến ngày *
                                </label>
                                <input type="date" id="period_end" name="period_end" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-section">
                        <div class="section-header">
                            <div class="section-icon">💵</div>
                            <div>
                                <h3>Các khoản thu</h3>
                                <p>Lương cơ bản và các phụ cấp</p>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="basic_salary">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <line x1="12" y1="1" x2="12" y2="23"></line>
                                    <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
                                </svg>
                                Lương cơ bản (VND) *
                            </label>
                            <input type="number" id="basic_salary" name="basic_salary" step="1000" min="0" required placeholder="0">
                        </div>

                        <div class="form-grid-2">
                            <div class="form-group">
                                <label for="lunch_allowance">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <circle cx="12" cy="12" r="10"></circle>
                                        <circle cx="12" cy="12" r="6"></circle>
                                        <circle cx="12" cy="12" r="2"></circle>
                                    </svg>
                                    Phụ cấp ăn trưa (VND)
                                </label>
                                <input type="number" id="lunch_allowance" name="lunch_allowance" step="1000" min="0" placeholder="0">
                            </div>

                            <div class="form-group">
                                <label for="travel_allowance">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <circle cx="12" cy="12" r="10"></circle>
                                        <polyline points="12 6 12 12 16 14"></polyline>
                                    </svg>
                                    Phụ cấp xăng xe (VND)
                                </label>
                                <input type="number" id="travel_allowance" name="travel_allowance" step="1000" min="0" placeholder="0">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="bonus">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                    <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
                                </svg>
                                Thưởng (VND)
                            </label>
                            <input type="number" id="bonus" name="bonus" step="1000" min="0" placeholder="0">
                        </div>
                    </div>

                    <div class="form-section">
                        <div class="section-header">
                            <div class="section-icon">📉</div>
                            <div>
                                <h3>Các khoản khấu trừ</h3>
                                <p>Bảo hiểm và thuế</p>
                            </div>
                        </div>

                        <div class="form-grid-2">
                            <div class="form-group">
                                <label for="social_insurance">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect>
                                        <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path>
                                    </svg>
                                    Bảo hiểm xã hội (8%)
                                </label>
                                <input type="number" id="social_insurance" name="social_insurance" step="1000" min="0" placeholder="0">
                            </div>

                            <div class="form-group">
                                <label for="health_insurance">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
                                        <line x1="3" y1="9" x2="21" y2="9"></line>
                                        <line x1="9" y1="21" x2="9" y2="9"></line>
                                    </svg>
                                    Bảo hiểm y tế (1.5%)
                                </label>
                                <input type="number" id="health_insurance" name="health_insurance" step="1000" min="0" placeholder="0">
                            </div>

                            <div class="form-group">
                                <label for="unemployment_insurance">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <polygon points="22 3 2 3 10 12.46 10 19 14 21 14 12.46 22 3"></polygon>
                                    </svg>
                                    Bảo hiểm thất nghiệp (1%)
                                </label>
                                <input type="number" id="unemployment_insurance" name="unemployment_insurance" step="1000" min="0" placeholder="0">
                            </div>

                            <div class="form-group">
                                <label for="personal_income_tax">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path>
                                        <polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline>
                                        <line x1="12" y1="22.08" x2="12" y2="12"></line>
                                    </svg>
                                    Thuế TNCN (VND)
                                </label>
                                <input type="number" id="personal_income_tax" name="personal_income_tax" step="1000" min="0" placeholder="0">
                            </div>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary btn-icon">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <polyline points="20 6 9 17 4 12"></polyline>
                            </svg>
                            Tạo bảng lương
                        </button>
                        <a href="${pageContext.request.contextPath}/payrolls" class="btn btn-secondary">
                            Hủy bỏ
                        </a>
                    </div>
                </form>
            </div>
        </main>

        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Set default date for period (current month)
                const today = new Date();
                const firstDay = new Date(today.getFullYear(), today.getMonth(), 1);
                const lastDay = new Date(today.getFullYear(), today.getMonth() + 1, 0);
                
                document.getElementById('period_start').value = firstDay.toISOString().split('T')[0];
                document.getElementById('period_end').value = lastDay.toISOString().split('T')[0];
            });
        </script>
    </body>
</html>


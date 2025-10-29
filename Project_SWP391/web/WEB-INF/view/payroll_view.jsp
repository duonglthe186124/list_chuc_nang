<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết bảng lương - StockPhone</title>
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
                    <h2><span class="icon">👁️</span> Chi tiết bảng lương</h2>
                    <p class="subtitle">${payroll.employee_name} - ${payroll.employee_code}</p>
                </div>
                <a href="${pageContext.request.contextPath}/payrolls" class="btn btn-secondary btn-icon">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <line x1="19" y1="12" x2="5" y2="12"></line>
                        <polyline points="12 19 5 12 12 5"></polyline>
                    </svg>
                    Quay lại
                </a>
            </div>

            <div class="form-container">
                <div class="form-section">
                    <div class="section-header">
                        <div class="section-icon">📅</div>
                        <div>
                            <h3>Thông tin kỳ lương</h3>
                            <p>Chi tiết về thời gian tính lương</p>
                        </div>
                    </div>

                    <div class="detail-table-wrapper">
                        <table class="detail-table">
                            <tr>
                                <td class="label">Kỳ lương:</td>
                                <td>
                                    <strong>
                                        <fmt:formatDate value="${payroll.period_start}" pattern="dd/MM/yyyy"/>
                                        - 
                                        <fmt:formatDate value="${payroll.period_end}" pattern="dd/MM/yyyy"/>
                                    </strong>
                                </td>
                            </tr>
                            <tr>
                                <td class="label">Ngày tạo:</td>
                                <td><fmt:formatDate value="${payroll.created_at}" pattern="dd/MM/yyyy HH:mm"/></td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="form-section">
                    <div class="section-header">
                        <div class="section-icon">💵</div>
                        <div>
                            <h3>Các khoản thu</h3>
                            <p>Lương và các khoản phụ cấp</p>
                        </div>
                    </div>

                    <table class="detail-table">
                        <c:forEach var="comp" items="${payroll.components}">
                            <c:if test="${comp.comp_type.contains('Lương') || comp.comp_type.contains('Phụ cấp') || comp.comp_type.contains('Thưởng')}">
                                <tr>
                                    <td class="label">${comp.comp_type}:</td>
                                    <td style="text-align: right; color: #10b981; font-weight: 600;">
                                        <fmt:formatNumber value="${comp.amount}" type="currency" currencyCode="VND"/>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        <tr style="border-top: 2px solid #e2e8f0; background: #f8fafc;">
                            <td class="label"><strong>Tổng thu:</strong></td>
                            <td style="text-align: right; color: #10b981; font-weight: 700; font-size: 16px;">
                                <fmt:formatNumber value="${payroll.gross_amount}" type="currency" currencyCode="VND"/>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="form-section">
                    <div class="section-header">
                        <div class="section-icon">📉</div>
                        <div>
                            <h3>Các khoản khấu trừ</h3>
                            <p>Bảo hiểm và thuế</p>
                        </div>
                    </div>

                    <table class="detail-table">
                        <c:forEach var="comp" items="${payroll.components}">
                            <c:if test="${!comp.comp_type.contains('Lương') && !comp.comp_type.contains('Phụ cấp') && !comp.comp_type.contains('Thưởng')}">
                                <tr>
                                    <td class="label">${comp.comp_type}:</td>
                                    <td style="text-align: right; color: #ef4444; font-weight: 600;">
                                        -<fmt:formatNumber value="${comp.amount}" type="currency" currencyCode="VND"/>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </table>
                </div>

                <div class="form-section">
                    <div class="section-header">
                        <div class="section-icon" style="background: linear-gradient(135deg, #06b6d4, #4f46e5);">💰</div>
                        <div>
                            <h3>Tổng kết</h3>
                            <p>Thực lĩnh của nhân viên</p>
                        </div>
                    </div>

                    <div style="background: linear-gradient(135deg, #06b6d4, #4f46e5); padding: 32px; border-radius: 16px; text-align: center;">
                        <p style="color: white; font-size: 14px; margin-bottom: 8px; opacity: 0.9;">TỔNG THỰC LĨNH</p>
                        <h2 style="color: white; font-size: 36px; margin: 0; font-weight: 700;">
                            <fmt:formatNumber value="${payroll.net_amount}" type="currency" currencyCode="VND"/>
                        </h2>
                    </div>
                </div>
            </div>
        </main>
    </body>
</html>


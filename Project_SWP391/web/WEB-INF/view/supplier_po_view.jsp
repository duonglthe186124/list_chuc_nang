<%-- 
    Document   : supplier_po_view
    Created on : Nov 12, 2025, 2:55:36 AM
    Author     : ASUS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Phiếu Mua Hàng ${poheader.po_code}</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
        <style>
            body {
                font-family: "Inter", sans-serif;
            }
        </style>
    </head>
    <body class="p-4 md:p-8">
        <div class="max-w-4xl mx-auto bg-white shadow-xl rounded-lg overflow-hidden">

            <c:if test="${poheader == null}">
                <div class="p-8 text-center bg-white">
                    <h2 class="text-2xl font-semibold text-red-600">Lỗi Truy Cập</h2>
                    <p class="text-gray-600 mt-2">${error != null ? error : 'Link xác nhận không hợp lệ hoặc đã hết hạn.'}</p>
                </div>
            </c:if>

            <c:if test="${poheader != null}">
                <div class="p-6 md:p-8 bg-indigo-600 text-white flex justify-between items-center">
                    <div>
                        <h1 class="text-3xl font-extrabold tracking-tight">PHIẾU MUA HÀNG (PURCHASE ORDER)</h1>
                        <p class="mt-1 text-indigo-200">Đơn hàng được tạo từ hệ thống WMS Pro</p>
                    </div>
                    <div class="text-right">
                        <span class="block text-2xl font-bold">#${poheader.po_code}</span>
                        <span class="inline-flex items-center px-3 py-0.5 mt-1 rounded-full text-sm font-medium
                              <c:choose>
                                  <c:when test="${poheader.status eq 'DRAFT'}">bg-yellow-100 text-yellow-800</c:when>
                                  <c:when test="${poheader.status eq 'PENDING'}">bg-blue-100 text-blue-800</c:when>
                                  <c:when test="${poheader.status eq 'CONFIRMED'}">bg-green-100 text-green-800</c:when>
                                  <c:when test="${poheader.status eq 'COMPLETED'}">bg-indigo-100 text-indigo-800</c:when>
                                  <c:when test="${poheader.status eq 'CANCELLED'}">bg-red-100 text-red-800</c:when>
                                  <c:otherwise>bg-gray-100 text-gray-800</c:otherwise>
                              </c:choose>">
                            <c:out value="${poheader.status}"/>
                        </span>
                    </div>
                </div>

                <div class="p-6 md:p-8 grid grid-cols-1 md:grid-cols-2 gap-6 border-b border-gray-200">
                    <div>
                        <h3 class="text-lg font-semibold text-gray-700 mb-2 border-b pb-1">THÔNG TIN NHÀ CUNG CẤP</h3>
                        <p class="text-gray-800 font-medium">${supplier.supplier_name}</p>
                        <p class="text-sm text-gray-600">${supplier.address}</p>
                        <p class="text-sm text-gray-600">Email: ${supplier.email}</p>
                        <p class="text-sm text-gray-600">SĐT: ${supplier.phone}</p>
                    </div>
                    <div class="text-left md:text-right">
                        <h3 class="text-lg font-semibold text-gray-700 mb-2 border-b pb-1">THÔNG TIN ĐƠN HÀNG</h3>
                        <p class="text-sm text-gray-600">Ngày tạo: 
                            <span class="font-medium text-gray-800">${poheader.created_at}</span>
                        </p>
                        <p class="text-sm text-gray-600">Người tạo: 
                            <span class="font-medium text-gray-800">${poheader.created_by}</span>
                        </p>
                        <p class="text-sm text-gray-600 mt-2">Ghi chú: 
                            <span class="font-normal text-gray-800">${poheader.note}</span>
                        </p>
                    </div>
                </div>

                <div class="p-6 md:p-8">
                    <h3 class="text-xl font-semibold text-gray-700 mb-4">Danh Sách Sản Phẩm</h3>
                    <div class="overflow-x-auto border border-gray-200 rounded-lg">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">STT</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Mã sản phẩm</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tên sản phẩm</th>
                                    <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Đơn giá</th>
                                    <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Số lượng</th>
                                    <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <c:set var="totalAmount" value="0"/>
                                <c:forEach var="item" items="${poline}" varStatus="loop">
                                    <tr>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${loop.index + 1}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${item.sku_code}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">${item.product_name}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-right text-gray-700">
                                            <fmt:formatNumber value="${item.unit_price}" type="number" maxFractionDigits="0"/> VNĐ
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-right text-gray-700">
                                            <fmt:formatNumber value="${item.qty_ordered}" type="number" maxFractionDigits="0"/>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-bold text-right text-gray-900">
                                            <c:set var="subtotal" value="${item.qty_ordered * item.unit_price}"/>
                                            <c:set var="totalAmount" value="${totalAmount + subtotal}"/>
                                            <fmt:formatNumber value="${subtotal}" type="number" maxFractionDigits="0"/> VNĐ
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="p-6 md:p-8 bg-gray-50 border-t border-gray-200 flex flex-col md:flex-row justify-between items-start md:items-center">
                    <div class="mb-4 md:mb-0">
                        <p class="text-xl font-semibold text-gray-700">TỔNG CỘNG:</p>
                        <p class="text-3xl font-extrabold text-indigo-600">
                            <fmt:formatNumber value="${totalAmount}" type="number" maxFractionDigits="0"/> VNĐ
                        </p>
                    </div>

                    <c:choose>
                        <c:when test="${poheader.status eq 'PENDING'}">
                            <form method="POST" action="${pageContext.request.contextPath}/confirm">
                                <input type="hidden" name="poId" value="${param.poId}" />
                                <input type="hidden" name="token" value="${param.token}" />
                                <button type="submit"
                                        class="w-full md:w-auto px-8 py-3 border border-transparent text-lg font-medium rounded-md shadow-lg text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-4 focus:ring-offset-2 focus:ring-green-500 transition duration-150 ease-in-out"
                                        onclick="return confirm('Bạn có chắc chắn muốn xác nhận đơn hàng này không? Hành động này không thể hoàn tác.')">
                                    XÁC NHẬN ĐƠN HÀNG
                                </button>
                                <p class="text-sm text-gray-500 mt-2 text-center">Bằng cách xác nhận, bạn đồng ý với các điều khoản.</p>
                            </form>
                        </c:when>
                        <c:when test="${poheader.status eq 'CONFIRM'}">
                            <div class="text-center md:text-right">
                                <p class="text-xl font-bold text-green-600">Đơn hàng ĐÃ ĐƯỢC XÁC NHẬN</p>
                                <p class="text-sm text-gray-500">Chúng tôi sẽ tiến hành các bước tiếp theo.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center md:text-right">
                                <p class="text-xl font-bold text-red-600">Không thể xác nhận</p>
                                <p class="text-sm text-gray-500">Đơn hàng đang ở trạng thái "${poheader.status}".</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="p-4 bg-gray-100 text-center text-xs text-gray-500">
                    Đây là tài liệu chỉ dành cho nhà cung cấp. Vui lòng không chia sẻ.
                </div>

            </c:if>

        </div>
    </body>
</html>
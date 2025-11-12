<%-- 
    Document   : success_confirmation
    Created on : Nov 12, 2025, 3:50:30 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Xác nhận Thành công</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <style> body {
            font-family: "Inter", sans-serif;
            background-color: #f1f5f9;
        } </style>
    </head>
    <body class="p-4 md:p-8">
        <div class="max-w-lg mx-auto bg-white shadow-xl rounded-lg p-8 text-center mt-20">
            <svg class="mx-auto h-16 w-16 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
            <h2 class="mt-4 text-3xl font-extrabold text-gray-900">Xác Nhận Thành Công!</h2>
            <p class="mt-2 text-lg text-gray-600">${message != null ? message : 'Phiếu mua hàng đã được xác nhận thành công.'}</p>
            <p class="mt-4 text-sm text-gray-500">Hệ thống của chúng tôi đã ghi nhận. Bạn có thể đóng cửa sổ này.</p>
        </div>
    </body>
</html>
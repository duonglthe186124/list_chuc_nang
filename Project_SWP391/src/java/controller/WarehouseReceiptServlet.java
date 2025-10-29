/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import model.Users;
import service.WarehouseImportService;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "WarehouseReceiptServlet", urlPatterns = {"/warehouse/receipt"})
public class WarehouseReceiptServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // (Sẽ load NCC, Sản phẩm ở đây sau)
        request.getRequestDispatcher("/WEB-INF/view/warehouseReceipt.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try {
            // 1. Lấy dữ liệu từ form
            int supplierId = Integer.parseInt(request.getParameter("supplierId"));
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double importPrice = Double.parseDouble(request.getParameter("importPrice"));
            String imeiListData = request.getParameter("imeiList");
            
            Users currentUser = (Users) request.getSession().getAttribute("user");
            int createdBy = (currentUser != null) ? currentUser.getUser_id() : 1; 
            
            // 2. Xử lý danh sách IMEI
            List<String> imeiList = new ArrayList<>();
            BufferedReader reader = new BufferedReader(new StringReader(imeiListData));
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    imeiList.add(line.trim());
                }
            }

            // 3. Validation IMEI
            if (imeiList.size() != quantity) {
                request.setAttribute("errorMessage", "Lỗi: Số lượng IMEI (" + imeiList.size() + ") không khớp với số lượng nhập (" + quantity + ").");
                request.getRequestDispatcher("/WEB-INF/view/warehouseReceipt.jsp").forward(request, response);
                return; 
            }

            // 4. Gọi Service MỚI để thực thi
            WarehouseImportService importService = new WarehouseImportService();
            boolean success = importService.importNewReceipt(supplierId, productId, quantity, importPrice, imeiList, createdBy);

            // 5. Phản hồi
            if (success) {
                // Thành công! Chuyển đến trang XEM TỒN KHO (sẽ tạo ở Bước 2)
                response.sendRedirect(request.getContextPath() + "/warehouse/inventory");
            } else {
                throw new Exception("Service thất bại khi lưu phiếu nhập. Dữ liệu đã được rollback.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/warehouseReceipt.jsp").forward(request, response);
        }
    }
}
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.UserDAO;
import dal.WarehouseReportDAO;
import dto.InventoryStockDTO; 
import model.Brands; 
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Users;

@WebServlet(name = "WarehouseReportServlet", urlPatterns = {"/warehouse/report"})
public class WarehouseReportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserDAO user_dao = new UserDAO();

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }

        Users user = (Users) session.getAttribute("account");
        if (user == null || !user_dao.check_role(user.getRole_id(), 22)) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }
        
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        try {
            // 1. Lấy tham số lọc từ request
            String productName = request.getParameter("productName");
            int brandId = 0; // Mặc định là 0 (Tất cả)
            String brandIdParam = request.getParameter("brandId");
            if (brandIdParam != null && !brandIdParam.isEmpty()) {
                brandId = Integer.parseInt(brandIdParam);
            }

            // 2. Khởi tạo DAO
            WarehouseReportDAO reportDAO = new WarehouseReportDAO();
            
            // 3. Lấy dữ liệu báo cáo (đã lọc)
            List<InventoryStockDTO> reportList = reportDAO.getFilteredInventoryStock(productName, brandId);
            
            // 4. Lấy dữ liệu cho dropdown 
            WarehouseReportDAO filterDAO = new WarehouseReportDAO();
            List<Brands> brandList = filterDAO.getAllBrands();

            // 5. Đặt thuộc tính vào request để gửi sang JSP
            request.setAttribute("reportList", reportList);
            request.setAttribute("brandList", brandList);
            
            // 6. Ghi nhớ các giá trị lọc đã chọn (để hiển thị lại trên form)
            request.setAttribute("selectedProductName", productName);
            request.setAttribute("selectedBrandId", brandId);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi tải báo cáo: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/WEB-INF/view/warehouseReport.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); 
    }
}
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.WarehouseDAO; 
import dto.InventoryDetailDTO; 
import model.Brands;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "InventoryListServlet", urlPatterns = {"/warehouse/inventory"})
public class InventoryListServlet extends HttpServlet {

private static final int PAGE_SIZE = 15; 

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        // Khởi tạo các biến để đóng kết nối trong finally
        WarehouseDAO countDao = null;
        WarehouseDAO dataDao = null;
        WarehouseDAO brandDao = null;
        
        try {
            // 1. Lấy tham số lọc
            String productName = request.getParameter("productName");
            int brandId = 0; 
            String brandIdParam = request.getParameter("brandId");
            if (brandIdParam != null && !brandIdParam.isEmpty()) {
                brandId = Integer.parseInt(brandIdParam);
            }

            // 2. Lấy tham số trang
            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                currentPage = Integer.parseInt(pageParam);
            }

            // 3. Lấy TỔNG SỐ item (Mở DAO 1)
            countDao = new WarehouseDAO();
            int totalItems = countDao.getDetailedStockCount(productName, brandId);
            
            // 4. Tính TỔNG SỐ trang
            int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);

            // 5. Lấy dữ liệu PHÂN TRANG (Mở DAO 2)
            dataDao = new WarehouseDAO();
            List<InventoryDetailDTO> stockList = dataDao.getDetailedStockPaginated(productName, brandId, currentPage, PAGE_SIZE);
            
            // 6. Lấy danh sách Brands (Mở DAO 3)
            brandDao = new WarehouseDAO();
            List<Brands> brandList = brandDao.getAllBrands();

            // 7. Gửi tất cả dữ liệu sang JSP
            request.setAttribute("stockList", stockList); 
            request.setAttribute("brandList", brandList); 
            request.setAttribute("selectedProductName", productName);
            request.setAttribute("selectedBrandId", brandId);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi tải báo cáo: " + e.getMessage());
        } finally {
            // *** QUAN TRỌNG: Đóng tất cả kết nối ***
            if (countDao != null) countDao.closeConnection();
            if (dataDao != null) dataDao.closeConnection();
            if (brandDao != null) brandDao.closeConnection();
        }
        
        request.getRequestDispatcher("/WEB-INF/view/inventoryList.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.UserDAO;
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
import jakarta.servlet.http.HttpSession;
import model.Users;

@WebServlet(name = "InventoryListServlet", urlPatterns = {"/warehouse/inventory"})
public class InventoryListServlet extends HttpServlet {
    private static final int PAGE_SIZE = 15; 
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        UserDAO user_dao = new UserDAO();

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }

        Users user = (Users) session.getAttribute("account");
        if (user == null || !user_dao.check_role(user.getRole_id(), 23)) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }
        
        
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        WarehouseDAO countDao = null;
        WarehouseDAO dataDao = null;
        WarehouseDAO brandDao = null;
        try {
            String productName = request.getParameter("productName");
            int brandId = 0; 
            String brandIdParam = request.getParameter("brandId");
            if (brandIdParam != null && !brandIdParam.isEmpty()) {
                brandId = Integer.parseInt(brandIdParam);
            }
            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                currentPage = Integer.parseInt(pageParam);
            }
            countDao = new WarehouseDAO();
            int totalItems = countDao.getDetailedStockCount(productName, brandId);
            int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);
            dataDao = new WarehouseDAO();
            List<InventoryDetailDTO> stockList = dataDao.getDetailedStockPaginated(productName, brandId, currentPage, PAGE_SIZE);
            brandDao = new WarehouseDAO();
            List<Brands> brandList = brandDao.getAllBrands();
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
            if (countDao != null) countDao.closeConnection();
            if (dataDao != null) dataDao.closeConnection();
            if (brandDao != null) brandDao.closeConnection();
        }
        request.getRequestDispatcher("/WEB-INF/view/inventoryList.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
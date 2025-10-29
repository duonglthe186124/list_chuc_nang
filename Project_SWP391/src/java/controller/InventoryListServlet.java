/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.WarehouseDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dto.InventoryStockDTO; 

@WebServlet(name = "InventoryListServlet", urlPatterns = {"/warehouse/inventory"})
public class InventoryListServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // 1. Gọi DAO MỚI để lấy dữ liệu
        WarehouseDAO dao = new WarehouseDAO();
        List<InventoryStockDTO> stockList = dao.getInventoryStock();
        
        // 2. Đặt dữ liệu vào request
        request.setAttribute("stockList", stockList);
        
        // 3. Chuyển tiếp đến trang JSP MỚI
        request.getRequestDispatcher("/WEB-INF/view/inventoryList.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
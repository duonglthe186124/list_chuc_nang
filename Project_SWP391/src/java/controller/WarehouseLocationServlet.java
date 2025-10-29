/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.WarehouseLocationDAO;
import model.Warehouse_locations;
import java.io.IOException;
import java.util.Date; 
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "WarehouseLocationServlet", urlPatterns = {"/warehouse/locations"})
public class WarehouseLocationServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        WarehouseLocationDAO dao = new WarehouseLocationDAO();
        try {
            // Luôn tải danh sách vị trí
            List<Warehouse_locations> locationList = dao.getAllLocations();
            request.setAttribute("locationList", locationList);
            
            // Chuyển đến trang JSP
            request.getRequestDispatcher("/WEB-INF/view/locationList.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/locationList.jsp").forward(request, response);
        }
    }

    // doPost (xử lý Thêm mới)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        WarehouseLocationDAO dao = new WarehouseLocationDAO();
        
        try {
            Warehouse_locations loc = new Warehouse_locations();
            loc.setCode(request.getParameter("code"));
            loc.setArea(request.getParameter("area"));
            loc.setAisle(request.getParameter("aisle"));
            loc.setSlot(request.getParameter("slot"));
            loc.setCapacity(Integer.parseInt(request.getParameter("capacity")));
            loc.setDescription(request.getParameter("description"));
            loc.setCreated_at(new Date()); 
            
            boolean success = dao.addLocation(loc);
            if (!success) {
                request.setAttribute("errorMessage", "Không thể thêm vị trí. Mã vị trí có thể đã tồn tại.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi thêm: " + e.getMessage());
        }
        
        // Tải lại trang (cùng danh sách đã được cập nhật)
        processRequest(request, response);
    }
}
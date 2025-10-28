/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dal.OrderInfoDAO;
import dal.StatusDAO;
import dto.OrderInfoDTO;
import dto.StatusDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.List;

/**
 *
 * @author hoang
 */
public class CreateShipController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       String orderIdParam = req.getParameter("orderId");

        if (orderIdParam == null || orderIdParam.trim().isEmpty()) {
            req.setAttribute("errorMessage", "Lỗi: Không nhận được Order ID!");
            req.getRequestDispatcher("/order/list").forward(req, resp);
            return;
        }

        int orderId = Integer.parseInt(orderIdParam);
        OrderInfoDAO orderInfoDAO = new OrderInfoDAO();
        StatusDAO statusDAO = new StatusDAO();
        
        try {
            OrderInfoDTO order = orderInfoDAO.getOrderDetailWithRepUnit(orderId);

            if (order == null) {
                req.setAttribute("errorMessage", "Không tìm thấy đơn hàng ID: " + orderId);
                req.getRequestDispatcher("/order/list").forward(req, resp);
                return;
            }
            
            List<StatusDTO> statusList = statusDAO.getAllOrderStatuses();
            

           
            req.setAttribute("order", order);          
            req.setAttribute("statuses", statusList);        
            req.getRequestDispatcher("/WEB-INF/view/PrepareShip.jsp").forward(req, resp);

        } catch (Exception e) {
            req.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            req.getRequestDispatcher("/order/list").forward(req, resp);
        }
    }
}

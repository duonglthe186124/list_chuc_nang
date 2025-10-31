/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dal.OrderInfoDAO;
import dal.ShipEmployeesDAO;
import dal.StatusDAO;
import dto.OrderInfoDTO;
import dto.ShipEmployeesDTO;
import dto.StatusDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hoang
 */
public class CreateShipController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       String orderIdParam = req.getParameter("orderId");

        // === KIỂM TRA orderId ===
        if (orderIdParam == null || orderIdParam.trim().isEmpty()) {
            req.setAttribute("errorMessage", "Lỗi: Không nhận được Order ID!");
            req.getRequestDispatcher("/order/list").forward(req, resp);
            return;
        }

        int orderId;
        try {
            orderId = Integer.parseInt(orderIdParam);
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Lỗi: Order ID không hợp lệ!");
            req.getRequestDispatcher("/order/list").forward(req, resp);
            return;
        }

        OrderInfoDAO orderInfoDAO = new OrderInfoDAO();
        StatusDAO statusDAO = new StatusDAO();
        ShipEmployeesDAO dao = new ShipEmployeesDAO();
            

        try {
            // 1. LẤY THÔNG TIN ĐƠN HÀNG
            OrderInfoDTO order = orderInfoDAO.getOrderDetailInfo(orderId);

            if (order == null) {
                req.setAttribute("errorMessage", "Không tìm thấy đơn hàng ID: " + orderId);
                req.getRequestDispatcher("/order/list").forward(req, resp);
                return;
            }
            
            //2. unit_id qty
            List<Integer> unitIds = orderInfoDAO.getSoldUnitIdsForShipment(order.getProductId(), order.getQty());

        if (unitIds.size() < order.getQty()) {
            req.setAttribute("errorMessage", "Không đủ hàng SOLD để giao! Cần: " + order.getQty() + ", Có: " + unitIds.size());
            req.getRequestDispatcher("/order/list").forward(req, resp);
            return;
        }

            // 3. LẤY DANH SÁCH STATUS
            List<StatusDTO> statusList = statusDAO.getAllOrderStatuses();
            
            // 4. list ship employees
            List<ShipEmployeesDTO> list = dao.getShipEmployees();
            


            // 5. GỬI DỮ LIỆU VÀO JSP
            req.setAttribute("order", order);
            req.setAttribute("unitIds", unitIds);
            req.setAttribute("statuses", statusList);
            req.setAttribute("shipList", list);

            // 6. CHUYỂN TIẾP ĐẾN PrepareShip.jsp
            req.getRequestDispatcher("/WEB-INF/view/PrepareShip.jsp").forward(req, resp);

        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            req.getRequestDispatcher("WEB-INF/view/order_list.jsp").forward(req, resp);
        }
    }
    }




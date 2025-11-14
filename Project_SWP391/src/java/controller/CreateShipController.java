/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dal.OrderInfoDAO;
import dal.ShipEmployeesDAO;
import dal.StatusDAO;
import dal.getRoleBySetIdDAO;
import dto.OrderInfoDTO;
import dto.ShipEmployeesDTO;
import dto.StatusDTO;
import dto.UserToCheckTask;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Users;

/**
 *
 * @author hoang
 */
public class CreateShipController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/loginStaff");
            return;
        }

        Users currentUser = (Users) session.getAttribute("account");

        if (currentUser.getRole_id() != 5) {  // role_id = 5 là Manager
            req.setAttribute("error", "User '" + currentUser.getFullname() + "' không có quyền thực hiện thao tác này!");
            req.getRequestDispatcher("/WEB-INF/view/error_page.jsp").forward(req, resp);
            return;
        }

        //lấy orderId
        String orderIdParam = req.getParameter("orderId");
        if (orderIdParam == null || orderIdParam.trim().isEmpty()) {
            req.setAttribute("errorMessage", "⚠️ Không nhận được Order ID!");
            req.getRequestDispatcher("/order/list").forward(req, resp);
            return;
        }

        int orderId;
        try {
            orderId = Integer.parseInt(orderIdParam);
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "⚠️ Order ID không hợp lệ!");
            req.getRequestDispatcher("/order/list").forward(req, resp);
            return;
        }

        // ✅ Phần xử lý logic gốc giữ nguyên
        OrderInfoDAO orderInfoDAO = new OrderInfoDAO();
        StatusDAO statusDAO = new StatusDAO();
        ShipEmployeesDAO dao = new ShipEmployeesDAO();

        try {
            // 1. Lấy thông tin đơn hàng
            OrderInfoDTO order = orderInfoDAO.getOrderDetailInfo(orderId);
            if (order == null) {
                req.setAttribute("errorMessage", "Không tìm thấy đơn hàng ID: " + orderId);
                req.getRequestDispatcher("/order/list").forward(req, resp);
                return;
            }

            // 2. Kiểm tra tồn kho (SOLD)
            List<Integer> unitIds = orderInfoDAO.getSoldUnitIdsForShipment(order.getProductId(), order.getQty(), order.getUnitPrice());
            if (unitIds.size() < order.getQty()) {
                req.setAttribute("errorMessage", "Không đủ hàng SOLD để giao! Cần: " + order.getQty() + ", Có: " + unitIds.size());
                req.getRequestDispatcher("/order/list").forward(req, resp);
                return;
            }

            // 3. Lấy danh sách status
            List<StatusDTO> statusList = statusDAO.getAllOrderStatuses();

            // 4. Lấy danh sách ship employees
            List<ShipEmployeesDTO> list = dao.getShipEmployees();

            // 5. Gửi dữ liệu vào JSP   
            req.setAttribute("order", order);
            req.setAttribute("unitIds", unitIds);
            req.setAttribute("statuses", statusList);
            req.setAttribute("shipList", list);

            // 6. Chuyển tiếp đến PrepareShip.jsp
            req.getRequestDispatcher("/WEB-INF/view/PrepareShip.jsp").forward(req, resp);

        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            req.getRequestDispatcher("WEB-INF/view/order_list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

}

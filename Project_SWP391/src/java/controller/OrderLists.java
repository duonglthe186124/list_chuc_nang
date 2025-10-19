/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.OrderListDBContext;
import dto.AuthUser_HE186124_DuongLT;
import dto.OrderList;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hoang
 */
public class OrderLists extends BaseAuthController {

    private static final Logger LOGGER = Logger.getLogger(OrderLists.class.getName());

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, AuthUser_HE186124_DuongLT user)
            throws ServletException, IOException {
        OrderListDBContext db = new OrderListDBContext();
        ArrayList<OrderList> orders = new ArrayList<>();

        LOGGER.info("Processing request for user ID: " + user.getUserId() + ", Role ID: " + user.getRoleId());

        try {
            // Giả định role_id != 2 là customer/shipper, role_id == 2 là manager
            if (user.getRoleId() != 2) { // Customer/Shipper
                orders = db.getOrdersByUserId(user.getUserId());
                LOGGER.info("Fetched " + orders.size() + " orders for user ID: " + user.getUserId());
            } else { // Manager (role_id == 2)
                orders = db.getAllOrders();
                LOGGER.info("Fetched " + orders.size() + " orders for all users");
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error while loading orders", e);
            req.setAttribute("errorMessage", "Failed to load orders due to database error: " + e.getMessage());
        }

        // Đặt danh sách orders vào request
        req.setAttribute("orders", orders);

        // Chuyển tiếp đến JSP, kiểm tra đường dẫn
        String jspPath = "/WEB-INF/view/order_list.jsp";
        if (req.getRequestDispatcher(jspPath) == null) {
            LOGGER.warning("JSP file not found: " + jspPath);
            req.setAttribute("errorMessage", "Page not found.");
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "JSP file not found.");
        } else {
            req.getRequestDispatcher(jspPath).forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, AuthUser_HE186124_DuongLT user)
            throws ServletException, IOException {
        doGet(req, resp, user); // Gọi lại doGet cho nhất quán
    }
}



/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.StatusDAO;
import dal.UpdateShipDAO;
import dal.getRoleBySetIdDAO;
import dto.StatusDTO;
import dto.UserToCheckTask;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.List;

/**
 *
 * @author hoang
 */
public class UpdateShipController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // === Lấy dữ liệu từ form ===
            int shipmentId = Integer.parseInt(req.getParameter("shipmentId"));
            String shipmentStatus = req.getParameter("shipmentStatus");
            int shipmentQty = Integer.parseInt(req.getParameter("shipmentQty"));
            String shipmentNote = req.getParameter("shipmentNote");
            String userIdRaw = req.getParameter("userId");

            // === Kiểm tra null hoặc chuỗi rỗng ===
            if (userIdRaw == null || userIdRaw.trim().isEmpty()) {
                req.setAttribute("error", "Thiếu thông tin userId! Không thể xác định người dùng.");
                req.getRequestDispatcher("/WEB-INF/view/error_page.jsp").forward(req, resp);
                return;
            }

            int userId = Integer.parseInt(userIdRaw.trim());
            getRoleBySetIdDAO db = new getRoleBySetIdDAO();
            UserToCheckTask user = db.getUserById(userId);

            if (user.getRoleId() != 10) {
                req.setAttribute("error", "Bạn không có quyền truy cập chức năng này!");
                req.getRequestDispatcher("/WEB-INF/view/error_page.jsp").forward(req, resp);
                return;
            }

            // === Lấy thêm thông tin liên quan ===
            UpdateShipDAO dao = new UpdateShipDAO();
            StatusDAO s = new StatusDAO();

            int productId = dao.getProductIdByShipmentId(shipmentId);
            int orderId = dao.getOrderIdByShipmentId(shipmentId);
            String cusName = dao.getCustomerFullname(shipmentId);
            String cusPhone = dao.getCustomerPhone(shipmentId);
            String phoneName = dao.getPhoneName(productId);
            List<StatusDTO> listStatus = s.getAllShipmentStatuses();

            // === Gửi dữ liệu sang JSP ===
            req.setAttribute("shipmentId", shipmentId);
            req.setAttribute("shipmentStatus", shipmentStatus);
            req.setAttribute("shipmentQty", shipmentQty);
            req.setAttribute("shipmentNote", shipmentNote);
            req.setAttribute("productId", productId);
            req.setAttribute("orderId", orderId);
            req.setAttribute("listStatus", listStatus);
            req.setAttribute("cusName", cusName);
            req.setAttribute("cusPhone", cusPhone);
            req.setAttribute("phoneName", phoneName);

            // === Chuyển đến JSP để hiển thị form update ===
            req.getRequestDispatcher("/WEB-INF/view/updateShip.jsp").forward(req, resp);

        } catch (Exception e) {
            throw new ServletException("Lỗi khi tải dữ liệu cập nhật shipment: " + e.getMessage(), e);
        }
    }
}

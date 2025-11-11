/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.StatusDAO;
import dal.UpdateShipDAO;
import dto.StatusDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author hoang
 */
public class ConfirmShipController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // === Lấy dữ liệu từ form ===
            int shipmentId = Integer.parseInt(req.getParameter("shipmentId"));
            String shipmentStatus = req.getParameter("shipmentStatus");
            int shipmentQty = Integer.parseInt(req.getParameter("shipmentQty"));
            String shipmentNote = req.getParameter("shipmentNote");

            if (shipmentNote == null) {
                shipmentNote = "";
            }

            // === Tạo DAO ===
            UpdateShipDAO dao = new UpdateShipDAO();
            StatusDAO s = new StatusDAO();

            // === Lấy thêm thông tin phụ ===
            int productId = dao.getProductIdByShipmentId(shipmentId);
            int orderId = dao.getOrderIdByShipmentId(shipmentId);
            String cusName = dao.getCustomerFullname(shipmentId);
            String cusPhone = dao.getCustomerPhone(shipmentId);
            String phoneName = dao.getPhoneName(productId);
            List<StatusDTO> listStatus = s.getAllShipmentStatuses();

            // === Kiểm tra lỗi đầu vào ===
            if (shipmentStatus == null || shipmentStatus.trim().isEmpty()) {
                // Gửi lại thông báo lỗi và dữ liệu về JSP
                req.setAttribute("error", "⚠️ Vui lòng chọn trạng thái giao hàng (Shipment Status).");
                req.setAttribute("shipmentId", shipmentId);
                req.setAttribute("shipmentStatus", shipmentStatus);
                req.setAttribute("shipmentQty", shipmentQty);
                req.setAttribute("shipmentNote", shipmentNote);
                req.setAttribute("productId", productId);
                req.setAttribute("orderId", orderId);
                req.setAttribute("listStatus", listStatus);
                req.setAttribute("cusName", cusName);
                req.setAttribute("cusPhone", cusPhone);
                req.setAttribute("phone", phoneName);

                // Quay lại form update
                req.getRequestDispatcher("/WEB-INF/view/updateShip.jsp").forward(req, resp);
                return; // Dừng không thực hiện update
            }

            // === Nếu hợp lệ thì update dữ liệu ===
            dao.updateShipmentStatusAndNote(shipmentId, shipmentStatus, shipmentNote);
            dao.updateOrderStatusIfShipmentFinalized(orderId, shipmentStatus);

            if ("CANCELLED".equalsIgnoreCase(shipmentStatus)) {
                // Nếu shipment bị hủy → reset qty và phục hồi lại units
                dao.resetQtyIfShipmentCancelled();
                dao.restoreAvailableUnits(productId, shipmentQty);
            }

            resp.sendRedirect(req.getContextPath() + "/order/list");

        } catch (NumberFormatException e) {
            req.setAttribute("error", "⚠️ Lỗi định dạng dữ liệu: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/view/updateShip.jsp").forward(req, resp);

        } catch (Exception e) {
            req.setAttribute("error", "⚠️ Lỗi hệ thống: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/view/updateShip.jsp").forward(req, resp);
        }
    }
}

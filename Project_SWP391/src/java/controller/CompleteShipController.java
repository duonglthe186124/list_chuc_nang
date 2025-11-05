/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CompleteShipDAO;
import dal.OrderInfoDAO;
import dal.ShipEmployeesDAO;
import dal.StatusDAO;
import dto.OrderInfoDTO;
import dto.ShipEmployeesDTO;
import dto.StatusDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

/**
 *
 * @author hoang
 */
public class CompleteShipController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/plain; charset=UTF-8");
        String error = "";
        PrintWriter out = resp.getWriter();

        try {

            int orderId = Integer.parseInt(req.getParameter("orderId"));
            int productId = Integer.parseInt(req.getParameter("productId"));
            int qty = Integer.parseInt(req.getParameter("qtyShipLine"));
            String shipNo = req.getParameter("ship_no");
            String shipperIdStr = req.getParameter("shipperId");
            String newStatus = req.getParameter("newStatus");

            OrderInfoDAO orderInfoDAO = new OrderInfoDAO();

            // kiem tra cac ship code da ton tai
            List<String> existingShipNos = orderInfoDAO.getAllShipmentNos();

            if (shipNo == null || shipNo.trim().isEmpty()) {
                error = "Mã giao hàng không được để trống.";
            } else if (!shipNo.trim().matches("^SHP\\d{3,}$")) {
                error = "Mã giao hàng phải có dạng SHP + ít nhất 3 chữ số (vd: SHP123)";
            } else if (existingShipNos.contains(shipNo.trim())) {
                error = "Mã giao hàng này đã tồn tại. Vui lòng nhập mã khác.";
            }

            // === VALIDATE shipperId ===
            int shipperId = -1;
            if (shipperIdStr == null || shipperIdStr.trim().isEmpty()) {
                if (error.isEmpty()) {
                    error = "Vui lòng chọn nhân viên giao hàng.";
                }
            } else {
                try {
                    shipperId = Integer.parseInt(shipperIdStr);
                } catch (NumberFormatException e) {
                    if (error.isEmpty()) {
                        error = "ID nhân viên giao hàng không hợp lệ.";
                    }
                }
            }

            // === VALIDATE newStatus ===
            if (newStatus == null || newStatus.trim().isEmpty()) {
                if (error.isEmpty()) {
                    error = "Vui lòng chọn trạng thái đơn hàng.";
                }
            }

            if (!error.isEmpty()) {
                try {
                    int orderIdBack = Integer.parseInt(req.getParameter("orderId"));
                    StatusDAO statusDAO = new StatusDAO();
                    ShipEmployeesDAO shipDAO = new ShipEmployeesDAO();

                    // lấy lại dữ liệu như CreateShipController
                    OrderInfoDTO order = orderInfoDAO.getOrderDetailInfo(orderIdBack);
                    List<Integer> unitIds = orderInfoDAO.getSoldUnitIdsForShipment(order.getProductId(), order.getQty());
                    List<StatusDTO> statuses = statusDAO.getAllOrderStatuses();
                    List<ShipEmployeesDTO> shipList = shipDAO.getShipEmployees();

                    // gán lại các attribute cần thiết
                    req.setAttribute("order", order);
                    req.setAttribute("unitIds", unitIds);
                    req.setAttribute("statuses", statuses);
                    req.setAttribute("shipList", shipList);
                    req.setAttribute("ship_no", shipNo);
                    req.setAttribute("error", error);

                    req.getRequestDispatcher("/WEB-INF/view/PrepareShip.jsp").forward(req, resp);
                    return;

                } catch (SQLException e) {
                    throw new ServletException("Lỗi khi load lại dữ liệu PrepareShip.jsp", e);
                }
            }

            // === Nếu hợp lệ, tiến hành insert vào DB ===
            CompleteShipDAO shipDAO = new CompleteShipDAO();

            // 1. Update trạng thái đơn hàng
            shipDAO.updateOrderStatus(orderId, newStatus);

            // 2. Insert vào Shipments -> lấy shipment_id
            int shipmentId = shipDAO.insertShipment(orderId, shipNo, shipperId);

            // 3. Insert vào Shipment_lines -> lấy line_id
            int lineId = shipDAO.insertShipmentLine(shipmentId, productId, qty);

            // 4. Insert các unit tương ứng
            String[] unitIdArray = req.getParameterValues("unitIds");
            List<Integer> unitIds = new ArrayList<>();
            if (unitIdArray != null) {
                for (String id : unitIdArray) {
                    unitIds.add(Integer.parseInt(id));
                }
            }
            shipDAO.insertShipmentUnits(lineId, unitIds);

            // === Sau khi hoàn tất, chuyển hướng hoặc hiển thị thông báo ===
            req.setAttribute("orderId", orderId);
            req.setAttribute("shipNo", shipNo);
            req.setAttribute("qty", qty);
            req.setAttribute("newStatus", newStatus);
            req.setAttribute("success", "Tạo shipment thành công cho đơn #" + orderId);
            req.getRequestDispatcher("/WEB-INF/view/successShip.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/view/error_page.jsp").forward(req, resp);
        }
    }

}

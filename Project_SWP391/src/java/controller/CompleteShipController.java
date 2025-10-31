/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

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
            int shipperId = Integer.parseInt(req.getParameter("shipperId"));
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

            String[] unitIdArray = req.getParameterValues("unitIds");
            List<Integer> unitIds = new ArrayList<>();
            if (unitIdArray != null) {
                for (String id : unitIdArray) {
                    unitIds.add(Integer.parseInt(id));
                }
            }

            out.println("=== DỮ LIỆU NHẬN ĐƯỢC TỪ FORM ===");
            out.println("Order ID: " + orderId);
            out.println("Product ID: " + productId);
            out.println("Số lượng (Qty): " + qty);
            out.println("Ship No: " + shipNo);
            out.println("Shipper ID: " + shipperId);
            out.println("New Status: " + newStatus);
            out.println("--- Danh sách Unit IDs (" + unitIds.size() + ") ---");
            for (int i = 0; i < unitIds.size(); i++) {
                out.println((i + 1) + ". Unit ID: " + unitIds.get(i));
            }
            out.println("======================================");

        } catch (Exception e) {
            out.println("LỖI: " + e.getMessage());
            e.printStackTrace();
        }
    }

}

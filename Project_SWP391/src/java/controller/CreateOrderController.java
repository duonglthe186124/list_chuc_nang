package controller;

import dal.CheckFormDAO;
import dal.ListProductDAO; // Thay ProductDAO bằng ListProductDAO
import dal.OrderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author hoang
 */
public class CreateOrderController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int productId = Integer.parseInt(req.getParameter("product_id"));
        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        int qty = Integer.parseInt(req.getParameter("qty"));
        BigDecimal unitPrice = new BigDecimal(req.getParameter("unitPrice"));
        BigDecimal totalAmount = new BigDecimal(req.getParameter("totalAmount"));

        String name = req.getParameter("name");
        String code = req.getParameter("code");
        int qtyRaw = Integer.parseInt(req.getParameter("qtyRaw"));
        String imgUrl = req.getParameter("image");

        CheckFormDAO userCheckDAO = new CheckFormDAO();
        OrderDAO orderDAO = new OrderDAO();

        Integer userId = null;
        try {
            userId = userCheckDAO.getUserIdByDetails(fullname, email, phone, address);
            if (userId == null) {
                req.setAttribute("errorMessage", "User not found or not activated.");
                req.setAttribute("id", productId);
                req.setAttribute("name", name);
                req.setAttribute("code", code);
                req.setAttribute("qty", qtyRaw);
                req.setAttribute("price", unitPrice);
                req.setAttribute("image", imgUrl); 

                req.getRequestDispatcher("/WEB-INF/view/create_order.jsp").forward(req, resp);
                return;
            }

            // 1. Insert vào Orders
            int orderId = orderDAO.insertOrder(userId, totalAmount);
            if (orderId == -1) {
                throw new SQLException("Failed to create order.");
            }

            // 2. Update TOP(qty) product_units status
            int updatedRows = orderDAO.updateProductUnitsStatus(productId, unitPrice, qty);
            if (updatedRows < qty) {
                throw new SQLException("Not enough available product units.");
            }

            // 3. Lấy unit_id đã update
            List<Integer> unitIds = orderDAO.getSoldUnitIds(productId, unitPrice, qty);

            // 4. Insert vào order_details
            orderDAO.insertOrderDetails(orderId, unitIds, qty, unitPrice, totalAmount);

            resp.sendRedirect(req.getContextPath() + "/order/list");

        } catch (SQLException e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.setAttribute("id", productId);
            req.setAttribute("name", name);
            req.setAttribute("code", code);
            req.setAttribute("qty", qtyRaw);
            req.setAttribute("price", unitPrice);
            req.setAttribute("image", imgUrl); 
            req.getRequestDispatcher("/WEB-INF/view/create_order.jsp").forward(req, resp);
        }
    }
}

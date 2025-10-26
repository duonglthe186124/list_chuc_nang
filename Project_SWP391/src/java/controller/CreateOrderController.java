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

        BigDecimal purchasePrice = new BigDecimal(req.getParameter("unitPrice"));
        if (purchasePrice == null) {
            req.setAttribute("errorMessage", "Purchase price is not available.");
            req.setAttribute("id", productId);
            req.getRequestDispatcher("/WEB-INF/view/create_order.jsp").forward(req, resp);
            return;
        }

        CheckFormDAO userCheckDAO = new CheckFormDAO();
        ListProductDAO productDAO = new ListProductDAO(); // Sử dụng ListProductDAO
        Integer userId = null;
        try {
            userId = userCheckDAO.getUserIdByDetails(fullname, email, phone, address);
            if (userId == null) {
                req.setAttribute("errorMessage", "User not found or not activated. Please check your details.");
                req.setAttribute("id", productId);
                req.setAttribute("fullname", fullname);
                req.setAttribute("email", email);
                req.setAttribute("phone", phone);
                req.setAttribute("address", address);
                req.setAttribute("qty", qty);
                req.getRequestDispatcher("/WEB-INF/view/create_order.jsp").forward(req, resp);
                return;
            }
        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Database error: " + e.getMessage());
            req.setAttribute("id", productId);
            req.getRequestDispatcher("/WEB-INF/view/create_order.jsp").forward(req, resp);
            return;
        }

        OrderDAO orderDAO = new OrderDAO();
        try {
            int currentQty = productDAO.getQuantityById(productId);
            if (currentQty < qty) {
                req.setAttribute("errorMessage", "Insufficient quantity in stock.");
                req.setAttribute("id", productId);
                req.setAttribute("fullname", fullname);
                req.setAttribute("email", email);
                req.setAttribute("phone", phone);
                req.setAttribute("address", address);
                req.setAttribute("qty", qty);
                req.getRequestDispatcher("/WEB-INF/view/create_order.jsp").forward(req, resp);
                return;
            }

            int orderId = orderDAO.createOrder(userId, productId, qty, purchasePrice);
            if (orderId != -1) {
                productDAO.updateQuantity(productId, currentQty - qty); // Cập nhật số lượng
                resp.sendRedirect(req.getContextPath() + "/order/list?page=1&sort=Latest orders&success=true");
            } else {
                req.setAttribute("errorMessage", "Failed to create order.");
                req.setAttribute("id", productId);
                req.setAttribute("fullname", fullname);
                req.setAttribute("email", email);
                req.setAttribute("phone", phone);
                req.setAttribute("address", address);
                req.setAttribute("qty", qty);
                req.getRequestDispatcher("/WEB-INF/view/create_order.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            req.setAttribute("errorMessage", e.getMessage());
            req.setAttribute("id", productId);
            req.setAttribute("fullname", fullname);
            req.setAttribute("email", email);
            req.setAttribute("phone", phone);
            req.setAttribute("address", address);
            req.setAttribute("qty", qty);
            req.getRequestDispatcher("/WEB-INF/view/create_order.jsp").forward(req, resp);
        }
    }

    @Override
    public String getServletInfo() {
        return "CreateOrderController handles order creation from create_order.jsp";
    }
}
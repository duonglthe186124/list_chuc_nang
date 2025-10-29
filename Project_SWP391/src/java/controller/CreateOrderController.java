package controller;

import dal.CheckFormDAO;
import dal.ListProductDAO; // Thay ProductDAO bằng ListProductDAO
import dal.OrderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.SQLException;

/**
 *
 * @author hoang
 */
public class CreateOrderController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        try {
            // Lấy tham số từ form
            int productId = Integer.parseInt(req.getParameter("product_id"));
            String fullname = req.getParameter("fullname");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String address = req.getParameter("address");
            int qty = Integer.parseInt(req.getParameter("qty"));
            BigDecimal unitPrice = new BigDecimal(req.getParameter("unitPrice"));
            BigDecimal totalAmount = new BigDecimal(req.getParameter("totalAmount"));

            // In thông tin nhận được
            out.println("<h2>Received Form Parameters:</h2><ul>");
            out.println("<li>product_id: " + productId + "</li>");
            out.println("<li>fullname: " + (fullname != null ? fullname : "null") + "</li>");
            out.println("<li>email: " + (email != null ? email : "null") + "</li>");
            out.println("<li>phone: " + (phone != null ? phone : "null") + "</li>");
            out.println("<li>address: " + (address != null ? address : "null") + "</li>");
            out.println("<li>qty: " + qty + "</li>");
            out.println("<li>unitPrice: " + unitPrice + "</li>");
            out.println("<li>totalAmount: " + totalAmount + "</li>");
            out.println("</ul>");

            // Khởi tạo DAO
            CheckFormDAO checkFormDAO = new CheckFormDAO();
            OrderDAO orderDAO = new OrderDAO();

            // Cập nhật status của unit_id thành SOLD
            int rowsUpdated = orderDAO.updateUnitStatusToSold(productId, qty);
            out.println("<h3>Update Result:</h3><p>Units updated to SOLD: " + rowsUpdated + "</p>");

            // Lấy userId
            int userId = checkFormDAO.getUserIdByDetails(fullname, email, phone, address);
            out.println("<h3>User Information:</h3><p>userId: " + (userId != -1 ? userId : "null") + "</p>");

            if (userId == -1) {
                out.println("<p style='color:red;'>User not found with given details</p>");
            } else {
                // Lấy unitId ngẫu nhiên
                int unitId = checkFormDAO.getRandomUnitIdByProductId(productId);
                out.println("<p>Random unit_id: " + (unitId != -1 ? unitId : "null") + "</p>");

                if (unitId == -1) {
                    out.println("<p style='color:red;'>No unit_id found for product_id: " + productId + "</p>");
                } else {
                    // Insert vào Orders
                    int orderId = orderDAO.insertOrder(userId, totalAmount);

                    // Insert vào Order_details
                    orderDAO.insertOrderDetails(orderId, qty, unitPrice, totalAmount, unitId);

                    out.println("<h3>Insert Result:</h3>");
                    out.println("<p>Order created with order_id: " + orderId + "</p>");
                    out.println("<p>Order_details inserted with qty: " + qty + ", line_amount: " + totalAmount + ", unit_id: " + unitId + "</p>");

                    // Chuyển hướng đến order_success.jsp với tham số
                    req.getRequestDispatcher("/WEB-INF/view/order_success.jsp").forward(req, resp);
                    return; // Thoát để tránh in thêm nội dung
                }
            }

            out.println("<h3>Status:</h3><p>Form parameters processed.</p>");
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        } finally {
            out.close();
        }
    }
}
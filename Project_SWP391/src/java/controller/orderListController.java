package controller;

import dal.OrderListDAO;
import dal.getRoleBySetIdDAO;
import dto.OrderList;
import dto.UserToCheckTask;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author hoang
 */
public class orderListController extends HttpServlet {

    private static final int PAGE_SIZE = 5;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Phương thức POST chưa được triển khai, có thể bỏ qua hoặc thêm logic nếu cần
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        OrderListDAO db = new OrderListDAO();
        getRoleBySetIdDAO dbr = new getRoleBySetIdDAO();
        ArrayList<OrderList> orders = new ArrayList<>();

        // Lấy tham số page
        int pageIndex = 1;
        String pageParam = req.getParameter("page");
        if (pageParam != null && !pageParam.trim().isEmpty()) {
            try {
                pageIndex = Integer.parseInt(pageParam);
                if (pageIndex < 1) {
                    pageIndex = 1;
                }
            } catch (NumberFormatException e) {
                pageIndex = 1;
            }
        }

        // Lấy tham số sort
        String sortBy = req.getParameter("sort");
        if (sortBy == null || sortBy.trim().isEmpty()) {
            sortBy = "Earliest orders";
        }

        // Lấy tham số success để hiển thị thông báo
        String successParam = req.getParameter("success");
        boolean showSuccess = "true".equalsIgnoreCase(successParam);

        // UserId cố định 
        int userId = 2;
        UserToCheckTask user = null;
        try {
            user = dbr.getUserById(userId);
            if (user == null) {
                req.setAttribute("errorMessage", "User not found.");
                req.getRequestDispatcher("/WEB-INF/view/order_list.jsp").forward(req, resp);
                return;
            }
        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/view/order_list.jsp").forward(req, resp);
            return;
        }

        try {
            int totalOrders, totalPages;

            if (user.getRoleId() != 2) { // Customer/Shipper
                orders = db.getOrdersByUserIdPageSorted(user.getUserId(), pageIndex, PAGE_SIZE, sortBy);
                totalOrders = db.countOrdersByUserId(user.getUserId());
            } else { // Manager (role_id == 2)
                orders = db.getAllOrdersByPageSorted(pageIndex, PAGE_SIZE, sortBy);
                totalOrders = db.countAllOrders();
            }
            totalPages = (int) Math.ceil((double) totalOrders / PAGE_SIZE);

            if (pageIndex > totalPages && totalPages > 0) {
                pageIndex = totalPages;
                if (user.getRoleId() != 2) {
                    orders = db.getOrdersByUserIdPageSorted(user.getUserId(), pageIndex, PAGE_SIZE, sortBy);
                } else {
                    orders = db.getAllOrdersByPageSorted(pageIndex, PAGE_SIZE, sortBy);
                }
            }

            // Truyền dữ liệu đến JSP
            req.setAttribute("orders", orders);
            req.setAttribute("currentPage", pageIndex);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("currentSort", sortBy);
            // Truyền thông báo thành công nếu có
            if (showSuccess) {
                req.setAttribute("successMessage", "Order created successfully! Your new order is now listed below.");
            }
        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Failed to load orders due to database error: " + e.getMessage());
        }

        // Forward đến JSP
        req.getRequestDispatcher("/WEB-INF/view/order_list.jsp").forward(req, resp);
    }

    @Override
    public String getServletInfo() {
        return "orderListController handles order list display";
    }
}
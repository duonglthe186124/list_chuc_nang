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
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Users;

/**
 *
 * @author hoang
 */
public class orderListController extends HttpServlet {

    private static final int PAGE_SIZE = 5;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        OrderListDAO db = new OrderListDAO();
        getRoleBySetIdDAO dbr = new getRoleBySetIdDAO();
        ArrayList<OrderList> orders = new ArrayList<>();
        List<UserToCheckTask> userList = new ArrayList<>();

        // ===== 1️⃣ Lấy tham số trang =====
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

        // ===== 2️⃣ Lấy tham số sort =====
        String sortBy = req.getParameter("sort");
        if (sortBy == null || sortBy.trim().isEmpty()) {
            sortBy = "Earliest orders";
        }

        // ===== 3️⃣ Lấy tham số success =====
        String successParam = req.getParameter("success");
        boolean showSuccess = "true".equalsIgnoreCase(successParam);

        HttpSession session = req.getSession(false);
        Users currentUser = null;

        
        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/loginStaff");
            return;
        }
        
        currentUser = (Users) session.getAttribute("account");
        // ===== 6️⃣ Lấy danh sách order =====
        try {
            int totalOrders, totalPages;

            if (currentUser.getRole_id() != 5) { // Không phải Manager
                orders = db.getOrdersByUserIdPageSorted(currentUser.getUser_id(), pageIndex, PAGE_SIZE, sortBy);
                totalOrders = db.countOrdersByUserId(currentUser.getUser_id());
            } else { // Manager
                orders = db.getAllOrdersByPageSorted(pageIndex, PAGE_SIZE, sortBy);
                totalOrders = db.countAllOrders();
            }
            totalPages = (int) Math.ceil((double) totalOrders / PAGE_SIZE);

            if (pageIndex > totalPages && totalPages > 0) {
                pageIndex = totalPages;
                if (currentUser.getRole_id() != 5) {
                    orders = db.getOrdersByUserIdPageSorted(currentUser.getUser_id(), pageIndex, PAGE_SIZE, sortBy);
                } else {
                    orders = db.getAllOrdersByPageSorted(pageIndex, PAGE_SIZE, sortBy);
                }
            }


            // ===== 8️⃣ Gửi dữ liệu sang JSP =====
            req.setAttribute("orders", orders);
            req.setAttribute("currentPage", pageIndex);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("currentSort", sortBy);
            

            if (showSuccess) {
                req.setAttribute("successMessage", "Order created successfully! Your new order is now listed below.");
            }

        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Failed to load orders due to database error: " + e.getMessage());
        }

        req.getRequestDispatcher("/WEB-INF/view/order_list.jsp").forward(req, resp);
    }

    @Override
    public String getServletInfo() {
        return "orderListController handles order list display";
    }
}

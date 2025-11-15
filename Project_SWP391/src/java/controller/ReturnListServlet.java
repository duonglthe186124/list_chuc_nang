/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ReturnsDAO;
import dto.ReturnHistoryDTO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Users;

@WebServlet(name = "ReturnListServlet", urlPatterns = {"/warehouse/returnsList"})
public class ReturnListServlet extends HttpServlet {

    /**
     * doGet: Lấy danh sách lịch sử trả hàng và hiển thị
     */
    private static final int PAGE_SIZE = 20; // 20 log mỗi trang

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        ReturnsDAO historyDao = null;
        ReturnsDAO countDao = null;

        try {
            // 1. Lấy 3 tham số lọc
            String status = request.getParameter("status");
            String dateStart = request.getParameter("dateStart");
            String dateEnd = request.getParameter("dateEnd");

            // 2. Lấy trang hiện tại
            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                currentPage = Integer.parseInt(pageParam);
            }

            // 3. Mở DAO 1: Đếm tổng số (đã lọc)
            countDao = new ReturnsDAO();
            int totalItems = countDao.getReturnHistoryCount(status, dateStart, dateEnd);
            int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);

            // 4. Mở DAO 2: Lấy Lịch sử (đã lọc và phân trang)
            historyDao = new ReturnsDAO();
            List<ReturnHistoryDTO> historyList = historyDao.getReturnHistoryPaginated(status, dateStart, dateEnd, currentPage, PAGE_SIZE);

            // 5. Gửi dữ liệu sang JSP
            request.setAttribute("historyList", historyList);

            // 6. Gửi lại các giá trị lọc
            request.setAttribute("selectedStatus", status);
            request.setAttribute("selectedDateStart", dateStart);
            request.setAttribute("selectedDateEnd", dateEnd);

            // 7. Gửi phân trang
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi tải lịch sử trả hàng: " + e.getMessage());
        } finally {
            if (historyDao != null) {
                historyDao.closeConnection();
            }
            if (countDao != null) {
                countDao.closeConnection();
            }
        }

        request.getRequestDispatcher("/WEB-INF/view/returnList.jsp").forward(request, response);
    }
}

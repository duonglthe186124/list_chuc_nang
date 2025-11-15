/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.AdjustmentHistoryDAO; 
import dto.AdjustmentHistoryDTO; 
import model.Employees;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdjustmentHistoryServlet", urlPatterns = {"/warehouse/history"})
public class AdjustmentHistoryServlet extends HttpServlet {

private static final int PAGE_SIZE = 20; // 20 log mỗi trang

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        AdjustmentHistoryDAO historyDao = null;
        AdjustmentHistoryDAO employeeDao = null;
        AdjustmentHistoryDAO countDao = null;
        
        try {
            // 1. Lấy 4 tham số lọc
            int employeeId = 0;
            String empIdParam = request.getParameter("employeeId");
            if (empIdParam != null && !empIdParam.isEmpty()) {
                employeeId = Integer.parseInt(empIdParam);
            }
            
            String reasonType = request.getParameter("reasonType");
            String dateStart = request.getParameter("dateStart");
            String dateEnd = request.getParameter("dateEnd");

            // 2. Lấy trang hiện tại
            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                currentPage = Integer.parseInt(pageParam);
            }

            // 3. Mở DAO 1: Đếm tổng số (đã lọc)
            countDao = new AdjustmentHistoryDAO();
            int totalItems = countDao.getHistoryCount(employeeId, reasonType, dateStart, dateEnd);
            int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);

            // 4. Mở DAO 2: Lấy Lịch sử (đã lọc và phân trang)
            historyDao = new AdjustmentHistoryDAO();
            List<AdjustmentHistoryDTO> historyList = historyDao.getHistoryPaginated(employeeId, reasonType, dateStart, dateEnd, currentPage, PAGE_SIZE);
            
            // 5. Mở DAO 3: Lấy danh sách Nhân viên (cho dropdown)
            employeeDao = new AdjustmentHistoryDAO();
            List<Employees> employeeList = employeeDao.getAllEmployees();

            // 6. Gửi dữ liệu sang JSP
            request.setAttribute("historyList", historyList);
            request.setAttribute("employeeList", employeeList);
            
            // 7. Gửi lại các giá trị lọc
            request.setAttribute("selectedEmployeeId", employeeId);
            request.setAttribute("selectedReasonType", reasonType);
            request.setAttribute("selectedDateStart", dateStart);
            request.setAttribute("selectedDateEnd", dateEnd);
            
            // 8. Gửi phân trang
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", currentPage);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi tải lịch sử: " + e.getMessage());
        } finally {
            if (historyDao != null) historyDao.closeConnection();
            if (employeeDao != null) employeeDao.closeConnection();
            if (countDao != null) countDao.closeConnection();
        }
        
        request.getRequestDispatcher("/WEB-INF/view/adjustmentHistory.jsp").forward(request, response);
    }
}
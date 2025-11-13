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

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        AdjustmentHistoryDAO historyDao = null;
        AdjustmentHistoryDAO employeeDao = null;
        
        try {
            // 1. Lấy tham số lọc
            int employeeId = 0;
            String empIdParam = request.getParameter("employeeId");
            if (empIdParam != null && !empIdParam.isEmpty()) {
                employeeId = Integer.parseInt(empIdParam);
            }

            // 2. Mở DAO 1: Lấy Lịch sử (đã lọc)
            historyDao = new AdjustmentHistoryDAO();
            List<AdjustmentHistoryDTO> historyList = historyDao.getHistory(employeeId);
            
            // 3. Mở DAO 2: Lấy danh sách Nhân viên (cho dropdown)
            employeeDao = new AdjustmentHistoryDAO();
            List<Employees> employeeList = employeeDao.getAllEmployees();

            // 4. Gửi dữ liệu sang JSP
            request.setAttribute("historyList", historyList);
            request.setAttribute("employeeList", employeeList);
            request.setAttribute("selectedEmployeeId", employeeId);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi tải lịch sử: " + e.getMessage());
        } finally {
            if (historyDao != null) historyDao.closeConnection();
            if (employeeDao != null) employeeDao.closeConnection();
        }
        
        request.getRequestDispatcher("/WEB-INF/view/adjustmentHistory.jsp").forward(request, response);
    }
}
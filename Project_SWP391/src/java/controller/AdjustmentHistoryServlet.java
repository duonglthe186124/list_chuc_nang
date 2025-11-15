/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AdjustmentHistoryDAO; 
import dal.UserDAO;
import dto.AdjustmentHistoryDTO; 
import model.Employees;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Users;

@WebServlet(name = "AdjustmentHistoryServlet", urlPatterns = {"/warehouse/history"})
public class AdjustmentHistoryServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserDAO user_dao = new UserDAO();

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }

        Users user = (Users) session.getAttribute("account");
        if (user == null || !user_dao.check_role(user.getRole_id(), 5)) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }
        
        
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        AdjustmentHistoryDAO historyDao = null;
        AdjustmentHistoryDAO employeeDao = null;
        try {
            int employeeId = 0;
            String empIdParam = request.getParameter("employeeId");
            if (empIdParam != null && !empIdParam.isEmpty()) {
                employeeId = Integer.parseInt(empIdParam);
            }
            historyDao = new AdjustmentHistoryDAO();
            List<AdjustmentHistoryDTO> historyList = historyDao.getHistory(employeeId);
            employeeDao = new AdjustmentHistoryDAO();
            List<Employees> employeeList = employeeDao.getAllEmployees();
            request.setAttribute("historyList", historyList);
            request.setAttribute("employeeList", employeeList);
            request.setAttribute("selectedEmployeeId", employeeId);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi tải lịch sử: " + e.getMessage());
        } finally {
            if (historyDao != null) {
                historyDao.closeConnection();
            }
            if (employeeDao != null) {
                employeeDao.closeConnection();
            }
        }
        request.getRequestDispatcher("/WEB-INF/view/adjustmentHistory.jsp").forward(request, response);
    }
}

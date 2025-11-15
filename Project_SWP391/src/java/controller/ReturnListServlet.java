/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.ReturnsDAO; 
import dal.UserDAO;
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
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserDAO user_dao = new UserDAO();

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }

        Users user = (Users) session.getAttribute("account");
        if (user == null || !user_dao.check_role(user.getRole_id(), 22)) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }
        
        
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        ReturnsDAO dao = null;
        try {
            // 1. Mở DAO
            dao = new ReturnsDAO();
            
            // 2. Gọi hàm lấy Lịch sử (Hàm 3 trong DAO)
            List<ReturnHistoryDTO> historyList = dao.getReturnHistory();
            
            // 3. Gửi danh sách sang JSP
            request.setAttribute("historyList", historyList);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi tải lịch sử trả hàng: " + e.getMessage());
        } finally {
            // 4. Đóng kết nối
            if (dao != null) dao.closeConnection();
        }
        
        // 5. Forward đến JSP
        request.getRequestDispatcher("/WEB-INF/view/returnList.jsp").forward(request, response);
    }
}
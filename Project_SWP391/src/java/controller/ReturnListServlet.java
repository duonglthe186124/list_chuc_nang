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
            dao = new ReturnsDAO();
            List<ReturnHistoryDTO> historyList = dao.getReturnHistory();
            request.setAttribute("historyList", historyList);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi tải lịch sử trả hàng: " + e.getMessage());
        } finally {
            if (dao != null) {
                dao.closeConnection();
            }
        }
        request.getRequestDispatcher("/WEB-INF/view/returnList.jsp").forward(request, response);
    }
}

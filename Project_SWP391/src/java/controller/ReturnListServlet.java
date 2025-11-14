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

@WebServlet(name = "ReturnListServlet", urlPatterns = {"/warehouse/returnsList"})
public class ReturnListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

package controller;

import dal.ReturnsDAO;
import dto.ReturnFormDTO;
import model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CreateReturnServlet", urlPatterns = {"/warehouse/returns"})
public class CreateReturnServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String imei = request.getParameter("imei");
        ReturnsDAO dao = null;
        try {
            if (imei != null && !imei.trim().isEmpty()) {
                dao = new ReturnsDAO();
                ReturnFormDTO unitDetails = dao.getUnitDetailsForReturn(imei.trim());
                if (unitDetails != null) {
                    request.setAttribute("unitDetails", unitDetails);
                } else {
                    request.setAttribute("errorMessage", "Không tìm thấy IMEI: " + imei + " (hoặc sản phẩm này chưa được bán/đã được trả).");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi tải dữ liệu: " + e.getMessage());
        } finally {
            if (dao != null) {
                dao.closeConnection();
            }
        }
        request.getRequestDispatcher("/WEB-INF/view/createReturn.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        ReturnsDAO dao = null;
        String imei = request.getParameter("imei");
        try {
            int unitId = Integer.parseInt(request.getParameter("unitId"));
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String reason = request.getParameter("reason");

            // Bảng Returns liên kết với Users (người trả)
            Users currentUser = (Users) request.getSession().getAttribute("user");
            int createdBy = (currentUser != null) ? currentUser.getUser_id() : 1;

            dao = new ReturnsDAO();
            boolean success = dao.processReturn(unitId, orderId, createdBy, reason);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/warehouse/returnsList");
            } else {
                throw new Exception("Xử lý trả hàng thất bại.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi lưu: " + e.getMessage());
            request.setAttribute("imei", imei);
            doGet(request, response);
        } finally {
            if (dao != null) {
                dao.closeConnection();
            }
        }
    }
}

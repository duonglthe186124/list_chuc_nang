package controller;

import dal.TransferDAO;
import model.Containers;
import dto.TransferDTO;
import model.Users;
import model.Employees; 
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "TransferServlet", urlPatterns = {"/warehouse/transfer"})
public class TransferServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String imei = request.getParameter("imei");
        TransferDAO dao = null;
        TransferDAO containerDao = null;
        try {
            containerDao = new TransferDAO();
            List<Containers> containerList = containerDao.getAllContainersWithLocation();
            request.setAttribute("containerList", containerList);
            if (imei != null && !imei.trim().isEmpty()) {
                dao = new TransferDAO();
                TransferDTO unitDetails = dao.getUnitForTransfer(imei.trim());
                if (unitDetails != null) {
                    request.setAttribute("unitDetails", unitDetails);
                } else {
                    request.setAttribute("errorMessage", "Không tìm thấy IMEI: " + imei + " (hoặc sản phẩm này không 'Trong kho').");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi tải dữ liệu: " + e.getMessage());
        } finally {
            if (dao != null) {
                dao.closeConnection();
            }
            if (containerDao != null) {
                containerDao.closeConnection();
            }
        }
        request.getRequestDispatcher("/WEB-INF/view/transfer.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        TransferDAO dao = null;
        String imei = request.getParameter("imei");
        try {
            int unitId = Integer.parseInt(request.getParameter("unitId"));
            int newContainerId = Integer.parseInt(request.getParameter("newContainerId"));
            int currentContainerId = Integer.parseInt(request.getParameter("currentContainerId"));
            String note = request.getParameter("note");

            // SỬA LỖI: Lấy Employee ID
            Employees currentEmployee = (Employees) request.getSession().getAttribute("employee");
            if (currentEmployee == null) {
                throw new Exception("Lỗi phiên đăng nhập. Không tìm thấy thông tin Employee.");
            }
            int employeeId = currentEmployee.getEmployee_id(); // Lấy employee_id

            if (newContainerId == currentContainerId) {
                throw new Exception("Lỗi: Vị trí mới phải khác vị trí hiện tại.");
            }
            String reason = "Internal Transfer. Ghi chú: " + note;
            dao = new TransferDAO();
            boolean success = dao.processTransfer(unitId, newContainerId, employeeId, reason);
            if (success) {
                request.setAttribute("successMessage", "Đã điều chuyển IMEI " + imei + " thành công!");
                doGet(request, response);
            } else {
                throw new Exception("Điều chuyển thất bại.");
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

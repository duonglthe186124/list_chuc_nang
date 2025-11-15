package controller;

import dal.WarehouseUnitDAO;
import model.Product_units;
import model.Employees; 
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "EditUnitServlet", urlPatterns = {"/warehouse/editUnit"})
public class EditUnitServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        WarehouseUnitDAO dao = null;
        WarehouseUnitDAO nameDao = null;
        try {
            int unitId = Integer.parseInt(request.getParameter("unitId"));
            dao = new WarehouseUnitDAO();
            Product_units unitToEdit = dao.getUnitById(unitId);
            if (unitToEdit == null) {
                throw new Exception("Không tìm thấy IMEI với ID: " + unitId);
            }
            nameDao = new WarehouseUnitDAO();
            String productName = nameDao.getProductNameById(unitToEdit.getProduct_id());
            request.setAttribute("unit", unitToEdit);
            request.setAttribute("productName", productName);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi tải trang sửa: " + e.getMessage());
        } finally {
            if (dao != null) {
                dao.closeConnection();
            }
            if (nameDao != null) {
                nameDao.closeConnection();
            }
        }
        request.getRequestDispatcher("/WEB-INF/view/editUnit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        WarehouseUnitDAO dao = null;
        try {
            int unitId = Integer.parseInt(request.getParameter("unitId"));
            String newStatus = request.getParameter("status");
            String oldStatus = request.getParameter("oldStatus");

            // SỬA LỖI: Lấy Employee ID
            Employees currentEmployee = (Employees) request.getSession().getAttribute("employee");
            if (currentEmployee == null) {
                throw new Exception("Lỗi phiên đăng nhập. Không tìm thấy thông tin Employee.");
            }
            int employeeId = currentEmployee.getEmployee_id(); 

            dao = new WarehouseUnitDAO();
            boolean success = dao.updateUnitStatus(unitId, oldStatus, newStatus, employeeId);
            if (!success) {
                throw new Exception("Cập nhật thất bại. Dữ liệu không đổi.");
            }
            response.sendRedirect(request.getContextPath() + "/warehouse/inventory");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi cập nhật: " + e.getMessage());
            doGet(request, response);
        } finally {
            if (dao != null) {
                dao.closeConnection();
            }
        }
    }
}

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

    /**
     * doGet: Hiển thị Form Sửa
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        WarehouseUnitDAO dao = null;
        WarehouseUnitDAO nameDao = null; 
        
        try {
            int unitId = Integer.parseInt(request.getParameter("unitId"));
            
            // Mở DAO 1: Lấy chi tiết IMEI
            dao = new WarehouseUnitDAO();
            Product_units unitToEdit = dao.getUnitById(unitId);
            
            if (unitToEdit == null) {
                throw new Exception("Không tìm thấy IMEI với ID: " + unitId);
            }
            
            // Mở DAO 2: Lấy tên Sản phẩm
            nameDao = new WarehouseUnitDAO();
            String productName = nameDao.getProductNameById(unitToEdit.getProduct_id());

            request.setAttribute("unit", unitToEdit);
            request.setAttribute("productName", productName);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi tải trang sửa: " + e.getMessage());
        } finally {
            if (dao != null) dao.closeConnection();
            if (nameDao != null) nameDao.closeConnection();
        }
        
        // Chú ý: Đây là file fragment
        request.getRequestDispatcher("/WEB-INF/view/editUnit.jsp").forward(request, response);
    }

    /**
     * doPost: Xử lý Cập nhật (ĐÃ NÂNG CẤP)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        WarehouseUnitDAO dao = null;
        
        try {
            // Lấy dữ liệu từ form
            int unitId = Integer.parseInt(request.getParameter("unitId"));
            String newStatus = request.getParameter("status");
            String oldStatus = request.getParameter("oldStatus"); // Lấy status cũ
            
            // Lấy Employee ID (Bạn phải lưu employee trong session khi login)
            Employees currentEmployee = (Employees) request.getSession().getAttribute("employee");
            int employeeId = (currentEmployee != null) ? currentEmployee.getEmployee_id() : 1; // Tạm
            
            // Mở DAO và cập nhật (truyền cả status cũ và mới)
            dao = new WarehouseUnitDAO();
            boolean success = dao.updateUnitStatus(unitId, oldStatus, newStatus, employeeId);

            if (!success) {
                throw new Exception("Cập nhật thất bại. Dữ liệu không đổi.");
            }
            
            // Thành công, quay lại trang Tồn kho
            response.sendRedirect(request.getContextPath() + "/warehouse/inventory");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi cập nhật: " + e.getMessage());
            doGet(request, response);
        } finally {
            if (dao != null) dao.closeConnection();
        }
    }
}
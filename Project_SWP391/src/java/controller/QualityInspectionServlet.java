package controller;

import dal.QualityInspectionDAO;
import dto.InspectionFormDTO;
import model.Quality_inspections;
import model.Users;
import model.Employees; 
import model.Warehouse_locations;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "QualityInspectionServlet", urlPatterns = {"/warehouse/inspections"})
public class QualityInspectionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String imei = request.getParameter("imei");
        QualityInspectionDAO dao = null;
        QualityInspectionDAO locDao = null;
        try {
            locDao = new QualityInspectionDAO();
            List<Warehouse_locations> locationList = locDao.getAllLocations();
            request.setAttribute("locationList", locationList);
            if (imei != null && !imei.trim().isEmpty()) {
                dao = new QualityInspectionDAO();
                InspectionFormDTO unitDetails = dao.getUnitDetailsForInspection(imei.trim());
                if (unitDetails != null) {
                    request.setAttribute("unitDetails", unitDetails);
                } else {
                    request.setAttribute("errorMessage", "Không tìm thấy sản phẩm với IMEI: " + imei);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi tải dữ liệu: " + e.getMessage());
        } finally {
            if (dao != null) {
                dao.closeConnection();
            }
            if (locDao != null) {
                locDao.closeConnection();
            }
        }
        request.getRequestDispatcher("/WEB-INF/view/qualityInspectionForm.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        QualityInspectionDAO dao = null;
        String imei = request.getParameter("imei");
        try {
            int unitId = Integer.parseInt(request.getParameter("unitId"));
            int locationId = Integer.parseInt(request.getParameter("location_id"));
            String newStatus = request.getParameter("new_status");
            String note = request.getParameter("note");

            // SỬA LỖI: Lấy Employee ID
            Employees currentEmployee = (Employees) request.getSession().getAttribute("employee");
            if (currentEmployee == null) {
                throw new Exception("Lỗi phiên đăng nhập. Không tìm thấy thông tin Employee.");
            }
            int inspectedBy = currentEmployee.getEmployee_id(); // Lấy employee_id

            Quality_inspections newInspection = new Quality_inspections();
            newInspection.setInspection_no("QC-" + System.currentTimeMillis());
            newInspection.setUnit_id(unitId);
            newInspection.setLocation_id(locationId);
            newInspection.setInspected_by(inspectedBy); // Gán employee_id
            newInspection.setInspected_date(new Date());
            newInspection.setStatus(newStatus);
            newInspection.setResult(newStatus);
            newInspection.setNote(note);

            dao = new QualityInspectionDAO();
            boolean success = dao.addInspection(newInspection);
            if (!success) {
                throw new Exception("Không thể lưu phiếu kiểm định.");
            }
            response.sendRedirect(request.getContextPath() + "/warehouse/inventory");
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

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.QualityInspectionDAO;
import dto.InspectionFormDTO; 
import model.Quality_inspections;
import model.Users;
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
            // Luôn tải danh sách Vị trí kho (cho dropdown)
            locDao = new QualityInspectionDAO();
            List<Warehouse_locations> locationList = locDao.getAllLocations();
            request.setAttribute("locationList", locationList);

            if (imei != null && !imei.trim().isEmpty()) {
                // Bước 2: Tìm kiếm IMEI
                dao = new QualityInspectionDAO();
                InspectionFormDTO unitDetails = dao.getUnitDetailsForInspection(imei.trim());
                
                if (unitDetails != null) {
                    request.setAttribute("unitDetails", unitDetails);
                } else {
                    request.setAttribute("errorMessage", "Không tìm thấy sản phẩm với IMEI: " + imei);
                }
            }
            // (Nếu không có IMEI, chỉ hiển thị trang với dropdown Vị trí)

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi tải dữ liệu: " + e.getMessage());
        } finally {
            if (dao != null) dao.closeConnection();
            if (locDao != null) locDao.closeConnection();
        }
        
        request.getRequestDispatcher("/WEB-INF/view/qualityInspectionForm.jsp").forward(request, response);
    }

    /**
     * doPost: Xử lý lưu Phiếu QC
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        QualityInspectionDAO dao = null;
        
        // Giữ lại IMEI để hiển thị lại form nếu có lỗi
        String imei = request.getParameter("imei"); 
        
        try {
            // 1. Lấy dữ liệu form
            int unitId = Integer.parseInt(request.getParameter("unitId"));
            int locationId = Integer.parseInt(request.getParameter("location_id"));
            String newStatus = request.getParameter("new_status"); // PASSED, FAILED, ...
            String note = request.getParameter("note"); // Lý do lỗi, bảo hành,...
            
            Users currentUser = (Users) request.getSession().getAttribute("user");
            int inspectedBy = (currentUser != null) ? currentUser.getUser_id() : 1; 
            // 2. Tạo đối tượng Inspection
            Quality_inspections newInspection = new Quality_inspections();
            newInspection.setInspection_no("QC-" + System.currentTimeMillis()); // Mã QC tự động
            newInspection.setUnit_id(unitId);
            newInspection.setLocation_id(locationId);
            newInspection.setInspected_by(inspectedBy);
            newInspection.setInspected_date(new Date()); // Ngày kiểm tra
            newInspection.setStatus(newStatus); // Kết quả kiểm tra
            newInspection.setResult(newStatus); // Dùng chung (hoặc bạn có thể thêm field result)
            newInspection.setNote(note); // Lý do lỗi / Bảo hành / ...
            
            // 3. Lưu vào CSDL
            dao = new QualityInspectionDAO();
            boolean success = dao.addInspection(newInspection);
            
            if (!success) {
                throw new Exception("Không thể lưu phiếu kiểm định vào CSDL.");
            }
            
            // 4. Thành công, quay về trang danh sách tồn kho
            response.sendRedirect(request.getContextPath() + "/warehouse/inventory");

        } catch (Exception e) {
            e.printStackTrace();
            // Nếu lỗi, phải tải lại trang với thông báo lỗi
            request.setAttribute("errorMessage", "Lỗi khi lưu: " + e.getMessage());
            // Gọi lại doGet để tải lại form với thông tin cũ
            request.setAttribute("imei", imei); // Gửi lại imei để doGet tìm lại
            doGet(request, response); 
        } finally {
            if (dao != null) dao.closeConnection();
        }
    }
}
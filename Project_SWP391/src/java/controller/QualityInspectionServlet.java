/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.QualityInspectionDAO; 
import dto.InspectionViewDTO; 
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

    // doGet: Hiển thị form và danh sách
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        QualityInspectionDAO dao = new QualityInspectionDAO();
        try {
            // 1. Lấy lịch sử kiểm định
            List<InspectionViewDTO> inspectionList = dao.getAllInspectionsForView();
            request.setAttribute("inspectionList", inspectionList);
            
            // 2. Lấy danh sách vị trí kho (cho dropdown)
            QualityInspectionDAO locationDao = new QualityInspectionDAO();
            List<Warehouse_locations> locationList = locationDao.getAllLocations();
            request.setAttribute("locationList", locationList);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi tải dữ liệu: " + e.getMessage());
        }
        
        request.getRequestDispatcher("/WEB-INF/view/qualityInspectionList.jsp").forward(request, response);
    }

    // doPost: Xử lý thêm mới QC
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        try {
            // 1. Lấy dữ liệu form
            String imei = request.getParameter("imei");
            String result = request.getParameter("result");
            String note = request.getParameter("note");
            int locationId = Integer.parseInt(request.getParameter("location_id"));
            
            Users currentUser = (Users) request.getSession().getAttribute("user");
            int inspectedBy = (currentUser != null) ? currentUser.getUser_id() : 1;
            
            QualityInspectionDAO dao = new QualityInspectionDAO();
            
            // 2. Tìm unit_id từ IMEI
            int unitId = dao.getUnitIdByImei(imei);
            if (unitId == 0) {
                throw new Exception("Không tìm thấy sản phẩm với IMEI: " + imei);
            }
            
            // 3. Tạo đối tượng Inspection
            Quality_inspections newInspection = new Quality_inspections();
            newInspection.setInspection_no("QC-" + System.currentTimeMillis()); // Mã QC tự động
            newInspection.setUnit_id(unitId);
            newInspection.setLocation_id(locationId);
            newInspection.setInspected_by(inspectedBy);
            newInspection.setInspected_date(new Date());
            newInspection.setStatus("Completed");
            newInspection.setResult(result);
            newInspection.setNote(note);
            
            // 4. Lưu vào CSDL (DAO này sẽ tự mở/đóng connection)
            boolean success = dao.addInspection(newInspection);
            
            if (!success) {
                throw new Exception("Không thể lưu phiếu kiểm định vào CSDL.");
            }
            
            // 5. Thành công, tải lại trang
            response.sendRedirect(request.getContextPath() + "/warehouse/inspections");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi thêm: " + e.getMessage());
            doGet(request, response); 
        }
    }
}
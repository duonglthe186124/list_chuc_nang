/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.TransferDAO; 
import model.Containers; 
import dto.TransferDTO; 
import model.Users;
import model.Employees; // Cần để lấy employee_id

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "TransferServlet", urlPatterns = {"/warehouse/transfer"})
public class TransferServlet extends HttpServlet {

    /**
     * doGet: Xử lý tìm kiếm IMEI
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        String imei = request.getParameter("imei");
        TransferDAO dao = null;
        TransferDAO containerDao = null;
        
        try {
            // Luôn tải danh sách Containers (cho dropdown)
            containerDao = new TransferDAO();
            List<Containers> containerList = containerDao.getAllContainersWithLocation();
            request.setAttribute("containerList", containerList);

            if (imei != null && !imei.trim().isEmpty()) {
                // Tìm kiếm IMEI
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
            if (dao != null) dao.closeConnection();
            if (containerDao != null) containerDao.closeConnection();
        }
        
        request.getRequestDispatcher("/WEB-INF/view/transfer.jsp").forward(request, response);
    }

    /**
     * doPost: Xử lý lưu Điều chuyển
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        TransferDAO dao = null;
        String imei = request.getParameter("imei"); // Giữ lại IMEI để hiển thị lại nếu lỗi
        
        try {
            // 1. Lấy dữ liệu form
            int unitId = Integer.parseInt(request.getParameter("unitId"));
            int newContainerId = Integer.parseInt(request.getParameter("newContainerId"));
            int currentContainerId = Integer.parseInt(request.getParameter("currentContainerId"));
            String note = request.getParameter("note");
            
            // Lấy Employee ID (ví dụ, bạn phải lưu employee trong session khi login)
            Employees currentEmployee = (Employees) request.getSession().getAttribute("employee");
            int employeeId = (currentEmployee != null) ? currentEmployee.getEmployee_id() : 1; // Tạm
            
            if (newContainerId == currentContainerId) {
                throw new Exception("Lỗi: Vị trí mới phải khác vị trí hiện tại.");
            }

            String reason = "Internal Transfer. Ghi chú: " + note;

            // 2. Gọi DAO để xử lý (trong 1 transaction)
            dao = new TransferDAO();
            boolean success = dao.processTransfer(unitId, newContainerId, employeeId, reason);
            
            if (success) {
                // 3. Thành công, tải lại trang với thông báo
                request.setAttribute("successMessage", "Đã điều chuyển IMEI " + imei + " thành công!");
                doGet(request, response);
            } else {
                throw new Exception("Điều chuyển thất bại. Dữ liệu đã được rollback.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi lưu: " + e.getMessage());
            request.setAttribute("imei", imei);
            doGet(request, response);
        } finally {
            // (DAO đã tự đóng kết nối trong finally)
        }
    }
}
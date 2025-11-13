/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

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

    /**
     * doGet: Xử lý tìm kiếm IMEI
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        String imei = request.getParameter("imei");
        ReturnsDAO dao = null;
        
        try {
            if (imei != null && !imei.trim().isEmpty()) {
                // Mở DAO
                dao = new ReturnsDAO();
                
                // Gọi Hàm 1 (JOIN 8 bảng)
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
            if (dao != null) dao.closeConnection();
        }
        
        request.getRequestDispatcher("/WEB-INF/view/createReturn.jsp").forward(request, response);
    }

    /**
     * doPost: Xử lý lưu phiếu trả hàng
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        ReturnsDAO dao = null;
        String imei = request.getParameter("imei"); // Giữ lại IMEI để hiển thị lại nếu lỗi
        
        try {
            // 1. Lấy dữ liệu form (gồm 3 trường input)
            int unitId = Integer.parseInt(request.getParameter("unitId"));
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String reason = request.getParameter("reason"); // Lý do (Dropdown)
            String note = request.getParameter("note"); // Ghi chú (Textarea)
            
            Users currentUser = (Users) request.getSession().getAttribute("user");
            int createdBy = (currentUser != null) ? currentUser.getUser_id() : 1; // Tạm
            
            // 2. Gọi DAO để xử lý (Hàm 2 - Transaction)
            dao = new ReturnsDAO();
            boolean success = dao.processReturn(unitId, orderId, createdBy, reason, note);
            
            if (success) {
                // 3. Thành công, quay về trang LỊCH SỬ
                response.sendRedirect(request.getContextPath() + "/warehouse/returnsList");
            } else {
                throw new Exception("Xử lý trả hàng thất bại. Dữ liệu đã được rollback.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi lưu: " + e.getMessage());
            // Gọi lại doGet để tải lại form với thông tin cũ
            request.setAttribute("imei", imei);
            doGet(request, response);
        } finally {
            if (dao != null) dao.closeConnection();
        }
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/reset-password"})
/**
 *
 * @author admin
 */
public class ResetPasswordServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu truy cập trực tiếp bằng GET (không hợp lệ), chuyển về login
        response.sendRedirect(request.getContextPath() + "/loginStaff"); 
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action"); // Thêm action để biết nút nào được nhấn
        if ("cancel".equals(action)) {
            response.sendRedirect(request.getContextPath() + "/loginStaff");
            return;
        }

        String email = request.getParameter("email");
        String token = request.getParameter("reset_code");
        String newPassword = request.getParameter("new_password");
        String confirmPassword = request.getParameter("confirm_password");
        
        request.setAttribute("email", email); // Giữ lại email để hiển thị nếu có lỗi

        // --- Bắt đầu phần CẬP NHẬT theo yêu cầu: Kiểm tra bỏ trống ô ---
        if (token == null || token.trim().isEmpty()) {
            request.setAttribute("error", "Please enter the reset code.");
            request.getRequestDispatcher("WEB-INF/view/reset_password.jsp").forward(request, response);
            return;
        }
        if (newPassword == null || newPassword.trim().isEmpty()) {
            request.setAttribute("error", "Please enter your new password.");
            request.getRequestDispatcher("WEB-INF/view/reset_password.jsp").forward(request, response);
            return;
        }
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            request.setAttribute("error", "Please confirm your new password.");
            request.getRequestDispatcher("WEB-INF/view/reset_password.jsp").forward(request, response);
            return;
        }
        // --- Kết thúc phần CẬP NHẬT ---

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("WEB-INF/view/reset_password.jsp").forward(request, response);
            return;
        }
        
        // --- Phần này vẫn chưa xử lý backend, tạm thời hiển thị thông báo thành công giả định ---
        // Sau này bạn sẽ tích hợp logic UserDAO vào đây
        System.out.println(">>> ResetPasswordServlet: Simulating password change for email: " + email);
        System.out.println(">>> New Password: " + newPassword);
        response.sendRedirect(request.getContextPath() + "/loginStaff?message=Password+has+been+reset+successfully+(" + email + ")");
    }

}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.UserDAO;
import model.Users;
import java.io.IOException;
import java.sql.Timestamp;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ResetPasswordServlet extends HttpServlet {
   

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/loginStaff"); 
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
//        String action = request.getParameter("action"); 
//        if ("cancel".equals(action)) {
//            response.sendRedirect(request.getContextPath() + "/loginStaff");
//            return;
//        }

        String email = request.getParameter("email").trim();
        String codeFromUser = request.getParameter("reset_code").trim();
        String newPassword = request.getParameter("new_password").trim();
        String confirmPassword = request.getParameter("confirm_password").trim();
        
        request.setAttribute("email", email); 

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("WEB-INF/view/reset_password.jsp").forward(request, response);
            return;
        }
        
        UserDAO userDAO = new UserDAO();
        // Tìm user bằng mã code mà người dùng nhập
        Users user = userDAO.findUserByResetToken(codeFromUser);
        
        // --- BẮT ĐẦU XÁC THỰC ---
        if (user == null) {
            request.setAttribute("error", "Invalid reset code.");
            request.getRequestDispatcher("WEB-INF/view/reset_password.jsp").forward(request, response);
            return;
        }

        // Kiểm tra xem mã code này có đúng là của email này không
        if (!user.getEmail().equals(email)) {
            request.setAttribute("error", "Invalid reset code for this email.");
            request.getRequestDispatcher("WEB-INF/view/reset_password.jsp").forward(request, response);
            return;
        }

        // Kiểm tra xem mã code đã hết hạn chưa
        if (user.getToken_expiry().before(new Timestamp(System.currentTimeMillis()))) {
            request.setAttribute("error", "Code has expired. Please request a new one.");
            request.getRequestDispatcher("WEB-INF/view/reset_password.jsp").forward(request, response);
            return;
        }
        // --- KẾT THÚC XÁC THỰC ---

        // Nếu tất cả đều hợp lệ:
        userDAO.updatePasswordByEmail(user.getEmail(), newPassword);
        
        // Chuyển về trang login với thông báo thành công
        response.sendRedirect(request.getContextPath() + "/loginStaff?message=Password+has+been+reset+successfully");
    }

}

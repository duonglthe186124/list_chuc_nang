/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.UserDAO;
import util.EmailUtil;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Random;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author admin
 */
public class ForgotPasswordServlet extends HttpServlet {
   
    private static final int EXPIRY_MINUTES = 2; //thời gian hết hạn là 2 PHÚT
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/forgot_password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");

        // 2. Kiểm tra (phòng trường hợp form bị gửi mà không có email)
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("message", "Error: Email was missing. Please try again.");
            request.getRequestDispatcher("WEB-INF/view/forgot_password.jsp").forward(request, response);
            return;
        }

        email = email.trim();
        UserDAO userDAO = new UserDAO();
        
        // 3. Tạo mã reset và thời gian hết hạn
        String resetCode = String.format("%06d", new Random().nextInt(999999));
        Timestamp expiryDate = new Timestamp(System.currentTimeMillis() + (EXPIRY_MINUTES * 60 * 1000)); 

        // 4. Lưu mã vào database
        boolean tokenSaved = userDAO.saveResetToken(email, resetCode, expiryDate);

        if (tokenSaved) {
            // 5. Gửi email
            EmailUtil.sendResetCode(email, resetCode);
            
            // 6. Chuyển tiếp đến trang nhập mã (reset_password.jsp)
            //    GỬI KÈM 'email' và 'expiryTime'
            request.setAttribute("email", email);
            request.setAttribute("expiryTime", expiryDate.getTime()); // Gửi mốc thời gian (số)
            
            request.getRequestDispatcher("WEB-INF/view/reset_password.jsp").forward(request, response);
            
        } else {
            // Lỗi này xảy ra nếu saveResetToken thất bại (vd: email không tìm thấy)
            request.setAttribute("message", "Error: Could not save reset token for that account.");
            request.getRequestDispatcher("WEB-INF/view/forgot_password.jsp").forward(request, response);
        }
    }
}

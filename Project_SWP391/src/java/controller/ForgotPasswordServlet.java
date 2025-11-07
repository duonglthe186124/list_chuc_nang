/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.UserDAO;
import model.Users;
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
        String credential = request.getParameter("credential").trim();
        UserDAO userDAO = new UserDAO();
        
        Users user = userDAO.findUserByEmailOrPhone(credential);

        if (user != null) {
            String resetCode = String.format("%06d", new Random().nextInt(999999));
            // Đặt thời gian hết hạn là 2 PHÚT kể từ bây giờ
            Timestamp expiryDate = new Timestamp(System.currentTimeMillis() + (EXPIRY_MINUTES * 60 * 1000)); 

            userDAO.saveResetToken(user.getEmail(), resetCode, expiryDate);
            EmailUtil.sendResetCode(user.getEmail(), resetCode);
            
            request.setAttribute("email", user.getEmail());
            // Gửi mốc thời gian hết hạn (dưới dạng số) sang JSP để JavaScript bắt đầu đếm ngược
            request.setAttribute("expiryTime", expiryDate.getTime());
            
            request.getRequestDispatcher("WEB-INF/view/reset_password.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Error: No account found with that email or phone number.");
            request.getRequestDispatcher("WEB-INF/view/forgot_password.jsp").forward(request, response);
        }
    }
}

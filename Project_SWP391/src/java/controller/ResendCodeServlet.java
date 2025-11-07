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
public class ResendCodeServlet extends HttpServlet {
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final int EXPIRY_MINUTES = 2; // 2 phút

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");

        // 3. THÊM KIỂM TRA NULL ĐỂ TRÁNH LỖI
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "An error occurred. Please try again from the beginning.");
            request.getRequestDispatcher("WEB-INF/view/forgot_password.jsp").forward(request, response);
            return;
        }
        
        email = email.trim(); 
        UserDAO userDAO = new UserDAO();
        
        String resetCode = String.format("%06d", new Random().nextInt(999999));
        Timestamp expiryDate = new Timestamp(System.currentTimeMillis() + (EXPIRY_MINUTES * 60 * 1000));

        userDAO.saveResetToken(email, resetCode, expiryDate);
        boolean emailSent = EmailUtil.sendResetCode(email, resetCode);

        if (emailSent) {
            request.setAttribute("successMessage", "A new code has been sent to your email.");
        } else {
            request.setAttribute("error", "Error: Could not send the new code. Please try again later.");
        }
        
        request.setAttribute("email", email);
        request.setAttribute("expiryTime", expiryDate.getTime());
        
        request.getRequestDispatcher("WEB-INF/view/reset_password.jsp").forward(request, response);
    }

}

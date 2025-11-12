/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author admin
 */
public class VerifyCodeServlet extends HttpServlet {
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String resetCode = request.getParameter("reset_code");

        UserDAO userDAO = new UserDAO();
        boolean isValid = userDAO.verifyResetCode(email, resetCode);

        // Thiết lập kiểu trả về là JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        String jsonResponse;

        if (isValid) {
            // TÌM THẤY VÀ HỢP LỆ
            jsonResponse = "{\"valid\": true}";
        } else {
            // KHÔNG TÌM THẤY hoặc HẾT HẠN
            jsonResponse = "{\"valid\": false, \"message\": \"Invalid or expired code. Please try again.\"}";
        }

        out.print(jsonResponse);
        out.flush();
    }

}

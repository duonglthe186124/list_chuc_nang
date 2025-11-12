/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.UserDAO;
import model.Users;
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
public class FindAccountServlet extends HttpServlet {
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        
        UserDAO userDAO = new UserDAO();
        Users user = userDAO.findUserWithRoleByEmail(email); 

        // Thiết lập kiểu trả về là JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        PrintWriter out = response.getWriter();
        String jsonResponse;

        if (user != null) {
            // TÌM THẤY: Trả về JSON chứa thông tin
            jsonResponse = String.format(
                "{\"found\": true, \"fullname\": \"%s\", \"roleName\": \"%s\"}",
                user.getFullname(), // Đảm bảo fullname không có dấu "
                user.getRoleName() != null ? user.getRoleName() : "N/A"
            );
        } else {
            // KHÔNG TÌM THẤY:
            jsonResponse = "{\"found\": false}";
        }

        out.print(jsonResponse);
        out.flush();
    }
}

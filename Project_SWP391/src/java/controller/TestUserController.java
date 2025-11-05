/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.getRoleBySetIdDAO;
import dto.UserToCheckTask;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hoang
 */
public class TestUserController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");

        String userId = req.getParameter("userId");

        // Kiểm tra null hoặc rỗng
        if (userId == null || userId.trim().isEmpty()) {
            resp.getWriter().println("<h3 style='color:red;'>Missing userId parameter!</h3>");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(userId);
        } catch (NumberFormatException e) {
            resp.getWriter().println("<h3 style='color:red;'>Invalid userId format!</h3>");
            return;
        }

        getRoleBySetIdDAO dao = new getRoleBySetIdDAO();

        try {
            UserToCheckTask user = dao.getUserById(id);

            if (user != null) {
                // In ra trình duyệt
                resp.getWriter().println("<h2>User Information</h2>");
                resp.getWriter().println("<ul>");
                resp.getWriter().println("<li><strong>User ID:</strong> " + user.getUserId() + "</li>");
                resp.getWriter().println("<li><strong>Full Name:</strong> " + user.getFullname() + "</li>");
                resp.getWriter().println("<li><strong>Role ID:</strong> " + user.getRoleId() + "</li>");
                resp.getWriter().println("<li><strong>Role Name:</strong> " + user.getRolename() + "</li>");
                resp.getWriter().println("</ul>");
                resp.getWriter().println("<a href='" + req.getContextPath() + "/order/list'>Back to Order List</a>");

                // In ra log server (NetBeans console)
                System.out.println("✅ Loaded user info:");
                System.out.println("User ID: " + user.getUserId());
                System.out.println("Full Name: " + user.getFullname());
                System.out.println("Role ID: " + user.getRoleId());
                System.out.println("Role Name: " + user.getRolename());
            } else {
                resp.getWriter().println("<h3 style='color:red;'>No user found with ID = " + id + "</h3>");
            }

        } catch (SQLException ex) {
            Logger.getLogger(TestUserController.class.getName()).log(Level.SEVERE, null, ex);
            resp.getWriter().println("<h3 style='color:red;'>Database error: " + ex.getMessage() + "</h3>");
        }
    }

}



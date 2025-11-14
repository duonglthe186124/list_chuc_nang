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
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Users;

/**
 *
 * @author hoang
 */
public class TestUserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");

        HttpSession session = req.getSession(false);
        Users currentUser = null;
        if (session != null) {
            currentUser = (Users) session.getAttribute("account");
        }

        if (currentUser != null) {
            // In ra trình duyệt
            resp.getWriter().println("<h2>User Information</h2>");
            resp.getWriter().println("<ul>");
            resp.getWriter().println("<li><strong>User ID:</strong> " + currentUser.getUser_id() + "</li>");
            resp.getWriter().println("<li><strong>Full Name:</strong> " + currentUser.getFullname() + "</li>");
            resp.getWriter().println("<li><strong>Role ID:</strong> " + currentUser.getRole_id() + "</li>");
            resp.getWriter().println("<li><strong>Role Name:</strong> " + currentUser.getRoleName() + "</li>");
            resp.getWriter().println("</ul>");
            
            // In ra log server (NetBeans console)
            System.out.println("✅ Loaded user info:");
            System.out.println("User ID: " + currentUser.getUser_id());
            System.out.println("Full Name: " + currentUser.getFullname());
            System.out.println("Role ID: " + currentUser.getRole_id());
            System.out.println("Role Name: " + currentUser.getRoleName());
        } else {
            resp.getWriter().println("User is null");
        }
    }

}

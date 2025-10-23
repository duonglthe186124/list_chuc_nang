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
import jakarta.servlet.annotation.WebServlet;
package controller;

import dal.UserDBContext_HE181624_DuongLT;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "login_servlet", urlPatterns = {"/loginStaff"})
public class login_servlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/login_page.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        UserDAO userDAO = new UserDAO();
        Users user = userDAO.checkLogin(email, password);
        
        if (user == null) {

            request.setAttribute("errorMessage", "Incorrect email or password.");
            request.getRequestDispatcher("/WEB-INF/view/login_page.jsp").forward(request, response);
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("account", user); 
            response.sendRedirect("home");
        }    
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Handles user login";
    }// </editor-fold>

import java.io.IOException;
import dto.AuthUser_HE186124_DuongLT;
import java.util.ArrayList;

public class login_servlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserDBContext_HE181624_DuongLT db = new UserDBContext_HE181624_DuongLT();
        AuthUser_HE186124_DuongLT users = db.getLogin(email, password);

        HttpSession session = req.getSession();

        if (users != null) {
            // Đăng nhập thành công
            session.setAttribute("users", users);

            // Lấy lại URL người dùng muốn truy cập trước đó
            String redirectURL = (String) session.getAttribute("redirectAfterLogin");
            if (redirectURL != null) {
                session.removeAttribute("redirectAfterLogin");
                resp.sendRedirect(redirectURL);
            } else {
                // Nếu không có URL trước đó thì về home
                resp.sendRedirect(req.getContextPath() + "/index.htm");
            }
        } else {
            // Sai thông tin đăng nhập
            req.setAttribute("error", "Sai email hoặc mật khẩu!");
            req.getRequestDispatcher("/WEB-INF/view/login_page.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/view/login_page.jsp").forward(req, resp);
    }
}

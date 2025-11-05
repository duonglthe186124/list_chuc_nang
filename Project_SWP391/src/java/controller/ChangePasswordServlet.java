/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.UserDAO;
import model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;

/**
 *
 * @author admin
 */
public class ChangePasswordServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ChangePasswordServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePasswordServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

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
//        if (request.getSession().getAttribute("account") == null) {
//            response.sendRedirect(request.getContextPath()+"/loginStaff");
//            return;
//        }
//        request.getRequestDispatcher("WEB-INF/view/change_password.jsp").forward(request, response);
        System.out.println(">>> ChangePasswordServlet: Bypassing login check for testing.");
        request.getRequestDispatcher("WEB-INF/view/change_password.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("account");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/loginStaff");
            return;
        }

        String oldPassword = request.getParameter("old_password");
        String newPassword = request.getParameter("new_password");
        String confirmPassword = request.getParameter("confirm_password");

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "New password and confirmation do not match.");
            request.getRequestDispatcher("WEB-INF/view/change_password.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        
        boolean isOldPasswordCorrect = userDAO.verifyOldPassword(currentUser.getUser_id(), oldPassword);
        if (!isOldPasswordCorrect) {
            request.setAttribute("errorMessage", "Incorrect old password.");
            request.getRequestDispatcher("WEB-INF/view/change_password.jsp").forward(request, response);
            return;
        }
        
        boolean updateSuccess = userDAO.updatePassword(currentUser.getUser_id(), newPassword);
        if (updateSuccess) {
            request.setAttribute("successMessage", "Password has changed successfully!");
            request.setAttribute("redirectUrl", request.getContextPath() + "/PersonalProfile");
        } else {
            request.setAttribute("errorMessage", "An error occurred. Please try again.");
        }
        request.getRequestDispatcher("WEB-INF/view/change_password.jsp").forward(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

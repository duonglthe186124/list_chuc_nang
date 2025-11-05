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
public class ProfileServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//    throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet ProfileServlet</title>");  
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet ProfileServlet at " + request.getContextPath () + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    } 

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

        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("account");

        if (currentUser == null) {
            System.out.println(">>> ProfileServlet: No user in session. Creating a mock user for testing.");

            currentUser = new Users();

            currentUser.setFullname("Test User Name");
            currentUser.setEmail("test.user@example.com");
            currentUser.setPhone("0987654321");
            currentUser.setAddress("123 Test Street, Hanoi");
        }

        request.setAttribute("userProfile", currentUser);
        request.getRequestDispatcher("WEB-INF/view/personal_profile.jsp").forward(request, response);
    }
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//    throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        Users currentUser = (Users) session.getAttribute("account");
//
//        if (currentUser == null) {
//            response.sendRedirect(request.getContextPath() + "/loginStaff");
//            return;
//        }
//        request.setAttribute("userProfile", currentUser);
//        request.getRequestDispatcher("WEB-INF/view/personal_profile.jsp").forward(request, response);
//    }

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
        request.setCharacterEncoding("UTF-8"); 

        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("account");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/loginStaff");
            return;
        }

        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        currentUser.setFullname(fullname);
        currentUser.setPhone(phone);
        currentUser.setAddress(address);

        UserDAO userDAO = new UserDAO();
        boolean success = userDAO.updateUser(currentUser);

        if (success) {
            session.setAttribute("account", currentUser);
            request.setAttribute("successMessage", "Profile updated successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
        }

        request.setAttribute("userProfile", currentUser);
        request.getRequestDispatcher("WEB-INF/view/personal_profile.jsp").forward(request, response);
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

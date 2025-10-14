/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import dal.InventoryDAO;
import java.io.PrintWriter;
import service.InventoryService;
import model.Inventory_records;

/**
 *
 * @author Ha Trung KI
 */
public class AuditController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AuditController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AuditController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private final InventoryDAO inventoryDAO = new InventoryDAO();
    private final InventoryService service = new InventoryService();
    
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
        try {
            List<Inventory_records> list = inventoryDAO.getAllInventoryRecords();
            request.setAttribute("inventoryList", list);
            request.getRequestDispatcher("/WEB-INF/view/inventory/audit.jsp").forward(request, response);
        } catch (SQLException ex) { throw new ServletException(ex); }
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
        try {
            int inventoryId = Integer.parseInt(request.getParameter("inventoryId"));
            int actualQty = Integer.parseInt(request.getParameter("actualQty"));
            String note = request.getParameter("note");

            service.auditAdjustAtomic(inventoryId, actualQty, 1, note);
            response.sendRedirect(request.getContextPath() + "/inventory/audit");
        } catch (SQLException ex) { throw new ServletException(ex); }
        catch (NumberFormatException ex) { request.setAttribute("error","Invalid input"); doGet(request, response); }
    }
    

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

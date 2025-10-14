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
import dal.ProductDAO;
import dal.LocationDAO;
import dal.QualityDAO;
import dal.ProductUnitDAO;
import java.io.PrintWriter;
import model.Products;
import model.Warehouse_locations;
/**
 *
 * @author Ha Trung KI
 */
public class QualityController extends HttpServlet {
   
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
            out.println("<title>Servlet QualityController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet QualityController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 
    private final ProductDAO productDAO = new ProductDAO();
    private final LocationDAO locationDAO = new LocationDAO();
    private final QualityDAO qualityDAO = new QualityDAO();
    private final ProductUnitDAO unitDAO = new ProductUnitDAO();
    
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
        try {
            request.setAttribute("products", productDAO.getAllProducts());
            request.setAttribute("locations", locationDAO.listAll());
            request.setAttribute("qcList", qualityDAO.getAllQC());
            request.getRequestDispatcher("/WEB-INF/view/inventory/quality.jsp").forward(request, response);
        } catch (SQLException e) { throw new ServletException(e); }
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
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int inspectorId = Integer.parseInt(request.getParameter("inspectorId"));
            String state = request.getParameter("state");
            String error = request.getParameter("error");
            String remarks = request.getParameter("remarks");

            int unitId = unitDAO.findFirstUnitIdByProduct(productId);
            Integer u = unitId >= 0 ? unitId : null;

            qualityDAO.insertQualityControl(u, null, inspectorId, state, error, remarks);
            response.sendRedirect(request.getContextPath() + "/inventory/quality");
        } catch (SQLException ex) { throw new ServletException(ex); }
        catch (NumberFormatException ex) { request.setAttribute("error","Invalid input"); doGet(request, response); }
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

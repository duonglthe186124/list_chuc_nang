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
import dal.ProductUnitDAO;
import java.io.PrintWriter;
import model.Products;
import model.Warehouse_locations;
import service.InventoryService;

/**
 *
 * @author Ha Trung KI
 */
public class MoveController extends HttpServlet {

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
            out.println("<title>Servlet MoveController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MoveController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    private final ProductDAO productDAO = new ProductDAO();
    private final LocationDAO locationDAO = new LocationDAO();
    private final ProductUnitDAO unitDAO = new ProductUnitDAO();
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
            request.setAttribute("products", productDAO.getAllProducts());
            request.setAttribute("locations", locationDAO.listAll());
            request.getRequestDispatcher("/WEB-INF/view/inventory/move.jsp").forward(request, response);
        } catch (SQLException e) { throw new ServletException(e); }
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
            int productId = Integer.parseInt(request.getParameter("productId"));
            int fromLocation = Integer.parseInt(request.getParameter("fromLocation"));
            int toLocation = Integer.parseInt(request.getParameter("toLocation"));
            int qty = Integer.parseInt(request.getParameter("qty"));
            String note = request.getParameter("note");

            int unitId = unitDAO.findFirstUnitIdByProduct(productId);
            if (unitId < 0) unitId = 1;

            boolean ok = service.moveProductAtomic(productId, fromLocation, toLocation, qty, unitId, 1, "MOVE", note);
            if (!ok) {
                request.setAttribute("error", "Not enough stock at source location");
                doGet(request, response);
                return;
            }
            response.sendRedirect(request.getContextPath() + "/inventory/move");
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

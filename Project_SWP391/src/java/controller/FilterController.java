/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import dal.ProductDAO;
import dal.EmployeeDAO;
import dal.TransactionDAO;
import java.io.PrintWriter;
import model.Products;
import model.Employees;
import model.Inventory_transactions;

/**
 *
 * @author Ha Trung KI
 */
public class FilterController extends HttpServlet {
   
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
            out.println("<title>Servlet FilterController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FilterController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 
    private final ProductDAO productDAO = new ProductDAO();
    private final EmployeeDAO employeeDAO = new EmployeeDAO();
    private final TransactionDAO txDAO = new TransactionDAO();
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
            List<Products> products = productDAO.getAllProducts();
            List<Employees> employees = employeeDAO.getAllEmployees();
            List<Inventory_transactions> txList = txDAO.getAllTransactions();
            request.setAttribute("products", products);
            request.setAttribute("employees", employees);
            request.setAttribute("txList", txList);
            request.getRequestDispatcher("/WEB-INF/view/inventory/filter.jsp").forward(request, response);
        } catch (Exception ex) { throw new ServletException(ex); }
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
            request.setCharacterEncoding("UTF-8");
            String txType = request.getParameter("txType");
            String fromStr = request.getParameter("from");
            String toStr = request.getParameter("to");
            String productIdStr = request.getParameter("productId");
            String employeeIdStr = request.getParameter("employeeId");

            Date from = (fromStr == null || fromStr.isEmpty()) ? null : Date.valueOf(fromStr);
            Date to = (toStr == null || toStr.isEmpty()) ? null : Date.valueOf(toStr);
            Integer productId = (productIdStr == null || productIdStr.isEmpty()) ? null : Integer.valueOf(productIdStr);
            Integer employeeId = (employeeIdStr == null || employeeIdStr.isEmpty()) ? null : Integer.valueOf(employeeIdStr);

            List<Products> products = productDAO.getAllProducts();
            List<Employees> employees = employeeDAO.getAllEmployees();
            List<Inventory_transactions> txList = txDAO.filter(txType, from, to, productId, employeeId);

            request.setAttribute("products", products);
            request.setAttribute("employees", employees);
            request.setAttribute("txList", txList);
            request.getRequestDispatcher("/WEB-INF/views/inventory/filter.jsp").forward(request, response);
        } catch (Exception ex) { throw new ServletException(ex); }
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

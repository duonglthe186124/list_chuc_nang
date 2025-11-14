/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.receipt_good;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.SupplierManagementService;

/**
 *
 * @author ASUS
 */
public class DeleteSupplierServlet extends HttpServlet {

    private static final SupplierManagementService service = new SupplierManagementService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int supplierId = Integer.parseInt(request.getParameter("id"));

            boolean success = service.remove_supplier(supplierId);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/inbound/suppliers");
            } else {
                response.sendRedirect(request.getContextPath() + "/inbound/suppliers?message=deleteFail");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID Nhà Cung Cấp không hợp lệ");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

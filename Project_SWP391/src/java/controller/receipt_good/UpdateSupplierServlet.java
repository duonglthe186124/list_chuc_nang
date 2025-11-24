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
import model.Suppliers;
import service.SupplierManagementService;

/**
 *
 * @author ASUS
 */
public class UpdateSupplierServlet extends HttpServlet {

    private static final SupplierManagementService service = new SupplierManagementService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int supplier_id = Integer.parseInt(request.getParameter("id"));
            Suppliers supplier_name = service.getSupplierDetails(supplier_id);

            if (supplier_name != null) {
                request.setAttribute("supplier", supplier_name);
                request.getRequestDispatcher("/WEB-INF/view/update_supplier.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy Nhà Cung Cấp");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID Nhà Cung Cấp không hợp lệ");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int supplierId = 0;
        try {
            supplierId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
             response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID Nhà Cung Cấp không hợp lệ");
             return;
        }
        
        String supplierName = request.getParameter("supplier_name");
        String displayName = request.getParameter("display_name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String representative = request.getParameter("representative");
        String paymentMethod = request.getParameter("payment_method");
        String note = request.getParameter("note");

        Suppliers updatedSupplier = new Suppliers(supplierId, supplierName, displayName, address, phone, email, representative, paymentMethod, note);

        boolean success = service.update_supplier_info(updatedSupplier);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/inbound/suppliers");
        } else {
            request.setAttribute("errorMessage", "Cập nhật Nhà Cung Cấp thất bại.");
            request.setAttribute("supplier", updatedSupplier); 
            request.getRequestDispatcher("/inbound/edit-supplier.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

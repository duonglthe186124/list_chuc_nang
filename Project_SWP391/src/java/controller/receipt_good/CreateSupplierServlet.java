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
public class CreateSupplierServlet extends HttpServlet {

    private static final SupplierManagementService service = new SupplierManagementService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/view/create_supplier.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String supplierName = request.getParameter("supplier_name");
        String displayName = request.getParameter("display_name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String representative = request.getParameter("representative");
        String paymentMethod = request.getParameter("payment_method");
        String note = request.getParameter("note");
        
        Suppliers newSupplier = new Suppliers(-1, supplierName, displayName, address, phone, email, representative, paymentMethod, note);

        int newId = service.create_supplier(newSupplier);

        if (newId > 0) {
            response.sendRedirect(request.getContextPath() + "/inbound/suppliers");
        } else {
            request.setAttribute("errorMessage", "Tạo Nhà Cung Cấp thất bại. Vui lòng kiểm tra lại dữ liệu.");
            request.setAttribute("oldSupplier", newSupplier); 
            request.getRequestDispatcher("/inbound/create_supplier.jsp").forward(request, response);
        }
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

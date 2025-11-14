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
public class ViewSupplierServlet extends HttpServlet {

    private static final SupplierManagementService service = new SupplierManagementService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int supplier_id = Integer.parseInt(request.getParameter("id"));
            Suppliers supplier = service.getSupplierDetails(supplier_id);

            if (supplier != null) {
                request.setAttribute("supplier", supplier);
                request.getRequestDispatcher("/WEB-INF/view/view_supplier.jsp").forward(request, response);
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
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

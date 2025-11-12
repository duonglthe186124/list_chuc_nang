package controller.receipt_good;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.ManagePOService;

/**
 *
 * @author ASUS
 */
public class CancelPurchaseOrderServlet extends HttpServlet {

    private static final ManagePOService service = new ManagePOService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String raw_po_id = request.getParameter("id");

        int po_id;
        try {
            po_id = Integer.parseInt(raw_po_id);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }

        try {
            service.cancel_po(po_id);
        } catch (IllegalArgumentException e) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }
        
        response.sendRedirect(request.getContextPath() + "/inbound/purchase-orders");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

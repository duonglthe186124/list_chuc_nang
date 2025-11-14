package controller.receipt_good;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.ManagePOService;

public class ConfirmPurchaseOrderServlet extends HttpServlet {

    private static final ManagePOService service = new ManagePOService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String rawPoId = request.getParameter("poId");
        String token = request.getParameter("token");
        
        if (rawPoId == null || token == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request.");
            return;
        }

        try {
            int poId = Integer.parseInt(rawPoId);
            
            boolean isConfirmed = service.confirm_purchase_order(poId, token); 

            if (isConfirmed) {
                request.setAttribute("message", "Xác nhận Đơn hàng thành công. Cảm ơn Nhà cung cấp.");
                request.getRequestDispatcher("/WEB-INF/view/success_confirmation.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Link xác nhận không hợp lệ, đã hết hạn, hoặc đơn hàng đã được xác nhận trước đó.");
                request.getRequestDispatcher("/WEB-INF/view/error_confirmation.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID đơn hàng không hợp lệ.");
        }
    }
}
package controller.receipt_good;

import dto.Response_POHeaderDTO;
import dto.Response_POLineDTO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Suppliers;
import service.ManagePOService;

/**
 *
 * @author ASUS
 */
public class SupplierPOViewServlet extends HttpServlet {

    private static final ManagePOService service = new ManagePOService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rawPoId = request.getParameter("poId");
        String token = request.getParameter("token");
        String sID = request.getParameter("sID");
        if (rawPoId == null || token == null || rawPoId.trim().isEmpty() || token.trim().isEmpty()) {
            request.setAttribute("error", "Tham số truy cập không hợp lệ.");
            request.getRequestDispatcher("/WEB-INF/view/supplier_po_view.jsp").forward(request, response);
            return;
        }

        try {
            int poId = Integer.parseInt(rawPoId);
            int supplier_id = Integer.parseInt(sID);

            Response_POHeaderDTO poheader = service.get_po_header_by_id_and_token(poId, token);
            Suppliers supplier = service.get_supplier_by_id(supplier_id);

            if (poheader != null) {
                List<Response_POLineDTO> poline = service.get_po_line(poId);

                request.setAttribute("poheader", poheader);
                request.setAttribute("poline", poline);
                request.setAttribute("supplier", supplier);
                request.setAttribute("token", token);

                request.getRequestDispatcher("/WEB-INF/view/supplier_po_view.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Đơn hàng không tồn tại hoặc link xác nhận đã hết hạn/không hợp lệ.");
                request.getRequestDispatcher("/WEB-INF/view/supplier_po_view.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID đơn hàng không hợp lệ.");
            request.getRequestDispatcher("/WEB-INF/view/supplier_po_view.jsp").forward(request, response);
        }
    }
}

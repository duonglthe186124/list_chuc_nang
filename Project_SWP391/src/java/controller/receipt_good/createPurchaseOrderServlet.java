package controller.receipt_good;

import dto.Response_POHeaderDTO;
import dto.Response_POLineDTO;
import dto.Response_ProductDTO;
import dto.Response_SupplierDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import service.EmailService;
import service.ManagePOService;
import static util.Validation.*;

/**
 *
 * @author ASUS
 */
public class createPurchaseOrderServlet extends HttpServlet {

    private static final ManagePOService service = new ManagePOService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String raw_po_id = request.getParameter("id");

        Response_POHeaderDTO poheader = null;
        List<Response_POLineDTO> poline = null;
        List<Response_SupplierDTO> supplier_list = new ArrayList();
        List<Response_ProductDTO> product_list = new ArrayList();
        int po_id = -1;

        if (raw_po_id != null && !raw_po_id.trim().isEmpty()) {
            try {
                po_id = Integer.parseInt(raw_po_id);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/404");
            }
        }

        if (po_id != -1) {
            try {
                poheader = service.get_po_header(po_id);
                poline = service.get_po_line(po_id);
            } catch (IllegalArgumentException e) {
                if ("404".equals(e.getMessage())) {
                    response.sendRedirect(request.getContextPath() + "/404");
                    return;
                }
            }
        }

        String po_code = service.get_auto_po_code();
        supplier_list = service.get_list_supplier();
        product_list = service.get_list_product_sku();

        request.setAttribute("sList", supplier_list);
        request.setAttribute("pList", product_list);
        request.setAttribute("po_code", po_code);
        request.setAttribute("poHeader", poheader);
        request.setAttribute("poLines", poline);
        request.getRequestDispatcher("/WEB-INF/view/create_purchase_order.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        String raw_po_id = request.getParameter("id");

        String po_code = request.getParameter("po_code");
        String raw_supplier = request.getParameter("supplier");
        String raw_date = request.getParameter("delivery_date");
        String note = request.getParameter("note");
        String[] raw_product = request.getParameterValues("product");
        String[] raw_qty = request.getParameterValues("qty");
        String[] raw_unit_price = request.getParameterValues("unit_price");

        int supplier_id;
        try {
            raw_supplier = validate_supplier_input(raw_supplier);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            doGet(request, response);
            return;
        }

        try {
            supplier_id = validate_supplier_id(raw_supplier);
        } catch (IllegalArgumentException e) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }

        if (raw_product == null || raw_product[0] == null || raw_product[0].trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng thêm ít nhất 1 sản phẩm");
            doGet(request, response);
            return;
        } else if (raw_qty == null) {
            request.setAttribute("error", "Số lượng là bắt buộc ");
            doGet(request, response);
            return;
        } else if (raw_unit_price == null) {
            request.setAttribute("error", "Đơn giá là bắt buộc ");
            doGet(request, response);
            return;
        }

        int length = Math.max(raw_product.length, Math.max(raw_qty.length, raw_unit_price.length));

        int[] product_id = new int[length];
        try {
            for (int i = 0; i < raw_product.length; i++) {
                if (raw_product[i] == null || raw_product[i].trim().isEmpty()) {
                    request.setAttribute("error", "Chưa chọn sản phẩm ở dòng " + (i + 1));
                    doGet(request, response);
                    return;
                }
                product_id[i] = Integer.parseInt(raw_product[i]);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }

        int[] qty = new int[length];
        try {
            for (int i = 0; i < raw_qty.length; i++) {
                if (raw_qty[i] == null || raw_qty[i].trim().isEmpty()) {
                    request.setAttribute("error", "Chưa chọn số lượng ở dòng" + (i + 1));
                    doGet(request, response);
                    return;
                }

                qty[i] = Integer.parseInt(raw_qty[i]);

                if (qty[i] < 1) {
                    request.setAttribute("error", "Số lượng sản phẩm ở dòng " + (i + 1) + " phải lớn hơn 1");
                    doGet(request, response);
                    return;
                }
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }

        float[] unit_price = new float[raw_unit_price.length];
        for (int i = 0; i < raw_unit_price.length; i++) {
            try {
                if (raw_unit_price[i] == null || raw_unit_price[i].trim().isEmpty()) {
                    request.setAttribute("error", "Chưa điền giá ở dòng " + (i + 1));
                    doGet(request, response);
                    return;
                }

                unit_price[i] = Float.parseFloat(raw_unit_price[i]);

                if (unit_price[i] <= 0) {
                    request.setAttribute("error", "Giá ở dòng " + (i + 1) + " phải là số dương");
                    doGet(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Lỗi định dạng giá ở dòng " + (i + 1));
                doGet(request, response);
                return;
            }
        }

        int po_id = service.add_purchase_order(po_code, supplier_id, note, product_id, qty, unit_price);
        try {
            String supplier_email = service.get_supplier_email_by_id(supplier_id);

            String confirmationToken = UUID.randomUUID().toString();

            service.save_confirmation_token(po_id, confirmationToken);

            String externalViewLink = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
                    + request.getContextPath() + "/view-external?sID=" + supplier_id + "&poId=" + po_id + "&token=" + confirmationToken;

            EmailService.sendPurchaseOrderEmail(supplier_email, po_code, externalViewLink, request, po_id);

            session.setAttribute("successMessage", "Thêm phiếu mua hàng mới thành công và đã gửi email xác nhận cho nhà cung cấp.");

        } catch (Exception e) {
            session.setAttribute("warningMessage", "Thêm phiếu mua hàng thành công, nhưng lỗi khi gửi email xác nhận.");
            System.err.println("Lỗi khi xử lý email hoặc token: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/inbound/purchase-orders");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

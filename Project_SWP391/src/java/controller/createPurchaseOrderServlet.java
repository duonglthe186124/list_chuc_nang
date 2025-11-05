package controller;

import dto.Response_ProductDTO;
import dto.Response_SupplierDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import service.ManagePOService;
import static util.Validation.*;

/**
 *
 * @author ASUS
 */
public class createPurchaseOrderServlet extends HttpServlet {

    private static final ManagePOService service = new ManagePOService();
    private static List<Response_SupplierDTO> supplier_list = new ArrayList();
    private static List<Response_ProductDTO> product_list = new ArrayList();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String po_code = service.get_auto_po_code();
        supplier_list = service.get_list_supplier();
        product_list = service.get_list_product_sku();

        request.setAttribute("sList", supplier_list);
        request.setAttribute("pList", product_list);
        request.setAttribute("po_code", po_code);
        request.getRequestDispatcher("/WEB-INF/view/create_purchase_order.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String po_code = request.getParameter("po_code");
        String raw_supplier = request.getParameter("supplier");
        String raw_date = request.getParameter("delivery_date");
        String note = request.getParameter("note");
        String[] raw_product = request.getParameterValues("product");
        String[] raw_qty = request.getParameterValues("qty");
        String[] raw_unit_price = request.getParameterValues("unit_price");

        Map<String, String> errors = new HashMap<>();
        String error;

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

        if (raw_product == null) {
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
                    error = "Please enter unit_price of product";
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

        service.add_purchase_order(po_code, supplier_id, note, product_id, qty, unit_price);

        response.sendRedirect(request.getContextPath() + "/inbound/transactions");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

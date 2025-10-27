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
import java.util.List;
import service.ManagePOService;

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
        product_list = service.get_list_product();

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

        String error = "";

        if (raw_supplier == null || raw_supplier.trim().isEmpty()) {
            error = "Please choose supplier";
            request.setAttribute("error", error);
            doGet(request, response);
            return;
        }

        int supplier_id;
        try {
            supplier_id = Integer.parseInt(raw_supplier);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }

        int length = raw_product.length;
        if (raw_product.length != length || raw_qty.length != length || raw_unit_price.length != length) {
            error = "Please enter all fields";
            request.setAttribute("error", error);
            doGet(request, response);
            return;
        }

        int[] product_id = new int[length];
        try {
            for (int i = 0; i < raw_product.length; i++) {
                if (raw_product[i] == null || raw_product[i].trim().isEmpty()) {
                    error = "Please check all products";
                    request.setAttribute("error", error);
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
                    error = "Please check all quantity";
                    request.setAttribute("error", error);
                    doGet(request, response);
                    return;
                }

                qty[i] = Integer.parseInt(raw_qty[i]);

                if (qty[i] < 1) {
                    error = "Quantity must be more than 1";
                    request.setAttribute("error", error);
                    doGet(request, response);
                    return;
                }
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }

        float[] unit_price = new float[raw_unit_price.length];
        try {
            for (int i = 0; i < raw_unit_price.length; i++) {
                if (raw_unit_price[i] == null || raw_unit_price[i].trim().isEmpty()) {
                    error = "Please check all price";
                    request.setAttribute("error", error);
                    doGet(request, response);
                    return;
                }

                unit_price[i] = Float.parseFloat(raw_unit_price[i]);

                if (unit_price[i] <= 0) {
                    error = "Price must be positive";
                    request.setAttribute("error", error);
                    doGet(request, response);
                    return;
                }
            }
        } catch (NumberFormatException e) {
            error = "Price is not correct statement";
            request.setAttribute("error", error);
            doGet(request, response);
            return;
        }

        service.add_purchase_order(po_code, supplier_id, note, product_id, qty, unit_price);

        response.sendRedirect(request.getContextPath() + "/inbound/transactions");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

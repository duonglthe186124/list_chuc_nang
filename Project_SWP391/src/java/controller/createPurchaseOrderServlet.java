package controller;

import dto.ProductResponseDTO;
import dto.SupplierResponseDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import service.ManagePOService;

/**
 *
 * @author ASUS
 */
public class createPurchaseOrderServlet extends HttpServlet {

    private static final ManagePOService service = new ManagePOService();
    private static List<SupplierResponseDTO> supplier_list = new ArrayList();
    private static List<ProductResponseDTO> product_list = new ArrayList();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        supplier_list = service.get_list_supplier();
        product_list = service.get_list_product();
        request.setAttribute("sList", supplier_list);
        request.setAttribute("pList", product_list);
        request.getRequestDispatcher("/WEB-INF/view/create_purchase_order.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String raw_supplier = request.getParameter("supplier");
        String raw_date = request.getParameter("delivery_date");
        String note = request.getParameter("note");
        String[] raw_product = request.getParameterValues("product");
        String[] raw_qty = request.getParameterValues("qty");
        String[] raw_unit_price = request.getParameterValues("unit_price");
        
        int supplier_id;
        Date date;
        int[] product_id = new int[raw_product.length];
        int[] qty = new int[raw_qty.length];
        float[] unit_price = new float[raw_unit_price.length];

        supplier_id = Integer.parseInt(raw_supplier);

        LocalDate localDate = LocalDate.parse(raw_date);
        date = Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());

        for (int i = 0; i < raw_product.length; i++) {
            product_id[i] = Integer.parseInt(raw_product[i]);
        }

        for (int i = 0; i < raw_qty.length; i++) {
            qty[i] = Integer.parseInt(raw_qty[i]);
        }

        for (int i = 0; i < raw_unit_price.length; i++) {
            unit_price[i] = Float.parseFloat(raw_unit_price[i]);
        }

        service.add_purchase_order(supplier_id, date, note, product_id, qty, unit_price);
        
        response.sendRedirect(request.getContextPath() + "/inbound/transaction");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

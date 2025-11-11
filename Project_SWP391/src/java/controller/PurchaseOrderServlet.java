package controller;

import dto.Response_PODTO;
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
public class PurchaseOrderServlet extends HttpServlet {

    private static final ManagePOService service = new ManagePOService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String raw_search = request.getParameter("search");
        String raw_status = request.getParameter("status");
        String raw_page_size = request.getParameter("pageSize");
        String raw_page_input = request.getParameter("pageInput");

        List<Response_PODTO> po_list = new ArrayList();
        String search = null, status = null;
        int page_size = 10, page_no = 1, total_items = 0;

        if (raw_search != null && !raw_search.trim().isEmpty()) {
            search = raw_search.replaceAll("[\"'%;]", "");
        }

        if (raw_status != null && !raw_status.trim().isEmpty()) {
            status = raw_status.replaceAll("[\"'%;]", "");
        }

        if (raw_page_size != null && !raw_page_size.trim().isEmpty()) {
            try {
                page_size = Integer.parseInt(raw_page_size);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/404");
                return;
            }
        }

        if (raw_page_input != null && !raw_page_input.trim().isEmpty()) {
            try {
                page_no = Integer.parseInt(raw_page_input);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/404");
                return;
            }
        }

        try {
            po_list = service.get_po_list(search, status, page_size, page_no);
            total_items = service.get_total_items(search, status);

        } catch (IllegalArgumentException e) {
            if ("404".equals(e.getMessage())) {
                response.sendRedirect(request.getContextPath() + "/404");
                return;
            }
        }
        request.setAttribute("list", po_list);
        request.setAttribute("search", search);
        request.setAttribute("status", status);
        request.setAttribute("pageInput", page_no);
        request.setAttribute("totalItems", total_items);
        request.getRequestDispatcher("/WEB-INF/view/purchase_orders.jsp").forward(request, response);
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

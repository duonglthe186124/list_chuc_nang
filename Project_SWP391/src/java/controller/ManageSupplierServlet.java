package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Suppliers;
import service.SupplierManagementService;

/**
 *
 * @author ASUS
 */
public class ManageSupplierServlet extends HttpServlet {

    private SupplierManagementService service = new SupplierManagementService();
    private List<Suppliers> suppliers = new ArrayList<>();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String raw_search = request.getParameter("searchInput");
        String raw_page_size = request.getParameter("pageSize");
        String raw_page_input = request.getParameter("pageInput");

        int page_no = 1, page_size = 10, total_lines;
        String search_input = "";

        if (raw_search != null && !raw_search.trim().isEmpty()) {
            search_input = raw_search;
        }
        
        total_lines = service.get_total_lines(search_input);

        if (raw_page_input != null && !raw_page_input.trim().isEmpty()) {
            try {
                page_no = Integer.parseInt(raw_page_input);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/404");
                return;
            }
        }

        if (raw_page_size != null && !raw_page_size.trim().isEmpty()) {
            try {
                page_size = Integer.parseInt(raw_page_size);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/404");
                return;
            }
        }

        suppliers = service.get_supplier_list(search_input, page_no, page_size);

        request.setAttribute("suppliers", suppliers);
        request.setAttribute("searchInput", search_input);
        request.setAttribute("pageSize", page_size);
        request.setAttribute("pageNo", page_no);
        request.setAttribute("totalLines", total_lines);
        request.getRequestDispatcher("/WEB-INF/view/supplier_list.jsp").forward(request, response);
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

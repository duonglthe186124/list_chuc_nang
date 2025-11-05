package controller;

import dto.Response_TransactionDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Arrays;
import service.TransactionService;
import static util.Validation.*;

/**
 *
 * @author ASUS
 */
public class transactionServlet extends HttpServlet {

    private List<Response_TransactionDTO> tx_list;
    private TransactionService service = new TransactionService();

    public transactionServlet(TransactionService service) {
        this.service = service;
    }

    public transactionServlet() {
        this.service = new TransactionService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String raw_search = request.getParameter("searchInput");
        String raw_status = request.getParameter("status");
        String raw_page_size = request.getParameter("pageSize");
        String raw_page_no = request.getParameter("pageNo");
        String raw_page_input = request.getParameter("pageInput");

        String search, status;
        int page_size, page_no = 1, total_lines;

        search = validate_string_input(raw_search);
        status = validate_option_string_input(raw_status);
        page_size = validate_option_integer_input(raw_page_size, 10);

        total_lines = service.get_total_lines(search, status);

        if (raw_page_input != null && !raw_page_input.trim().isEmpty()) {
            page_no = Integer.parseInt(raw_page_input);
            if (page_no > (int) Math.ceil((double) total_lines / page_size) || page_no < 1) {
                page_no = 1;
                request.setAttribute("errorPageInput", "Page does not exists");
            }
        } else if ((raw_page_input == null || raw_page_input.trim().isEmpty()) && raw_page_no != null) {
            page_no = Integer.parseInt(raw_page_no);
        }

        tx_list = service.get_transactions(search, status, page_no, page_size);
        request.setAttribute("tx_list", tx_list);
        request.setAttribute("searchInput", search);
        request.setAttribute("status", status);
        request.setAttribute("pageSize", page_size);
        request.setAttribute("pageNo", page_no);
        request.setAttribute("totalLines", total_lines);
        request.getRequestDispatcher("/WEB-INF/view/transaction_history.jsp").forward(request, response);
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

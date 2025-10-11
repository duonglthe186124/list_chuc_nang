/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dto.TransactionDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Arrays;
import service.transactionService;

/**
 *
 * @author ASUS
 */
public class transaction_history_servlet extends HttpServlet {

    private List<TransactionDTO> tx_list;
    private static final transactionService service = new transactionService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String raw_search = request.getParameter("searchInput");
        String raw_tx_type = request.getParameter("txType");
        String raw_page_size = request.getParameter("pageSize");
        String raw_page_no = request.getParameter("pageNo");
        String raw_page_input = request.getParameter("pageInput");

        String search = null, tx_type = null;
        int page_size = 10, page_no = 1, total_lines;

        if (raw_search != null && !raw_search.isEmpty()) {
            search = raw_search.trim();
            if (search.length() > 30) {
                search = search.substring(0, 15);
            }
        }

        if (raw_tx_type != null && !raw_tx_type.isEmpty()) {
            List<String> allowedTypes = Arrays.asList("Inbound", "Outbound", "Moving", "Destroy");
            if (allowedTypes.contains(raw_tx_type)) {
                tx_type = raw_tx_type;
            }
        }

        if (raw_page_size != null && !raw_page_size.isEmpty()) {
            page_size = Integer.parseInt(raw_page_size);
        }

        if (raw_page_input != null && !raw_page_input.trim().isEmpty()) {
            page_no = Integer.parseInt(raw_page_input);
        } else if ((raw_page_input == null || raw_page_input.trim().isEmpty()) && raw_page_no != null) {
            page_no = Integer.parseInt(raw_page_no);
        }

        total_lines = service.get_total_lines(search, tx_type);
        tx_list = service.get_transactions(search, tx_type, page_no, page_size);
        request.setAttribute("tx_list", tx_list);
        request.setAttribute("searchInput", search);
        request.setAttribute("txType", tx_type);
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

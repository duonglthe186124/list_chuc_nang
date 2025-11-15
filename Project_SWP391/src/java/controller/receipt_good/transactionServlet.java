package controller.receipt_good;

import dal.UserDAO;
import dto.Response_TransactionDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Arrays;
import model.Users;
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
        UserDAO user_dao = new UserDAO();

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }

        Users user = (Users) session.getAttribute("account");
        if (user == null || !user_dao.check_role(user.getRole_id(), 14)) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }
        

        String raw_search = request.getParameter("search");
        String raw_status = request.getParameter("status");
        String raw_page_size = request.getParameter("pageSize");
        String raw_page_input = request.getParameter("pageInput");

        String search, status;
        int page_size, page_no = 1, total_items = 0;

        search = validate_string_input(raw_search);
        status = validate_option_string_input(raw_status);
        page_size = validate_option_integer_input(raw_page_size, 10);

        try {
            total_items = service.get_total_lines(search, status);
        } catch (IllegalArgumentException e) {
            request.getSession().setAttribute("errorMessage", e.getMessage());
        }

        if (raw_page_input != null && !raw_page_input.trim().isEmpty()) {
            try {
                page_no = Integer.parseInt(raw_page_input);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/404");
                return;
            }
        }

        tx_list = service.get_transactions(search, status, page_no, page_size);
        request.setAttribute("tx_list", tx_list);
        request.setAttribute("search", search);
        request.setAttribute("status", status);
        request.setAttribute("pageInput", page_no);
        request.setAttribute("totalItems", total_items);
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

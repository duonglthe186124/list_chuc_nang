package controller.receipt_good;

import dto.Response_LineTransactionDTO;
import dto.Response_SerialTransactionDTO;
import dto.Response_ViewTransactionDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import service.ViewTransactionService;

/**
 *
 * @author ASUS
 */
public class viewTransactionServlet extends HttpServlet {

    private Response_ViewTransactionDTO view;
    private List<Response_LineTransactionDTO> line;
    private Map<Integer, List<Response_SerialTransactionDTO>> unit = new HashMap();
    private static final ViewTransactionService service = new ViewTransactionService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String receipt_id = request.getParameter("id");

        int id = 0;
        if (receipt_id != null && !receipt_id.trim().isEmpty()) {
            id = Integer.parseInt(receipt_id);
        }

        view = service.get_transaction_view(id);
        line = service.get_transaction_line(id);
        for (Response_LineTransactionDTO l : line) {
            unit.put(l.getProduct_id(), service.get_transaction_unit(id, l.getProduct_id()));
        }

        if (view == null) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }

        request.setAttribute("view", view);
        request.setAttribute("line", line);
        request.setAttribute("unit", unit);
        request.getRequestDispatcher("/WEB-INF/view/view_transaction.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}

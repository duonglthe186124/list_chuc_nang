package controller.receipt_good;

import dal.UserDAO;
import dto.Response_POHeaderDTO;
import dto.Response_POLineDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Users;
import service.ManagePOService;

/**
 *
 * @author ASUS
 */
public class ViewPurchaseOrderServlet extends HttpServlet {

    private static final ManagePOService service = new ManagePOService();

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
        if (user == null || !user_dao.check_role(user.getRole_id(), 13)) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }
        
        String raw_po_id = request.getParameter("id");

        Response_POHeaderDTO poheader = null;
        List<Response_POLineDTO> poline = null;
        int po_id;
        try {
            po_id = Integer.parseInt(raw_po_id);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }

        try {
            poheader = service.get_po_header(po_id);
            poline = service.get_po_line(po_id);
        } catch (IllegalArgumentException e) {
            if ("404".equals(e.getMessage())) {
                response.sendRedirect(request.getContextPath() + "/404");
                return;
            }
        }

        request.setAttribute("poheader", poheader);
        request.setAttribute("poLines", poline);
        request.getRequestDispatcher("/WEB-INF/view/view_purchase_order.jsp").forward(request, response);
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

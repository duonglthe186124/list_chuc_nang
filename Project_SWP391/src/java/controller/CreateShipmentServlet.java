package controller;

import dto.Response_OrderInfoDTO;
import dto.Response_OrderListDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import service.ShipmentService;

/**
 *
 * @author ASUS
 */
public class CreateShipmentServlet extends HttpServlet {

    private static final ShipmentService service = new ShipmentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String raw_order_id = request.getParameter("id");

        int selected_id = 0;
        try {
            selected_id = Integer.parseInt(raw_order_id);
        } catch (NumberFormatException e) {

        }

        List<Integer> order_id = service.get_order_id();
        request.setAttribute("order_id", order_id);

        if (selected_id != 0) {
            Response_OrderInfoDTO order_info = service.get_order_info(selected_id);
            List<Response_OrderListDTO> order_details = service.get_order_details(selected_id);

            request.setAttribute("selectedID", selected_id);
            request.setAttribute("orderInfo", order_info);
            request.setAttribute("orderDetail", order_details);
        }

        request.getRequestDispatcher("/WEB-INF/view/create_shipment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String raw_order_id = request.getParameter("id");
        String[] raw_out_qty = request.getParameterValues("out_qty");
        String note = request.getParameter("note");

        int selected_id = 0;
        try {
            selected_id = Integer.parseInt(raw_order_id);
        } catch (NumberFormatException e) {

        }

        int[] out_qty = new int[raw_out_qty.length];
        for (int i = 0; i < raw_out_qty.length; i++) {
            out_qty[i] = Integer.parseInt(raw_out_qty[i]);
        }
        
        service.add_shipment(selected_id, out_qty, note);
        response.sendRedirect(request.getContextPath() + "/warehouse/locations");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

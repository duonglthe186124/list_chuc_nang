/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dto.POLineResponseDTO;
import dto.ReceiptHeaderDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import service.ReceiptService;

/**
 *
 * @author ASUS
 */
public class createReceiptServlet extends HttpServlet {

    private static final ReceiptService service = new ReceiptService();
    private static List<ReceiptHeaderDTO> purchase_order_list;
    private static List<POLineResponseDTO> po_line_list;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String raw_po_id = request.getParameter("po_id");

        int po_id = 0;
        if (raw_po_id != null && !raw_po_id.trim().isEmpty()) {
            po_id = Integer.parseInt(raw_po_id);
        }

        purchase_order_list = service.get_purchase_order_list();
        if (po_id != 0) {
            po_line_list = service.get_po_line(po_id);
            request.setAttribute("poLine", po_line_list);
        }
        request.setAttribute("selectedID", po_id);
        request.setAttribute("poList", purchase_order_list);
        request.getRequestDispatcher("/WEB-INF/view/create_receipt.jsp").forward(request, response);
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

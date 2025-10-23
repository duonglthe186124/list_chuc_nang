/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dto.InboundDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import service.InboundService;

public class InboundController extends HttpServlet {

    private final InboundService service = new InboundService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<InboundDTO> list = service.getAllReceipts();
        req.setAttribute("receipts", list);
        req.getRequestDispatcher("/WEB-INF/view/inventory/inbound.jsp").forward(req, resp);
    }
}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dto.AuditDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import service.AuditService;

public class AuditController extends HttpServlet {

    private final AuditService service = new AuditService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<AuditDTO> list = service.getAll();
        req.setAttribute("audits", list);
        req.getRequestDispatcher("/WEB-INF/view/inventory/audit.jsp").forward(req, resp);
    }
}

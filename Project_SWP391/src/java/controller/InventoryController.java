/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dto.InventoryDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import service.InventoryService;

public class InventoryController extends HttpServlet {

    private final InventoryService service = new InventoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            List<InventoryDTO> list = service.getAll();
            req.setAttribute("inventoryList", list);
            req.getRequestDispatcher("/WEB-INF/view/inventory/inventory.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException("DB error when loading inventory", e);
        }
    }
}

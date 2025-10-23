/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dto.FilterDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import service.FilterService;

public class FilterController extends HttpServlet {

    private final FilterService service = new FilterService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String employee = req.getParameter("employee");
        String type = req.getParameter("type");

        List<FilterDTO> list = service.filterBy(employee, type);
        req.setAttribute("filteredList", list);
        req.getRequestDispatcher("/WEB-INF/view/inventory/filter.jsp").forward(req, resp);
    }
}

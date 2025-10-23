/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dto.QualityDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import service.QualityService;

public class QualityController extends HttpServlet {

    private final QualityService service = new QualityService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<QualityDTO> list = service.getAll();
        req.setAttribute("qualityList", list);
        req.getRequestDispatcher("/WEB-INF/view/inventory/quality.jsp").forward(req, resp);
    }
}


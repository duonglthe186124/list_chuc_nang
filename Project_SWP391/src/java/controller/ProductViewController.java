/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ProductViewDAO;
import dto.ProductViewDTO;
import dto.StatusDTO;
import dto.UnitViewDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.sql.*;

/**
 *
 * @author hoang
 */
public class ProductViewController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            int productId = Integer.parseInt(req.getParameter("id"));
            int pageIndex = req.getParameter("page") != null ? Integer.parseInt(req.getParameter("page")) : 1;
            int pageSize = 2;

            ProductViewDAO dao = new ProductViewDAO();

            ProductViewDTO product = dao.getProductCommonInfoById(productId);
            List<UnitViewDTO> units = dao.getUnitsByProductIdPaged(productId, pageIndex, pageSize);
            List<StatusDTO> status = dao.getAllStatusesUnit();

            int totalUnits = dao.countUnitsByProductId(productId);
            int totalPages = (int) Math.ceil((double) totalUnits / pageSize);

            req.setAttribute("product", product);
            req.setAttribute("units", units);
            req.setAttribute("status", status);
            req.setAttribute("pageIndex", pageIndex);
            req.setAttribute("totalPages", totalPages);

            req.getRequestDispatcher("/WEB-INF/view/productViewDetail.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Lỗi khi tải dữ liệu sản phẩm!");
            req.getRequestDispatcher("/WEB-INF/view/error_page.jsp").forward(req, resp);
        }

    }

}

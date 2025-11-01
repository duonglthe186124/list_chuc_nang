/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ProductViewDAO;
import dto.ProductViewDTO;
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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            int productId = Integer.parseInt(req.getParameter("id"));

            ProductViewDAO dao = new ProductViewDAO();
            // Lấy thông tin chung
            ProductViewDTO product = dao.getProductCommonInfoById(productId);

            // Lấy danh sách unit riêng
            List<UnitViewDTO> units = dao.getUnitsByProductId(productId);

            // Gửi sang JSP
            req.setAttribute("product", product);
            req.setAttribute("units", units);

            req.getRequestDispatcher("/WEB-INF/view/productViewDetail.jsp").forward(req, resp);
        } catch (ServletException | IOException | SQLException e) {
            req.setAttribute("error", "ID sản phẩm không hợp lệ!");
            req.getRequestDispatcher("/WEB-INF/view/error_page.jsp").forward(req, resp);
        }

    }

}

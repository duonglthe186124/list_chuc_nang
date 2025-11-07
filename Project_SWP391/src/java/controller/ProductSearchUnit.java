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
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hoang
 */
public class ProductSearchUnit extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String productIdParam = req.getParameter("id");
        String status = req.getParameter("status");
        String imei = req.getParameter("imei");
        String serial = req.getParameter("serial");

        int pageIndex = 1;
        int pageSize = 2;

        String pageParam = req.getParameter("page");
        if (pageParam != null && !pageParam.trim().isEmpty()) {
            pageIndex = Integer.parseInt(pageParam.trim());
        }

        if (productIdParam == null || productIdParam.trim().isEmpty()) {
            resp.getWriter().println("❌ Thiếu productId!");
            return;
        }

        try {
            int productId = Integer.parseInt(productIdParam);
            ProductViewDAO dao = new ProductViewDAO();

            ProductViewDTO product = dao.getProductCommonInfoById(productId);

            // ✅ Phân trang
            List<UnitViewDTO> units = dao.searchUnitsByFiltersPaged(productId, status, imei, serial, pageIndex, pageSize);
            int totalUnits = dao.countUnitsByFilters(productId, status, imei, serial);
            int totalPages = (int) Math.ceil((double) totalUnits / pageSize);

            List<StatusDTO> allStatuses = dao.getAllStatusesUnit();

            String error = null;
            if (units == null || units.isEmpty()) {
                error = "⚠️ Không tìm thấy đơn vị sản phẩm phù hợp.";
            }

            req.setAttribute("product", product);
            req.setAttribute("units", units);
            req.setAttribute("status", allStatuses);
            req.setAttribute("error", error);
            req.setAttribute("pageIndex", pageIndex);
            req.setAttribute("totalPages", totalPages);

            req.getRequestDispatcher("/WEB-INF/view/productViewDetail.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.getWriter().println("❌ ID sản phẩm không hợp lệ!");
        } catch (SQLException e) {
            throw new ServletException("Lỗi khi lấy dữ liệu sản phẩm: " + e.getMessage(), e);
        }
    }
}

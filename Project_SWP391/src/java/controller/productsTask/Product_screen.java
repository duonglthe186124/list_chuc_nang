/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.productsTask;

import controller.BaseAuthController;
import dal.ListProductDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.AuthUser_HE186124_DuongLT;
import model.ProductInfoScreen_DuongLT;

/**
 *
 * @author hoang
 */
public class Product_screen extends BaseAuthController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, AuthUser_HE186124_DuongLT user)
            throws ServletException, IOException {

        int pageIndex = 1;   // Trang mặc định
        int pageSize = 5;    // Mỗi trang 5 sản phẩm

        // Lấy số trang từ request (nếu có)
        String pageParam = req.getParameter("page");
        if (pageParam != null) {
            try {
                pageIndex = Integer.parseInt(pageParam);
                if (pageIndex < 1) pageIndex = 1;
            } catch (NumberFormatException e) {
                pageIndex = 1;
            }
        }

        ListProductDBContext dbProduct = new ListProductDBContext();

        try {
            // Đếm tổng số sản phẩm
            int totalProducts = dbProduct.countProducts();
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

            // Lấy danh sách sản phẩm theo trang
            ArrayList<ProductInfoScreen_DuongLT> products = dbProduct.getProductsByPage(pageIndex, pageSize);

            // Gửi dữ liệu sang JSP
            req.setAttribute("products", products);
            req.setAttribute("pageIndex", pageIndex);
            req.setAttribute("totalPages", totalPages);

            // Chuyển tiếp sang JSP hiển thị danh sách sản phẩm
            req.getRequestDispatcher("/WEB-INF/task_view/product_screen.jsp").forward(req, resp);

        } catch (SQLException ex) {
            Logger.getLogger(Product_screen.class.getName()).log(Level.SEVERE, null, ex);

            // Nếu có lỗi DB, điều hướng đến trang lỗi riêng
            req.setAttribute("errorMessage", "Error loading products: " + ex.getMessage());
            req.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, AuthUser_HE186124_DuongLT user)
            throws ServletException, IOException {
        // Gọi lại doGet để xử lý tương tự GET
        doGet(req, resp, user);
    }
}
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.ProductOrderInfoDAO;
import dto.ProductOrderInfo;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.*;

/**
 *
 * @author hoang
 */
public class orderProduct extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ProductOrderInfoDAO db = new ProductOrderInfoDAO();
        ProductOrderInfo productInfo = null;
        
        try {
            String productIdStr = req.getParameter("id");
            if (productIdStr == null || productIdStr.trim().isEmpty()) {
                req.setAttribute("errorMessage", "Product ID is required.");
                req.getRequestDispatcher("/WEB-INF/view/error_page.jsp").forward(req, resp);
                return;
            }

            int productId = Integer.parseInt(productIdStr);
    
        

            
            productInfo = db.getProductOrderInfoById(productId);

            if (productInfo == null) {
                req.setAttribute("errorMessage", "Product not found or no available quantity.");
                req.getRequestDispatcher("/WEB-INF/view/error_page.jsp").forward(req, resp);
                return;
            }

            
            req.setAttribute("productInfo", productInfo);

            
            req.getRequestDispatcher("/WEB-INF/view/create_order.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Invalid product ID format.");
            req.getRequestDispatcher("/WEB-INF/view/error_page.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("errorMessage", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/view/error_page.jsp").forward(req, resp);
        }
   
    
    }
}

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
import java.math.BigDecimal;
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
          try {
            
            String idStr = req.getParameter("id");
            String name = req.getParameter("name");
            String qtyStr = req.getParameter("qty");
            String code = req.getParameter("code");
            String priceStr = req.getParameter("price");
            String image = req.getParameter("image");

           
            if (idStr == null || name == null || qtyStr == null || code == null || priceStr == null
                    || idStr.trim().isEmpty() || name.trim().isEmpty()
                    || qtyStr.trim().isEmpty() || code.trim().isEmpty()
                    || priceStr.trim().isEmpty()) {

                req.setAttribute("error", "Thiếu thông tin sản phẩm được gửi từ form!");
                req.getRequestDispatcher("/WEB-INF/view/error_page.jsp").forward(req, resp);
                return;
            }

            
            int id = Integer.parseInt(idStr);
            int qty = Integer.parseInt(qtyStr);
            BigDecimal price = new BigDecimal(priceStr);

            
            req.setAttribute("id", id);
            req.setAttribute("name", name);
            req.setAttribute("qty", qty);
            req.setAttribute("code", code);
            req.setAttribute("price", price);
            req.setAttribute("image", image);

            
            req.getRequestDispatcher("/WEB-INF/view/create_order.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            req.setAttribute("error", "Sai định dạng dữ liệu: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/view/error_page.jsp").forward(req, resp);
        }
    }

   
    
    }


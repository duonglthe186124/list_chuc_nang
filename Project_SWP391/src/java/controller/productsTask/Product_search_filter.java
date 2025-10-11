/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.productsTask;

import controller.BaseAuthController;
import dal.SearchProductDBContext;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;

import model.AuthUser_HE186124_DuongLT;
import model.ProductInfoScreen_DuongLT;

import model.SpecsOptions;

/**
 *
 * @author hoang
 */
public class Product_search_filter extends BaseAuthController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, AuthUser_HE186124_DuongLT user) throws ServletException, IOException {
        doPost(req, resp, user);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, AuthUser_HE186124_DuongLT user) throws ServletException, IOException {

        String brandName = req.getParameter("brandName");
        String cpu = req.getParameter("cpu");
        String memory = req.getParameter("memory");
        String storage = req.getParameter("storage");
        String color = req.getParameter("color");
        String screenType = req.getParameter("screenType");

        int battery = parseIntOrZero(req.getParameter("battery"));
        float screenSize = parseFloatOrZero(req.getParameter("screenSize"));
        int camera = parseIntOrZero(req.getParameter("camera"));
        BigDecimal minPrice = parseBigDecimal(req.getParameter("minPrice"));
        BigDecimal maxPrice = parseBigDecimal(req.getParameter("maxPrice"));

        boolean hasFilter = false;

        if ((brandName != null && !brandName.isEmpty())
                || (cpu != null && !cpu.isEmpty())
                || (memory != null && !memory.isEmpty())
                || (storage != null && !storage.isEmpty())
                || (color != null && !color.isEmpty())
                || (screenType != null && !screenType.isEmpty())
                || battery > 0
                || screenSize > 0
                || camera > 0
                || minPrice != null
                || maxPrice != null) {
            hasFilter = true;
        }

        if (!hasFilter) {
            resp.sendRedirect(req.getContextPath() + "/products");
            return;
        }
        
         try {
            SearchProductDBContext db = new SearchProductDBContext();
            ArrayList<ProductInfoScreen_DuongLT> list = db.getProductsByPageFiltered(
                    brandName, cpu, memory, storage, color, battery, screenSize,
                    screenType, camera, minPrice, maxPrice);

            req.setAttribute("products", list);
            req.getRequestDispatcher("/WEB-INF/task_view/product_search_filter.jsp").forward(req, resp);
        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }

    }

    private int parseIntOrZero(String value) {
        try {
            return (value != null && !value.isEmpty()) ? Integer.parseInt(value) : 0;
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    private float parseFloatOrZero(String value) {
        try {
            return (value != null && !value.isEmpty()) ? Float.parseFloat(value) : 0f;
        } catch (NumberFormatException e) {
            return 0f;
        }
    }

    private BigDecimal parseBigDecimal(String value) {
        try {
            return (value != null && !value.isEmpty()) ? new BigDecimal(value) : null;
        } catch (NumberFormatException e) {
            return null;
        }
    }

}

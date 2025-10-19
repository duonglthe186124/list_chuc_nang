/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import controller.BaseAuthController;
import dal.ProductSpecsDBContext;
import dal.SearchProductDBContext;
import dto.AuthUser_HE186124_DuongLT;
import dto.PriceRange;
import dto.ProductInfoScreen_DuongLT;
import dto.SpecsOptions;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hoang
 */
public class Product_search_filter extends BaseAuthController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, AuthUser_HE186124_DuongLT user) throws ServletException, IOException {
        ProductSpecsDBContext dbs = new ProductSpecsDBContext();
        // specs choice 
        try {
            ArrayList<SpecsOptions> brandOptions = dbs.getDistinctBrandOptions();
            ArrayList<SpecsOptions> cpuOptions = dbs.getDistinctCpuOptions();
            ArrayList<SpecsOptions> memoryOptions = dbs.getDistinctMemoryOptions();
            ArrayList<SpecsOptions> storageOptions = dbs.getDistinctStorageOptions();
            ArrayList<SpecsOptions> colorOptions = dbs.getDistinctColorOptions();
            ArrayList<SpecsOptions> batteryOptions = dbs.getDistinctBatteryOptions();
            ArrayList<SpecsOptions> ScreenSizeOptions = dbs.getDistinctScreenSizeOptions();
            ArrayList<SpecsOptions> ScreenTypeOptions = dbs.getDistinctScreenTypeOptions();
            ArrayList<SpecsOptions> cameraOptions = dbs.getDistinctCameraOptions();

            //price choice
            BigDecimal[] minmax = dbs.getMinMaxPrice();
            List<PriceRange> priceRanges = new ArrayList<>();
            if (minmax != null) {
                BigDecimal min = minmax[0];
                BigDecimal max = minmax[1];
                priceRanges = ProductSpecsDBContext.generatePriceRanges(min, max, 6, 0);
            }

            req.setAttribute("brandOptions", brandOptions);
            req.setAttribute("cpuOptions", cpuOptions);
            req.setAttribute("memoryOptions", memoryOptions);
            req.setAttribute("storageOptions", storageOptions);
            req.setAttribute("colorOptions", colorOptions);
            req.setAttribute("batteryOptions", batteryOptions);
            req.setAttribute("ScreenSizeOptions", ScreenSizeOptions);
            req.setAttribute("ScreenTypeOptions", ScreenTypeOptions);
            req.setAttribute("cameraOptions", cameraOptions);
            req.setAttribute("priceRanges", priceRanges);

        } catch (SQLException ex) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }

        String keyword = req.getParameter("keyword");
        String brandName = req.getParameter("brand");
        String cpu = req.getParameter("cpu");
        String memory = req.getParameter("memory");
        String storage = req.getParameter("storage");
        String color = req.getParameter("color");
        String screenType = req.getParameter("screen_type");

        int battery = parseIntOrZero(req.getParameter("battery"));
        BigDecimal screenSize = parseBigDecimal(req.getParameter("screen_size"));
        int camera = parseIntOrZero(req.getParameter("camera"));
        String priceParam = req.getParameter("price");
        BigDecimal minPrice = null;
        BigDecimal maxPrice = null;

        if (priceParam != null && !priceParam.isEmpty()) {
            priceParam = priceParam.trim();

            if (priceParam.endsWith("+")) {
                String minStr = priceParam.substring(0, priceParam.length() - 1).trim();
                if (!minStr.isEmpty()) {
                    try {
                        minPrice = new BigDecimal(minStr); //200 max
                        maxPrice = null;

                    } catch (NumberFormatException e) {
                        System.err.println("error parse minPrice: " + minStr);
                    }
                }
            } else if (priceParam.contains("-")) {
                String[] parts = priceParam.split("\\s*-\\s*");
                if (parts.length == 2) {
                    if (!parts[0].isEmpty()) {
                        try {
                            minPrice = new BigDecimal(parts[0]);
                        } catch (NumberFormatException e) {
                            System.err.println("error parse minPrice: " + parts[0]);
                        }
                    }
                    if (!parts[1].isEmpty()) {
                        try {
                            maxPrice = new BigDecimal(parts[1]);
                        } catch (NumberFormatException e) {
                            System.err.println("error parse maxPrice: " + parts[1]);
                        }
                    }
                    if (minPrice != null && maxPrice != null && minPrice.compareTo(maxPrice) > 0) {
                        BigDecimal temp = minPrice;
                        minPrice = maxPrice;
                        maxPrice = temp;
                    }
                }
            }
        }

        System.out.println("priceParam = " + priceParam + " | min=" + minPrice + " | max=" + maxPrice);

        boolean hasFilter
                = (brandName != null && !brandName.isEmpty())
                || (cpu != null && !cpu.isEmpty())
                || (memory != null && !memory.isEmpty())
                || (storage != null && !storage.isEmpty())
                || (color != null && !color.isEmpty())
                || (screenType != null && !screenType.isEmpty())
                || battery > 0
                || screenSize != null
                || camera > 0
                || minPrice != null
                || maxPrice != null
                || (keyword != null && !keyword.isEmpty());

        if (!hasFilter) {
            resp.sendRedirect(req.getContextPath() + "/products");
            return;
        }

        int pageIndex = 1;   // Trang mặc định
        int pageSize = 3;    // Mỗi trang 3 sản phẩm

        // Lấy số trang từ request (nếu có)
        String pageParam = req.getParameter("page");
        if (pageParam != null) {
            try {
                pageIndex = Integer.parseInt(pageParam);
                if (pageIndex < 1) {
                    pageIndex = 1;
                }
            } catch (NumberFormatException e) {
                pageIndex = 1;
            }
        }
        SearchProductDBContext db = new SearchProductDBContext();

        try {
            ArrayList<ProductInfoScreen_DuongLT> list = db.getProductsByPageFiltered(
                    brandName, cpu, memory, storage, color, battery, screenSize,
                    screenType, camera, minPrice, maxPrice, keyword, pageIndex, pageSize
            );

            // Đếm tổng số sản phẩm phù hợp filter (phục vụ phân trang)
            int totalProducts = db.countFilteredProducts(
                    brandName, cpu, memory, storage, color, battery, screenSize,
                    screenType, camera, minPrice, maxPrice, keyword
            );

            // Tính tổng số trang
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

            // Nếu không tìm thấy sản phẩm
            if (list == null || list.isEmpty()) {
                String message;
                if (keyword != null && !keyword.trim().isEmpty()) {
                    message = "Not found any products with name \"" + keyword.trim() + "\".";
                } else {
                    message = "Not found any products.";
                }
                req.setAttribute("notFoundMessage", message);
            }

            // ✅ Gửi dữ liệu sang JSP
            req.setAttribute("products", list);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("pageIndex", pageIndex);

            // ✅ Gửi lại toàn bộ filter để JSP giữ nguyên giá trị đã chọn
            req.setAttribute("keyword", keyword);
            req.setAttribute("brand", brandName);
            req.setAttribute("cpu", cpu);
            req.setAttribute("memory", memory);
            req.setAttribute("storage", storage);
            req.setAttribute("color", color);
            req.setAttribute("battery", battery);
            req.setAttribute("screen_size", screenSize);
            req.setAttribute("screen_type", screenType);
            req.setAttribute("camera", camera);
            req.setAttribute("minPrice", minPrice);
            req.setAttribute("maxPrice", maxPrice);
            req.getRequestDispatcher("/WEB-INF/view/product_search_filter.jsp").forward(req, resp);

        } catch (SQLException ex) {
            Logger.getLogger(Product_search_filter.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, AuthUser_HE186124_DuongLT user) throws ServletException, IOException {
        doGet(req, resp, user);
    }

    private int parseIntOrZero(String value) {
        try {
            return (value != null && !value.isEmpty()) ? Integer.parseInt(value) : 0;
        } catch (NumberFormatException e) {
            return 0;
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

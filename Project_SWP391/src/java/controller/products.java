/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.ListProductDBContext;
import dal.ProductSpecsDBContext;
import dto.AuthUser_HE186124_DuongLT;
import dto.PriceRange;
import dto.ProductInfoScreen_DuongLT;
import dto.SpecsOptions;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hoang
 */
public class products extends BaseAuthController {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, AuthUser_HE186124_DuongLT user) throws ServletException, IOException {
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

         ListProductDBContext dbProduct = new ListProductDBContext();

        try {
            // Đếm tổng số sản phẩm
            int totalProducts = dbProduct.countProducts();
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

            // Lấy danh sách sản phẩm theo trang
            ArrayList<ProductInfoScreen_DuongLT> products = dbProduct.getProductsByPage(pageIndex, pageSize);
            
             // specs choice 
            ProductSpecsDBContext db = new ProductSpecsDBContext();
            ArrayList<SpecsOptions> brandOptions = db.getDistinctBrandOptions();
            ArrayList<SpecsOptions> cpuOptions = db.getDistinctCpuOptions();
            ArrayList<SpecsOptions> memoryOptions = db.getDistinctMemoryOptions();
            ArrayList<SpecsOptions> storageOptions = db.getDistinctStorageOptions();
            ArrayList<SpecsOptions> colorOptions = db.getDistinctColorOptions();
            ArrayList<SpecsOptions> batteryOptions = db.getDistinctBatteryOptions();
            ArrayList<SpecsOptions> ScreenSizeOptions = db.getDistinctScreenSizeOptions();
            ArrayList<SpecsOptions> ScreenTypeOptions = db.getDistinctScreenTypeOptions();
            ArrayList<SpecsOptions> cameraOptions = db.getDistinctCameraOptions();
            
            //price choice
            BigDecimal[] minmax = db.getMinMaxPrice();
            List<PriceRange> priceRanges = new ArrayList<>();
            if(minmax != null){
                BigDecimal min = minmax[0];
                BigDecimal max = minmax[1];
                priceRanges = ProductSpecsDBContext.generatePriceRanges(min,max,6,0);
            }
            

           

            // Gửi dữ liệu sang JSP
            req.setAttribute("products", products);
            req.setAttribute("pageIndex", pageIndex);
            req.setAttribute("totalPages", totalPages);
            
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
            
            
           
            // Chuyển tiếp sang JSP hiển thị danh sách sản phẩm
            req.getRequestDispatcher("/WEB-INF/view/product_screen.jsp").forward(req, resp);

        } catch (SQLException ex) {
            Logger.getLogger(products.class.getName()).log(Level.SEVERE, null, ex);

            // Nếu có lỗi DB, điều hướng đến trang lỗi riêng
            req.setAttribute("errorMessage", "Error loading products: " + ex.getMessage());
            req.getRequestDispatcher("/WEB-INF/view/error_page.jsp").forward(req, resp);
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, AuthUser_HE186124_DuongLT user) throws ServletException, IOException {
        doGet(req, resp, user);
    }

}

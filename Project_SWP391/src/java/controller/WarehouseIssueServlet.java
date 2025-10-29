/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import model.Users;
import service.WarehouseIssueService; 

import java.io.BufferedReader;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "WarehouseIssueServlet", urlPatterns = {"/warehouse/issue"})
public class WarehouseIssueServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển đến trang JSP MỚI
        request.getRequestDispatcher("/WEB-INF/view/warehouseIssue.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        try {
            // 1. Lấy dữ liệu từ form
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String imeiListData = request.getParameter("imeiList");
            
            Users currentUser = (Users) request.getSession().getAttribute("user");
            int userId = (currentUser != null) ? currentUser.getUser_id() : 1; 
            
            // 2. Xử lý danh sách IMEI
            List<String> imeiList = new ArrayList<>();
            BufferedReader reader = new BufferedReader(new StringReader(imeiListData));
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    imeiList.add(line.trim());
                }
            }

            // 3. Validation IMEI
            if (imeiList.size() != quantity) {
                request.setAttribute("errorMessage", "Lỗi: Số lượng IMEI (" + imeiList.size() + ") không khớp với số lượng xuất (" + quantity + ").");
                request.getRequestDispatcher("/WEB-INF/view/warehouseIssue.jsp").forward(request, response);
                return; 
            }

            // 4. Gọi Service MỚI để thực thi
            WarehouseIssueService issueService = new WarehouseIssueService();
            boolean success = issueService.issueProductUnits(imeiList, userId);

            // 5. Phản hồi
            if (success) {
                // Thành công! Quay lại trang Tồn kho
                response.sendRedirect(request.getContextPath() + "/warehouse/inventory");
            } else {
                // Lỗi này thường là do 1 trong các IMEI bị sai
                throw new Exception("Service thất bại. Vui lòng kiểm tra lại danh sách IMEI, có thể IMEI không tồn tại hoặc đã bị xuất.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/warehouseIssue.jsp").forward(request, response);
        }
    }
}

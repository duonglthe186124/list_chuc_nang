/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author hoang
 */
public class TestOrderController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
         resp.setContentType("text/html;charset=UTF-8");
        
        // Tạo đối tượng để ghi nội dung ra trình duyệt
        PrintWriter out = resp.getWriter();
        
        
        // Lấy dữ liệu từ form JSP
        String id = req.getParameter("product_id");
        String unitPrice = req.getParameter("unitPrice");
        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String qty = req.getParameter("qty");
        String totalAmount = req.getParameter("totalAmount");

        // In ra màn hình trình duyệt để kiểm tra
        out.println("<html><body>");
        out.println("<h2>Order Information Received:</h2>");
        out.println("<p><strong>Product ID:</strong> " + id + "</p>");
        out.println("<p><strong>Unit Price:</strong> " + unitPrice + "</p>");
        out.println("<p><strong>Full Name:</strong> " + fullname + "</p>");
        out.println("<p><strong>Email:</strong> " + email + "</p>");
        out.println("<p><strong>Phone:</strong> " + phone + "</p>");
        out.println("<p><strong>Address:</strong> " + address + "</p>");
        out.println("<p><strong>Quantity:</strong> " + qty + "</p>");
        out.println("<p><strong>Total Amount:</strong> " + totalAmount + " USD</p>");
        out.println("</body></html>");
        
       
    }
   
   

}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.UserDAO;
import model.Users;
import util.PasswordUtils;
import java.util.HashMap;
import java.util.Map;
        
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author admin
 */
public class register_servlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/view/register.jsp").forward(request, response);
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        // 1. Lấy dữ liệu từ form
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String secAddress = request.getParameter("sec_address");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        Map<String, String> errors = new HashMap<>();
        UserDAO userDAO = new UserDAO(); 

        // 2. SERVER-SIDE VALIDATION

        // a. Kiểm tra trường trống (nên kiểm tra kỹ hơn các định dạng tương tự JavaScript)
        if (fullname == null || fullname.trim().isEmpty()) { errors.put("fullname", "Họ và Tên không được để trống."); }
        if (email == null || email.trim().isEmpty() || !email.matches("^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$")) { 
            errors.put("email", "Email không hợp lệ."); 
        }
        if (phone == null || phone.trim().isEmpty() || !phone.matches("^\\+?[0-9]{10,15}$")) { 
            errors.put("phone", "Số điện thoại không hợp lệ."); 
        }
        if (address == null || address.trim().isEmpty()) { errors.put("address", "Địa chỉ liên hệ không được để trống."); }
        if (password == null || password.isEmpty() || password.length() < 8) { 
            errors.put("password", "Mật khẩu phải có ít nhất 8 ký tự."); 
        }

        // b. Kiểm tra mật khẩu khớp
        if (password != null && !password.isEmpty() && !password.equals(confirmPassword)) {
            errors.put("confirmPassword", "Mật khẩu xác nhận không khớp.");
        }
        
        // c. Kiểm tra Email tồn tại (UNIQUE)
        if (email != null && errors.get("email") == null && userDAO.isEmailExist(email)) {
            errors.put("email", "Email này đã được sử dụng.");
        }


        // 3. Xử lý kết quả Validation
        if (!errors.isEmpty()) {
            // Đặt lỗi và dữ liệu nhập lại vào request scope để hiển thị lại trên JSP
            request.setAttribute("errors", errors);
            request.setAttribute("fullname", fullname);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.setAttribute("sec_address", secAddress);
            
            request.getRequestDispatcher("WEB-INF/view/register.jsp").forward(request, response);
            return;
        }

        // 4. Băm Mật khẩu và Lưu vào Database
        try {
            String hashedPassword = PasswordUtils.hashPassword(password);
            
            Users newUser = new Users();
            newUser.setEmail(email);
            newUser.setPassword(hashedPassword);
            newUser.setFullname(fullname);
            newUser.setPhone(phone);
            newUser.setAddress(address);
            // Đảm bảo sec_address không phải là chuỗi rỗng khi lưu vào cột NULLABLE
            newUser.setSec_address(secAddress != null && !secAddress.trim().isEmpty() ? secAddress : null); 
            // Gán Role ID mặc định. Giả định ID=2 là role cho Staff/User mới
            newUser.setRole_id(2); 

            boolean isSuccess = userDAO.insertUser(newUser);

            if (isSuccess) {
                // Đăng ký thành công -> Chuyển hướng đến trang Login
                response.sendRedirect(request.getContextPath() + "/login?success=register");
            } else {
                // Lỗi DB nhưng không phát sinh Exception (ví dụ: lỗi logic DAO)
                request.setAttribute("registerError", "Đăng ký không thành công. Lỗi hệ thống.");
                request.getRequestDispatcher("WEB-INF/view/register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("registerError", "Lỗi xử lý hệ thống: " + e.getMessage());
            request.getRequestDispatcher("WEB-INF/view/register.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet xử lý logic đăng ký người dùng";
    }
}

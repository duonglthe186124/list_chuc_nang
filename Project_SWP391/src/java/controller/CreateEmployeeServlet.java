/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.UserDAO;
import model.Roles;
import model.Users;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author admin
 */
public class CreateEmployeeServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserDAO user_dao = new UserDAO();

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }

        Users user = (Users) session.getAttribute("account");
        if (user == null || !user_dao.check_role(user.getRole_id(), 16)) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }
        
        UserDAO userDAO = new UserDAO();
        // Lấy danh sách Roles
        List<Roles> roleList = userDAO.getAllRoles();
        
        request.setAttribute("roleList", roleList);
        request.getRequestDispatcher("/WEB-INF/view/create_employee.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
    
        // 1. Lấy dữ liệu từ form
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        int roleId = 0;
        try {
            roleId = Integer.parseInt(request.getParameter("role_id"));
        } catch (NumberFormatException e) {
            // Xử lý nếu role_id không phải là số
        }

        UserDAO userDAO = new UserDAO();

        // 2. Kiểm tra Email đã tồn tại chưa
        if (userDAO.checkEmailExists(email)) {
            request.setAttribute("errorMessage", "This email address is already in use.");
            List<Roles> roleList = userDAO.getAllRoles();
            request.setAttribute("roleList", roleList);
            request.getRequestDispatcher("/WEB-INF/view/create_employee.jsp").forward(request, response);
            return;
        }

        // 3. Tạo tài khoản
        boolean success = userDAO.createStaffAccount(fullname, email, roleId);

        HttpSession session = request.getSession();
        if (success) {

            // === THÊM MỚI TẠI ĐÂY ===
            try {
                // Lấy mật khẩu mặc định (phải giống hệt trong DAO)
                String defaultPassword = "@Abcde12345";

                // Gọi hàm gửi email
                util.EmailUtil.sendNewStaffAccountEmail(email, defaultPassword);

                session.setAttribute("successMessage", "Account created and notification email sent!");

            } catch (Exception e) {
                e.printStackTrace();
                // Tạo tài khoản thành công, nhưng gửi email thất bại
                session.setAttribute("successMessage", "Account created, but FAILED to send email notification.");
            }
            // =======================

        } else {
            session.setAttribute("errorMessage", "Failed to create account.");
        }

        // 4. Chuyển hướng về trang quản lý
        response.sendRedirect(request.getContextPath() + "/account-management");
    }
}

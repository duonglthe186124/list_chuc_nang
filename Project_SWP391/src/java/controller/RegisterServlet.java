package controller;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Roles;
import model.Users;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        List<Roles> rolesList = userDAO.getAllRoles();
        request.setAttribute("rolesList", rolesList);
        request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        // Get data from the form
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email").trim();
        String contactAddress = request.getParameter("address");
        String phone = request.getParameter("phone").trim();
        String password = request.getParameter("password").trim();
        String confirmPassword = request.getParameter("confirm_password").trim();
        String roleIdStr = request.getParameter("role_id").trim();
        
        UserDAO userDAO = new UserDAO();
        
        if (roleIdStr == null || roleIdStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please select an account role.");
            // Gửi lại danh sách roles để dropdown không bị rỗng
            request.setAttribute("rolesList", userDAO.getAllRoles());
            request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
            return;
        }
        
        // Server-side validation
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Confirmation password does not match!");
            request.setAttribute("rolesList", userDAO.getAllRoles());
            request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
            return;
        }

        
        if (userDAO.checkEmailExists(email)) {
            request.setAttribute("errorMessage", "This email address is already in use!");
            request.setAttribute("rolesList", userDAO.getAllRoles());
            request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
            return;
        }

        // Create a new Users object
        Users newUser = new Users();
        newUser.setFullname(fullName);
        newUser.setEmail(email);
        newUser.setAddress(contactAddress);
        newUser.setPhone(phone);
        newUser.setPassword(password);
        newUser.setSec_address(null);
        newUser.setRole_id(Integer.parseInt(roleIdStr));

        // Add the user to the database
        boolean success = userDAO.addUser(newUser);

        if (success) {
            // Redirect to the login page on success
            response.sendRedirect(request.getContextPath() + "/loginStaff");
        } else {
            // Show an error on failure
            request.setAttribute("errorMessage", "An error occurred. Please try again.");
            request.setAttribute("rolesList", userDAO.getAllRoles());
            request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
            //response.sendRedirect( request.getContextPath() + "/registerStaff");
        }
    }
}

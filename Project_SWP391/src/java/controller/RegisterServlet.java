package controller;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Users;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
        
        UserDAO userDAO = new UserDAO();
        
        // Server-side validation
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Confirmation password does not match!");
            request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
            return;
        }

        
        if (userDAO.checkEmailExists(email)) {
            request.setAttribute("errorMessage", "This email address is already in use!");
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
        newUser.setRole_id(9);

        // Add the user to the database
        boolean success = userDAO.addUser(newUser);

        if (success) {
            // Redirect to the login page on success
            response.sendRedirect(request.getContextPath() + "/loginStaff");
        } else {
            // Show an error on failure
            request.setAttribute("errorMessage", "An error occurred. Please try again.");
            request.getRequestDispatcher("/WEB-INF/view/register.jsp").forward(request, response);
            //response.sendRedirect( request.getContextPath() + "/registerStaff");
        }
    }
}

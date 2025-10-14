package controller;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Users;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/registerStaff"})
public class RegisterServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // When a user navigates to the URL, show them the registration form.
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get data from the form
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String contactAddress = request.getParameter("address");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");

        // Server-side validation
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Confirmation password does not match!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        if (userDAO.checkEmailExists(email)) {
            request.setAttribute("errorMessage", "This email address is already in use!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
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

        // Add the user to the database
        boolean success = userDAO.addUser(newUser);

        if (success) {
            // Redirect to the login page on success
            response.sendRedirect("login_page.jsp");
        } else {
            // Show an error on failure
            request.setAttribute("errorMessage", "An error occurred. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
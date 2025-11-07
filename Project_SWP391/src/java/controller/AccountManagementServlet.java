package controller;

import dal.UserDAO;
import model.Roles;
import model.Users;
import java.io.IOException;
import java.util.List;
import java.util.Set;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet; 
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashSet;

public class AccountManagementServlet extends HttpServlet {

    /**
     * Xử lý việc hiển thị danh sách người dùng.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Users admin = (Users) session.getAttribute("account");
        if (admin == null || admin.getRole_id() != 1) { 
            response.sendRedirect(request.getContextPath() + "/PersonalProfile"); 
            return;
        }

        UserDAO userDAO = new UserDAO();
        List<Users> userList = userDAO.getAllUsers();
        List<Roles> roleList = userDAO.getAllRoles();
        Set<Integer> activeUserSet = (Set<Integer>) getServletContext().getAttribute("activeUserSet");
        
        request.setAttribute("userList", userList);
        request.setAttribute("roleList", roleList);
        request.setAttribute("activeUserSet", activeUserSet);

        request.getRequestDispatcher("WEB-INF/view/account_management.jsp").forward(request, response);
    }

    /**
     * Xử lý các hành động: Disable, Enable, Delete.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Users admin = (Users) session.getAttribute("account");
        if (admin == null || admin.getRole_id() != 1) { 
            response.sendError(HttpServletResponse.SC_FORBIDDEN); 
            return;
        }
        
        String action = request.getParameter("action");
        int userId = Integer.parseInt(request.getParameter("userId"));
        
        if (admin.getUser_id() == userId && action.equals("changeRole")) {
             // Cho phép Admin tự đổi role của mình
        }
        else if (admin.getUser_id() == userId) {
            System.out.println("Admin cannot perform this action on themselves.");
            response.sendRedirect(request.getContextPath() + "/account-management");
            return;
        }

        UserDAO userDAO = new UserDAO();
        

        switch (action) {
            case "changeRole":
                int roleId = Integer.parseInt(request.getParameter("roleId"));
                userDAO.updateUserRole(userId, roleId);
                break;
            case "disable":
                userDAO.setUserActiveStatus(userId, false); 
                break;
            case "enable":
                userDAO.setUserActiveStatus(userId, true); 
                break;
            case "delete":
                userDAO.deleteUser(userId);
                break;
            default:
                System.out.println("Unknown action: " + action);
                break;
        }
        
        response.sendRedirect(request.getContextPath() + "/account-management");
    }
}
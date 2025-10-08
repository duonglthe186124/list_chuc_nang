/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.productsTask;

import controller.BaseAuthController;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.AuthUser_HE186124_DuongLT;

/**
 *
 * @author hoang
 */
public class Edit_info_product extends BaseAuthController{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, AuthUser_HE186124_DuongLT user) throws ServletException, IOException {
        if (user.getRoleId() != 2) {
            req.setAttribute("errorMessage", "You do not have permission to access this page.");
            req.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(req, resp);
            return;

        }
        
        req.getRequestDispatcher("/WEB-INF/task_view/edit_product.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, AuthUser_HE186124_DuongLT user) throws ServletException, IOException {
        if (user.getRoleId() != 2) {
            req.setAttribute("errorMessage", "You do not have permission to access this page.");
            req.getRequestDispatcher("/WEB-INF/view/error.jsp").forward(req, resp);
            return;

        }
        
        req.getRequestDispatcher("/WEB-INF/task_view/edit_product.jsp").forward(req, resp);
    }
    
}

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
public class Add_new_product extends BaseAuthController{

    private static final int feature_id = 10;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp, AuthUser_HE186124_DuongLT user) throws ServletException, IOException {
        // Giả sử user có thuộc tính getRoleId()
    if (user.getRoleId() != 2) {
        // Không đủ quyền → quay lại trang product_screen.jsp
        req.getRequestDispatcher("/WEB-INF/task_view/product_screen.jsp").forward(req, resp);
        return;
    }

    // Nếu roleId == 2 → cho phép vào trang thêm sản phẩm
    req.getRequestDispatcher("/WEB-INF/task_view/add_product_screen.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp, AuthUser_HE186124_DuongLT user) throws ServletException, IOException {
        // Giả sử user có thuộc tính getRoleId()
    if (user.getRoleId() != 2) {
        // Không đủ quyền → quay lại trang product_screen.jsp
        req.getRequestDispatcher("/WEB-INF/task_view/product_screen.jsp").forward(req, resp);
        return;
    }

    // Nếu roleId == 2 → cho phép vào trang thêm sản phẩm
    req.getRequestDispatcher("/WEB-INF/task_view/add_product_screen.jsp").forward(req, resp);
    }
    
}

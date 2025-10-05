package controller;

import dal.UserDBContext_HE181624_DuongLT;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.AuthUser_HE186124_DuongLT;

public class login_servlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserDBContext_HE181624_DuongLT db = new UserDBContext_HE181624_DuongLT();
        AuthUser_HE186124_DuongLT users = db.getLogin(email, password);

        HttpSession session = req.getSession();

        if (users != null) {
            // Đăng nhập thành công
            session.setAttribute("users", users);

            // Lấy lại URL người dùng muốn truy cập trước đó
            String redirectURL = (String) session.getAttribute("redirectAfterLogin");
            if (redirectURL != null) {
                session.removeAttribute("redirectAfterLogin");
                resp.sendRedirect(redirectURL);
            } else {
                // Nếu không có URL trước đó thì về home
                resp.sendRedirect(req.getContextPath() + "/index.htm");
            }
        } else {
            // Sai thông tin đăng nhập
            req.setAttribute("error", "Sai email hoặc mật khẩu!");
            req.getRequestDispatcher("/WEB-INF/view/login_page.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/view/login_page.jsp").forward(req, resp);
    }
}

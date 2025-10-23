package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import dto.AuthUser_HE186124_DuongLT;

public abstract class BaseAuthController extends HttpServlet {

    private AuthUser_HE186124_DuongLT getAuthenticated(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session != null) {
            return (AuthUser_HE186124_DuongLT) session.getAttribute("users");
        }
        return null;
    }

    protected abstract void doGet(HttpServletRequest req, HttpServletResponse resp,
                                  AuthUser_HE186124_DuongLT user)
            throws ServletException, IOException;

    protected abstract void doPost(HttpServletRequest req, HttpServletResponse resp,
                                   AuthUser_HE186124_DuongLT user)
            throws ServletException, IOException;

    @Override
    protected final void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String uri = req.getRequestURI();

        // Nếu đang ở /login thì không kiểm tra quyền
        if (uri.endsWith("/login")) {
            req.getRequestDispatcher("/WEB-INF/view/login_page.jsp").forward(req, resp);
            return;
        }

        AuthUser_HE186124_DuongLT user = getAuthenticated(req);
        if (user == null) {
            // Lưu URL người dùng định vào
            String target = req.getRequestURI();
            if (req.getQueryString() != null) {
                target += "?" + req.getQueryString();
            }
            req.getSession().setAttribute("redirectAfterLogin", target);

            // Chuyển về trang login
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            doGet(req, resp, user);
        }
    }

    @Override
    protected final void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String uri = req.getRequestURI();

        // Nếu là login thì không cần check
        if (uri.endsWith("/login")) {
            doPost(req, resp, null);
            return;
        }

        AuthUser_HE186124_DuongLT user = getAuthenticated(req);
        if (user == null) {
            String target = req.getRequestURI();
            if (req.getQueryString() != null) {
                target += "?" + req.getQueryString();
            }
            req.getSession().setAttribute("redirectAfterLogin", target);
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            doPost(req, resp, user);
        }
    }
}

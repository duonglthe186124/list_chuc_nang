package controller;

import dal.UserDAO;
import model.Users;
import util.GithubAuthHelper;
import java.io.IOException;
import java.util.Set;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CallbackGithubServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/loginStaff");
            return;
        }

        try {
            String accessToken = GithubAuthHelper.getAccessToken(code);
            Users ghUser = GithubAuthHelper.getUserInfo(accessToken);

            UserDAO userDAO = new UserDAO();
            Users user = userDAO.findUserByGithubId(ghUser.getGithubId());

            if (user == null) {
                // Nếu email user trả về là null, không thể tạo tài khoản
                if (ghUser.getEmail() == null) {
                    // Yêu cầu người dùng quay lại và cấp quyền email
                    request.setAttribute("errorMessage", "GitHub login failed. Email permission is required.");
                    request.getRequestDispatcher("WEB-INF/view/login_page.jsp").forward(request, response);
                    return;
                }
                
                // Kiểm tra xem email đã tồn tại chưa
                user = userDAO.findUserByEmailOrPhone(ghUser.getEmail());
                if (user != null) {
                    // TODO: Nâng cấp: Nối tài khoản GitHub này vào tài khoản email đã có
                } else {
                    // Tạo tài khoản mới
                    userDAO.createGithubUser(ghUser);
                    user = userDAO.findUserByGithubId(ghUser.getGithubId());
                }
            }

            // Đăng nhập cho người dùng
            HttpSession session = request.getSession();
            session.setAttribute("account", user); 

            Set<Integer> activeUserSet = (Set<Integer>) getServletContext().getAttribute("activeUserSet");
            if (activeUserSet != null) {
                activeUserSet.add(user.getUser_id());
            }
            
            response.sendRedirect(request.getContextPath() + "/home");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/loginStaff");
        }
    }
}
package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet; 
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "LoginGithubServlet", urlPatterns = {"/login-github"})
public class LoginGithubServlet extends HttpServlet { 

    private static final String CLIENT_ID = "Ov23lifh9EODRJ9Uknqg"; 
    private static final String REDIRECT_URI = "http://localhost:9999/Project_SWP391/callback-github";

    // 3. SỬ DỤNG doGet (thay vì @GetMapping)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String scope = "read:user,user:email"; 

        String githubAuthUrl = "https://github.com/login/oauth/authorize?"
                + "client_id=" + CLIENT_ID
                + "&redirect_uri=" + REDIRECT_URI
                + "&scope=" + scope;

        // 4. Dùng 'response.sendRedirect' (thay vì 'return "redirect:..."')
        response.sendRedirect(githubAuthUrl);
    }
}
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.UserDAO;
import model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;

/**
 *
 * @author admin
 */
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10, // 10MB
    maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class ProfileServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//    throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet ProfileServlet</title>");  
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet ProfileServlet at " + request.getContextPath () + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String SAVE_DIR = "resources/uploads/avatars";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//        HttpSession session = request.getSession();
//        Users currentUser = (Users) session.getAttribute("account");
//
//        if (currentUser == null) {
//            System.out.println(">>> ProfileServlet: No user in session. Creating a mock user for testing.");
//
//            currentUser = new Users();
//
//            currentUser.setFullname("Test User Name");
//            currentUser.setEmail("test.user@example.com");
//            currentUser.setPhone("0987654321");
//            currentUser.setAddress("123 Test Street, Hanoi");
//        }
//
//        request.setAttribute("userProfile", currentUser);
//        request.getRequestDispatcher("WEB-INF/view/personal_profile.jsp").forward(request, response);

        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("account");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/loginStaff");
            return;
        }

        request.setAttribute("userProfile", currentUser);
        request.getRequestDispatcher("WEB-INF/view/personal_profile.jsp").forward(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); 
        HttpSession session = request.getSession();
        Users currentUser = (Users) session.getAttribute("account");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/loginStaff");
            return;
        }

        try {
            // 1. Lấy file từ form
            Part filePart = request.getPart("avatar_file");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            // 2. Kiểm tra xem người dùng CÓ upload file mới không
            if (fileName != null && !fileName.isEmpty()) {
                String appPath = request.getServletContext().getRealPath("");
                String savePath = appPath + File.separator + SAVE_DIR;
                
                File fileSaveDir = new File(savePath);
                if (!fileSaveDir.exists()) {
                    fileSaveDir.mkdirs();
                }
                
                String fileExtension = fileName.substring(fileName.lastIndexOf("."));
                String newFileName = "user_" + currentUser.getUser_id() + "_avatar" + fileExtension;
                
                filePart.write(savePath + File.separator + newFileName);
                
                // 3. Cập nhật đối tượng user VỚI URL ẢNH MỚI
                currentUser.setAvatar_url(SAVE_DIR + "/" + newFileName);
            }
            // Nếu người dùng không upload file mới, chúng ta sẽ không làm gì cả
            // và `currentUser.getAvatar_url()` sẽ giữ nguyên giá trị cũ của nó

            // 4. Cập nhật các thông tin khác
            currentUser.setFullname(request.getParameter("fullname"));
            currentUser.setPhone(request.getParameter("phone"));
            currentUser.setAddress(request.getParameter("address"));

            // 5. Gọi DAO để lưu tất cả thay đổi (bao gồm cả avatar_url MỚI hoặc CŨ)
            UserDAO userDAO = new UserDAO();
            boolean success = userDAO.updateUser(currentUser); 

            if (success) {
                session.setAttribute("account", currentUser); // Cập nhật lại session
                request.setAttribute("successMessage", "Profile updated successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
        }

        request.setAttribute("userProfile", currentUser);
        request.getRequestDispatcher("WEB-INF/view/personal_profile.jsp").forward(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

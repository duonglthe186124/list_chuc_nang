/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dto.ViewTransactionDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import service.viewTransactionService;

/**
 *
 * @author ASUS
 */
public class view_tx_history_servlet extends HttpServlet {

    private ViewTransactionDTO view;
    private static final viewTransactionService service = new viewTransactionService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tx_id = request.getParameter("id");

        int id = 0;
        if (tx_id != null && !tx_id.trim().isEmpty()) {
            id = Integer.parseInt(tx_id);
        }

        System.out.println(id);
        
        view = service.get_transaction_view(id);
        request.setAttribute("view", view);
        request.getRequestDispatcher("/WEB-INF/view/view_transaction.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

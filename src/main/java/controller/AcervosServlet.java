package controller;

import model.Book;
import dao.BookDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet responsável por redirecionar de /acervos para /livros.
 */
@WebServlet("/acervos")
public class AcervosServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Redireciona todas as solicitações para /livros
        response.sendRedirect(request.getContextPath() + "/livros");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Redireciona todas as solicitações para /livros
        response.sendRedirect(request.getContextPath() + "/livros");
    }
}
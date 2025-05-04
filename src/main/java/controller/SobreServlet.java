package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet que mapeia a URL "/sobre" para a página sobre.jsp
 */
@WebServlet("/sobre")
public class SobreServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    /**
     * Método que processa requisições GET para a URL "/sobre"
     * 
     * @param request objeto que representa a requisição HTTP
     * @param response objeto que representa a resposta HTTP
     * @throws ServletException se ocorrer um erro no servlet
     * @throws IOException se ocorrer um erro de E/S
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Encaminha a requisição para a página sobre.jsp
        request.getRequestDispatcher("/sobre.jsp").forward(request, response);
    }
} 
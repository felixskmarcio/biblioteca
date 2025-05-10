// Este servlet é responsável por gerenciar o perfil do usuário.

package controller;

import model.User;
import service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet responsável por gerenciar o perfil do usuário.
 */
@WebServlet("/perfil")
public class ProfileServlet extends HttpServlet {
    
    private UserService userService;
    
    @Override
    public void init() throws ServletException {
        super.init();
        userService = new UserService();
    }
    
    /**
     * Método GET para exibir o perfil do usuário.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Verifica se o usuário está autenticado
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            // Usuário não está logado, redireciona para a página de login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Obtém o ID do usuário da sessão
        int userId = (int) session.getAttribute("userId");
        
        // Busca o usuário pelo ID
        User user = userService.getUserById(userId);
        
        if (user != null) {
            // Adiciona o usuário como atributo da requisição
            request.setAttribute("user", user);
            
            // Encaminha para a página de perfil
            request.getRequestDispatcher("/WEB-INF/views/user-profile.jsp").forward(request, response);
        } else {
            // Usuário não encontrado (situação incomum)
            session.invalidate(); // Invalida a sessão por segurança
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
} 
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
 * Servlet responsável por processar as requisições de autenticação (login).
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    private UserService userService;
    
    @Override
    public void init() throws ServletException {
        super.init();
        userService = new UserService();
    }
    
    /**
     * Método GET para exibir o formulário de login.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Redireciona o usuário para a página inicial se já estiver autenticado
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        // Tenta usar a página de login básica no diretório raiz
        try {
            request.getRequestDispatcher("/login-basic.jsp").forward(request, response);
        } catch (Exception e) {
            // Se falhar, tenta a página original
            System.out.println("Erro ao carregar login-basic.jsp: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
    
    /**
     * Método POST para processar o envio do formulário de login.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Validação simples dos campos
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Por favor, preencha todos os campos");
            request.getRequestDispatcher("/login-basic.jsp").forward(request, response);
            return;
        }
        
        // Tenta autenticar o usuário
        User user = userService.authenticate(email, password);
        
        if (user != null) {
            // Autenticação bem-sucedida
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userEmail", user.getEmail());
            
            // Redireciona para a página inicial
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            // Autenticação falhou
            request.setAttribute("errorMessage", "Email ou senha inválidos");
            request.getRequestDispatcher("/login-basic.jsp").forward(request, response);
        }
    }
} 
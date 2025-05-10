package controller;

import model.User;
import service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Base64;

/**
 * Servlet responsável por processar as requisições de autenticação (login).
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    private UserService userService;
    private static final int COOKIE_MAX_AGE = 60 * 60 * 24 * 30; // 30 dias
    
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
        
        // Verifica se há um cookie de "lembrar de mim" e autentica o usuário automaticamente
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            String rememberedEmail = null;
            String rememberedToken = null;
            
            for (Cookie cookie : cookies) {
                if ("rememberedEmail".equals(cookie.getName())) {
                    rememberedEmail = cookie.getValue();
                } else if ("rememberedToken".equals(cookie.getName())) {
                    rememberedToken = cookie.getValue();
                }
            }
            
            // Se encontrou os cookies de login, tenta autenticar o usuário
            if (rememberedEmail != null && rememberedToken != null) {
                User user = userService.getUserByEmail(rememberedEmail);
                if (user != null && validateRememberMeToken(rememberedToken, user)) {
                    // Autenticação bem-sucedida via cookie
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    session.setAttribute("userId", user.getId());
                    session.setAttribute("userName", user.getName());
                    session.setAttribute("userEmail", user.getEmail());
                    
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                    return;
                }
            }
        }
        
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
        String rememberMe = request.getParameter("rememberMe");
        
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
            
            // Se o usuário marcou "lembrar de mim", cria cookies
            if (rememberMe != null && rememberMe.equals("on")) {
                String token = generateRememberMeToken(user);
                
                Cookie emailCookie = new Cookie("rememberedEmail", email);
                emailCookie.setMaxAge(COOKIE_MAX_AGE);
                emailCookie.setPath("/");
                
                Cookie tokenCookie = new Cookie("rememberedToken", token);
                tokenCookie.setMaxAge(COOKIE_MAX_AGE);
                tokenCookie.setPath("/");
                
                response.addCookie(emailCookie);
                response.addCookie(tokenCookie);
            }
            
            // Redireciona para a página inicial
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            // Autenticação falhou
            request.setAttribute("errorMessage", "Email ou senha inválidos");
            request.getRequestDispatcher("/login-basic.jsp").forward(request, response);
        }
    }
    
    /**
     * Gera um token para o recurso "lembrar de mim"
     */
    private String generateRememberMeToken(User user) {
        // Em um ambiente de produção, use uma solução mais segura
        // Considere usar JWT ou outro mecanismo de token seguro
        String baseString = user.getId() + ":" + user.getEmail() + ":" + System.currentTimeMillis();
        return Base64.getEncoder().encodeToString(baseString.getBytes());
    }
    
    /**
     * Valida o token do recurso "lembrar de mim"
     */
    private boolean validateRememberMeToken(String token, User user) {
        // Em um ambiente de produção, implemente validação mais robusta
        try {
            String decodedToken = new String(Base64.getDecoder().decode(token));
            return decodedToken.startsWith(user.getId() + ":" + user.getEmail());
        } catch (Exception e) {
            return false;
        }
    }
} 
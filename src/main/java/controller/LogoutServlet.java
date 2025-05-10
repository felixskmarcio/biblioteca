package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet responsável por processar o logout do usuário.
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    
    /**
     * Método GET para processar a requisição de logout.
     * Invalida a sessão atual e redireciona para a página inicial.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Obtém a sessão atual, se existir
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // Remove todos os atributos da sessão
            session.removeAttribute("user");
            session.removeAttribute("userId");
            session.removeAttribute("userName");
            session.removeAttribute("userEmail");
            
            // Invalida a sessão
            session.invalidate();
        }
        
        // Limpa os cookies de "lembrar de mim"
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("rememberedEmail".equals(cookie.getName()) || "rememberedToken".equals(cookie.getName())) {
                    cookie.setValue("");
                    cookie.setMaxAge(0); // Remove o cookie
                    cookie.setPath("/");
                    response.addCookie(cookie);
                }
            }
        }
        
        // Redireciona para a página inicial
        response.sendRedirect(request.getContextPath() + "/");
    }
} 
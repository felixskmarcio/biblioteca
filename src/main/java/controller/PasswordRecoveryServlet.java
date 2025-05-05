package controller;

import model.User;
import service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;

/**
 * Servlet responsável por processar as requisições de recuperação de senha.
 */
@WebServlet("/senha/recuperar")
public class PasswordRecoveryServlet extends HttpServlet {
    
    private UserService userService;
    
    @Override
    public void init() throws ServletException {
        super.init();
        userService = new UserService();
    }
    
    /**
     * Método GET para exibir o formulário de recuperação de senha.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Encaminha para a página de recuperação de senha
        request.getRequestDispatcher("/WEB-INF/views/recover-password.jsp").forward(request, response);
    }
    
    /**
     * Método POST para processar o envio do formulário de recuperação de senha.
     * 
     * Neste exemplo, simulamos o envio de um email com instruções de recuperação.
     * Em um ambiente de produção, você implementaria o envio real de email.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        
        // Validação do email
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Por favor, informe seu email");
            request.getRequestDispatcher("/WEB-INF/views/recover-password.jsp").forward(request, response);
            return;
        }
        
        // Verifica se o email existe na base de dados
        User user = userService.getUserByEmail(email);
        
        // Independentemente se o email existe ou não, mostraremos a mesma mensagem
        // para evitar vazamento de informações sobre quais emails estão cadastrados
        String successMessage = "Se o email informado estiver cadastrado em nosso sistema, você receberá as instruções para recuperação de senha em breve.";
        
        // Aqui você adicionaria a lógica de envio de email com token de recuperação
        // Por exemplo, gerar um token único, salvar no banco e enviar por email
        if (user != null) {
            // Em um ambiente real, você enviaria um email com instruções
            // Apenas simulando a geração de um token para este exemplo
            String resetToken = UUID.randomUUID().toString();
            
            // Armazenar o token no banco associado ao usuário
            // userService.storeResetToken(user.getId(), resetToken);
            
            // Enviar email com link para resetar senha
            // emailService.sendPasswordResetEmail(user.getEmail(), resetToken);
            
            // Log para debug
            System.out.println("Token de recuperação para " + email + ": " + resetToken);
        }
        
        request.setAttribute("successMessage", successMessage);
        request.getRequestDispatcher("/WEB-INF/views/recover-password.jsp").forward(request, response);
    }
} 
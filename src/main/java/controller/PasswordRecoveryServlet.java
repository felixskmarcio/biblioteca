package controller;

import model.User;
import service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * Servlet responsável por processar as requisições de recuperação de senha.
 */
@WebServlet("/senha/recuperar")
public class PasswordRecoveryServlet extends HttpServlet {
    
    private UserService userService;
    // Em um ambiente de produção, isso seria armazenado em um banco de dados
    private Map<String, PasswordResetRequest> passwordResetTokens = new HashMap<>();
    
    private static class PasswordResetRequest {
        private final int userId;
        private final long expiryTime;
        
        public PasswordResetRequest(int userId) {
            this.userId = userId;
            // Token expira em 1 hora
            this.expiryTime = System.currentTimeMillis() + (60 * 60 * 1000);
        }
        
        public boolean isValid() {
            return System.currentTimeMillis() < expiryTime;
        }
        
        public int getUserId() {
            return userId;
        }
    }
    
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
        
        String token = request.getParameter("token");
        if (token != null) {
            // Verifica se o token é válido
            PasswordResetRequest resetRequest = passwordResetTokens.get(token);
            if (resetRequest == null || !resetRequest.isValid()) {
                request.setAttribute("errorMessage", "O link de recuperação é inválido ou expirou. Por favor, solicite uma nova recuperação de senha.");
            }
        }
        
        // Encaminha para a página de recuperação de senha
        request.getRequestDispatcher("/WEB-INF/views/recover-password.jsp").forward(request, response);
    }
    
    /**
     * Método POST para processar o envio do formulário de recuperação de senha.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String token = request.getParameter("token");
        
        // Se temos um token, estamos processando a redefinição de senha
        if (token != null && !token.trim().isEmpty()) {
            processPasswordReset(request, response, token);
        } else {
            // Caso contrário, estamos iniciando o processo de recuperação
            processRecoveryRequest(request, response);
        }
    }
    
    /**
     * Processa a solicitação inicial de recuperação de senha
     */
    private void processRecoveryRequest(HttpServletRequest request, HttpServletResponse response) 
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
        if (user != null) {
            // Em um ambiente real, você enviaria um email com instruções
            // Apenas simulando a geração de um token para este exemplo
            String resetToken = UUID.randomUUID().toString();
            
            // Armazenar o token (em produção, seria no banco de dados)
            passwordResetTokens.put(resetToken, new PasswordResetRequest(user.getId()));
            
            // URL de redefinição que seria enviada por email
            String resetUrl = request.getRequestURL().toString() + "?token=" + resetToken;
            
            // Log para debug (em produção, isso seria removido e o email seria enviado)
            System.out.println("Token de recuperação para " + email + ": " + resetToken);
            System.out.println("URL de recuperação: " + resetUrl);
        }
        
        request.setAttribute("successMessage", successMessage);
        request.getRequestDispatcher("/WEB-INF/views/recover-password.jsp").forward(request, response);
    }
    
    /**
     * Processa a redefinição de senha usando o token
     */
    private void processPasswordReset(HttpServletRequest request, HttpServletResponse response, String token) 
            throws ServletException, IOException {
        
        // Verifica se o token é válido
        PasswordResetRequest resetRequest = passwordResetTokens.get(token);
        if (resetRequest == null || !resetRequest.isValid()) {
            request.setAttribute("errorMessage", "O link de recuperação é inválido ou expirou. Por favor, solicite uma nova recuperação de senha.");
            request.getRequestDispatcher("/WEB-INF/views/recover-password.jsp").forward(request, response);
            return;
        }
        
        // Obtém e valida as senhas
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        if (password == null || password.trim().isEmpty() || 
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Por favor, preencha todos os campos");
            request.getRequestDispatcher("/WEB-INF/views/recover-password.jsp").forward(request, response);
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "As senhas não coincidem");
            request.getRequestDispatcher("/WEB-INF/views/recover-password.jsp").forward(request, response);
            return;
        }
        
        // Valida o padrão de senha (essa validação deve ser complementada com validação do lado cliente)
        if (!password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$")) {
            request.setAttribute("errorMessage", "A senha deve ter no mínimo 8 caracteres, incluindo letras maiúsculas, minúsculas e números");
            request.getRequestDispatcher("/WEB-INF/views/recover-password.jsp").forward(request, response);
            return;
        }
        
        // Atualiza a senha do usuário
        boolean success = userService.changePassword(resetRequest.getUserId(), password);
        
        if (success) {
            // Remove o token usado
            passwordResetTokens.remove(token);
            
            request.setAttribute("successMessage", "Sua senha foi redefinida com sucesso. Você já pode fazer login com sua nova senha.");
        } else {
            request.setAttribute("errorMessage", "Ocorreu um erro ao redefinir sua senha. Por favor, tente novamente mais tarde.");
        }
        
        request.getRequestDispatcher("/WEB-INF/views/recover-password.jsp").forward(request, response);
    }
} 
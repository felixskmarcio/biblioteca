package controller;

import model.User;
import service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

/**
 * Servlet responsável por processar as requisições de registro de novos usuários.
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    
    private UserService userService;
    
    @Override
    public void init() throws ServletException {
        super.init();
        userService = new UserService();
    }
    
    /**
     * Método GET para exibir o formulário de registro.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Encaminha para a página de registro
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }
    
    /**
     * Método POST para processar o envio do formulário de registro.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        // Validação dos campos
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "Por favor, preencha todos os campos obrigatórios");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        // Verifica se as senhas são iguais
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "As senhas não conferem");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        // Verifica critérios de complexidade da senha
        if (!password.matches("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$")) {
            request.setAttribute("errorMessage", "A senha deve ter no mínimo 8 caracteres, incluindo letras maiúsculas, minúsculas e números");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        // Cria o novo usuário
        User newUser = new User(name, email, password);
        newUser.setPhone(phone);
        newUser.setAddress(address);
        newUser.setRegistrationDate(new Date());
        newUser.setActive(true);
        
        // Tenta registrar o usuário
        boolean success = userService.registerUser(newUser);
        
        if (success) {
            // Registro bem-sucedido
            request.setAttribute("successMessage", "Cadastro realizado com sucesso! Agora você pode fazer login.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        } else {
            // Falha no registro (provavelmente email já existe)
            request.setAttribute("errorMessage", "Este email já está em uso. Por favor, tente outro email.");
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        }
    }
} 
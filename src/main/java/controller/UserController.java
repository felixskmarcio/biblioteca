// Este controlador é responsável por gerenciar as requisições relacionadas a usuários.

package controller;

// Importações necessárias para o funcionamento do controlador
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Importações de classes do projeto
import model.User; // Modelo de dados para usuários
import service.UserService; // Serviço que gerencia operações com usuários

/**
 * Controlador responsável por gerenciar as requisições relacionadas a usuários.
 * Implementa operações CRUD (Create, Read, Update, Delete) para usuários do sistema.
 */
public class UserController extends HttpServlet {
    private static final long serialVersionUID = 1L; // Identificador para serialização
    private UserService userService; // Serviço que contém a lógica de negócio

    /**
     * Método de inicialização chamado quando o servlet é carregado.
     * Inicializa o serviço de usuários.
     */
    public void init() {
        userService = new UserService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) {
            action = "/";
        }

        switch (action) {
            case "/list":
                listUsers(request, response);
                break;
            case "/register":
                showRegisterForm(request, response);
                break;
            case "/edit":
                showEditForm(request, response);
                break;
            case "/delete":
                deleteUser(request, response);
                break;
            default:
                listUsers(request, response);
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getPathInfo();
        if (action == null) {
            action = "/";
        }

        switch (action) {
            case "/add":
                addUser(request, response);
                break;
            case "/update":
                updateUser(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/users/list");
                break;
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("users", userService.getAllUsers());
        request.getRequestDispatcher("/WEB-INF/views/user-profile.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        User user = userService.getUserById(id);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/views/user-profile.jsp").forward(request, response);
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPhone(phone);

        userService.addUser(user);
        response.sendRedirect(request.getContextPath() + "/users/list");
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        User user = new User(id, name, email, phone);
        userService.updateUser(user);
        response.sendRedirect(request.getContextPath() + "/users/list");
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Long id = Long.parseLong(request.getParameter("id"));
        userService.deleteUser(id);
        response.sendRedirect(request.getContextPath() + "/users/list");
    }

    private void showRegisterForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }
}
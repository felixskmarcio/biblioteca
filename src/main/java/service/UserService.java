// Este arquivo é responsável por definir o serviço de usuário, que lida com a lógica de negócios para operações relacionadas a usuários.

package service;

import dao.UserDAO;
import model.User;

import java.util.List;

/**
 * Serviço responsável por gerenciar operações relacionadas a usuários.
 * Implementa a lógica de negócio para cadastro, autenticação e gerenciamento de usuários.
 */
public class UserService {
    private UserDAO userDAO;
    
    public UserService() {
        this.userDAO = new UserDAO();
    }
    
    /**
     * Autentica um usuário no sistema.
     * 
     * @param email Email do usuário
     * @param password Senha do usuário
     * @return Usuário autenticado ou null se as credenciais forem inválidas
     */
    public User authenticate(String email, String password) {
        return userDAO.authenticate(email, password);
    }
    
    /**
     * Busca um usuário pelo email.
     * 
     * @param email Email do usuário
     * @return Usuário encontrado ou null se não existir
     */
    public User getUserByEmail(String email) {
        return userDAO.findByEmail(email);
    }
    
    /**
     * Registra um novo usuário no sistema.
     * Verifica se o email já está em uso antes de registrar.
     */
    public boolean registerUser(User user) {
        User existingUser = userDAO.findByEmail(user.getEmail());
        if (existingUser != null) {
            return false; // Email já está em uso
        }
        return userDAO.insert(user);
    }
    
    /**
     * Atualiza as informações de um usuário.
     * Verifica se o novo email já está em uso por outro usuário.
     */
    public boolean updateUser(User user) {
        User existingUser = userDAO.findByEmail(user.getEmail());
        if (existingUser != null && existingUser.getId() != user.getId()) {
            return false; // Email já está em uso por outro usuário
        }
        return userDAO.update(user);
    }
    
    /**
     * Altera a senha de um usuário.
     * 
     * @param userId ID do usuário
     * @param newPassword Nova senha
     * @return true se a alteração foi bem-sucedida, false caso contrário
     */
    public boolean changePassword(int userId, String newPassword) {
        return userDAO.updatePassword(userId, newPassword);
    }
    
    /**
     * Ativa ou desativa uma conta de usuário.
     * 
     * @param userId ID do usuário
     * @param active Status de ativação (true para ativar, false para desativar)
     * @return true se a operação foi bem-sucedida, false caso contrário
     */
    public boolean setUserActive(int userId, boolean active) {
        return userDAO.setActive(userId, active);
    }
    
    /**
     * Remove um usuário do sistema.
     * 
     * @param userId ID do usuário a ser removido
     * @return true se a remoção foi bem-sucedida, false caso contrário
     */
    public boolean deleteUser(int userId) {
        return userDAO.delete(userId);
    }
    
    /**
     * Retorna todos os usuários cadastrados.
     * 
     * @return Lista de usuários
     */
    public List<User> getAllUsers() {
        return userDAO.findAll();
    }
    
    /**
     * Busca um usuário pelo ID.
     * 
     * @param userId ID do usuário
     * @return Usuário encontrado ou null se não existir
     */
    public User getUserById(int userId) {
        return userDAO.findById(userId);
    }
    
    /**
     * Busca usuários por nome ou email.
     * Se a consulta for vazia, retorna todos os usuários.
     */
    public List<User> searchUsers(String query) {
        if (query == null || query.trim().isEmpty()) {
            return getAllUsers();
        }
        return userDAO.search(query);
    }
}
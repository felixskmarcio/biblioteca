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
    
    /**
     * Construtor padrão que inicializa o DAO de usuários.
     */
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
     * Registra um novo usuário no sistema.
     * Verifica se o email já está em uso antes de registrar.
     * 
     * @param user Usuário a ser registrado
     * @return true se o registro foi bem-sucedido, false caso contrário
     */
    public boolean registerUser(User user) {
        // Verifica se já existe um usuário com o mesmo email
        User existingUser = userDAO.findByEmail(user.getEmail());
        if (existingUser != null) {
            return false; // Email já está em uso
        }
        
        return userDAO.insert(user);
    }
    
    /**
     * Atualiza as informações de um usuário.
     * Verifica se o novo email já está em uso por outro usuário.
     * 
     * @param user Usuário com informações atualizadas
     * @return true se a atualização foi bem-sucedida, false caso contrário
     */
    public boolean updateUser(User user) {
        // Verifica se o novo email já está em uso por outro usuário
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
     * 
     * @param query Termo de busca
     * @return Lista de usuários que correspondem à busca
     */
    public List<User> searchUsers(String query) {
        if (query == null || query.trim().isEmpty()) {
            return getAllUsers();
        }
        return userDAO.search(query);
    }
}
// Este DAO é responsável por realizar operações de CRUD (Create, Read, Update, Delete)
// relacionadas aos usuários no banco de dados.

package dao;

import model.User;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Classe DAO (Data Access Object) responsável por realizar operações de CRUD
 * relacionadas aos usuários no banco de dados.
 */
public class UserDAO {

    /**
     * Insere um novo usuário no banco de dados.
     * 
     * @param user O usuário a ser inserido
     * @return true se a inserção for bem-sucedida, false caso contrário
     */
    public boolean insert(User user) {
        String sql = "INSERT INTO usuarios (nome, email, senha, telefone, endereco, ativo) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getAddress());
            stmt.setBoolean(6, user.isActive());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Erro ao inserir usuário: " + e.getMessage());
            return false;
        } finally {
            try {
                if (stmt != null) stmt.close();
                DatabaseConnection.closeConnection(conn);
            } catch (SQLException e) {
                System.err.println("Erro ao fechar recursos: " + e.getMessage());
            }
        }
    }
    
    /**
     * Retorna um usuário pelo seu ID.
     * 
     * @param id O ID do usuário a ser buscado
     * @return O usuário encontrado ou null se não existir
     */
    public User findById(int id) {
        String sql = "SELECT * FROM usuarios WHERE id = ?";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        User user = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                user = createUserFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Erro ao buscar usuário por ID: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                DatabaseConnection.closeConnection(conn);
            } catch (SQLException e) {
                System.err.println("Erro ao fechar recursos: " + e.getMessage());
            }
        }
        
        return user;
    }
    
    /**
     * Busca um usuário pelo email.
     * Útil para verificar login e autenticação.
     * 
     * @param email O email do usuário
     * @return O usuário encontrado ou null se não existir
     */
    public User findByEmail(String email) {
        String sql = "SELECT * FROM usuarios WHERE email = ?";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        User user = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                user = createUserFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Erro ao buscar usuário por email: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                DatabaseConnection.closeConnection(conn);
            } catch (SQLException e) {
                System.err.println("Erro ao fechar recursos: " + e.getMessage());
            }
        }
        
        return user;
    }
    
    /**
     * Autentica um usuário pelo email e senha.
     * 
     * @param email Email do usuário
     * @param password Senha do usuário
     * @return O usuário autenticado ou null se as credenciais forem inválidas
     */
    public User authenticate(String email, String password) {
        String sql = "SELECT * FROM usuarios WHERE email = ? AND senha = ? AND ativo = TRUE";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        User user = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                user = createUserFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Erro ao autenticar usuário: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                DatabaseConnection.closeConnection(conn);
            } catch (SQLException e) {
                System.err.println("Erro ao fechar recursos: " + e.getMessage());
            }
        }
        
        return user;
    }
    
    /**
     * Atualiza as informações de um usuário no banco de dados.
     * 
     * @param user O usuário com as informações atualizadas
     * @return true se a atualização for bem-sucedida, false caso contrário
     */
    public boolean update(User user) {
        String sql = "UPDATE usuarios SET nome = ?, email = ?, telefone = ?, " +
                     "endereco = ?, ativo = ? WHERE id = ?";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getAddress());
            stmt.setBoolean(5, user.isActive());
            stmt.setInt(6, user.getId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Erro ao atualizar usuário: " + e.getMessage());
            return false;
        } finally {
            try {
                if (stmt != null) stmt.close();
                DatabaseConnection.closeConnection(conn);
            } catch (SQLException e) {
                System.err.println("Erro ao fechar recursos: " + e.getMessage());
            }
        }
    }
    
    /**
     * Atualiza a senha de um usuário.
     * 
     * @param userId ID do usuário
     * @param newPassword Nova senha
     * @return true se a atualização for bem-sucedida, false caso contrário
     */
    public boolean updatePassword(int userId, String newPassword) {
        String sql = "UPDATE usuarios SET senha = ? WHERE id = ?";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, newPassword);
            stmt.setInt(2, userId);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Erro ao atualizar senha: " + e.getMessage());
            return false;
        } finally {
            try {
                if (stmt != null) stmt.close();
                DatabaseConnection.closeConnection(conn);
            } catch (SQLException e) {
                System.err.println("Erro ao fechar recursos: " + e.getMessage());
            }
        }
    }
    
    /**
     * Remove um usuário do banco de dados.
     * 
     * @param id O ID do usuário a ser removido
     * @return true se a remoção for bem-sucedida, false caso contrário
     */
    public boolean delete(int id) {
        String sql = "DELETE FROM usuarios WHERE id = ?";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Erro ao remover usuário: " + e.getMessage());
            return false;
        } finally {
            try {
                if (stmt != null) stmt.close();
                DatabaseConnection.closeConnection(conn);
            } catch (SQLException e) {
                System.err.println("Erro ao fechar recursos: " + e.getMessage());
            }
        }
    }
    
    /**
     * Ativa ou desativa um usuário.
     * 
     * @param id ID do usuário
     * @param active Status de ativação
     * @return true se a atualização for bem-sucedida, false caso contrário
     */
    public boolean setActive(int id, boolean active) {
        String sql = "UPDATE usuarios SET ativo = ? WHERE id = ?";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            
            stmt.setBoolean(1, active);
            stmt.setInt(2, id);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Erro ao atualizar status do usuário: " + e.getMessage());
            return false;
        } finally {
            try {
                if (stmt != null) stmt.close();
                DatabaseConnection.closeConnection(conn);
            } catch (SQLException e) {
                System.err.println("Erro ao fechar recursos: " + e.getMessage());
            }
        }
    }
    
    /**
     * Retorna todos os usuários cadastrados no banco de dados.
     * 
     * @return Lista com todos os usuários
     */
    public List<User> findAll() {
        String sql = "SELECT * FROM usuarios ORDER BY nome";
        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<User> users = new ArrayList<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                users.add(createUserFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Erro ao listar usuários: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                DatabaseConnection.closeConnection(conn);
            } catch (SQLException e) {
                System.err.println("Erro ao fechar recursos: " + e.getMessage());
            }
        }
        
        return users;
    }
    
    /**
     * Busca usuários no banco de dados de acordo com os termos informados.
     * 
     * @param query Termo para busca no nome ou email
     * @return Lista de usuários que correspondem à busca
     */
    public List<User> search(String query) {
        String sql = "SELECT * FROM usuarios WHERE nome LIKE ? OR email LIKE ? ORDER BY nome";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<User> users = new ArrayList<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            
            String searchTerm = "%" + query + "%";
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                users.add(createUserFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Erro ao buscar usuários: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                DatabaseConnection.closeConnection(conn);
            } catch (SQLException e) {
                System.err.println("Erro ao fechar recursos: " + e.getMessage());
            }
        }
        
        return users;
    }
    
    /**
     * Método auxiliar para criar um objeto User a partir de um ResultSet.
     * 
     * @param rs ResultSet com dados do usuário
     * @return Objeto User preenchido
     * @throws SQLException Se ocorrer erro ao acessar dados do ResultSet
     */
    private User createUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setName(rs.getString("nome"));
        user.setEmail(rs.getString("email"));
        user.setPassword(rs.getString("senha"));
        user.setPhone(rs.getString("telefone"));
        user.setAddress(rs.getString("endereco"));
        
        Timestamp registrationDate = rs.getTimestamp("data_cadastro");
        if (registrationDate != null) {
            user.setRegistrationDate(new java.util.Date(registrationDate.getTime()));
        }
        
        user.setActive(rs.getBoolean("ativo"));
        return user;
    }
} 
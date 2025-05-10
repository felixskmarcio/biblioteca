// Este DAO é responsável por realizar operações de CRUD (Create, Read, Update, Delete)
// relacionadas aos livros no banco de dados.

package dao;

import model.Book;
import util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Classe DAO (Data Access Object) responsável por realizar operações de CRUD
 * relacionadas aos livros no banco de dados.
 */
public class BookDAO {

    /**
     * Insere um novo livro no banco de dados.
     * 
     * @param book O livro a ser inserido
     * @return true se a inserção for bem-sucedida, false caso contrário
     */
    public boolean insert(Book book) {
        String sql = "INSERT INTO livros (titulo, autor, isbn, editora, ano_publicacao, genero, " +
                     "quantidade_total, quantidade_disponivel, data_aquisicao, localizacao) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setString(3, book.getIsbn());
            stmt.setString(4, book.getPublisher());
            stmt.setInt(5, book.getPublicationYear());
            stmt.setString(6, book.getGenre());
            stmt.setInt(7, book.getTotalQuantity());
            stmt.setInt(8, book.getAvailableQuantity());
            
            // Tratando a data de aquisição
            if (book.getAcquisitionDate() != null) {
                stmt.setDate(9, new java.sql.Date(book.getAcquisitionDate().getTime()));
            } else {
                stmt.setNull(9, Types.DATE);
            }
            
            stmt.setString(10, book.getLocation());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Erro ao inserir livro: " + e.getMessage());
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
     * Retorna um livro pelo seu ID.
     * 
     * @param id O ID do livro a ser buscado
     * @return O livro encontrado ou null se não existir
     */
    public Book findById(int id) {
        String sql = "SELECT * FROM livros WHERE id = ?";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Book book = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                book = createBookFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("Erro ao buscar livro por ID: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                DatabaseConnection.closeConnection(conn);
            } catch (SQLException e) {
                System.err.println("Erro ao fechar recursos: " + e.getMessage());
            }
        }
        
        return book;
    }
    
    /**
     * Atualiza as informações de um livro no banco de dados.
     * 
     * @param book O livro com as informações atualizadas
     * @return true se a atualização for bem-sucedida, false caso contrário
     */
    public boolean update(Book book) {
        String sql = "UPDATE livros SET titulo = ?, autor = ?, isbn = ?, editora = ?, " +
                     "ano_publicacao = ?, genero = ?, quantidade_total = ?, " +
                     "quantidade_disponivel = ?, data_aquisicao = ?, localizacao = ? " +
                     "WHERE id = ?";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setString(3, book.getIsbn());
            stmt.setString(4, book.getPublisher());
            stmt.setInt(5, book.getPublicationYear());
            stmt.setString(6, book.getGenre());
            stmt.setInt(7, book.getTotalQuantity());
            stmt.setInt(8, book.getAvailableQuantity());
            
            if (book.getAcquisitionDate() != null) {
                stmt.setDate(9, new java.sql.Date(book.getAcquisitionDate().getTime()));
            } else {
                stmt.setNull(9, Types.DATE);
            }
            
            stmt.setString(10, book.getLocation());
            stmt.setInt(11, book.getId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Erro ao atualizar livro: " + e.getMessage());
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
     * Remove um livro do banco de dados.
     * 
     * @param id O ID do livro a ser removido
     * @return true se a remoção for bem-sucedida, false caso contrário
     */
    public boolean delete(int id) {
        String sql = "DELETE FROM livros WHERE id = ?";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Erro ao remover livro: " + e.getMessage());
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
     * Retorna todos os livros cadastrados no banco de dados.
     * 
     * @return Lista com todos os livros
     */
    public List<Book> findAll() {
        String sql = "SELECT * FROM livros ORDER BY titulo";
        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<Book> books = new ArrayList<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                books.add(createBookFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Erro ao listar livros: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                DatabaseConnection.closeConnection(conn);
            } catch (SQLException e) {
                System.err.println("Erro ao fechar recursos: " + e.getMessage());
            }
        }
        
        return books;
    }
    
    /**
     * Busca livros no banco de dados de acordo com os termos informados.
     * 
     * @param query Termo para busca no título, autor ou gênero
     * @return Lista de livros que correspondem à busca
     */
    public List<Book> search(String query) {
        String sql = "SELECT * FROM livros WHERE titulo LIKE ? OR autor LIKE ? OR genero LIKE ? ORDER BY titulo";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Book> books = new ArrayList<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            
            String searchTerm = "%" + query + "%";
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            stmt.setString(3, searchTerm);
            
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                books.add(createBookFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Erro ao buscar livros: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                DatabaseConnection.closeConnection(conn);
            } catch (SQLException e) {
                System.err.println("Erro ao fechar recursos: " + e.getMessage());
            }
        }
        
        return books;
    }
    
    /**
     * Obtém a contagem total de livros no banco de dados.
     * Útil para implementar paginação.
     * 
     * @return Total de livros cadastrados
     */
    public int count() {
        String sql = "SELECT COUNT(*) FROM livros";
        
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        int count = 0;
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            
            if (rs.next()) {
                count = rs.getInt(1);
            }
            
        } catch (SQLException e) {
            System.err.println("Erro ao contar livros: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                DatabaseConnection.closeConnection(conn);
            } catch (SQLException e) {
                System.err.println("Erro ao fechar recursos: " + e.getMessage());
            }
        }
        
        return count;
    }
    
    /**
     * Retorna uma lista de livros com paginação.
     * 
     * @param offset Posição inicial
     * @param limit Quantidade de registros a retornar
     * @return Lista de livros paginada
     */
    public List<Book> findWithPagination(int offset, int limit) {
        String sql = "SELECT * FROM livros ORDER BY titulo LIMIT ?, ?";
        
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Book> books = new ArrayList<>();
        
        try {
            conn = DatabaseConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, offset);
            stmt.setInt(2, limit);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                books.add(createBookFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Erro ao listar livros com paginação: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                DatabaseConnection.closeConnection(conn);
            } catch (SQLException e) {
                System.err.println("Erro ao fechar recursos: " + e.getMessage());
            }
        }
        
        return books;
    }
    
    /**
     * Método auxiliar para criar um objeto Book a partir de um ResultSet.
     * 
     * @param rs ResultSet com dados do livro
     * @return Objeto Book preenchido
     * @throws SQLException Se ocorrer erro ao acessar dados do ResultSet
     */
    private Book createBookFromResultSet(ResultSet rs) throws SQLException {
        Book book = new Book();
        book.setId(rs.getInt("id"));
        book.setTitle(rs.getString("titulo"));
        book.setAuthor(rs.getString("autor"));
        book.setIsbn(rs.getString("isbn"));
        book.setPublisher(rs.getString("editora"));
        book.setPublicationYear(rs.getInt("ano_publicacao"));
        book.setGenre(rs.getString("genero"));
        book.setTotalQuantity(rs.getInt("quantidade_total"));
        book.setAvailableQuantity(rs.getInt("quantidade_disponivel"));
        
        Date acquisitionDate = rs.getDate("data_aquisicao");
        if (acquisitionDate != null) {
            book.setAcquisitionDate(new java.util.Date(acquisitionDate.getTime()));
        }
        
        book.setLocation(rs.getString("localizacao"));
        return book;
    }
} 
// Este DAO é responsável por estabelecer conexões com o banco de dados.

package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Classe DAO responsável por estabelecer conexões com o banco de dados.
 * Implementa o padrão Singleton para reutilização da conexão.
 */
public class conexaoDAO {
    private static conexaoDAO instance;
    private Connection connection;
    
    // Parâmetros de conexão
    private static final String HOST = "localhost";
    private static final String PORT = "3306";
    private static final String DATABASE = "db_mobile";
    private static final String USER = "root";
    private static final String PASSWORD = "felixbr";
    private static final String URL = "jdbc:mysql://" + HOST + ":" + PORT + "/" + DATABASE;
    
    /**
     * Construtor privado para implementar o padrão Singleton.
     */
    private conexaoDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("Erro ao carregar driver MySQL: " + e.getMessage());
        }
    }
    
    /**
     * Obtém a instância única da classe (padrão Singleton).
     * 
     * @return Instância única da conexaoDAO
     */
    public static conexaoDAO getInstance() {
        if (instance == null) {
            instance = new conexaoDAO();
        }
        return instance;
    }
    
    /**
     * Obtém uma conexão com o banco de dados.
     * 
     * @return Objeto Connection representando a conexão estabelecida
     * @throws SQLException Se ocorrer um erro ao conectar com o banco de dados
     */
    public Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        }
        return connection;
    }
    
    /**
     * Fecha a conexão com o banco de dados de forma segura.
     */
    public void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Erro ao fechar conexão: " + e.getMessage());
            }
        }
    }
}

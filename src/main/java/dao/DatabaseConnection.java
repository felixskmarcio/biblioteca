// Este arquivo é responsável por gerenciar as conexões com o banco de dados.

package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Classe utilitária para gerenciar conexões com o banco de dados.
 */
public class DatabaseConnection {
    private static final String HOST = "localhost";
    private static final String PORT = "3306";
    private static final String DATABASE = "db_mobile";
    private static final String USER = "root";
    private static final String PASSWORD = "felixbr"; // Senha atualizada
    private static final String URL = "jdbc:mysql://" + HOST + ":" + PORT + "/" + DATABASE;
    
    /**
     * Obtém uma conexão com o banco de dados.
     * 
     * @return Objeto Connection representando a conexão estabelecida
     * @throws SQLException Se ocorrer um erro ao conectar com o banco de dados
     */
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver JDBC MySQL não encontrado", e);
        }
    }
    
    /**
     * Fecha a conexão com o banco de dados de forma segura.
     * 
     * @param connection A conexão a ser fechada
     */
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                System.err.println("Erro ao fechar conexão: " + e.getMessage());
            }
        }
    }
} 
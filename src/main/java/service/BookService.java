package service;

import dao.BookDAO;
import model.Book;

import java.util.List;

/**
 * Serviço responsável por gerenciar operações relacionadas a livros.
 * Implementa a lógica de negócio para cadastro, listagem e busca de livros.
 */
public class BookService {
    private BookDAO bookDAO;
    
    /**
     * Construtor padrão que inicializa o DAO de livros.
     */
    public BookService() {
        this.bookDAO = new BookDAO();
    }
    
    /**
     * Registra um novo livro no sistema.
     * 
     * @param book O objeto livro a ser registrado
     * @return true se o livro foi registrado com sucesso, false caso contrário
     */
    public boolean registerBook(Book book) {
        return bookDAO.insert(book);
    }
    
    /**
     * Retorna todos os livros cadastrados no sistema.
     * 
     * @return Lista com todos os livros
     */
    public List<Book> getAllBooks() {
        return bookDAO.findAll();
    }
    
    /**
     * Retorna livros com paginação.
     * 
     * @param page Número da página (começando de 1)
     * @param pageSize Quantidade de registros por página
     * @return Lista de livros para a página solicitada
     */
    public List<Book> getBooksWithPagination(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return bookDAO.findWithPagination(offset, pageSize);
    }
    
    /**
     * Realiza uma busca de livros por título, autor ou gênero.
     * 
     * @param query Termo de busca
     * @return Lista de livros que correspondem ao termo de busca
     */
    public List<Book> searchBooks(String query) {
        // Se a consulta for vazia, retorna todos os livros
        if (query == null || query.trim().isEmpty()) {
            return getAllBooks();
        }
        
        return bookDAO.search(query);
    }
    
    /**
     * Obtém um livro pelo seu ID.
     * 
     * @param id ID do livro
     * @return Livro encontrado ou null se não existir
     */
    public Book getBookById(int id) {
        return bookDAO.findById(id);
    }
    
    /**
     * Atualiza as informações de um livro.
     * 
     * @param book Livro com informações atualizadas
     * @return true se a atualização foi bem-sucedida, false caso contrário
     */
    public boolean updateBook(Book book) {
        return bookDAO.update(book);
    }
    
    /**
     * Remove um livro pelo seu ID.
     * 
     * @param id ID do livro a ser removido
     * @return true se a remoção foi bem-sucedida, false caso contrário
     */
    public boolean deleteBook(int id) {
        return bookDAO.delete(id);
    }
    
    /**
     * Retorna o total de livros cadastrados.
     * 
     * @return Número total de livros
     */
    public int getTotalBooks() {
        return bookDAO.count();
    }
    
    /**
     * Calcula o total de páginas para paginação.
     * 
     * @param pageSize Tamanho da página
     * @return Número total de páginas
     */
    public int getTotalPages(int pageSize) {
        int totalBooks = getTotalBooks();
        return (int) Math.ceil((double) totalBooks / pageSize);
    }
}

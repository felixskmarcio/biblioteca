package com.example.controller;

// Importações necessárias para o funcionamento do controlador
import com.example.model.Book; // Modelo de dados para livros
import com.example.service.BookService; // Serviço que gerencia operações com livros

// Importações do Java Servlet API para processamento de requisições web
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Controlador responsável por gerenciar as requisições relacionadas a livros.
 * Mapeia URLs para operações específicas como registro, listagem e busca de livros.
 */
@WebServlet(urlPatterns = {"/books/register", "/books/list", "/books/search"})
public class BookController extends HttpServlet {
    // Serviço que contém a lógica de negócio para operações com livros
    private BookService bookService;

    /**
     * Método de inicialização chamado quando o servlet é carregado.
     * Inicializa o serviço de livros.
     */
    @Override
    public void init() throws ServletException {
        this.bookService = new BookService(); // Cria uma nova instância do serviço
    }

    /**
     * Processa requisições POST, utilizadas para envio de formulários.
     * Atualmente, trata apenas o registro de novos livros.
     * 
     * @param request Objeto que contém os dados da requisição
     * @param response Objeto usado para enviar a resposta
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath(); // Obtém o caminho da requisição
        
        // Verifica se é uma requisição para registrar um novo livro
        if ("/books/register".equals(servletPath)) {
            // Extrai os parâmetros do formulário
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String isbn = request.getParameter("isbn");
            
            // Cria um novo objeto Book com os dados do formulário
            Book book = new Book(title, author, isbn);
            
            // Registra o livro usando o serviço
            bookService.registerBook(book);
            
            // Redireciona para a página de listagem após o registro
            response.sendRedirect(request.getContextPath() + "/books/list");
        }
    }

    /**
     * Processa requisições GET, utilizadas para exibir páginas e realizar buscas.
     * Trata três tipos de requisições: busca de livros, listagem de todos os livros e exibição do formulário de registro.
     * 
     * @param request Objeto que contém os dados da requisição
     * @param response Objeto usado para enviar a resposta
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String servletPath = request.getServletPath(); // Obtém o caminho da requisição
        
        // Verifica se é uma requisição de busca de livros
        if ("/books/search".equals(servletPath)) {
            // Extrai o termo de busca da requisição
            String query = request.getParameter("query");
            
            // Realiza a busca e adiciona os resultados como atributo da requisição
            request.setAttribute("books", bookService.searchBooks(query));
            
            // Encaminha para a página de resultados
            request.getRequestDispatcher("/WEB-INF/books/results.jsp").forward(request, response);
        } 
        // Verifica se é uma requisição para listar todos os livros
        else if ("/books/list".equals(servletPath)) {
            // Obtém todos os livros e adiciona como atributo da requisição
            request.setAttribute("books", bookService.getAllBooks());
            
            // Encaminha para a página de listagem
            request.getRequestDispatcher("/WEB-INF/books/list.jsp").forward(request, response);
        } 
        // Verifica se é uma requisição para exibir o formulário de registro
        else if ("/books/register".equals(servletPath)) {
            // Encaminha para a página de registro
            request.getRequestDispatcher("/WEB-INF/books/register.jsp").forward(request, response);
        }
    }
}
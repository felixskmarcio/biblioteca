package controller;

import model.Book;
import service.BookService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Servlet responsável por gerenciar as operações CRUD de livros.
 */
@WebServlet("/livros/*")
public class BookServlet extends HttpServlet {
    
    private BookService bookService;
    private SimpleDateFormat dateFormat;
    
    @Override
    public void init() throws ServletException {
        super.init();
        bookService = new BookService();
        dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    }
    
    /**
     * Método GET para listar e visualizar livros.
     * - /livros: lista todos os livros (com paginação)
     * - /livros?q=termo: busca livros pelo termo
     * - /livros/novo: exibe formulário para cadastro
     * - /livros/editar?id=X: exibe formulário para edição
     * - /livros/visualizar?id=X: exibe detalhes de um livro
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getPathInfo();
        if (action == null) {
            action = "/";
        }
        
        switch (action) {
            case "/novo":
                showNewForm(request, response);
                break;
            case "/editar":
                showEditForm(request, response);
                break;
            case "/visualizar":
                viewBook(request, response);
                break;
            case "/remover":
                deleteBook(request, response);
                break;
            default:
                listBooks(request, response);
                break;
        }
    }
    
    /**
     * Método POST para processar os formulários de livros.
     * - /livros/salvar: processa o formulário de cadastro/edição
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getPathInfo();
        if (action == null) {
            action = "/";
        }
        
        switch (action) {
            case "/salvar":
                saveBook(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/livros");
                break;
        }
    }
    
    /**
     * Exibe a lista de livros, com suporte a paginação e busca.
     */
    private void listBooks(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Parâmetros para paginação
        int page = 1;
        int recordsPerPage = 10;
        
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            }
        } catch (NumberFormatException e) {
            // Usa o valor padrão (page = 1)
        }
        
        // Verifica se há um termo de busca
        String searchTerm = request.getParameter("q");
        List<Book> books;
        int noOfRecords;
        int noOfPages;
        
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            // Realiza a busca
            books = bookService.searchBooks(searchTerm);
            noOfRecords = books.size();
            noOfPages = (int) Math.ceil((double) noOfRecords / recordsPerPage);
            
            // Para simplicidade, não aplicamos paginação no resultado da busca
            request.setAttribute("searchTerm", searchTerm);
        } else {
            // Lista com paginação
            books = bookService.getBooksWithPagination(page, recordsPerPage);
            noOfRecords = bookService.getTotalBooks();
            noOfPages = (int) Math.ceil((double) noOfRecords / recordsPerPage);
        }
        
        request.setAttribute("books", books);
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);
        request.getRequestDispatcher("/WEB-INF/views/livros/lista.jsp").forward(request, response);
    }
    
    /**
     * Exibe o formulário para cadastro de um novo livro.
     */
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/WEB-INF/views/livros/formulario.jsp").forward(request, response);
    }
    
    /**
     * Exibe o formulário para edição de um livro existente.
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Book book = bookService.getBookById(id);
            
            if (book != null) {
                request.setAttribute("book", book);
                request.getRequestDispatcher("/WEB-INF/views/livros/formulario.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Livro não encontrado");
                response.sendRedirect(request.getContextPath() + "/livros");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID inválido");
            response.sendRedirect(request.getContextPath() + "/livros");
        }
    }
    
    /**
     * Exibe os detalhes de um livro.
     */
    private void viewBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Book book = bookService.getBookById(id);
            
            if (book != null) {
                request.setAttribute("book", book);
                request.getRequestDispatcher("/WEB-INF/views/livros/visualizar.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Livro não encontrado");
                response.sendRedirect(request.getContextPath() + "/livros");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID inválido");
            response.sendRedirect(request.getContextPath() + "/livros");
        }
    }
    
    /**
     * Processa o formulário para salvar um livro (novo ou editado).
     */
    private void saveBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Recupera os dados do formulário
        String idParam = request.getParameter("id");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String isbn = request.getParameter("isbn");
        String publisher = request.getParameter("publisher");
        String publicationYearParam = request.getParameter("publicationYear");
        String genre = request.getParameter("genre");
        String totalQuantityParam = request.getParameter("totalQuantity");
        String availableQuantityParam = request.getParameter("availableQuantity");
        String acquisitionDateParam = request.getParameter("acquisitionDate");
        String location = request.getParameter("location");
        
        // Validação básica
        if (title == null || title.trim().isEmpty()) {
            request.setAttribute("errorMessage", "O título é obrigatório");
            request.getRequestDispatcher("/WEB-INF/views/livros/formulario.jsp").forward(request, response);
            return;
        }
        
        // Cria ou recupera o objeto livro
        Book book;
        boolean isNew = (idParam == null || idParam.trim().isEmpty());
        
        if (isNew) {
            book = new Book();
        } else {
            try {
                int id = Integer.parseInt(idParam);
                book = bookService.getBookById(id);
                
                if (book == null) {
                    request.setAttribute("errorMessage", "Livro não encontrado");
                    response.sendRedirect(request.getContextPath() + "/livros");
                    return;
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "ID inválido");
                response.sendRedirect(request.getContextPath() + "/livros");
                return;
            }
        }
        
        // Preenche os dados do livro
        book.setTitle(title);
        book.setAuthor(author);
        book.setIsbn(isbn);
        book.setPublisher(publisher);
        
        try {
            if (publicationYearParam != null && !publicationYearParam.trim().isEmpty()) {
                book.setPublicationYear(Integer.parseInt(publicationYearParam));
            }
        } catch (NumberFormatException e) {
            // Usa o valor existente ou mantém como 0
        }
        
        book.setGenre(genre);
        
        try {
            if (totalQuantityParam != null && !totalQuantityParam.trim().isEmpty()) {
                book.setTotalQuantity(Integer.parseInt(totalQuantityParam));
            }
        } catch (NumberFormatException e) {
            // Usa o valor existente ou mantém como 1
            if (isNew) book.setTotalQuantity(1);
        }
        
        try {
            if (availableQuantityParam != null && !availableQuantityParam.trim().isEmpty()) {
                book.setAvailableQuantity(Integer.parseInt(availableQuantityParam));
            }
        } catch (NumberFormatException e) {
            // Usa o valor existente ou mantém como 1
            if (isNew) book.setAvailableQuantity(1);
        }
        
        try {
            if (acquisitionDateParam != null && !acquisitionDateParam.trim().isEmpty()) {
                Date acquisitionDate = dateFormat.parse(acquisitionDateParam);
                book.setAcquisitionDate(acquisitionDate);
            }
        } catch (ParseException e) {
            // Usa o valor existente ou deixa como null
        }
        
        book.setLocation(location);
        
        // Salva o livro
        boolean success;
        if (isNew) {
            success = bookService.registerBook(book);
        } else {
            success = bookService.updateBook(book);
        }
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/livros");
        } else {
            request.setAttribute("errorMessage", "Erro ao salvar o livro");
            request.setAttribute("book", book);
            request.getRequestDispatcher("/WEB-INF/views/livros/formulario.jsp").forward(request, response);
        }
    }
    
    /**
     * Remove um livro pelo ID.
     */
    private void deleteBook(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean success = bookService.deleteBook(id);
            
            if (!success) {
                request.setAttribute("errorMessage", "Erro ao remover o livro");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "ID inválido");
        }
        
        response.sendRedirect(request.getContextPath() + "/livros");
    }
} 
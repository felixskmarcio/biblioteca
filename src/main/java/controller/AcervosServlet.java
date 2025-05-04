package controller;

import model.Book;
import dao.BookDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet responsável por gerenciar a página de Acervos.
 */
@WebServlet("/acervos")
public class AcervosServlet extends HttpServlet {
    
    private BookDAO bookDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        bookDAO = new BookDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Parâmetros para paginação
        int page = 1;
        int recordsPerPage = 12;
        
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                // Mantém o valor padrão (page = 1)
            }
        }
        
        // Verifica se há um termo de busca
        String searchTerm = request.getParameter("q");
        List<Book> books;
        int noOfRecords;
        int noOfPages;
        
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            // Realiza a busca
            books = bookDAO.search(searchTerm);
            noOfRecords = books.size();
        } else {
            // Lista com paginação
            int offset = (page - 1) * recordsPerPage;
            books = bookDAO.findWithPagination(offset, recordsPerPage);
            noOfRecords = bookDAO.count();
        }
        
        noOfPages = (int) Math.ceil((double) noOfRecords / recordsPerPage);
        
        // Define os atributos para uso nas tags JSTL
        request.setAttribute("books", books);
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("searchTerm", searchTerm);
        
        // Encaminha para a JSP
        request.getRequestDispatcher("/Acervos.jsp").forward(request, response);
    }
} 
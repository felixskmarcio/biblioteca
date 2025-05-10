package controller;

import dao.BookDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;

/**
 * Servlet responsável por processar a exclusão de múltiplos livros.
 */
@WebServlet("/livros/excluir-multiplos")
public class ExcluirMultiplosServlet extends HttpServlet {
    
    private BookDAO bookDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        bookDAO = new BookDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String[] bookIdsStr = request.getParameterValues("bookIds");
        String mensagem;
        int contador = 0;
        
        if (bookIdsStr != null && bookIdsStr.length > 0) {
            
            for (String idStr : bookIdsStr) {
                try {
                    int id = Integer.parseInt(idStr);
                    if (bookDAO.delete(id)) {
                        contador++;
                    }
                } catch (NumberFormatException e) {
                    // Ignora IDs inválidos
                }
            }
            
            if (contador > 0) {
                mensagem = contador + " livro(s) excluído(s) com sucesso.";
            } else {
                mensagem = "Não foi possível excluir os livros selecionados.";
            }
        } else {
            mensagem = "Nenhum livro selecionado para exclusão.";
        }
        
        // Adiciona a mensagem como atributo de flash para exibir na próxima página
        request.getSession().setAttribute("mensagem", mensagem);
        request.getSession().setAttribute("tipoAlerta", contador > 0 ? "success" : "danger");
        
        // Redireciona de volta para a página de livros
        response.sendRedirect(request.getContextPath() + "/livros");
    }
} 
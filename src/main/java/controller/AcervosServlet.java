package controller;

import model.Book;
import dao.BookDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
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
        
        // Em vez de encaminhar para JSP, geramos HTML diretamente
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html lang=\"pt-br\">");
            out.println("<head>");
            out.println("    <meta charset=\"UTF-8\">");
            out.println("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">");
            out.println("    <title>Acervo da Biblioteca</title>");
            out.println("    <link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css\">");
            out.println("    <link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css\">");
            // CSS inline
            out.println("    <style>");
            out.println("        .hero-section { background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('assets/images/library-bg.jpg'); background-size: cover; background-position: center; color: white; padding: 60px 0; margin-bottom: 30px; }");
            out.println("        .book-card { transition: transform 0.3s; height: 100%; }");
            out.println("        .book-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }");
            out.println("        .book-title { font-weight: 600; height: 48px; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; }");
            out.println("        .book-author { color: #6c757d; font-style: italic; height: 24px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis; }");
            out.println("        .filter-section { background-color: #f8f9fa; padding: 20px; border-radius: 5px; margin-bottom: 30px; }");
            out.println("    </style>");
            out.println("</head>");
            out.println("<body>");
            
            // Header/Navbar
            out.println("    <header class=\"bg-dark text-white\">");
            out.println("        <nav class=\"navbar navbar-expand-lg navbar-dark bg-dark\">");
            out.println("            <div class=\"container\">");
            out.println("                <a class=\"navbar-brand\" href=\"" + request.getContextPath() + "/\">Biblioteca Comunitária</a>");
            out.println("                <button class=\"navbar-toggler\" type=\"button\" data-bs-toggle=\"collapse\" data-bs-target=\"#navbarMain\">");
            out.println("                    <span class=\"navbar-toggler-icon\"></span>");
            out.println("                </button>");
            out.println("                <div class=\"collapse navbar-collapse\" id=\"navbarMain\">");
            out.println("                    <ul class=\"navbar-nav ms-auto\">");
            out.println("                        <li class=\"nav-item\">");
            out.println("                            <a class=\"nav-link\" href=\"" + request.getContextPath() + "/\">Início</a>");
            out.println("                        </li>");
            out.println("                        <li class=\"nav-item\">");
            out.println("                            <a class=\"nav-link active\" href=\"" + request.getContextPath() + "/acervos\">Acervo</a>");
            out.println("                        </li>");
            out.println("                        <li class=\"nav-item\">");
            out.println("                            <a class=\"nav-link\" href=\"" + request.getContextPath() + "/sobre\">Sobre</a>");
            out.println("                        </li>");
            out.println("                        <li class=\"nav-item\">");
            out.println("                            <a class=\"nav-link btn btn-primary text-white ms-2\" href=\"" + request.getContextPath() + "/login\">Login</a>");
            out.println("                        </li>");
            out.println("                    </ul>");
            out.println("                </div>");
            out.println("            </div>");
            out.println("        </nav>");
            out.println("    </header>");
            
            // Hero Section
            out.println("    <section class=\"hero-section\">");
            out.println("        <div class=\"container text-center\">");
            out.println("            <h1 class=\"display-5 mb-3\">Acervo da Biblioteca</h1>");
            out.println("            <p class=\"lead\">Explore nossa coleção de livros e encontre sua próxima leitura</p>");
            out.println("        </div>");
            out.println("    </section>");
            
            // Mensagem de Feedback
            String mensagem = (String) request.getSession().getAttribute("mensagem");
            String tipoAlerta = (String) request.getSession().getAttribute("tipoAlerta");
            
            if (mensagem != null && !mensagem.isEmpty()) {
                // Limpa os atributos da sessão após exibir a mensagem
                request.getSession().removeAttribute("mensagem");
                request.getSession().removeAttribute("tipoAlerta");
                
                out.println("    <div class=\"container mb-4\">");
                out.println("        <div class=\"alert alert-" + (tipoAlerta != null ? tipoAlerta : "info") + " alert-dismissible fade show\" role=\"alert\">");
                out.println("            " + mensagem);
                out.println("            <button type=\"button\" class=\"btn-close\" data-bs-dismiss=\"alert\" aria-label=\"Fechar\"></button>");
                out.println("        </div>");
                out.println("    </div>");
            }
            
            // Search and Filter Section
            out.println("    <section class=\"container filter-section\">");
            out.println("        <div class=\"row\">");
            out.println("            <div class=\"col-lg-6 offset-lg-3\">");
            out.println("                <form action=\"" + request.getContextPath() + "/acervos\" method=\"GET\" class=\"d-flex\">");
            out.println("                    <input type=\"text\" name=\"q\" class=\"form-control me-2\" placeholder=\"Pesquisar por título, autor ou gênero...\" value=\"" + (searchTerm != null ? searchTerm : "") + "\">");
            out.println("                    <button type=\"submit\" class=\"btn btn-primary\">");
            out.println("                        <i class=\"bi bi-search\"></i> Buscar");
            out.println("                    </button>");
            out.println("                </form>");
            out.println("            </div>");
            out.println("        </div>");
            out.println("    </section>");
            
            // Books Grid
            out.println("    <section class=\"container mb-5\">");
            out.println("        <div class=\"row mb-4\">");
            out.println("            <div class=\"col-12 d-flex justify-content-between align-items-center\">");
            out.println("                <h2 class=\"mb-0\">");
            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                out.println("                    Resultados para: \"" + searchTerm + "\"");
            } else {
                out.println("                    Nosso Acervo");
            }
            out.println("                </h2>");
            out.println("                <button type=\"button\" id=\"btnExcluirSelecionados\" class=\"btn btn-danger\" style=\"display: none;\" onclick=\"confirmarExclusao()\">");
            out.println("                    <i class=\"bi bi-trash\"></i> Excluir Selecionados");
            out.println("                </button>");
            out.println("            </div>");
            out.println("        </div>");
            
            out.println("        <form id=\"formExclusao\" action=\"" + request.getContextPath() + "/livros/excluir-multiplos\" method=\"POST\">");
            out.println("        <div class=\"row g-4\">");
            if (books == null || books.isEmpty()) {
                out.println("            <div class=\"col-12 text-center py-5\">");
                out.println("                <i class=\"bi bi-search display-1 text-muted\"></i>");
                out.println("                <h3 class=\"mt-4\">Nenhum livro encontrado</h3>");
                out.println("                <p class=\"text-muted\">Tente uma busca diferente ou explore nosso acervo completo.</p>");
                out.println("            </div>");
            } else {
                for (Book book : books) {
                    out.println("            <div class=\"col-md-6 col-lg-4 col-xl-3\">");
                    out.println("                <div class=\"card book-card\">");
                    out.println("                    <div class=\"card-body\">");
                    out.println("                        <div class=\"form-check mb-2\">");
                    out.println("                            <input class=\"form-check-input book-checkbox\" type=\"checkbox\" name=\"bookIds\" value=\"" + book.getId() + "\" onchange=\"verificarSelecionados()\">");
                    out.println("                        </div>");
                    out.println("                        <h5 class=\"card-title book-title\">" + book.getTitle() + "</h5>");
                    out.println("                        <p class=\"card-text book-author\">" + book.getAuthor() + "</p>");
                    out.println("                        <div class=\"d-flex justify-content-between align-items-center mt-3\">");
                    out.println("                            <span class=\"badge bg-info\">" + book.getGenre() + "</span>");
                    out.println("                            <small class=\"text-muted\">" + book.getPublicationYear() + "</small>");
                    out.println("                        </div>");
                    out.println("                        <hr>");
                    out.println("                        <div class=\"d-flex justify-content-between\">");
                    out.println("                            <span class=\"badge " + (book.getAvailableQuantity() > 0 ? "bg-success" : "bg-danger") + "\">");
                    out.println("                                " + (book.getAvailableQuantity() > 0 ? "Disponível" : "Indisponível"));
                    out.println("                            </span>");
                    out.println("                            <a href=\"" + request.getContextPath() + "/livros/visualizar?id=" + book.getId() + "\" class=\"btn btn-sm btn-outline-primary\">");
                    out.println("                                Detalhes");
                    out.println("                            </a>");
                    out.println("                        </div>");
                    out.println("                    </div>");
                    out.println("                </div>");
                    out.println("            </div>");
                }
            }
            out.println("        </div>");
            out.println("        </form>");
            
            // Pagination
            if (searchTerm == null || searchTerm.trim().isEmpty()) {
                if (noOfPages > 1) {
                    out.println("        <nav aria-label=\"Navegação de páginas\" class=\"mt-5\">");
                    out.println("            <ul class=\"pagination justify-content-center\">");
                    out.println("                <li class=\"page-item " + (page == 1 ? "disabled" : "") + "\">");
                    out.println("                    <a class=\"page-link\" href=\"" + request.getContextPath() + "/acervos?page=" + (page - 1) + "\" aria-label=\"Anterior\">");
                    out.println("                        <span aria-hidden=\"true\">&laquo;</span>");
                    out.println("                    </a>");
                    out.println("                </li>");
                    
                    for (int i = 1; i <= noOfPages; i++) {
                        out.println("                <li class=\"page-item " + (page == i ? "active" : "") + "\">");
                        out.println("                    <a class=\"page-link\" href=\"" + request.getContextPath() + "/acervos?page=" + i + "\">" + i + "</a>");
                        out.println("                </li>");
                    }
                    
                    out.println("                <li class=\"page-item " + (page == noOfPages ? "disabled" : "") + "\">");
                    out.println("                    <a class=\"page-link\" href=\"" + request.getContextPath() + "/acervos?page=" + (page + 1) + "\" aria-label=\"Próximo\">");
                    out.println("                        <span aria-hidden=\"true\">&raquo;</span>");
                    out.println("                    </a>");
                    out.println("                </li>");
                    out.println("            </ul>");
                    out.println("        </nav>");
                }
            }
            out.println("    </section>");
            
            // Footer
            out.println("    <footer class=\"bg-dark text-white py-4 mt-5\">");
            out.println("        <div class=\"container\">");
            out.println("            <div class=\"row\">");
            out.println("                <div class=\"col-md-4 mb-3\">");
            out.println("                    <h5>Biblioteca Comunitária</h5>");
            out.println("                    <p class=\"text-muted\">Promovendo acesso à leitura e cultura para todos.</p>");
            out.println("                    <p class=\"mb-0\"><i class=\"bi bi-envelope\"></i> felixskmarcio2@gmail.com</p>");
            out.println("                    <p><i class=\"bi bi-telephone\"></i> (82) 9.982748-81</p>");
            out.println("                </div>");
            out.println("                <div class=\"col-md-4 mb-3\">");
            out.println("                    <h5>Links Rápidos</h5>");
            out.println("                    <ul class=\"list-unstyled\">");
            out.println("                        <li><a href=\"" + request.getContextPath() + "/\" class=\"text-decoration-none text-light\">Início</a></li>");
            out.println("                        <li><a href=\"" + request.getContextPath() + "/acervos\" class=\"text-decoration-none text-light\">Acervo</a></li>");
            out.println("                        <li><a href=\"" + request.getContextPath() + "/cadastro\" class=\"text-decoration-none text-light\">Cadastro</a></li>");
            out.println("                        <li><a href=\"" + request.getContextPath() + "/sobre\" class=\"text-decoration-none text-light\">Sobre</a></li>");
            out.println("                    </ul>");
            out.println("                </div>");
            out.println("                <div class=\"col-md-4 mb-3\">");
            out.println("                    <h5>Horário de Funcionamento</h5>");
            out.println("                    <p class=\"mb-1\">Segunda a Sexta: 09h às 18h</p>");
            out.println("                    <p class=\"mb-1\">Sábado: 09h às 13h</p>");
            out.println("                    <p>Domingo: Fechado</p>");
            out.println("                </div>");
            out.println("            </div>");
            out.println("            <hr>");
            out.println("            <div class=\"row\">");
            out.println("                <div class=\"col-md-6 text-center text-md-start\">");
            out.println("                    <p class=\"mb-0\">&copy; 2025 Biblioteca Comunitária. Todos os direitos reservados.</p>");
            out.println("                </div>");
            out.println("                <div class=\"col-md-6 text-center text-md-end\">");
            out.println("                    <a href=\"#\" class=\"text-light me-2\"><i class=\"bi bi-facebook\"></i></a>");
            out.println("                    <a href=\"#\" class=\"text-light me-2\"><i class=\"bi bi-twitter\"></i></a>");
            out.println("                    <a href=\"#\" class=\"text-light me-2\"><i class=\"bi bi-instagram\"></i></a>");
            out.println("                </div>");
            out.println("            </div>");
            out.println("        </div>");
            out.println("    </footer>");
            
            out.println("    <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js\"></script>");
            
            // JavaScript para gerenciar seleção e exclusão
            out.println("    <script>");
            out.println("        function verificarSelecionados() {");
            out.println("            const checkboxes = document.querySelectorAll('.book-checkbox:checked');");
            out.println("            const btnExcluir = document.getElementById('btnExcluirSelecionados');");
            out.println("            ");
            out.println("            if (checkboxes.length > 0) {");
            out.println("                btnExcluir.style.display = 'block';");
            out.println("            } else {");
            out.println("                btnExcluir.style.display = 'none';");
            out.println("            }");
            out.println("        }");
            out.println("        ");
            out.println("        function confirmarExclusao() {");
            out.println("            const checkboxes = document.querySelectorAll('.book-checkbox:checked');");
            out.println("            const quantidade = checkboxes.length;");
            out.println("            ");
            out.println("            if (confirm(`Tem certeza que deseja excluir ${quantidade} livro(s) do acervo? Esta ação não pode ser desfeita.`)) {");
            out.println("                document.getElementById('formExclusao').submit();");
            out.println("            }");
            out.println("        }");
            out.println("    </script>");
            
            out.println("</body>");
            out.println("</html>");
        }
    }
} 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Livros da Biblioteca</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('assets/images/library-bg.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 60px 0;
            margin-bottom: 30px;
        }
        
        .book-card {
            transition: transform 0.3s;
            height: 100%;
        }
        
        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        
        .book-title {
            font-weight: 600;
            height: 48px;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
        
        .book-author {
            color: #6c757d;
            font-style: italic;
            height: 24px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }
        
        .filter-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <!-- Header/Navbar -->
    <header class="bg-dark text-white">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/">Biblioteca Comunitária</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarMain">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/">Início</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/livros">Livros</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/sobre">Sobre</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link btn btn-primary text-white ms-2" href="${pageContext.request.contextPath}/login">Login</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>
    
    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container text-center">
            <h1 class="display-5 mb-3">Livros da Biblioteca</h1>
            <p class="lead">Explore nossa coleção de livros e encontre sua próxima leitura</p>
        </div>
    </section>
    
    <!-- Mensagem de Feedback -->
    <% 
    String mensagem = (String) session.getAttribute("mensagem");
    String tipoAlerta = (String) session.getAttribute("tipoAlerta");
    
    if (mensagem != null && !mensagem.isEmpty()) {
        // Limpa os atributos da sessão após exibir a mensagem
        session.removeAttribute("mensagem");
        session.removeAttribute("tipoAlerta");
    %>
    <div class="container mb-4">
        <div class="alert alert-<%= tipoAlerta != null ? tipoAlerta : "info" %> alert-dismissible fade show" role="alert">
            <%= mensagem %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fechar"></button>
        </div>
    </div>
    <% } %>
    
    <!-- Search and Filter Section -->
    <section class="container filter-section">
        <div class="row">
            <div class="col-lg-6 offset-lg-3">
                <form action="${pageContext.request.contextPath}/livros" method="GET" class="d-flex">
                    <input type="text" name="q" class="form-control me-2" placeholder="Pesquisar por título, autor ou gênero..." value="${searchTerm}">
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-search"></i> Buscar
                    </button>
                </form>
            </div>
        </div>
    </section>
    
    <!-- Books Grid -->
    <section class="container mb-5">
        <div class="row mb-4">
            <div class="col-12 d-flex justify-content-between align-items-center">
                <h2 class="mb-0">
                    <% if (request.getAttribute("searchTerm") != null && !request.getAttribute("searchTerm").toString().isEmpty()) { %>
                        Resultados para: "${searchTerm}"
                    <% } else { %>
                        Nossos Livros
                    <% } %>
                </h2>
                <div>
                    <button type="button" class="btn btn-success me-2" data-bs-toggle="collapse" data-bs-target="#formCadastroLivro" aria-expanded="false" aria-controls="formCadastroLivro">
                        <i class="bi bi-plus-circle"></i> Cadastrar Livro
                    </button>
                    <button type="button" id="btnExcluirSelecionados" class="btn btn-danger" style="display: none;" onclick="confirmarExclusao()">
                        <i class="bi bi-trash"></i> Excluir Selecionados
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Formulário de Cadastro Colapsável -->
        <div class="collapse mb-4" id="formCadastroLivro">
            <div class="card">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0">Cadastrar Novo Livro</h5>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/processarCadastroLivro.jsp" method="POST">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="title" class="form-label">Título*</label>
                                <input type="text" class="form-control" id="title" name="title" required>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label for="author" class="form-label">Autor*</label>
                                <input type="text" class="form-control" id="author" name="author" required>
                            </div>
                        </div>
                        
                        <!-- Campos ocultos com valores padrão -->
                        <input type="hidden" name="isbn" value="N/A">
                        <input type="hidden" name="totalQuantity" value="1">
                        <input type="hidden" name="availableQuantity" value="1">
                        
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-3">
                            <button type="button" class="btn btn-outline-secondary me-md-2" data-bs-toggle="collapse" data-bs-target="#formCadastroLivro">
                                Cancelar
                            </button>
                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-save"></i> Salvar Livro
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <form id="formExclusao" action="${pageContext.request.contextPath}/livros/excluir-multiplos" method="POST">
            <div class="row g-4">
                <% 
                java.util.List<model.Book> books = (java.util.List<model.Book>)request.getAttribute("books");
                if (books == null || books.isEmpty()) { 
                %>
                    <div class="col-12 text-center py-5">
                        <i class="bi bi-search display-1 text-muted"></i>
                        <h3 class="mt-4">Nenhum livro encontrado</h3>
                        <p class="text-muted">Tente uma busca diferente ou explore nossa coleção completa de livros.</p>
                    </div>
                <% } else { 
                    for (model.Book book : books) { 
                %>
                    <div class="col-md-6 col-lg-4 col-xl-3">
                        <div class="card book-card">
                            <div class="card-body">
                                <div class="form-check mb-2">
                                    <input class="form-check-input book-checkbox" type="checkbox" name="bookIds" value="<%= book.getId() %>" onchange="verificarSelecionados()">
                                </div>
                                <h5 class="card-title book-title"><%= book.getTitle() %></h5>
                                <p class="card-text book-author"><%= book.getAuthor() %></p>
                                <div class="d-flex justify-content-between">
                                    <a href="${pageContext.request.contextPath}/livros/visualizar?id=<%= book.getId() %>" class="btn btn-sm btn-outline-primary">
                                        Detalhes
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                <% 
                    }
                } 
                %>
            </div>
        </form>
        
        <!-- Pagination -->
        <% 
        String searchTerm = (String)request.getAttribute("searchTerm");
        Integer noOfPages = (Integer)request.getAttribute("noOfPages");
        Integer currentPage = (Integer)request.getAttribute("currentPage");
        if ((searchTerm == null || searchTerm.isEmpty()) && noOfPages != null && noOfPages > 1) { 
        %>
            <nav aria-label="Navegação de páginas" class="mt-5">
                <ul class="pagination justify-content-center">
                    <li class="page-item <%= (currentPage == 1) ? "disabled" : "" %>">
                        <a class="page-link" href="${pageContext.request.contextPath}/livros?page=<%= currentPage - 1 %>" aria-label="Anterior">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    
                    <% for (int i = 1; i <= noOfPages; i++) { %>
                        <li class="page-item <%= (currentPage == i) ? "active" : "" %>">
                            <a class="page-link" href="${pageContext.request.contextPath}/livros?page=<%= i %>"><%= i %></a>
                        </li>
                    <% } %>
                    
                    <li class="page-item <%= (currentPage == noOfPages) ? "disabled" : "" %>">
                        <a class="page-link" href="${pageContext.request.contextPath}/livros?page=<%= currentPage + 1 %>" aria-label="Próximo">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
        <% } %>
    </section>
    
    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-3">
                    <h5>Biblioteca Comunitária</h5>
                    <p class="text-muted">Promovendo acesso à leitura e cultura para todos.</p>
                    <p class="mb-0"><i class="bi bi-envelope"></i> felixskmarcio2@gmail.com</p>
                    <p><i class="bi bi-telephone"></i> (82) 9.982748-81</p>
                </div>
                <div class="col-md-4 mb-3">
                    <h5>Links Rápidos</h5>
                    <ul class="list-unstyled">
                        <li><a href="${pageContext.request.contextPath}/" class="text-decoration-none text-light">Início</a></li>
                        <li><a href="${pageContext.request.contextPath}/livros" class="text-decoration-none text-light">Livros</a></li>
                        <li><a href="${pageContext.request.contextPath}/cadastro" class="text-decoration-none text-light">Cadastro</a></li>
                        <li><a href="${pageContext.request.contextPath}/sobre" class="text-decoration-none text-light">Sobre</a></li>
                    </ul>
                </div>
                <div class="col-md-4 mb-3">
                    <h5>Horário de Funcionamento</h5>
                    <p class="mb-1">Segunda a Sexta: 09h às 18h</p>
                    <p class="mb-1">Sábado: 09h às 13h</p>
                    <p>Domingo: Fechado</p>
                </div>
            </div>
            <hr>
            <div class="row">
                <div class="col-md-6 text-center text-md-start">
                    <p class="mb-0">&copy; 2025 Biblioteca Comunitária. Todos os direitos reservados.</p>
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <a href="#" class="text-light me-2"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="text-light me-2"><i class="bi bi-twitter"></i></a>
                    <a href="#" class="text-light me-2"><i class="bi bi-instagram"></i></a>
                </div>
            </div>
        </div>
    </footer>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- JavaScript para gerenciar seleção e exclusão -->
    <script>
        function verificarSelecionados() {
            const checkboxes = document.querySelectorAll('.book-checkbox:checked');
            const btnExcluir = document.getElementById('btnExcluirSelecionados');
            
            if (checkboxes.length > 0) {
                btnExcluir.style.display = 'block';
            } else {
                btnExcluir.style.display = 'none';
            }
        }
        
        function confirmarExclusao() {
            const checkboxes = document.querySelectorAll('.book-checkbox:checked');
            const quantidade = checkboxes.length;
            
            if (confirm(`Tem certeza que deseja excluir ${quantidade} livro(s) da biblioteca? Esta ação não pode ser desfeita.`)) {
                document.getElementById('formExclusao').submit();
            }
        }
    </script>
</body>
</html> 
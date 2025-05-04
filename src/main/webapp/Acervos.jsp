<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acervo da Biblioteca</title>
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
                            <a class="nav-link active" href="${pageContext.request.contextPath}/acervos">Acervo</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/emprestimos">Empréstimos</a>
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
            <h1 class="display-5 mb-3">Acervo da Biblioteca</h1>
            <p class="lead">Explore nossa coleção de livros e encontre sua próxima leitura</p>
        </div>
    </section>
    
    <!-- Search and Filter Section -->
    <section class="container filter-section">
        <div class="row">
            <div class="col-lg-6 offset-lg-3">
                <form action="${pageContext.request.contextPath}/acervos" method="GET" class="d-flex">
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
            <div class="col-12">
                <h2 class="mb-4">
                    <% if (request.getAttribute("searchTerm") != null && !request.getAttribute("searchTerm").toString().isEmpty()) { %>
                        Resultados para: "${searchTerm}"
                    <% } else { %>
                        Nosso Acervo
                    <% } %>
                </h2>
            </div>
        </div>
        
        <div class="row g-4">
            <% 
            java.util.List<model.Book> books = (java.util.List<model.Book>)request.getAttribute("books");
            if (books == null || books.isEmpty()) { 
            %>
                <div class="col-12 text-center py-5">
                    <i class="bi bi-search display-1 text-muted"></i>
                    <h3 class="mt-4">Nenhum livro encontrado</h3>
                    <p class="text-muted">Tente uma busca diferente ou explore nosso acervo completo.</p>
                </div>
            <% } else { 
                for (model.Book book : books) { 
            %>
                <div class="col-md-6 col-lg-4 col-xl-3">
                    <div class="card book-card">
                        <div class="card-body">
                            <h5 class="card-title book-title"><%= book.getTitle() %></h5>
                            <p class="card-text book-author"><%= book.getAuthor() %></p>
                            <div class="d-flex justify-content-between align-items-center mt-3">
                                <span class="badge bg-info"><%= book.getGenre() %></span>
                                <small class="text-muted"><%= book.getPublicationYear() %></small>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between">
                                <span class="badge <%= book.getAvailableQuantity() > 0 ? "bg-success" : "bg-danger" %>">
                                    <%= book.getAvailableQuantity() > 0 ? "Disponível" : "Indisponível" %>
                                </span>
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
                        <a class="page-link" href="${pageContext.request.contextPath}/acervos?page=<%= currentPage - 1 %>" aria-label="Anterior">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    
                    <% for (int i = 1; i <= noOfPages; i++) { %>
                        <li class="page-item <%= (currentPage == i) ? "active" : "" %>">
                            <a class="page-link" href="${pageContext.request.contextPath}/acervos?page=<%= i %>"><%= i %></a>
                        </li>
                    <% } %>
                    
                    <li class="page-item <%= (currentPage == noOfPages) ? "disabled" : "" %>">
                        <a class="page-link" href="${pageContext.request.contextPath}/acervos?page=<%= currentPage + 1 %>" aria-label="Próximo">
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
                        <li><a href="${pageContext.request.contextPath}/acervos" class="text-decoration-none text-light">Acervo</a></li>
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
</body>
</html> 
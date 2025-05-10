<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Livros - Biblioteca Comunitária</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('${pageContext.request.contextPath}/assets/images/library-bg.jpg');
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
            <h1 class="display-5 mb-3">Lista de Livros</h1>
            <p class="lead">Gerencie os livros da biblioteca</p>
        </div>
    </section>
    
    <!-- Mensagem de Feedback -->
    <c:if test="${not empty errorMessage}">
        <div class="container mb-4">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fechar"></button>
            </div>
        </div>
    </c:if>
    
    <!-- Books List -->
    <section class="container mb-5">
        <div class="row mb-4">
            <div class="col-12 d-flex justify-content-between align-items-center">
                <h2 class="mb-0">
                    <c:if test="${not empty searchTerm}">
                        Resultados para: "${searchTerm}"
                    </c:if>
                    <c:if test="${empty searchTerm}">
                        Nossos Livros
                    </c:if>
                </h2>
                <div>
                    <a href="${pageContext.request.contextPath}/livros/novo" class="btn btn-success me-2">
                        <i class="bi bi-plus-circle"></i> Novo Livro
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Search Form -->
        <div class="row mb-4">
            <div class="col-lg-6 offset-lg-3">
                <form action="${pageContext.request.contextPath}/livros" method="GET" class="d-flex">
                    <input type="text" name="q" class="form-control me-2" placeholder="Pesquisar por título, autor ou gênero..." value="${searchTerm}">
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-search"></i> Buscar
                    </button>
                </form>
            </div>
        </div>
        
        <!-- Books Table -->
        <div class="card shadow-sm">
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty books}">
                        <div class="alert alert-info">
                            Nenhum livro encontrado. <a href="${pageContext.request.contextPath}/livros/novo" class="alert-link">Cadastre um livro agora</a>.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>Título</th>
                                        <th>Autor</th>
                                        <th>ISBN</th>
                                        <th>Quantidade</th>
                                        <th>Disponíveis</th>
                                        <th>Ações</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="book" items="${books}">
                                        <tr>
                                            <td>${book.title}</td>
                                            <td>${book.author}</td>
                                            <td>${book.isbn}</td>
                                            <td>${book.totalQuantity}</td>
                                            <td>
                                                <span class="badge ${book.availableQuantity > 0 ? 'bg-success' : 'bg-danger'}">
                                                    ${book.availableQuantity} ${book.availableQuantity > 1 ? 'exemplares' : 'exemplar'}
                                                </span>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/livros/visualizar?id=${book.id}" class="btn btn-sm btn-outline-primary">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/livros/editar?id=${book.id}" class="btn btn-sm btn-outline-secondary">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/livros/remover?id=${book.id}" class="btn btn-sm btn-outline-danger" 
                                                   onclick="return confirm('Tem certeza que deseja excluir este livro?');">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <!-- Pagination -->
                        <c:if test="${noOfPages > 1}">
                            <nav aria-label="Navegação da paginação">
                                <ul class="pagination justify-content-center mt-4">
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/livros?page=${currentPage - 1}" aria-label="Anterior">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    
                                    <c:forEach begin="1" end="${noOfPages}" var="i">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link" href="${pageContext.request.contextPath}/livros?page=${i}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    
                                    <li class="page-item ${currentPage == noOfPages ? 'disabled' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/livros?page=${currentPage + 1}" aria-label="Próximo">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
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
</body>
</html> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${book.title} - Biblioteca Comunitária</title>
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
        
        .book-info .label {
            font-weight: bold;
            color: #495057;
        }
        
        .book-actions {
            margin-top: 2rem;
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
            <h1 class="display-5 mb-3">${book.title}</h1>
            <p class="lead">por ${book.author}</p>
        </div>
    </section>
    
    <!-- Book Details Section -->
    <section class="container mb-5">
        <div class="row">
            <div class="col-lg-8 offset-lg-2">
                <div class="card shadow-sm">
                    <div class="card-body p-4">
                        <div class="row book-info">
                            <div class="col-md-6 mb-4">
                                <p><span class="label">ISBN:</span> ${book.isbn}</p>
                                <p><span class="label">Editora:</span> ${not empty book.publisher ? book.publisher : 'Não informado'}</p>
                                <p><span class="label">Ano de Publicação:</span> ${book.publicationYear > 0 ? book.publicationYear : 'Não informado'}</p>
                                <p><span class="label">Gênero:</span> ${not empty book.genre ? book.genre : 'Não informado'}</p>
                            </div>
                            <div class="col-md-6 mb-4">
                                <p><span class="label">Quantidade Total:</span> ${book.totalQuantity}</p>
                                <p><span class="label">Disponíveis:</span> 
                                    <span class="badge ${book.availableQuantity > 0 ? 'bg-success' : 'bg-danger'}">
                                        ${book.availableQuantity} ${book.availableQuantity > 1 ? 'exemplares' : 'exemplar'}
                                    </span>
                                </p>
                                <p><span class="label">Data de Aquisição:</span> 
                                    <c:if test="${not empty book.acquisitionDate}">
                                        <fmt:formatDate value="${book.acquisitionDate}" pattern="dd/MM/yyyy"/>
                                    </c:if>
                                    <c:if test="${empty book.acquisitionDate}">
                                        Não informado
                                    </c:if>
                                </p>
                                <p><span class="label">Localização:</span> ${not empty book.location ? book.location : 'Não informado'}</p>
                            </div>
                        </div>
                        
                        <div class="book-actions d-flex justify-content-between">
                            <div>
                                <a href="${pageContext.request.contextPath}/livros" class="btn btn-outline-secondary">
                                    <i class="bi bi-arrow-left"></i> Voltar aos Livros
                                </a>
                            </div>
                            <div>
                                <a href="${pageContext.request.contextPath}/livros/editar?id=${book.id}" class="btn btn-outline-primary me-2">
                                    <i class="bi bi-pencil"></i> Editar
                                </a>
                                <a href="${pageContext.request.contextPath}/livros/remover?id=${book.id}" class="btn btn-outline-danger"
                                   onclick="return confirm('Tem certeza que deseja remover este livro?');">
                                    <i class="bi bi-trash"></i> Excluir
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
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
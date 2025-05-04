<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty book.id ? 'Cadastrar' : 'Editar'} Livro - Biblioteca Comunitária</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('${pageContext.request.contextPath}/assets/images/library-bg.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 40px 0;
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
            <h1 class="display-5 mb-3">${empty book.id ? 'Cadastrar Novo Livro' : 'Editar Livro'}</h1>
            <p class="lead">Preencha o formulário abaixo com os dados do livro</p>
        </div>
    </section>
    
    <!-- Form Section -->
    <section class="container mb-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow-sm">
                    <div class="card-body p-4">
                        <form action="${pageContext.request.contextPath}/processarCadastroLivro.jsp" method="POST">
                            <c:if test="${not empty book.id}">
                                <input type="hidden" name="id" value="${book.id}">
                            </c:if>
                            
                            <div class="mb-3">
                                <label for="title" class="form-label">Título*</label>
                                <input type="text" class="form-control" id="title" name="title" value="${book.title}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="author" class="form-label">Autor*</label>
                                <input type="text" class="form-control" id="author" name="author" value="${book.author}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="isbn" class="form-label">ISBN*</label>
                                <input type="text" class="form-control" id="isbn" name="isbn" value="${book.isbn}" required>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="publisher" class="form-label">Editora</label>
                                    <input type="text" class="form-control" id="publisher" name="publisher" value="${book.publisher}">
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="publicationYear" class="form-label">Ano de Publicação</label>
                                    <input type="number" class="form-control" id="publicationYear" name="publicationYear" min="1000" max="2099" value="${book.publicationYear}">
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="genre" class="form-label">Gênero</label>
                                <input type="text" class="form-control" id="genre" name="genre" value="${book.genre}">
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="totalQuantity" class="form-label">Quantidade Total*</label>
                                    <input type="number" class="form-control" id="totalQuantity" name="totalQuantity" min="1" value="${empty book.totalQuantity ? '1' : book.totalQuantity}" required>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="availableQuantity" class="form-label">Quantidade Disponível*</label>
                                    <input type="number" class="form-control" id="availableQuantity" name="availableQuantity" min="0" value="${empty book.availableQuantity ? '1' : book.availableQuantity}" required>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="acquisitionDate" class="form-label">Data de Aquisição</label>
                                    <input type="date" class="form-control" id="acquisitionDate" name="acquisitionDate" value="${book.acquisitionDate}">
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label for="location" class="form-label">Localização na Biblioteca</label>
                                    <input type="text" class="form-control" id="location" name="location" value="${book.location}" placeholder="Ex: Estante A, Prateleira 3">
                                </div>
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                <a href="${pageContext.request.contextPath}/acervos" class="btn btn-outline-secondary me-md-2">Cancelar</a>
                                <button type="submit" class="btn btn-primary">Salvar</button>
                            </div>
                        </form>
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
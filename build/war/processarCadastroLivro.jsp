<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.BookDAO" %>
<%@ page import="model.Book" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Livro Processado - Biblioteca Comunitária</title>
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
    </style>
</head>
<body>
    <%
        // Recuperar os dados do formulário
        String idStr = request.getParameter("id");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String isbn = request.getParameter("isbn");
        String publisher = request.getParameter("publisher");
        String publicationYearStr = request.getParameter("publicationYear");
        String genre = request.getParameter("genre");
        String totalQuantityStr = request.getParameter("totalQuantity");
        String availableQuantityStr = request.getParameter("availableQuantity");
        String acquisitionDateStr = request.getParameter("acquisitionDate");
        String location = request.getParameter("location");
        
        // Validar os dados obrigatórios
        boolean isValid = title != null && !title.trim().isEmpty() 
                       && author != null && !author.trim().isEmpty()
                       && isbn != null && !isbn.trim().isEmpty();
        
        // Criar um objeto Book
        Book book = new Book();
        if (idStr != null && !idStr.trim().isEmpty()) {
            try {
                book.setId(Integer.parseInt(idStr));
            } catch (NumberFormatException e) {
                // Ignora se o ID não for um número válido
            }
        }
        
        book.setTitle(title);
        book.setAuthor(author);
        book.setIsbn(isbn);
        book.setPublisher(publisher);
        
        if (publicationYearStr != null && !publicationYearStr.trim().isEmpty()) {
            try {
                book.setPublicationYear(Integer.parseInt(publicationYearStr));
            } catch (NumberFormatException e) {
                // Ignora se o ano não for um número válido
            }
        }
        
        book.setGenre(genre);
        
        if (totalQuantityStr != null && !totalQuantityStr.trim().isEmpty()) {
            try {
                book.setTotalQuantity(Integer.parseInt(totalQuantityStr));
            } catch (NumberFormatException e) {
                book.setTotalQuantity(1); // Valor padrão
            }
        } else {
            book.setTotalQuantity(1); // Valor padrão
        }
        
        if (availableQuantityStr != null && !availableQuantityStr.trim().isEmpty()) {
            try {
                book.setAvailableQuantity(Integer.parseInt(availableQuantityStr));
            } catch (NumberFormatException e) {
                book.setAvailableQuantity(1); // Valor padrão
            }
        } else {
            book.setAvailableQuantity(1); // Valor padrão
        }
        
        if (acquisitionDateStr != null && !acquisitionDateStr.trim().isEmpty()) {
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date acquisitionDate = sdf.parse(acquisitionDateStr);
                book.setAcquisitionDate(acquisitionDate);
            } catch (Exception e) {
                // Ignora se a data não for válida
            }
        }
        
        book.setLocation(location);
        
        // Salvar o livro no banco de dados
        boolean success = false;
        String message = "";
        
        if (isValid) {
            BookDAO bookDAO = new BookDAO();
            
            if (book.getId() > 0) {
                // Atualização
                success = bookDAO.update(book);
                message = success ? "Livro atualizado com sucesso!" : "Erro ao atualizar o livro.";
            } else {
                // Inserção
                success = bookDAO.insert(book);
                message = success ? "Livro cadastrado com sucesso!" : "Erro ao cadastrar o livro.";
            }
        } else {
            message = "Dados obrigatórios não informados.";
        }
        
        // Definir atributos para uso na página JSP
        request.setAttribute("success", success);
        request.setAttribute("message", message);
        request.setAttribute("book", book);
    %>
    
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
            <h1 class="display-5 mb-3">Processamento de Livro</h1>
            <p class="lead">${message}</p>
        </div>
    </section>
    
    <!-- Result Section -->
    <section class="container mb-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow-sm">
                    <div class="card-body p-4">
                        <c:choose>
                            <c:when test="${success}">
                                <div class="alert alert-success mb-4" role="alert">
                                    <i class="bi bi-check-circle-fill me-2"></i> ${message}
                                </div>
                                
                                <h4 class="mb-3">Dados do Livro:</h4>
                                <ul class="list-group mb-4">
                                    <li class="list-group-item"><strong>Título:</strong> ${book.title}</li>
                                    <li class="list-group-item"><strong>Autor:</strong> ${book.author}</li>
                                    <li class="list-group-item"><strong>ISBN:</strong> ${book.isbn}</li>
                                    <c:if test="${not empty book.publisher}">
                                        <li class="list-group-item"><strong>Editora:</strong> ${book.publisher}</li>
                                    </c:if>
                                    <c:if test="${book.publicationYear > 0}">
                                        <li class="list-group-item"><strong>Ano de Publicação:</strong> ${book.publicationYear}</li>
                                    </c:if>
                                    <c:if test="${not empty book.genre}">
                                        <li class="list-group-item"><strong>Gênero:</strong> ${book.genre}</li>
                                    </c:if>
                                    <li class="list-group-item"><strong>Quantidade Total:</strong> ${book.totalQuantity}</li>
                                    <li class="list-group-item"><strong>Quantidade Disponível:</strong> ${book.availableQuantity}</li>
                                </ul>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-danger mb-4" role="alert">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i> ${message}
                                </div>
                            </c:otherwise>
                        </c:choose>
                        
                        <div class="d-grid gap-2 d-md-flex">
                            <a href="${pageContext.request.contextPath}/formulario.jsp" class="btn btn-outline-primary me-md-2">
                                <i class="bi bi-plus-circle"></i> Cadastrar Outro Livro
                            </a>
                            <a href="${pageContext.request.contextPath}/acervos" class="btn btn-primary">
                                <i class="bi bi-book"></i> Ver Acervo
                            </a>
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
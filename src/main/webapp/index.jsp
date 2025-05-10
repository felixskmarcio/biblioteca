// Este arquivo é tipicamente a página inicial da aplicação.


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <!-- Configuração básica da página com codificação UTF-8 para suporte a caracteres especiais -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Título da página que aparece na aba do navegador -->
    <title>Biblioteca Comunitária</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('assets/images/library-bg.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 100px 0;
            margin-bottom: 40px;
        }
        
        .feature-card {
            transition: transform 0.3s;
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
        }
        
        .feature-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/livros">Livros</a>
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
            <h1 class="display-4 mb-4">Biblioteca Comunitária</h1>
            <p class="lead mb-5">Promovendo o acesso à leitura e cultura para todos</p>
            <div>
                <a href="${pageContext.request.contextPath}/livros" class="btn btn-primary btn-lg me-3">
                    <i class="bi bi-book"></i> Explorar Livros
                </a>
                <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-light btn-lg">
                    <i class="bi bi-person-plus"></i> Cadastre-se
                </a>
            </div>
        </div>
    </section>
    
    <!-- Features Section -->
    <section class="container mb-5">
        <h2 class="text-center mb-5">Funcionalidades do Sistema</h2>
        
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card h-100 feature-card">
                    <div class="card-body text-center">
                        <i class="bi bi-book feature-icon text-primary"></i>
                        <h3 class="card-title">Gerenciamento de Livros</h3>
                        <p class="card-text">Cadastre, atualize e organize o acervo da biblioteca de forma simples e intuitiva.</p>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card h-100 feature-card">
                    <div class="card-body text-center">
                        <i class="bi bi-people feature-icon text-primary"></i>
                        <h3 class="card-title">Gestão de Usuários</h3>
                        <p class="card-text">Mantenha um registro detalhado dos membros da biblioteca e gerencie suas permissões.</p>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card h-100 feature-card">
                    <div class="card-body text-center">
                        <i class="bi bi-arrow-left-right feature-icon text-primary"></i>
                        <h3 class="card-title">Acesso ao Catálogo</h3>
                        <p class="card-text">Consulte o catálogo completo da biblioteca e a disponibilidade dos exemplares.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- About Section -->
    <section class="bg-light py-5 mb-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h2 class="mb-4">Sobre o Projeto</h2>
                    <p>A Biblioteca Comunitária é um sistema web desenvolvido para facilitar a administração de bibliotecas comunitárias, promovendo o acesso à leitura e cultura em comunidades.</p>
                    <p>O sistema permite o gerenciamento completo do acervo e usuários, tornando a administração da biblioteca mais eficiente e acessível.</p>
                    <a href="${pageContext.request.contextPath}/sobre" class="btn btn-primary mt-3">Saiba Mais</a>
                </div>
                <div class="col-md-6">
                    <img src="assets/images/library-illustration.svg" alt="Ilustração de Biblioteca" class="img-fluid">
                </div>
            </div>
        </div>
    </section>
    
    <!-- Stats Section -->
    <section class="container mb-5">
        <h2 class="text-center mb-5">Estatísticas da Biblioteca</h2>
        
        <div class="row g-4 text-center">
            <div class="col-md-4">
                <div class="p-4 bg-primary text-white rounded">
                    <h2 class="display-4">500+</h2>
                    <p class="lead">Livros no Acervo</p>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="p-4 bg-success text-white rounded">
                    <h2 class="display-4">200+</h2>
                    <p class="lead">Usuários Cadastrados</p>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="p-4 bg-info text-white rounded">
                    <h2 class="display-4">100+</h2>
                    <p class="lead">Consultas Realizadas</p>
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
                        <li><a href="${pageContext.request.contextPath}/register" class="text-decoration-none text-light">Cadastro</a></li>
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
                    <a href="#" class="text-light"><i class="bi bi-linkedin"></i></a>
                </div>
            </div>
        </div>
    </footer>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
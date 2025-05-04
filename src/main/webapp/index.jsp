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
    <jsp:include page="WEB-INF/views/common/header.jsp" />
    
    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container text-center">
            <h1 class="display-4 mb-4">Biblioteca Comunitária</h1>
            <p class="lead mb-5">Promovendo o acesso à leitura e cultura para todos</p>
            <div>
                <a href="${pageContext.request.contextPath}/livros" class="btn btn-primary btn-lg me-3">
                    <i class="bi bi-book"></i> Explorar Acervo
                </a>
                <a href="${pageContext.request.contextPath}/cadastro" class="btn btn-outline-light btn-lg">
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
                        <h3 class="card-title">Controle de Empréstimos</h3>
                        <p class="card-text">Acompanhe empréstimos, devoluções e disponibilidade de exemplares em tempo real.</p>
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
                    <p>O sistema permite o gerenciamento completo do acervo, usuários e empréstimos, tornando a administração da biblioteca mais eficiente e acessível.</p>
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
                    <p class="lead">Empréstimos Realizados</p>
                </div>
            </div>
        </div>
    </section>
    
    <jsp:include page="WEB-INF/views/common/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <!-- Configuração básica da página com codificação UTF-8 para suporte a caracteres especiais -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Título da página que aparece na aba do navegador -->
    <title>Sobre - Biblioteca Comunitária</title>
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
        
        .team-member {
            transition: transform 0.3s;
        }
        
        .team-member:hover {
            transform: translateY(-10px);
        }
        
        .timeline-item {
            position: relative;
            padding-left: 40px;
            margin-bottom: 40px;
        }
        
        .timeline-item:before {
            content: "";
            position: absolute;
            left: 0;
            top: 0;
            width: 4px;
            height: 100%;
            background-color: #007bff;
        }
        
        .timeline-item:after {
            content: "";
            position: absolute;
            left: -8px;
            top: 0;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            background-color: #007bff;
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/acervos">Acervo</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/emprestimos">Empréstimos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/sobre">Sobre</a>
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
            <h1 class="display-4 mb-4">Sobre a Biblioteca Comunitária</h1>
            <p class="lead mb-5">Conheça nossa história, missão e os valores que nos guiam</p>
        </div>
    </section>
    
    <!-- About Section -->
    <section class="container mb-5">
        <div class="row">
            <div class="col-lg-8 mx-auto">
                <h2 class="text-center mb-4">Nossa Missão</h2>
                <p class="lead text-center mb-5">Democratizar o acesso à informação, cultura e conhecimento através da gestão eficiente de bibliotecas comunitárias.</p>
                
                <div class="card mb-5">
                    <div class="card-body">
                        <h3 class="card-title mb-4">Quem Somos</h3>
                        <p>A Biblioteca Comunitária é um projeto que nasceu da necessidade de facilitar o acesso à leitura e ao conhecimento em comunidades com poucos recursos. Utilizamos tecnologia para simplificar a gestão de bibliotecas pequenas, tornando-as mais eficientes e acessíveis.</p>
                        <p>Nossa plataforma foi desenvolvida por estudantes de Sistemas de Informação da UFAL, como parte de um projeto acadêmico que cresceu e se transformou em uma solução real para bibliotecas comunitárias em todo o Brasil.</p>
                    </div>
                </div>
                
                <h3 class="mb-4">Nossos Valores</h3>
                <div class="row g-4 mb-5">
                    <div class="col-md-4">
                        <div class="card h-100">
                            <div class="card-body text-center">
                                <i class="bi bi-book-half text-primary" style="font-size: 2.5rem;"></i>
                                <h4 class="mt-3">Acesso Universal</h4>
                                <p class="card-text">Acreditamos que o conhecimento deve ser acessível a todos, independentemente de condição socioeconômica.</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card h-100">
                            <div class="card-body text-center">
                                <i class="bi bi-people-fill text-primary" style="font-size: 2.5rem;"></i>
                                <h4 class="mt-3">Comunidade</h4>
                                <p class="card-text">Valorizamos o poder da comunidade e acreditamos que bibliotecas são espaços de conexão e transformação social.</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="card h-100">
                            <div class="card-body text-center">
                                <i class="bi bi-shield-check text-primary" style="font-size: 2.5rem;"></i>
                                <h4 class="mt-3">Responsabilidade</h4>
                                <p class="card-text">Comprometemo-nos com a preservação do acervo cultural e literário, respeitando a propriedade intelectual.</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <h3 class="mb-4">Nossa História</h3>
                <div class="timeline-container mb-5">
                    <div class="timeline-item">
                        <h4>2023</h4>
                        <p>Início do desenvolvimento do sistema como projeto acadêmico na Universidade Federal de Alagoas.</p>
                    </div>
                    
                    <div class="timeline-item">
                        <h4>2024</h4>
                        <p>Implementação do sistema piloto em três bibliotecas comunitárias no estado de Alagoas.</p>
                    </div>
                    
                    <div class="timeline-item">
                        <h4>2025</h4>
                        <p>Expansão do projeto para bibliotecas em todo o Brasil e desenvolvimento de novos recursos.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Team Section -->
    <section class="bg-light py-5 mb-5">
        <div class="container">
            <h2 class="text-center mb-5">Nossa Equipe</h2>
            
            <div class="row g-4">
                <div class="col-md-6">
                    <div class="card h-100 team-member">
                        <div class="card-body text-center">
                            <img src="https://avatars.githubusercontent.com/u/32266467?v=4" alt="Foto do Desenvolvedor" class="rounded-circle mb-3" width="150" height="150">
                            <h4>Márcio Eduardo Felix</h4>
                            <p class="text-muted">Desenvolvedor Principal e Designer</p>
                            <p>Graduando em Sistemas de Informação pela UFAL e responsável pelo desenvolvimento e design do sistema.</p>
                            <div class="mt-3">
                                <a href="https://github.com/felixskmarcio" class="text-dark me-2" target="_blank"><i class="bi bi-github"></i></a>
                                <a href="#" class="text-dark me-2"><i class="bi bi-linkedin"></i></a>
                                <a href="mailto:felixskmarcio2@gmail.com" class="text-dark"><i class="bi bi-envelope"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="card h-100 team-member">
                        <div class="card-body text-center">
                            <img src="https://avatars.githubusercontent.com/u/12481911?v=4" alt="Foto do Coordenador" class="rounded-circle mb-3" width="150" height="150">
                            <h4>Prof. Gustavo Miranda</h4>
                            <p class="text-muted">Coordenador do Projeto</p>
                            <p>Professor do curso de Sistemas de Informação e orientador do projeto acadêmico.</p>
                            <div class="mt-3">
                                <a href="https://github.com/GustavoHFMO" class="text-dark me-2" target="_blank"><i class="bi bi-github"></i></a>
                                <a href="#" class="text-dark me-2"><i class="bi bi-linkedin"></i></a>
                                <a href="#" class="text-dark"><i class="bi bi-envelope"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Contact Section -->
    <section class="container mb-5">
        <div class="row">
            <div class="col-lg-8 mx-auto">
                <h2 class="text-center mb-5">Entre em Contato</h2>
                
                <div class="row g-4">
                    <div class="col-md-6">
                        <div class="card h-100">
                            <div class="card-body">
                                <h4 class="mb-3">Informações de Contato</h4>
                                <p><i class="bi bi-envelope me-2"></i> felixskmarcio2@gmail.com</p>
                                <p><i class="bi bi-telephone me-2"></i> (82) 9 9827-4881</p>
                                <p><i class="bi bi-geo-alt me-2"></i> Universidade Federal de Alagoas - Campus A.C. Simões, Maceió/AL</p>
                                <p><i class="bi bi-clock me-2"></i> Segunda a Sexta: 09h às 18h</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="card h-100">
                            <div class="card-body">
                                <h4 class="mb-3">Envie-nos uma Mensagem</h4>
                                <form>
                                    <div class="mb-3">
                                        <input type="text" class="form-control" placeholder="Seu Nome">
                                    </div>
                                    <div class="mb-3">
                                        <input type="email" class="form-control" placeholder="Seu Email">
                                    </div>
                                    <div class="mb-3">
                                        <textarea class="form-control" rows="3" placeholder="Sua Mensagem"></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Enviar Mensagem</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- FAQ Section -->
    <section class="bg-light py-5 mb-5">
        <div class="container">
            <h2 class="text-center mb-5">Perguntas Frequentes</h2>
            
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <div class="accordion" id="accordionFAQ">
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne">
                                    Como posso implementar o sistema na minha biblioteca?
                                </button>
                            </h2>
                            <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#accordionFAQ">
                                <div class="accordion-body">
                                    Para implementar o sistema em sua biblioteca, entre em contato conosco através do email ou telefone informados. Nossa equipe irá avaliar as necessidades da sua biblioteca e propor um plano de implementação personalizado.
                                </div>
                            </div>
                        </div>
                        
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo">
                                    O sistema é gratuito?
                                </button>
                            </h2>
                            <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#accordionFAQ">
                                <div class="accordion-body">
                                    Sim, o sistema é completamente gratuito para bibliotecas comunitárias sem fins lucrativos. Nosso objetivo é democratizar o acesso à tecnologia de gestão de bibliotecas.
                                </div>
                            </div>
                        </div>
                        
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree">
                                    É necessário internet para utilizar o sistema?
                                </button>
                            </h2>
                            <div id="collapseThree" class="accordion-collapse collapse" data-bs-parent="#accordionFAQ">
                                <div class="accordion-body">
                                    O sistema foi desenvolvido para funcionar online, mas também oferecemos uma versão offline com sincronização periódica para bibliotecas com acesso limitado à internet.
                                </div>
                            </div>
                        </div>
                        
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour">
                                    Como posso contribuir com o projeto?
                                </button>
                            </h2>
                            <div id="collapseFour" class="accordion-collapse collapse" data-bs-parent="#accordionFAQ">
                                <div class="accordion-body">
                                    Existem várias formas de contribuir: como desenvolvedor, você pode participar do código aberto no GitHub; como bibliotecário, pode compartilhar suas necessidades e sugestões; e como usuário, pode reportar bugs e sugerir melhorias.
                                </div>
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
                    <a href="#" class="text-light"><i class="bi bi-linkedin"></i></a>
                </div>
            </div>
        </div>
    </footer>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 
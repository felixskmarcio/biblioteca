<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro - Biblioteca Comunitária</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .register-container {
            max-width: 650px;
            margin: 50px auto;
        }
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        .card-header {
            background-color: #6c757d;
            color: white;
            text-align: center;
            border-radius: 10px 10px 0 0 !important;
            padding: 20px;
        }
        .register-icon {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        .btn-success {
            width: 100%;
            padding: 12px;
            font-weight: 500;
        }
        .login-link {
            text-align: center;
            margin-top: 20px;
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

    <div class="container register-container">
        <div class="card">
            <div class="card-header">
                <i class="bi bi-person-plus-fill register-icon"></i>
                <h3 class="card-title">Cadastre-se</h3>
            </div>
            <div class="card-body p-4">
                <!-- Exibe mensagem de erro se existir -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger" role="alert">
                        ${errorMessage}
                    </div>
                </c:if>
                
                <!-- Exibe mensagem de sucesso se existir -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success" role="alert">
                        ${successMessage}
                    </div>
                </c:if>
                
                <form action="${pageContext.request.contextPath}/register" method="post">
                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label for="name" class="form-label">Nome Completo</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-person"></i></span>
                                <input type="text" class="form-control" id="name" name="name" 
                                       placeholder="Digite seu nome completo" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label for="email" class="form-label">Email</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                <input type="email" class="form-control" id="email" name="email" 
                                       placeholder="seu.email@exemplo.com" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="password" class="form-label">Senha</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                <input type="password" class="form-control" id="password" name="password" 
                                       placeholder="Digite sua senha" required 
                                       pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$" 
                                       title="A senha deve conter pelo menos 8 caracteres, incluindo letras maiúsculas, minúsculas e números">
                            </div>
                            <small class="text-muted">A senha deve ter no mínimo 8 caracteres, incluindo letras maiúsculas, minúsculas e números.</small>
                        </div>
                        <div class="col-md-6">
                            <label for="confirmPassword" class="form-label">Confirmar Senha</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                                       placeholder="Confirme sua senha" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="phone" class="form-label">Telefone</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                                <input type="tel" class="form-control" id="phone" name="phone" 
                                       placeholder="(xx) xxxxx-xxxx">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="address" class="form-label">Endereço</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-house"></i></span>
                                <input type="text" class="form-control" id="address" name="address" 
                                       placeholder="Seu endereço">
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="termsCheck" required>
                        <label class="form-check-label" for="termsCheck">
                            Eu concordo com os <a href="#" data-bs-toggle="modal" data-bs-target="#termsModal">Termos de Uso</a> 
                            e <a href="#" data-bs-toggle="modal" data-bs-target="#privacyModal">Política de Privacidade</a>
                        </label>
                    </div>
                    
                    <button type="submit" class="btn btn-success">
                        <i class="bi bi-person-plus me-2"></i>Cadastrar
                    </button>
                </form>
            </div>
        </div>
        
        <div class="login-link">
            <p>Já tem uma conta? 
                <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">
                    Faça login
                </a>
            </p>
        </div>
    </div>
    
    <!-- Modal Termos de Uso -->
    <div class="modal fade" id="termsModal" tabindex="-1" aria-labelledby="termsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="termsModalLabel">Termos de Uso</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <h6>1. Aceitação dos Termos</h6>
                    <p>Ao utilizar os serviços da Biblioteca Comunitária, você concorda com estes termos. Por favor, leia-os atentamente.</p>
                    
                    <h6>2. Uso do Serviço</h6>
                    <p>Os serviços da Biblioteca Comunitária são fornecidos apenas para fins pessoais e educacionais. Você concorda em não utilizar os serviços para qualquer fim comercial sem autorização prévia.</p>
                    
                    <h6>3. Responsabilidades do Usuário</h6>
                    <p>Você é responsável pela segurança de sua conta e por todas as atividades que ocorrem em sua conta. Os usuários devem tratar os materiais da biblioteca com cuidado e devolver os itens emprestados dentro do prazo estabelecido.</p>
                    
                    <h6>4. Alterações nos Termos</h6>
                    <p>A Biblioteca Comunitária reserva-se o direito de modificar estes termos a qualquer momento. As alterações entrarão em vigor imediatamente após a publicação dos termos atualizados.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Modal Política de Privacidade -->
    <div class="modal fade" id="privacyModal" tabindex="-1" aria-labelledby="privacyModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="privacyModalLabel">Política de Privacidade</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <h6>1. Coleta de Informações</h6>
                    <p>A Biblioteca Comunitária coleta informações pessoais como nome, endereço, e-mail e telefone durante o processo de cadastro. Estas informações são necessárias para a prestação dos serviços da biblioteca.</p>
                    
                    <h6>2. Uso das Informações</h6>
                    <p>As informações coletadas são utilizadas apenas para fins de gestão da biblioteca, comunicação com os usuários e melhoria dos serviços oferecidos.</p>
                    
                    <h6>3. Proteção de Dados</h6>
                    <p>A Biblioteca Comunitária implementa medidas de segurança para proteger suas informações pessoais contra acesso não autorizado, alteração, divulgação ou destruição.</p>
                    
                    <h6>4. Compartilhamento de Dados</h6>
                    <p>A Biblioteca Comunitária não compartilha, vende ou aluga informações pessoais dos usuários a terceiros, exceto quando obrigada por lei.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container text-center">
            <p class="mb-0">&copy; 2025 Biblioteca Comunitária. Todos os direitos reservados.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Validação de senha e confirmação
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');
        
        function validatePassword() {
            if (password.value !== confirmPassword.value) {
                confirmPassword.setCustomValidity('As senhas não conferem');
            } else {
                confirmPassword.setCustomValidity('');
            }
        }
        
        password.onchange = validatePassword;
        confirmPassword.onkeyup = validatePassword;
    </script>
</body>
</html> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recuperação de Senha - Biblioteca Comunitária</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .recover-container {
            max-width: 500px;
            margin: 80px auto;
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
        .recover-icon {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        .btn-secondary {
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
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <div class="container recover-container">
        <div class="card">
            <div class="card-header">
                <i class="bi bi-key-fill recover-icon"></i>
                <h3 class="card-title">Recuperação de Senha</h3>
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
                
                <!-- Se um token não foi fornecido, exibe formulário para solicitar recuperação -->
                <c:if test="${empty param.token}">
                    <p class="mb-4">Informe seu email cadastrado para receber instruções de recuperação de senha.</p>
                    
                    <form action="${pageContext.request.contextPath}/senha/recuperar" method="post">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                <input type="email" class="form-control" id="email" name="email" 
                                       placeholder="Seu email" required>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-secondary">
                            <i class="bi bi-send me-2"></i>Solicitar Recuperação
                        </button>
                    </form>
                </c:if>
                
                <!-- Se um token foi fornecido, exibe formulário para definir nova senha -->
                <c:if test="${not empty param.token}">
                    <p class="mb-4">Digite sua nova senha.</p>
                    
                    <form action="${pageContext.request.contextPath}/senha/recuperar" method="post">
                        <input type="hidden" name="token" value="${param.token}">
                        
                        <div class="mb-3">
                            <label for="password" class="form-label">Nova Senha</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                <input type="password" class="form-control" id="password" name="password" 
                                       placeholder="Nova senha" required 
                                       pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$" 
                                       title="A senha deve conter pelo menos 8 caracteres, incluindo letras maiúsculas, minúsculas e números">
                            </div>
                            <small class="text-muted">A senha deve ter no mínimo 8 caracteres, incluindo letras maiúsculas, minúsculas e números.</small>
                        </div>
                        
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">Confirmar Senha</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                                       placeholder="Confirme sua senha" required>
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-secondary">
                            <i class="bi bi-check2-circle me-2"></i>Redefinir Senha
                        </button>
                    </form>
                </c:if>
            </div>
        </div>
        
        <div class="login-link">
            <p>Lembrou sua senha? 
                <a href="${pageContext.request.contextPath}/login" class="text-decoration-none">
                    Voltar para login
                </a>
            </p>
        </div>
    </div>
    
    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-5 fixed-bottom">
        <div class="container text-center">
            <p class="mb-0">&copy; 2023 Biblioteca Comunitária. Todos os direitos reservados.</p>
        </div>
    </footer>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Verificar se as senhas coincidem quando o usuário digita
        document.addEventListener('DOMContentLoaded', function() {
            const password = document.getElementById('password');
            const confirmPassword = document.getElementById('confirmPassword');
            
            if (password && confirmPassword) {
                confirmPassword.addEventListener('input', function() {
                    if (password.value !== confirmPassword.value) {
                        confirmPassword.setCustomValidity('As senhas não coincidem');
                    } else {
                        confirmPassword.setCustomValidity('');
                    }
                });
                
                password.addEventListener('input', function() {
                    if (confirmPassword.value !== '') {
                        if (password.value !== confirmPassword.value) {
                            confirmPassword.setCustomValidity('As senhas não coincidem');
                        } else {
                            confirmPassword.setCustomValidity('');
                        }
                    }
                });
            }
        });
    </script>
</body>
</html> 
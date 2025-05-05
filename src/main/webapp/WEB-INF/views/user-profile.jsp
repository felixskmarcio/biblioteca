<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meu Perfil - Biblioteca Comunitária</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .profile-header {
            background-color: #f8f9fa;
            padding: 30px 0;
            margin-bottom: 40px;
            border-bottom: 1px solid #e9ecef;
        }
        .profile-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }
        .profile-card-header {
            background-color: #6c757d;
            color: white;
            border-radius: 10px 10px 0 0 !important;
            padding: 15px 20px;
        }
        .profile-image {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid #fff;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
        }
        .tab-content {
            padding: 30px 0;
        }
        .badge-borrowed {
            background-color: #ffc107;
            color: #212529;
        }
        .badge-returned {
            background-color: #198754;
            color: white;
        }
        .badge-overdue {
            background-color: #dc3545;
            color: white;
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
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/">Início</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/acervos">Acervo</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/sobre">Sobre</a>
                        </li>
                    </ul>
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-person-circle me-1"></i>${sessionScope.userName}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/perfil"><i class="bi bi-person me-2"></i>Meu Perfil</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/perfil/emprestimos"><i class="bi bi-book me-2"></i>Meus Empréstimos</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Sair</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <!-- Profile Header Section -->
    <section class="profile-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-3 text-center">
                    <img src="https://via.placeholder.com/150" alt="Foto de Perfil" class="profile-image">
                </div>
                <div class="col-md-9">
                    <h1 class="mb-2">${user.name}</h1>
                    <p class="text-muted mb-2"><i class="bi bi-envelope me-2"></i>${user.email}</p>
                    <p class="text-muted mb-2"><i class="bi bi-telephone me-2"></i>${user.phone}</p>
                    <p class="text-muted mb-3"><i class="bi bi-house me-2"></i>${user.address}</p>
                    <p>
                        <small class="text-muted">Membro desde: 
                            <jsp:useBean id="dateValue" class="java.util.Date"/>
                            <jsp:setProperty name="dateValue" property="time" value="${user.registrationDate.time}"/>
                            <fmt:formatDate value="${dateValue}" pattern="dd/MM/yyyy"/>
                        </small>
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Profile Content Section -->
    <section class="container">
        <ul class="nav nav-tabs nav-fill mb-4" id="profileTab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="overview-tab" data-bs-toggle="tab" data-bs-target="#overview" type="button" role="tab" aria-controls="overview" aria-selected="true">
                    <i class="bi bi-house-door me-2"></i>Visão Geral
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="books-tab" data-bs-toggle="tab" data-bs-target="#books" type="button" role="tab" aria-controls="books" aria-selected="false">
                    <i class="bi bi-book me-2"></i>Meus Empréstimos
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="settings-tab" data-bs-toggle="tab" data-bs-target="#settings" type="button" role="tab" aria-controls="settings" aria-selected="false">
                    <i class="bi bi-gear me-2"></i>Configurações
                </button>
            </li>
        </ul>
        
        <div class="tab-content" id="profileTabContent">
            <!-- Overview Tab -->
            <div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview-tab">
                <div class="row">
                    <div class="col-md-6">
                        <div class="card profile-card">
                            <div class="card-header profile-card-header d-flex justify-content-between align-items-center">
                                <h5 class="m-0"><i class="bi bi-book me-2"></i>Resumo de Empréstimos</h5>
                            </div>
                            <div class="card-body">
                                <div class="row text-center">
                                    <div class="col-4">
                                        <h4>5</h4>
                                        <p class="text-muted">Total</p>
                                    </div>
                                    <div class="col-4">
                                        <h4>2</h4>
                                        <p class="text-muted">Ativos</p>
                                    </div>
                                    <div class="col-4">
                                        <h4>0</h4>
                                        <p class="text-muted">Atrasados</p>
                                    </div>
                                </div>
                                <hr>
                                <div class="d-grid gap-2">
                                    <a href="#books" class="btn btn-outline-primary" data-bs-toggle="tab" data-bs-target="#books">
                                        <i class="bi bi-eye me-2"></i>Ver Detalhes
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card profile-card">
                            <div class="card-header profile-card-header d-flex justify-content-between align-items-center">
                                <h5 class="m-0"><i class="bi bi-bell me-2"></i>Notificações</h5>
                            </div>
                            <div class="card-body">
                                <div class="list-group">
                                    <a href="#" class="list-group-item list-group-item-action">
                                        <div class="d-flex w-100 justify-content-between">
                                            <h6 class="mb-1">Devolução em breve</h6>
                                            <small>3 dias atrás</small>
                                        </div>
                                        <p class="mb-1">O livro "O Senhor dos Anéis" deve ser devolvido em 2 dias.</p>
                                    </a>
                                    <a href="#" class="list-group-item list-group-item-action">
                                        <div class="d-flex w-100 justify-content-between">
                                            <h6 class="mb-1">Livro reservado disponível</h6>
                                            <small>1 semana atrás</small>
                                        </div>
                                        <p class="mb-1">O livro "Cem Anos de Solidão" que você reservou está disponível para retirada.</p>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Books Tab -->
            <div class="tab-pane fade" id="books" role="tabpanel" aria-labelledby="books-tab">
                <div class="card profile-card">
                    <div class="card-header profile-card-header d-flex justify-content-between align-items-center">
                        <h5 class="m-0"><i class="bi bi-book me-2"></i>Meus Empréstimos</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Livro</th>
                                        <th>Data Empréstimo</th>
                                        <th>Data Devolução</th>
                                        <th>Status</th>
                                        <th>Ações</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>O Senhor dos Anéis</td>
                                        <td>10/04/2025</td>
                                        <td>25/04/2025</td>
                                        <td><span class="badge badge-borrowed">Emprestado</span></td>
                                        <td>
                                            <button class="btn btn-sm btn-primary">Renovar</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Harry Potter e a Pedra Filosofal</td>
                                        <td>15/03/2025</td>
                                        <td>30/03/2025</td>
                                        <td><span class="badge badge-overdue">Atrasado</span></td>
                                        <td>
                                            <button class="btn btn-sm btn-primary">Renovar</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Duna</td>
                                        <td>01/01/2025</td>
                                        <td>16/01/2025</td>
                                        <td><span class="badge badge-returned">Devolvido</span></td>
                                        <td>
                                            <button class="btn btn-sm btn-outline-secondary" disabled>Renovar</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Settings Tab -->
            <div class="tab-pane fade" id="settings" role="tabpanel" aria-labelledby="settings-tab">
                <div class="card profile-card">
                    <div class="card-header profile-card-header d-flex justify-content-between align-items-center">
                        <h5 class="m-0"><i class="bi bi-person me-2"></i>Informações Pessoais</h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/perfil/atualizar" method="post">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="name" class="form-label">Nome Completo</label>
                                    <input type="text" class="form-control" id="name" name="name" value="${user.name}" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" value="${user.email}" required>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="phone" class="form-label">Telefone</label>
                                    <input type="tel" class="form-control" id="phone" name="phone" value="${user.phone}">
                                </div>
                                <div class="col-md-6">
                                    <label for="address" class="form-label">Endereço</label>
                                    <input type="text" class="form-control" id="address" name="address" value="${user.address}">
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-save me-2"></i>Salvar Alterações
                            </button>
                        </form>
                    </div>
                </div>
                
                <div class="card profile-card mt-4">
                    <div class="card-header profile-card-header d-flex justify-content-between align-items-center">
                        <h5 class="m-0"><i class="bi bi-lock me-2"></i>Alterar Senha</h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/perfil/senha" method="post">
                            <div class="row mb-3">
                                <div class="col-md-12">
                                    <label for="currentPassword" class="form-label">Senha Atual</label>
                                    <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="newPassword" class="form-label">Nova Senha</label>
                                    <input type="password" class="form-control" id="newPassword" name="newPassword" 
                                           pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$" 
                                           title="A senha deve conter pelo menos 8 caracteres, incluindo letras maiúsculas, minúsculas e números" required>
                                    <small class="text-muted">A senha deve ter no mínimo 8 caracteres, incluindo letras maiúsculas, minúsculas e números.</small>
                                </div>
                                <div class="col-md-6">
                                    <label for="confirmNewPassword" class="form-label">Confirmar Nova Senha</label>
                                    <input type="password" class="form-control" id="confirmNewPassword" name="confirmNewPassword" required>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-key me-2"></i>Alterar Senha
                            </button>
                        </form>
                    </div>
                </div>
                
                <div class="card profile-card mt-4">
                    <div class="card-header profile-card-header d-flex justify-content-between align-items-center bg-danger">
                        <h5 class="m-0"><i class="bi bi-exclamation-triangle me-2"></i>Zona de Perigo</h5>
                    </div>
                    <div class="card-body">
                        <p class="text-danger">Atenção: A exclusão da conta é permanente e não pode ser desfeita.</p>
                        <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#deleteAccountModal">
                            <i class="bi bi-trash me-2"></i>Excluir Minha Conta
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Delete Account Modal -->
    <div class="modal fade" id="deleteAccountModal" tabindex="-1" aria-labelledby="deleteAccountModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title" id="deleteAccountModalLabel">Confirmação de Exclusão</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Você tem certeza que deseja excluir sua conta? Esta ação não pode ser desfeita.</p>
                    <p><strong>Observação:</strong> Se você possuir empréstimos ativos, não será possível excluir sua conta.</p>
                    <form id="deleteAccountForm" action="${pageContext.request.contextPath}/perfil/excluir" method="post">
                        <div class="mb-3">
                            <label for="passwordConfirm" class="form-label">Digite sua senha para confirmar</label>
                            <input type="password" class="form-control" id="passwordConfirm" name="passwordConfirm" required>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" form="deleteAccountForm" class="btn btn-danger">Excluir Conta</button>
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
        // Validação de senha e confirmação para alteração de senha
        const newPassword = document.getElementById('newPassword');
        const confirmNewPassword = document.getElementById('confirmNewPassword');
        
        function validatePassword() {
            if (newPassword.value !== confirmNewPassword.value) {
                confirmNewPassword.setCustomValidity('As senhas não conferem');
            } else {
                confirmNewPassword.setCustomValidity('');
            }
        }
        
        if (newPassword && confirmNewPassword) {
            newPassword.onchange = validatePassword;
            confirmNewPassword.onkeyup = validatePassword;
        }
    </script>
</body>
</html> 
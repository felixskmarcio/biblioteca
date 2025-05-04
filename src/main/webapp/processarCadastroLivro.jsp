<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Livro Cadastrado - Biblioteca Comunitária</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        .success-container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: var(--primary-light);
            border-left: 4px solid var(--primary-color);
            border-radius: var(--border-radius);
            text-align: center;
        }
        
        .success-icon {
            font-size: 4rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }
        
        .success-message {
            font-size: 1.5rem;
            color: var(--primary-dark);
            margin-bottom: 1.5rem;
        }
        
        .book-details {
            background-color: white;
            padding: 1.5rem;
            border-radius: var(--border-radius);
            margin: 1.5rem 0;
            text-align: left;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .book-details p {
            margin: 0.5rem 0;
            font-size: 1.1rem;
        }
        
        .book-details strong {
            color: var(--primary-dark);
        }
    </style>
</head>
<body>
    <main class="main-container">
        <header>
            <div class="logo">
                <i class="fas fa-book-reader"></i>
            </div>
            <h1>Sistema de Biblioteca Comunitária</h1>
        </header>
        
        <div class="success-container">
            <i class="fas fa-check-circle success-icon"></i>
            <h2 class="success-message">Livro Cadastrado com Sucesso!</h2>
            
            <div class="book-details">
                <p><strong>Título:</strong> <%= request.getParameter("titulo") %></p>
                <p><strong>Autor:</strong> <%= request.getParameter("autor") %></p>
                <% if(request.getParameter("editora") != null && !request.getParameter("editora").isEmpty()) { %>
                    <p><strong>Editora:</strong> <%= request.getParameter("editora") %></p>
                <% } %>
                <% if(request.getParameter("ano") != null && !request.getParameter("ano").isEmpty()) { %>
                    <p><strong>Ano:</strong> <%= request.getParameter("ano") %></p>
                <% } %>
                <% if(request.getParameter("categoria") != null && !request.getParameter("categoria").isEmpty()) { %>
                    <p><strong>Categoria:</strong> <%= request.getParameter("categoria") %></p>
                <% } %>
                <% if(request.getParameter("codigo") != null && !request.getParameter("codigo").isEmpty()) { %>
                    <p><strong>Código:</strong> <%= request.getParameter("codigo") %></p>
                <% } %>
            </div>
            
            <p>O livro foi adicionado ao sistema. O que deseja fazer agora?</p>
            
            <div style="margin-top: 2rem;">
                <a href="${pageContext.request.contextPath}/registerBook.jsp" class="btn">
                    <i class="fas fa-plus-circle btn-icon"></i> Cadastrar Outro Livro
                </a>
                <a href="${pageContext.request.contextPath}/index.jsp" class="btn" style="margin-left: 1rem;">
                    <i class="fas fa-home btn-icon"></i> Voltar à Página Inicial
                </a>
            </div>
        </div>
    </main>
    
    <footer style="text-align: center; margin-top: 2rem; padding: 1rem; color: #777; font-size: 0.9rem;">
        <p>© 2023 Sistema de Biblioteca Comunitária | Desenvolvido para apoiar bibliotecas comunitárias</p>
    </footer>
</body>
</html> 
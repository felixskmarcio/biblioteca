<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastrar Novo Livro - Biblioteca Comunitária</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <style>
        .form-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 0;
            background-color: var(--card-bg);
        }

        .form-header {
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--primary-light);
            text-align: center;
        }

        .form-group {
            margin-bottom: 1.8rem;
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.7rem;
            font-weight: 500;
            color: var(--text-color);
        }

        .form-group input[type="text"],
        .form-group input[type="number"],
        .form-group select {
            width: 100%;
            padding: 0.9rem 1rem;
            border: 1px solid #e0e0e0;
            border-radius: var(--border-radius);
            font-size: 1rem;
            transition: var(--transition);
            background-color: #f9f9f9;
        }

        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.2);
            background-color: white;
        }

        .form-actions {
            margin-top: 2.5rem;
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
        }
        
        .btn-secondary {
             display: inline-block;
             padding: 0.8rem 1.5rem;
             text-align: center;
             background-color: #6c757d;
             color: white;
             text-decoration: none;
             border-radius: var(--border-radius);
             font-weight: 500;
             transition: var(--transition);
             border: none;
             box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        .page-title {
            color: var(--primary-dark);
            font-size: 1.8rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .page-title i {
            margin-right: 0.75rem;
            color: var(--primary-color);
        }
        
        .form-icon {
            display: flex;
            align-items: center;
            margin-bottom: 0.5rem;
            position: relative;
        }
        
        .form-icon i {
            margin-right: 0.5rem;
            color: var(--primary-color);
        }
        
        .required-field::after {
            content: "*";
            color: #e53935;
            margin-left: 4px;
            font-size: 1.2rem;
            position: absolute;
            top: -2px;
        }
        
        .form-instructions {
            background-color: var(--primary-light);
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 2rem;
            color: var(--primary-dark);
            font-size: 0.9rem;
        }
        
        .form-instructions i {
            margin-right: 0.5rem;
        }
        
        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }
            
            .form-actions {
                flex-direction: column;
            }
            
            .form-actions .btn,
            .form-actions .btn-secondary {
                width: 100%;
                margin-bottom: 0.5rem;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <main class="main-container">
        <header class="form-header">
            <h2 class="page-title"><i class="fas fa-plus-circle"></i> Cadastrar Novo Livro</h2>
        </header>

        <section class="form-container">
            <div class="form-instructions">
                <i class="fas fa-info-circle"></i> 
                Preencha os campos abaixo para adicionar um novo livro ao acervo da biblioteca. Os campos marcados com * são obrigatórios.
            </div>
            
            <form action="${pageContext.request.contextPath}/processarCadastroLivro.jsp" method="POST">
                <div class="form-row">
                    <div class="form-group">
                        <label for="titulo" class="required-field">
                            <span class="form-icon"><i class="fas fa-book"></i> Título</span>
                        </label>
                        <input type="text" id="titulo" name="titulo" required placeholder="Digite o título do livro">
                    </div>

                    <div class="form-group">
                        <label for="autor" class="required-field">
                            <span class="form-icon"><i class="fas fa-user-edit"></i> Autor</span>
                        </label>
                        <input type="text" id="autor" name="autor" required placeholder="Nome do autor">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="editora">
                            <span class="form-icon"><i class="fas fa-building"></i> Editora</span>
                        </label>
                        <input type="text" id="editora" name="editora" placeholder="Nome da editora">
                    </div>

                    <div class="form-group">
                        <label for="ano">
                            <span class="form-icon"><i class="fas fa-calendar-alt"></i> Ano de Publicação</span>
                        </label>
                        <input type="number" id="ano" name="ano" min="1000" max="9999" placeholder="Ex: 2023">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="categoria">
                            <span class="form-icon"><i class="fas fa-tag"></i> Categoria</span>
                        </label>
                        <input type="text" id="categoria" name="categoria" placeholder="Ex: Romance, Ficção Científica, Infantil">
                    </div>

                    <div class="form-group">
                        <label for="codigo">
                            <span class="form-icon"><i class="fas fa-barcode"></i> Código (ISBN)</span>
                        </label>
                        <input type="text" id="codigo" name="codigo" placeholder="Código ISBN (opcional)">
                    </div>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="btn-secondary">
                        <i class="fas fa-arrow-left"></i> Voltar
                    </a>
                    <button type="submit" class="btn">
                        <i class="fas fa-save"></i> Cadastrar Livro
                    </button>
                </div>
            </form>
        </section>
    </main>

    <footer style="text-align: center; margin-top: 2rem; padding: 1rem; color: #777; font-size: 0.9rem;">
        <p>© 2023 Sistema de Biblioteca Comunitária | Desenvolvido para apoiar bibliotecas comunitárias</p>
    </footer>
</body>
</html> 
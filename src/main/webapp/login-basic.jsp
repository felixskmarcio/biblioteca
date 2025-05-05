<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Básico</title>
    <style>
        .error-message {
            color: red;
            font-weight: bold;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <h1>Login Básico</h1>
    
    <% if(request.getAttribute("errorMessage") != null) { %>
        <div class="error-message">
            <%= request.getAttribute("errorMessage") %>
        </div>
    <% } %>
    
    <form action="<%= request.getContextPath() %>/login" method="post">
        <div style="margin-bottom: 10px;">
            <label for="email">Email:</label><br>
            <input type="email" id="email" name="email" required style="width: 250px; padding: 5px;">
        </div>
        <div style="margin-bottom: 15px;">
            <label for="password">Senha:</label><br>
            <input type="password" id="password" name="password" required style="width: 250px; padding: 5px;">
        </div>
        <button type="submit" style="padding: 8px 15px; background-color: #4CAF50; color: white; border: none; cursor: pointer;">Entrar</button>
    </form>
    <p>
        <a href="<%= request.getContextPath() %>/register">Cadastre-se</a>
    </p>
</body>
</html> 
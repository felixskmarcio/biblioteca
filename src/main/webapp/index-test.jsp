<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teste JSP</title>
</head>
<body>
    <h1>Página de Teste JSP</h1>
    <p>Esta é uma página de teste para verificar se os arquivos JSP estão sendo processados corretamente.</p>
    <p>Data e hora atual: <%= new java.util.Date() %></p>
    
    <h2>Links:</h2>
    <ul>
        <li><a href="<%= request.getContextPath() %>/">Página Inicial</a></li>
        <li><a href="<%= request.getContextPath() %>/login">Login (WEB-INF/views/login.jsp)</a></li>
        <li><a href="<%= request.getContextPath() %>/login-basic.jsp">Login Básico (raiz/login-basic.jsp)</a></li>
        <li><a href="<%= request.getContextPath() %>/register">Cadastro</a></li>
    </ul>
</body>
</html> 
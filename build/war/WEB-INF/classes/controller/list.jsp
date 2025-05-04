<!-- filepath: c:\Users\Felix\Documents\avb2\src\main\webapp\books\list.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Lista de Livros</title>
</head>
<body>
<h1>Lista de Livros</h1>
<table border="1">
    <tr>
        <th>Título</th>
        <th>Autor</th>
        <th>ISBN</th>
    </tr>
    <c:forEach var="book" items="${books}">
        <tr>
            <td>${book.title}</td>
            <td>${book.author}</td>
            <td>${book.isbn}</td>
        </tr>
    </c:forEach>
</table>
<a href="<%= request.getContextPath() %>/books/register.jsp">Cadastrar Novo Livro</a>
</body>
</html>
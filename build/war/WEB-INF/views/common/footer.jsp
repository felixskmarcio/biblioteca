<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

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
                    <li><a href="${pageContext.request.contextPath}/livros" class="text-decoration-none text-light">Acervo</a></li>
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
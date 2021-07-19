<%-- 
    Document   : operador-atendimentos-detalhes
    Created on : 18/07/2021, 17:03:08
    Author     : Felipe Bomfim
--%>
<%@ page errorPage = "erro.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>  
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Meus atendimentos</title>
    <!-- UIkit CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-rc.20/css/uikit.min.css"/>
    <!-- UIkit JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-rc.20/js/uikit.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-rc.20/js/uikit-icons.min.js"></script>
    <script type="text/javascript" src="universal/js/jquery.js"></script>
</head>
<body>
<header>
    <div id="logo" class="img left"><img src="img/logo.png"></div>
    <div id="info-cabecalho" class="left">
        <div id="boas-vindas" class="block">Bem vindo, <span>${sessionScope.nome}</span></div>
    </div>
    <nav class="right">
        <ul>
            <!-- direcione para as servlets adequadas-->
            <li id="atendimentos" class="ativo"><a href="AtendimentoServlet?action=listar_atendimentos_funcionario">ATENDIMENTOS</a></li>
            <li id="categorias"><a href="operador-categorias.jsp">CATEGORIAS</a></li>
            <li id="produtos"><a href="operador-produtos.jsp">PRODUTOS</a></li>
            <li><a href="Logout">SAIR</a></li>
        </ul>
    </nav>
</header>
<div id="foto-menu" class="right img"><img src="img/support.png"></div>
<h1 class="left titulo">${fn:toUpperCase(atendimentos.titulo)}</h1>

<div class="atend-detalhes block">
    <div class="atend-desc block">${fn:toUpperCase(atendimentos.descricao)}</div>
    <div class="atend-tipo right">${fn:toUpperCase(atendimentos.tipoAtendimento)} - ${fn:toUpperCase(atendimentos.produto)} </div>

    <fmt:parseDate value="${atendimentos.data_resposta}" pattern="yyyy-MM-dd HH:mm:ss" var="date"/>
    <fmt:formatDate pattern = "dd/MM/yyyy HH:mm:ss" value = "${date}" var="data" />
            
    <c:if test="${not empty data}">
    <div class="resp block">
        <h2 class="left subtitulo-resp">RESPOSTA</h2>
        <div class="resp-desc block">${fn:toUpperCase(atendimentos.resposta)}</div><!--preencher dinamicamente-->
        <div class="resp-fechamento right">Finalizado em <span class="resp-data">${data}</span></div>
    </div>
    </c:if>
  
</div>
 <c:if test="${empty data}">
   <form action="AtendimentoServlet?action=adicionar_resposta&id=${atendimentos.id}" method="post" class="form-resp"><!-- enviar para a servlet-->
        <textarea class="resp-textarea uk-textarea block" name="resp" rows="5" placeholder="Sua resposta..."></textarea>
        <button type="submit" id="btn-resp-enviar" class="left uk-button uk-button-primary">Enviar</button>
    </form>
</c:if>

<a href="AtendimentoServlet?action=listar_atendimentos_funcionario" id="btn-atend-voltar" class="right uk-button uk-button-default">VOLTAR</a>

<link rel="stylesheet" href="universal/css/menu.css">
<link rel="stylesheet" href="universal/css/reset.css">
<link rel="stylesheet" href="css/operador.css">
<script type="text/javascript" src="js/operador.js"></script>
</body>
</html>
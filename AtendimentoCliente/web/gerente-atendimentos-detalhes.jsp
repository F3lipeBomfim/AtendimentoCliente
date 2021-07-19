<%-- 
    Document   : gerente-atendimentos-detalhes
    Created on : 18/07/2021, 15:37:30
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
        <!--alterar dinamicamente o "span" com o nome do referido operador no bd-->
    </div>
    <nav class="right">
        <ul>
            <!-- direcione para as servlets adequadas-->
            <li id="atendimentos"><a href="AtendimentoServlet?action=listar_atendimentos_gerente">ATENDIMENTOS</a></li>
            <li id="equipe" class="ativo"><a href="gerente-equipe.jsp">EQUIPE</a></li>
            <li id="relatorios"><a href="gerente-relatorios.jsp">RELATÓRIOS</a></li>
            <li><a href="Logout">SAIR</a></li>
        </ul>
    </nav>
</header>
<div id="foto-menu" class="right img"><img src="img/support.png"></div>
<h1 class="left titulo">${fn:toUpperCase(atendimentos.titulo)}</h1>

<div class="atend-detalhes block">
    <div class="atend-desc block">${fn:toUpperCase(atendimentos.descricao)}</div>
    <div class="atend-tipo right">${fn:toUpperCase(atendimentos.tipoAtendimento)}</div>

    <div class="resp block" >
        <h2 class="left subtitulo-resp">RESPOSTA</h2>
        <div class="resp-desc block">Bom dia, é verdade que o creme embuste faz você ficar 10 anos mais jovem?</div>
        <div class="resp-fechamento right">Finalizado em <span class="resp-data">01/01/2018</span></div>
    </div>
</div>

<a href="AtendimentoServlet?action=listar_atendimentos_gerente" id="btn-atend-voltar" class="right uk-button uk-button-default">VOLTAR</a>

<link rel="stylesheet" href="universal/css/menu.css">
<link rel="stylesheet" href="universal/css/reset.css">
<link rel="stylesheet" href="css/gerente.css">
<script type="text/javascript" src="js/gerente.js"></script>
</body>
</html>
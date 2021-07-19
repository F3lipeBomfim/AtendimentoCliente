<%-- 
    Document   : gerente_equipe
    Created on : 18/07/2021, 13:26:10
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
    <title>ATENDIMENTOS</title>
    <!-- UIkit CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-rc.20/css/uikit.min.css"/>
    <!-- UIkit JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-rc.20/js/uikit.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-rc.20/js/uikit-icons.min.js"></script>
    <script type="text/javascript" src="universal/js/jquery.js"></script>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/css/toastr.css" rel="stylesheet"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>
<body>
<header>
    <c:if test="${not empty msg}">
        <input type="hidden" id="msg" value="${msg}" />
        <input type="hidden" id="class" value="${class}" />
    </c:if>
    <div id="logo" class="img left"><img src="img/logo.png"></div>
    <div id="info-cabecalho" class="left">
        <div id="boas-vindas" class="block">Bem vindo, <span>${sessionScope.nome}</span></div> <!--buscar no bd e preencher o nome do gerente-->
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
<div id="foto-menu" class="right img"><img src="img/users.png"></div>
<h1 class="left titulo-atend">EQUIPE</h1>

<form action="" method="post">
<div id="equipe-select" class="block uk-margin">
    <label class="uk-form-label" for="membro-selecionado">Selecione membro da equipe</label>
    <div class="uk-form-controls">
        <select class="left uk-select" id="membro-selecionado"></select>
    </div>
    <button id="editar-membro" type="button" class="equipe-icon left" uk-icon="icon: cog" onclick="editarMembro();"></button>
    <a id="excluir-membro" class="equipe-icon left" uk-icon="icon: trash" href="#" onclick="confirmExcluir(event);"></a>
    <a href="cadastro.jsp" id="btn-novo-membro" class="block uk-button uk-button-default">NOVO</a>
</div>
</form>

<link rel="stylesheet" href="universal/css/menu.css">
<link rel="stylesheet" href="universal/css/reset.css">
<link rel="stylesheet" href="css/gerente.css">
<script type="text/javascript" src="js/gerente.js"></script>
</body>
</html>

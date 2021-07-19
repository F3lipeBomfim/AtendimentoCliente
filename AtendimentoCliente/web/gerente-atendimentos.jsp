<%-- 
    Document   : gerente-atendimentos
    Created on : 18/07/2021, 12:40:14
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
    <div id="logo" class="img left"><img src="img/logo.png"></div>
    <div id="info-cabecalho" class="left">
        <div id="boas-vindas" class="block">Bem vindo, <span>${sessionScope.nome}</span></div> <!--buscar no bd e preencher o nome do operador-->
    </div>
    <nav class="right">
        <ul>
            <!-- direcione para as servlets adequadas-->
            <li id="atendimentos" class="ativo"><a href="">ATENDIMENTOS</a></li>
            <li id="equipe"><a href="gerente-equipe.jsp">EQUIPE</a></li>
            <li id="relatorios"><a href="gerente-relatorios.jsp">RELATÓRIOS</a></li>
            <li><a href="Logout">SAIR</a></li>
        </ul>
    </nav>
</header>
    
<c:if test="${not empty msg}">
    <input type="hidden" id="msg" value="${msg}" />
    <input type="hidden" id="class" value="${class}" />
</c:if>
<div id="foto-menu" class="right img"><img src="img/support.png"></div>
<h1 class="left titulo-atend">ATENDIMENTOS</h1>
<div id="div-opcoes-prod" class="uk-margin">
    <label class="uk-form-label" for="opcoes-prod">Exibir:s</label>
    <select id="opcoes-prod" class="uk-select">
        <!-- buscar no bd por estes critérios e listar-->
        <option value="0">TODOS</option>
        <option value="1">ABERTOS</option>
        <option value="2">URGENTES</option>
        <option value="3">FECHADOS</option>
    </select>
</div>
<div id="listagem"> </div>

<link rel="stylesheet" href="universal/css/menu.css">
<link rel="stylesheet" href="universal/css/reset.css">
<link rel="stylesheet" href="css/gerente.css">
<script type="text/javascript" src="js/gerente.js"></script>
</body>
</html>
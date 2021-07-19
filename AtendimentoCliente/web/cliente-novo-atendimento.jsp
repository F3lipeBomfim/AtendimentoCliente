<%-- 
    Document   : cliente-novo-atend
    Created on : 16/07/2021, 20:49:18
    Author     : Felipe Bomfim  
--%>

<%@ page errorPage = "erro.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/css/toastr.css" rel="stylesheet"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>
<body>
<header>
    <div id="logo" class="img left"><img src="img/logo.png"></div>
    <div id="info-cabecalho" class="left">
        <div id="boas-vindas" class="block">Bem vindo, <span>${sessionScope.nome}</span></div>
        <!--alterar dinamicamente o "span" com o nome do referido cliente no bd-->
        <div id="link-perfil" class="block"><a href="UsuarioServlet?action=editar&id=<c:out value="${sessionScope.id}"/>">Editar perfil</a></div> 
        </div>
    <nav class="right">
        <ul>
            <!-- direcione para as servlets adequadas-->
            <li id="novo_atend" class="ativo"><a href="#">NOVO ATENDIMENTO</a></li>
            <li id="meus_atend"><a href="AtendimentoServlet?action=listar_atendimentos">MEUS ATENDIMENTOS</a></li>
            <li><a href="#">SAIR</a></li>
        </ul>
    </nav>
</header>
<div id="foto-menu" class="right img"><img src="img/comment_add.png"></div>
<h1 class="left titulo">NOVO ATENDIMENTO</h1>
<span class="block msg-erro"></span>
<form id="form-novo-atend" class="block">
    <div id="campos" class="block">
        <input type="hidden" id="id_usuario" value="${sessionScope.id}">
        <input id="titulo-novo-atend" name="titulo-novo-atend" class="uk-input" type="text" placeholder="Título...">
        <textarea id="desc-novo-atend" name="desc-novo-atend" class="uk-input" type="text" placeholder="descrição..."></textarea>
    </div>
    <div class="block">
    <div id="seletor" class="left uk-margin uk-grid-uk-child-width-auto">
        <select class="uk-select left" style="margin-top: 10px" name="tipo-atend-select" id="tipo-atend-select"> </select>
    </div>
    <select class="uk-select right" name="atend-prod-select" id="atend-prod-select"> </select>
    </div>
    <button id="btn-atend-enviar" type="button" class="left uk-button uk-button-primary">ENVIAR</button>
</form>
<link rel="stylesheet" href="universal/css/menu.css">
<link rel="stylesheet" href="universal/css/reset.css">
<link rel="stylesheet" href="css/cliente.css">
<script type="text/javascript" src="js/cliente.js"></script>
</body>
</html>
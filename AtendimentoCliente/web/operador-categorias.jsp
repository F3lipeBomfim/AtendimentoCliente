<%-- 
    Document   : operador-categorias
    Created on : 18/07/2021, 17:03:39
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
    <title>Categorias</title>
    <!-- UIkit CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-rc.20/css/uikit.min.css"/>
    <!-- UIkit JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-rc.20/js/uikit.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-rc.20/js/uikit-icons.min.js"></script>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script type="text/javascript" src="universal/js/jquery.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/css/toastr.css" rel="stylesheet"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>
<body>
<header>
    <div id="logo" class="img left"><img src="img/logo.png"></div>
    <div id="info-cabecalho" class="left">
        <div id="boas-vindas" class="block">Bem vindo, <span>${sessionScope.nome}</span></div>
    </div>
    <nav class="right">
        <ul>
            <li id="atendimentos"><a href="AtendimentoServlet?action=listar_atendimentos_funcionario">ATENDIMENTOS</a></li>
            <li id="categorias" class="ativo"><a href="operador-categorias.jsp">CATEGORIAS</a></li>
            <li id="produtos"><a href="operador-produtos.jsp">PRODUTOS</a></li>
            <li><a href="index.html">SAIR</a></li>
        </ul>
    </nav>
</header>
<div id="foto-menu" class="right img"><img src="img/box.png"></div>
<h1 class="left titulo">CATEGORIAS</h1>

<div id="forms" class="block">
    <form id="form-categorias" class="block" action="" method="post">
        <div id="categorias-select" class="left uk-margin">
            <label class="uk-form-label" for="categ-selecionada">Selecione a categoria</label>
            <div class="uk-form-controls">
                <select class="uk-select" id="categ-selecionada" name="nome-categ">
                </select>
            </div>
        </div>
        <a id="editar-categ" class="categ-icon left" uk-icon="icon: cog" onclick="editarCateg();"></a>
        <a id="excluir-categ" class="categ-icon left" uk-icon="icon: trash" href="#" onclick="confirmExcl(event);"></a>
        <a id="btn-nova-categ" class="left uk-button uk-button-default" onclick="novaCateg();">NOVO</a>
    </form>

    <form id="insere-categ" class="hidden block" action="" method="post">
        <div class="left uk-margin">
            <input class="uk-input" id="nome_categoria" type="text" placeholder="Digite a categoria...">
        </div>
        <button id="btn-salvar-categ" type="button" class="left uk-button uk-button-primary" onclick="confirmIncl(event);">SALVAR</button>
        <a id="btn-cancel-categ" class="left uk-button uk-button-default" onclick="cancelar();">CANCELAR</a>
    </form>
</div>

<link rel="stylesheet" href="universal/css/menu.css">
<link rel="stylesheet" href="universal/css/reset.css">
<link rel="stylesheet" href="css/operador.css">
<script type="text/javascript" src="js/operador.js"></script>
</body>
</html>
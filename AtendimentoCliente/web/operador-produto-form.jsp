<%-- 
    Document   : operador-produto-form
    Created on : 18/07/2021, 20:46:14
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
        <title>Produtos</title>
        <!-- UIkit CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-rc.20/css/uikit.min.css"/>
        <!-- UIkit JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-rc.20/js/uikit.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-rc.20/js/uikit-icons.min.js"></script>
        <script type="text/javascript" src="universal/js/jquery.js"></script>
    </head>
    <body>
        <c:if test="${empty nome}">
            <c:set var="msg" value="Usuário deve se autenticar para acessar o sistema" scope="request" />
            <c:set var="class" value="error" scope="request" />
            <jsp:forward page="index.jsp" />
        </c:if>
        <header>
            <div id="logo" class="img left"><img src="img/logo.png"></div>
            <div id="info-cabecalho" class="left">
                <div id="boas-vindas" class="block">Bem vindo, <span>${sessionScope.nome}</span></div>
            </div>
            <nav class="right">
                <ul>
                    <li id="atendimentos"><a href="AtendimentoServlet?action=listar_atendimentos_funcionario">ATENDIMENTOS</a></li>
                    <li id="categorias"><a href="operador-categorias.jsp">CATEGORIAS</a></li>
                    <li id="produtos" class="ativo"><a href="operador-produtos.jsp">PRODUTOS</a></li>
                    <li><a href="Logout">SAIR</a></li>
                </ul>
            </nav>
        </header>
        <div id="foto-menu" class="right img"><img src="img/prod.jpg"></div>
        <h1 class="left titulo">NOVO PRODUTO</h1>
        <form id="form-prod" action="ProdutosServlet?action=adicionar_produto" method="post"><!--url que direciona para a servet de inserção de produto-->
            <div id="titulo-prod" class="block uk-margin">
                <input class="uk-input" type="text" name="nome_produto" placeholder="Nome do produto" required>
            </div>
            <div id="desc-prod" class="block uk-margin">
                <textarea class="uk-textarea" rows="5" name="descricao" placeholder="Descrição" required></textarea>
            </div>
            <div id="select-prod" class="left uk-margin">
                <label class="uk-form-label" for="form-stacked-select">Categoria</label>
                <div class="uk-form-controls">
                    <select class="uk-select" name="categoria" id="categ-selecionada">
                    </select>
                </div>
            </div>
            <div id="peso-prod" class="left uk-margin">
                <label class="uk-form-label" for="form-stacked-text">Peso(g)</label>
                <div class="uk-form-controls">
                    <input class="uk-input" name="peso" id="form-stacked-text" type="number" placeholder="" required>
                </div>
            </div>
            <div id="btn-voltar-prod" class="block uk-margin">
                <a href="operador-produtos.jsp" class="left uk-button uk-button-default">Voltar</a>
            </div>
            <div id="btn-novo-prod" class="block uk-margin">
                <button type="submit" class="left uk-button uk-button-primary">Enviar</button>
            </div>
        </form>

        <link rel="stylesheet" href="universal/css/menu.css">
        <link rel="stylesheet" href="universal/css/reset.css">
        <link rel="stylesheet" href="css/operador.css">
        <script type="text/javascript" src="js/operador.js"></script>
    </body>
</html>

<%-- 
    Document   : operador-produtos.jsp
    Created on : 18/07/2021, 17:14:33
    Author     : Felipe Bomfim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/css/toastr.css" rel="stylesheet"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
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
            <li id="atendimentos"><a href="AtendimentoServlet?action=listar_atendimentos_funcionario">ATENDIMENTOS</a></li>
            <li id="categorias"><a href="operador-categorias.jsp">CATEGORIAS</a></li>
            <li id="produtos" class="ativo"><a href="operador-produtos.jsp">PRODUTOS</a></li>
            <li><a href="Logout">SAIR</a></li>
        </ul>
    </nav>
</header>
<div id="foto-menu" class="right img"><img src="img/prod.jpg"></div>
<h1 class="left titulo">PRODUTOS</h1>

<c:if test="${not empty msg}">
    <input type="hidden" id="msg" value="${msg}" />
    <input type="hidden" id="class" value="${class}" />
</c:if>

<div id="forms" class="block">
    <form id="form-categorias" class="block" action="" method="post">
        <div id="categorias-select" class="left uk-margin">
            <label class="uk-form-label" for="categ-selecionada">Selecione a categoria</label>
            <div class="uk-form-controls">
                <select class="uk-select" id="categ-selecionada" name="nome-categ" onchange="listaProd()">
                    <option selected>SELECIONE</option><!--buscar todas  as categorias do bd-->
                </select>
            </div>
        </div>
    </form>
    <form id="form-produtos" class="hidden block" action="" method="post">
        <div id="produtos-select" class="left uk-margin">
            <label class="uk-form-label" for="prod-selecionado">Selecione o produto</label>
            <div class="uk-form-controls">
                <select class="uk-select" id="prod-selecionado" name="nome-prod">
                    <option selected>SELECIONE</option> <!--buscar todos os produtos da categoria selecionada -->
                </select>
            </div>
        </div>
        <a id="editar-prod" class="prod-icon left" uk-icon="icon: cog" href="" onclick="editarProd(event)"></a>
        <a id="excluir-prod" class="prod-icon left" uk-icon="icon: trash" href="" onclick="confirmExclProd(event);"></a>
        <a id="btn-novo-prod" class="left uk-button uk-button-default" href="operador-produto-form.jsp">NOVO</a>
        <a id="btn-cancel-categ" style="margin-top:42px" class="left uk-button uk-button-default" onclick="cancelarProd();">CANCELAR</a>
    </form>
</div>

<link rel="stylesheet" href="universal/css/menu.css">
<link rel="stylesheet" href="universal/css/reset.css">
<link rel="stylesheet" href="css/operador.css">
<script type="text/javascript" src="js/operador.js"></script>
</body>
</html>
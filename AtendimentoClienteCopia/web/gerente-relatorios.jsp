<%-- 
    Document   : gerente-relatorios
    Created on : 18/07/2021, 15:26:13
    Author     : Felipe Bomfim
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
        <script type="text/javascript" src="universal/js/jquery.mask.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/css/toastr.css" rel="stylesheet"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
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
                <div id="boas-vindas" class="block">Bem vindo, <span>${sessionScope.nome}</span></div> <!--buscar no bd e preencher o nome do gerente-->
                <!--alterar dinamicamente o "span" com o nome do referido operador no bd-->
            </div>
            <nav class="right">
                <ul>
                    <!-- direcione para as servlets adequadas-->
                    <li id="atendimentos"><a href="AtendimentoServlet?action=listar_atendimentos_gerente">ATENDIMENTOS</a></li>
                    <li id="equipe"><a href="gerente-equipe.jsp">EQUIPE</a></li>
                    <li id="relatorios" class="ativo"><a href="gerente-relatorios.jsp">RELATÓRIOS</a></li>
                    <li><a href="Logout">SAIR</a></li>
                </ul>
            </nav>
        </header>
        <div id="foto-menu" class="right img"><img src="img/report.png"></div>
        <h1 class="left titulo-atend">RELATÓRIOS</h1>

        <div class="relatorio block">
            <form method="post" action="GeradorRelatorio?action=funcionarios">
                <div class="img left"><img src="img/users.png"></div>
                <div class="topico left">EQUIPE</div>
                <div class="download right" ><button style="background:transparent;border:0;" type="submit" value=""><img src="img/pdf.png"></button></div>
            </form>
        </div>

        <div class="relatorio block">
            <form method="post" action="GeradorRelatorio?action=produtos">
                <div class="img left"><img src="img/products.jpg"></div>
                <div class="topico left">PRODUTOS MAIS RECLAMADOS</div>
                <div class="download right" ><button style="background:transparent;border:0;" type="submit" value=""><img src="img/pdf.png"></button></div>
            </form>
        </div>

        <div class="relatorio block">
            <div class="img left"><img src="img/sad.png"></div>
            <div class="topico left">RECLAMAÇÕES</div>
            <form method="post" action="GeradorRelatorio?action=reclamacoes">
                <div class="left checkbox"><input class="uk-radio" type="radio" value="Todos" name="tipo" checked>Todos</div>
                <div class="left checkbox"><input class="uk-radio" type="radio" value="Em aberto" name="tipo" >Em aberto</div>
                <div class="left checkbox"><input class="uk-radio" type="radio" value="Finalizados" name="tipo" >Finalizados</div>
                <div class="download right" ><button style="background:transparent;border:0;" type="submit" value=""><img src="img/pdf.png"></button></div>
            </form>
        </div>

        <div class="relatorio block">
            <form method="post" action="GeradorRelatorio?action=aberto">
                <div class="img left"><img src="img/support.png"></div>
                <div class="topico left">ATENDIMENTOS EM ABERTO</div>
                <div id="data-inicio" class="left"><span class="label left">DE: </span><input class="data uk-input" type="date" name="datainicio" ></div>
                <div id="data-fim" class="left"><span class="label left">ATÉ: </span><input class="data uk-input" type="date" name="datafim" ></div>
                <div class="download right" ><button style="background:transparent;border:0;" type="submit" value=""><img src="img/pdf.png"></button></div>
            </form>
        </div>

        <link rel="stylesheet" href="universal/css/menu.css">
        <link rel="stylesheet" href="universal/css/reset.css">
        <link rel="stylesheet" href="css/gerente.css">
        <script type="text/javascript" src="js/gerente.js"></script>
    </body>
</html>
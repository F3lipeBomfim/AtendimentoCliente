<%-- 
    Document   : cliente-meus-atend-detalhes
    Created on : 16/07/2021, 23:25:09
    Author     : lipe1
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
        <!--alterar dinamicamente o "span" com o nome do referido cliente no bd-->
        <div id="link-perfil" class="block"><a href="UsuarioServlet?action=editar&id=<c:out value="${sessionScope.id}"/>">Editar perfil</a></div> 
        <a href="UsuarioServlet?action=editar&id=<c:out value="${sessionScope.id}"/>"><i style="margin-top:5px" title="Editar" class="fa fa-edit" aria-hidden="true"></i></a>
    </div>
    <nav class="right">
        <ul>
            <!-- direcione para as servlets adequadas-->
            <li id="novo_atend"><a href="cliente-novo-atendimento.jsp">NOVO ATENDIMENTO</a></li>
            <li id="meus_atend" class="ativo"><a href="AtendimentoServlet?action=listar_atendimentos">MEUS ATENDIMENTOS</a></li>
            <li><a href="#">SAIR</a></li>
        </ul>
    </nav>
</header>
<div id="foto-menu" class="right img"><img src="img/support.png"></div>
<h1 class="left titulo">${fn:toUpperCase(atendimentos.titulo)}</h1> <!--buscar no bd e preencher-->

<fmt:parseDate value="${atendimentos.data}" pattern="yyyy-MM-dd HH:mm:ss" var="date"/>

<!-- Busque e exiba abaixo cada reclamação/comentário em uma div "detalhe"-->
<div class="block detalhe">
    <div class="block corpo-detalhe"> 
    ${fn:toUpperCase(atendimentos.descricao)}
    </div>
    <!--se for uma reclamação, aparece o nome do produto (como é o caso) em "prod", se tratar de um comentário, simplesmente substituir o texto por "COMENTARIO"-->
    <div class="block prod">${fn:toUpperCase(atendimentos.produto)}</div>
        <!--preencher "ultima-atualizacao" dinamicamente com a data de abertura, se não finalizado, ou data de fechamento, se já estiver fechado.-->
        <!-- trocar texto em "texto-situação" por "por [nome do cliente]" se já estiver finalizado-->
        <div class="detalhes-final right">Aberto em <span class="ultima-atualizacao"><fmt:formatDate pattern = "dd/MM/yyyy HH:mm:ss" value = "${date}" /></span> <span class="texto-situacao"> SITUAÇÃO: <strong> ${fn:toUpperCase(atendimentos.nome_situacao)}</strong></span></div>

    <!--Abaixo é a resposta. Já temos a respectiva reclamação/comentário vindo do bd. Basta apenas verificar se está respondida(finalizada). Descomente a resposta com os campos devidamente preenchidos, caso positivo-->

    <!--
    <div class="resposta block">
        <h2 class="block subtitulo">RESPOSTA</h2>
        <div class="resp-texto block">Bom dia Sr José. Se é isto que a embalagem está dizendo, acho que é, ne</div>
        <div class="resposta-final right">Finalizado em <span class="ultima-atualizacao">04/08/2018</span> por <span class="nome-atendente"> Fernanda Golçalves</span></div>
    </div>
    -->

</div>

<a class="voltar uk-button uk-button-default right" href="AtendimentoServlet?action=listar_atendimentos&id=<c:out value="${sessionScope.id}"/>">VOLTAR</a>

<link rel="stylesheet" href="universal/css/menu.css">
<link rel="stylesheet" href="universal/css/reset.css">
<link rel="stylesheet" href="css/cliente.css">
<script type="text/javascript" src="js/cliente.js"></script>
</body>
</html>
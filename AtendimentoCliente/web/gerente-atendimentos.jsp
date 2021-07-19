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
        <option>TODOS</option>
        <option>ABERTOS</option>
        <option>URGENTES</option>
        <option>FECHADOS</option>
    </select>
</div>

<c:choose>
    <c:when test="${empty atendimentos}">
        <div class="block" style='margin-left: 2%;width: 90%'>
            <div class="uk-alert-primary uk-alert" style='border-radius:8px' uk-alert="">
                <p>Você ainda não possui atendimentos!</p>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <c:forEach items="${atendimentos}" var="atendimento">
            <fmt:parseDate value="${atendimento.data}" pattern="yyyy-MM-dd HH:mm:ss" var="date"/>
            <fmt:formatDate pattern = "dd/MM/yyyy HH:mm:ss" value = "${date}" var="dataAtual" />
            
          <c:choose>
            <c:when test="${atendimento.date_diff > 7}">
             <a href="AtendimentoServlet?action=atendimento_detalhes_gerente&id=${atendimento.id}">
                <div class="atendimento urgente block">
                    <div class="left rotulo-esq">
                        <div class="block topico superior">${fn:toUpperCase(atendimento.titulo)}</div>
                        <!-- preencher dinamicamente o html em "tipo" com "RECLAMAÇÃO" ou "COMENTÁRIO" conforme classificado no bd-->
                        <!-- preencher o nome do cliente "nome" e email do cliente "email" dinamicamente-->
                        <div class="block"><span class="tipo">${fn:toUpperCase(atendimento.tipoAtendimento)}</span> - <span class="nome-cli">${atendimento.nome_usuario}</span> (<span class="email">${atendimento.email_usuario}</span>) </div>
                    </div>
                    <div class="right rotulo-dir">
                        <!-- preencher a data da última atualização (de abertura, se ainda estiver aberto ou de finalização caso contrário) em "data"-->
                        <div class="data block superior">${dataAtual}</div> 

                    </div>
                </div>
            </a>
            </c:when>
            <c:when test="${atendimento.date_diff < 7}">
             <a href="AtendimentoServlet?action=atendimento_detalhes_gerente&id=${atendimento.id}">
                <div class="atendimento aberto block">
                    <div class="left rotulo-esq">
                        <!-- pegar e preencher os respectivos dados abaixo do bd-->
                        <div class="block topico superior">${fn:toUpperCase(atendimento.titulo)}</div>
                        <div class="block"><span class="tipo">${fn:toUpperCase(atendimento.titulo)}</span> - <span class="nome-cli">${atendimento.nome_usuario}</span> (<span class="email">${atendimento.email_usuario}</span>) </div>
                    </div>
                    <div class="right rotulo-dir">
                        <div class="data block superior">${dataAtual}</div>
                    </div>
                </div>
            </a>
            </c:when>
            <c:otherwise>
             <a href="AtendimentoServlet?action=atendimento_detalhes_gerente&id=${atendimento.id}">
                    <div class="atendimento block">
                    <div class="left rotulo-esq">
                        <div class="block topico superior">${fn:toUpperCase(atendimento.titulo)}</div>
                        <div class="block"><span class="tipo">${fn:toUpperCase(atendimento.titulo)}</span> - <span class="nome-cli">${atendimento.nome_usuario}</span> (<span class="email">${atendimento.email_usuario}</span>) </div>
                    </div>
                    <div class="right rotulo-dir">
                        <div class="data block superior">${dataAtual}</div>
                    </div>
                </div>
            </a>
            </c:otherwise>
        </c:choose>
        </c:forEach>
    </c:otherwise>
</c:choose>

<link rel="stylesheet" href="universal/css/menu.css">
<link rel="stylesheet" href="universal/css/reset.css">
<link rel="stylesheet" href="css/gerente.css">
<script type="text/javascript" src="js/gerente.js"></script>
</body>
</html>
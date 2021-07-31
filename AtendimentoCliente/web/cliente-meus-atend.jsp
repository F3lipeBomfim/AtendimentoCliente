<%-- 
    Document   : cliente-meus-atend
    Created on : 16/07/2021, 20:32:01
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
        <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script type="text/javascript" src="universal/js/jquery.js"></script>
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
                <div id="boas-vindas" class="block">Bem vindo, <span>${sessionScope.nome}</span></div> 
                <div id="link-perfil" class="block"><a href="UsuarioServlet?action=editar&id=<c:out value="${sessionScope.id}"/>">Editar perfil</a></div> 
            </div>
            <nav class="right">
                <ul>
                    <!-- direcione para as servlets adequadas-->
                    <li id="novo_atend"><a href="cliente-novo-atendimento.jsp">NOVO ATENDIMENTO</a></li>
                    <li id="meus_atend" class="ativo"><a href="#">MEUS ATENDIMENTOS</a></li>
                    <li><a href="Logout">SAIR</a></li>
                </ul>
            </nav>
        </header>
        <div id="foto-menu" class="right img"><img src="img/support.png"></div>
        <h1 class="left titulo">MEUS ATENDIMENTOS</h1>
        <c:if test="${not empty msg}">
            <input type="hidden" id="msg" value="${msg}" />
            <input type="hidden" id="class" value="${class}" />
        </c:if>
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
                    <c:choose>
                        <c:when test="${atendimento.situacao == 1}">
                            <div class="comentario aberto block">
                                <div class="left rotulo-esq">
                                    <div class="block topico">${fn:toUpperCase(atendimento.titulo)}</div>
                                    <div class="left icones">
                                        <a href="AtendimentoServlet?action=detalhes_atendimento&id_atendimento=${atendimento.id}" class="left" uk-icon="more"></a> 
                                        <!--<a href="#" class="left" title="Imprimir" uk-icon="print"></a>--> 
                                        <a href="#" onclick="ExcluirRegistro(${atendimento.id})" class="left icone trash" uk-icon="trash"></a>
                                    </div>
                                    <div class="tipo left">${fn:toUpperCase(atendimento.tipoAtendimento)}</div>
                                </div>
                                <div class="right rotulo-dir">
                                    <div class="data block"><fmt:formatDate pattern = "dd/MM/yyyy HH:mm:ss" value = "${date}" /></div>
                                    <div class="situacao block">ABERTO</div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="comentario block">
                                <div class="left rotulo-esq">
                                    <div class="block topico">${fn:toUpperCase(atendimento.titulo)}</div>
                                    <div class=" block icones">
                                        <a href="AtendimentoServlet?action=detalhes_atendimento&id_atendimento=${atendimento.id}" class="left icone" title="Detalhes" uk-icon="more"></a> 
                                        <a href="#" class="left icone" title="Imprimir" uk-icon="print"></a> 
                                    </div>
                                    <div class="tipo left">${fn:toUpperCase(atendimento.tipoAtendimento)}</div>
                                </div>
                                <div class="right rotulo-dir">
                                    <div class="data block"><fmt:formatDate pattern = "dd/MM/yyyy HH:mm:ss" value = "${date}" /></div> 
                                    <div class="situacao block">FINALIZADO</div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        <link rel="stylesheet" href="universal/css/menu.css">
        <link rel="stylesheet" href="universal/css/reset.css">
        <link rel="stylesheet" href="css/cliente.css">
        <script type="text/javascript" src="js/cliente.js"></script>
    </body>
</html>
<%-- 
    Document   : listagem-gerente
    Created on : 18/07/2021, 21:40:07
    Author     : Felipe Bomfim
--%>

<%@ page errorPage = "erro.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
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
            <c:when test="${(atendimento.date_diff > 7) and (empty atendimento.data_resposta)}">
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
            <c:when test="${(atendimento.date_diff < 7) and (empty atendimento.data_resposta)}">
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
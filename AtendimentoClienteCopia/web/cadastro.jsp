<%-- 
    Document   : cadastro
    Created on : 16/07/2021, 21:27:19
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">   
    <title>Meus atendimentos</title>
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
<c:choose>
    <c:when test="${sessionScope.perfil == 3}">
        <header>
          <div id="logo" class="img left"><img src="img/logo.png"></div>
          <div id="info-cabecalho" class="left">
              <div id="boas-vindas" class="block">Bem vindo, <span>${sessionScope.nome}</span></div> 
          </div>
          <nav class="right">
              <ul>
                  <!-- direcione para as servlets adequadas-->
                  <li id="atendimentos"><a href="gerente-atendimentos.jsp">ATENDIMENTOS</a></li>
                  <li id="equipe" class="ativo"><a href="gerente-equipe.jsp">EQUIPE</a></li>
                  <li id="relatorios"><a href="gerente-relatorios.jsp">RELATÓRIOS</a></li>
                  <li><a href="index.html">SAIR</a></li>
              </ul>
          </nav>
      </header>
      <div id="foto-menu" class="right img"><img src="img/users.png"></div>
        <c:choose>
            <c:when test="${not empty usuario.id}">
                <h1 class="left titulo-atend">EDITAR MEMBRO</h1>
            </c:when>
            <c:otherwise>
                <h1 class="left titulo-atend">NOVO MEMBRO</h1>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <header>
          <div id="logo" class="img left"><img src="img/logo.png"></div>
          <div id="info-cabecalho" class="left">
              <div id="boas-vindas" class="block">Bem vindo, VISITANTE</div>
          </div>
          <nav class="right">
              <div id="login-key" class="right img"><a href="index.jsp"><img src="img/signin.png"></a></div>
          </nav>
      </header>
    </c:otherwise>
</c:choose>

<form class="block" action="UsuarioServlet?action=adicionar" method="post" onsubmit="return validaSenha();">
    <input type="hidden" id="id_estado_hidden" value="<c:out value="${usuario.id_estado}" /> " />
    <input type="hidden" id="id_cidade_hidden" value="<c:out value="${usuario.id_cidade}" /> " />
    <input type="hidden" id="id" name="id" value="<c:out value="${usuario.id}" />"/>

    <fieldset class="left-fieldset">
        <h2 class="subtopico">Dados pessoais</h2>
        <div class="large-input uk-margin">
            <label class="uk-form-label" for="nome">Nome completo</label>
            <div class="nome uk-form-controls">
                <input class="uk-input" id="nome" name="nome" value="${usuario.nome}" type="text" placeholder="" required>
            </div>
        </div>
        <div class="medium-input uk-margin">
            <label class="uk-form-label" for="email">Email</label>
            <div class="nome uk-form-controls">
                <input class="uk-input" id="email" name="email"  value="${usuario.email}" type="email" placeholder="" required>
            </div>
        </div>
        <div class="short-input uk-margin">
            <label class="uk-form-label" for="cpf">CPF</label>
            <div class="nome uk-form-controls">
                <input class="uk-input" id="cpf" name="cpf" type="text" value="${usuario.cpf}" placeholder="000.000.000-00" required>
            </div>
        </div>
        <div class="short-input uk-margin">
            <label class="uk-form-label" for="tel">Telefone</label>
            <div class="nome uk-form-controls">
                <input class="uk-input" id="tel" name="tel" type="text" value="${usuario.telefone}" placeholder="(00)0000-0000" required>
            </div>
        </div>
        <div class="short-input uk-margin uk-grid-small uk-child-width-auto uk-grid">
            <label><input class="uk-radio" value="1" <c:if test="${usuario.tipo_tel == 1}"> checked</c:if> id="fixo" type="radio" name="tipoTel" onclick="setMask('#tel','(00)0000-0000')" checked>Fixo</label>
            <label><input class="uk-radio" value="2" <c:if test="${usuario.tipo_tel == 2}"> checked</c:if> type="radio" name="tipoTel" onclick="setMask('#tel','(00)00000-0000')">Celular</label>
        </div>
        <div class="short-input uk-margin">
            <label class="uk-form-label" for="senha">Senha</label>
            <div class="nome uk-form-controls">
                <input class="uk-input" id="senha" name="senha" type="password" placeholder="">
            </div>
        </div>
        <div class="short-input uk-margin">
            <label class="uk-form-label" for="pwd">Confirmação da senha</label>
            <div class="nome uk-form-controls">
                <input class="uk-input" id="pwd" type="password" placeholder="" >
            </div>
        </div>
        <div id="msg-erro"></div>
    </fieldset>
    <fieldset class="right-fieldset">
        <h2 class="subtopico">Endereço</h2>
        <div class="short-input uk-margin">
            <label class="uk-form-label" for="cep">CEP</label>
            <div class="nome uk-form-controls">
                <input class="uk-input" id="cep" value="${usuario.cep}" onblur="BuscarCep(this.value)" name="cep" type="text" placeholder="00.000-000" required>
            </div>
        </div>
        <div class="short-input uk-margin" style="width:53% !important">
            <label class="uk-form-label" for="rua">Logradouro</label>
            <div class="nome uk-form-controls">
                <input class="uk-input" id="rua" value="${usuario.logradouro}" name="rua" type="text" placeholder="" required>
            </div>
        </div>
        <div class="short-input uk-margin">
            <label class="uk-form-label" for="num">Apto/número</label>
            <div class="nome uk-form-controls">
                <input class="uk-input" id="num" name="num" value="${usuario.numero}" type="text" placeholder="" required>
            </div>
        </div>
        <div class="short-input uk-margin">
            <label class="uk-form-label" for="complemento">Complemento</label>
            <div class="nome uk-form-controls">
                <input class="uk-input" id="complemento" value="${usuario.complemento}" name="complemento" type="text" placeholder="" required>
            </div>
        </div>
      
        <div class="shorter-input uk-margin">
            <label class="uk-form-label" for="uf">UF</label>
            <select class="nome uk-select"  placeholder="Estados" name="id_estado" id="estado">
            </select>
        </div>
        <div class="medium-input uk-margin">
            <label class="uk-form-label" for="cidade">Cidade</label>
            <select class="nome uk-select"  placeholder="Estados" name="id_cidade" id="cidade">
            </select>
        </div>
        <div class="medium-input uk-margin">
            <label class="uk-form-label" for="bairro">Bairro</label>
            <div class="nome uk-form-controls">
                <input class="uk-input" id="bairro" name="bairro" value="${usuario.bairro}" type="text" placeholder="" required>
            </div>
        </div>
    </fieldset>
<c:choose>
    <c:when test="${sessionScope.perfil == 3}">
        <fieldset id="permissao" class="left">
            <div class="large-input uk-margin uk-grid-small uk-child-width-auto uk-grid">
                <label class="left"><input class="uk-radio" type="radio" value="2" name="permissao" <c:if test="${usuario.perfil == 2}"> checked</c:if>>Operador</label>
                <label class="left"><input class="uk-radio" type="radio" value="3" name="permissao" <c:if test="${usuario.perfil == 3}"> checked</c:if>>Gerente</label>
            </div>
        </fieldset>
        <a id="cancelar" href="gerente-equipe.jsp" class="uk-button uk-button-default uk-button-large right">CANCELAR</a>
          <c:choose>
            <c:when test="${not empty usuario.id}">
                <button type="submit" class="uk-button uk-button-primary uk-button-large right">EDITAR</button>
            </c:when>
            <c:otherwise>
                <button type="submit" class="uk-button uk-button-primary uk-button-large right">CADASTRAR</button>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
          <input type="hidden" name="permissao" value=""> 
          <button type="submit" style="font-size:18px" class="uk-button uk-button-primary uk-button-large">SALVAR</button>
    </c:otherwise>
</c:choose>
</form>
<link rel="stylesheet" href="universal/css/menu.css">
<link rel="stylesheet" href="universal/css/reset.css">
<link rel="stylesheet" href="css/cadastro.css">
<link rel="stylesheet" href="css/gerente.css">
<script type="text/javascript" src="js/cadastro.js"></script>
</body>
</html>
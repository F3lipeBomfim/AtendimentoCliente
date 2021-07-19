<%-- 
    Document   : index
    Created on : 13/07/2021, 21:02:09
    Author     : lipe1
--%>

<%@page errorPage = "erro.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>BEIBE</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, inicial-scale=1"/>
    <!-- UIkit CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-rc.20/css/uikit.min.css" />
    <!-- UIkit JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-rc.20/js/uikit.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/uikit/3.0.0-rc.20/js/uikit-icons.min.js"></script>
    <script type="text/javascript" src="universal/js/jquery.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/2.0.1/css/toastr.css" rel="stylesheet"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <link rel="stylesheet" href="css/index.css">
</head>
<body>
<form method="POST" action='Login' name="frmAddUser">
    <div class="uk-conteiner uk-conteiner-center uk-align-center">
        <div class="uk-height-medium uk-flex uk-flex-center uk-flex-middle uk-background-contain uk-light"
             data-src="img/logo-beibe.PNG" uk-img></div>
        <div class="areaformulario">
            <form action="cliente-meus-atend.html" method="post">
                <input class="uk-input uk-form-width-medium uk-form-width-large" name="email" type="text" placeholder="E-mail" required><br><br>
                <input class="uk-input uk-form-width-medium uk-form-width-large" name="senha" type="password" placeholder="Senha" required><br>
                <c:if test="${not empty msg}">
                    <input type="hidden" id="msg" value="${msg}" />
                    <input type="hidden" id="class" value="${class}" />
                </c:if>
                <p>
                    <button class="uk-button uk-button-primary">LOGIN</button>
                    <a class="uk-button uk-button-default" href="cadastro.jsp">CADASTRO</a>
                </p>
            </form>
        </div>
    </div>
</form>
<script type="text/javascript" src="js/index.js"></script>
</body>
</html>
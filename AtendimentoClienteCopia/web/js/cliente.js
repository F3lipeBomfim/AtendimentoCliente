/* CLIENTE-NOVO-ATENDIMENTO*/
$(document).ready(function () {
    getProdutos();
    getTipoAtendimento();
    
    if($('#msg').val() != "" && $('#msg').val() != undefined){
        var classe = $("#class").val(); 
        toastr[classe]($("#msg").val());
    }
});

$("body").on("click", function(e){
    if (e.target.textContent == "OK"){
        location.reload();
    }
});  

function ExcluirRegistro(id){
    
    swal.fire({
        title: "Confirme, por favor",
        text: "Você realmente gostaria de remover este registro?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "Sim, continue!",
        cancelButtonText: "Não, cancelar!",
        closeOnConfirm: false,
        closeOnCancel: false,
        showClass: {
            popup: 'animate__animated animate__fadeInDown'
        }
        }).then((isConfirm) =>{
        if (isConfirm.value) {
            $.ajax({
            method: "POST",
            url: 'AtendimentoServlet?action=remover&id_atendimento='+id, 
            }).done(function( msg ) {
                toastr["success"]("Registro removido com sucesso!")
            });
            swal.fire("Removido!", "O registro foi removido com sucesso.", "success");
        } else {
            swal.fire("Cancelado", "Remoção cancelada pelo usuário", "error");
        }
    });
    
}
function getProdutos(){
    var estadoId = $("#estado").val();
    var url = "AJAXServlet?action=getProdutos";
    $.ajax({
        url : url, 
        data : {
            estadoId : estadoId
        }, 
        dataType : 'json',  
        success : function(data) {
            $("#atend-prod-select").empty();
            $("#atend-prod-select").append('  <option value="" selected>Escolha um Produto</option>');
            $.each(data, function(i, obj) {
                $("#atend-prod-select").append('<option value=' + obj.id + '>' + obj.nome + '</option>');
            });
        },
        error : function(request, textStatus, errorThrown) {
            alert(request.status + ', Error: ' + request.statusText);
        }
    });
}
function getTipoAtendimento(){
    var estadoId = $("#estado").val();
    var url = "AJAXServlet?action=getTipoAtendimento";
    $.ajax({
        url : url, 
        data : {
            estadoId : estadoId
        }, 
        dataType : 'json',  
        success : function(data) {
            $("#tipo-atend-select").empty();
            $("#tipo-atend-select").append('  <option value="" selected>Selecione o tipo de atendimento</option>');
            $.each(data, function(i, obj) {
                $("#tipo-atend-select").append('<option value=' + obj.id_tipo + '>' + obj.nome_tipo + '</option>');
            });
        },
        error : function(request, textStatus, errorThrown) {
            alert(request.status + ', Error: ' + request.statusText);
        }
    });
}

function desabilitaSelectProd(param) {
    $('#atend-prod-select').prop('disabled',param);
}
function atualizarListagem(){
     setTimeout(function(){
        window.location.href = "AtendimentoServlet?action=listar_atendimentos";
    }, 1000);
}
$("#btn-atend-enviar").on("click", function() {
    var result;
    if($('#titulo-novo-atend').val().length == 0 ) {
        $('.msg-erro').html("Título é obrigatório!");
        $('#titulo-novo-atend').addClass("error");
        result = false;
    }else {
        $('#titulo-novo-atend').removeClass("error");
    }
    if($('#tipo-atend-select').val() == '') {   
        $('.msg-erro').html("Selecione o tipo de atendimento!");
        $('#tipo-atend-select').addClass('error');
        result = false;
    }else{
        $('#tipo-atend-select').removeClass('error');
    }
    if($('#atend-prod-select').val() == '') {
        $('.msg-erro').html("Selecione um produto!");
        $('#atend-prod-select').addClass('error');
        result = false;
    }else{
        $('#atend-prod-select').removeClass('error');
    }
    if($('#desc-novo-atend').val().length == 0) {
        $('.msg-erro').html("Escreva uma descrição!");
        $('#desc-novo-atend').addClass("error");
        result = false;
    }else {
        $('#desc-novo-atend').removeClass("error");
    }
    
    if (result == false){
        return result
    }else{
        var userID = $("#id_usuario").val();
        $.post("AtendimentoServlet?action=novo_atendimento&id_usuario="+userID,$("#form-novo-atend").serialize(),
            // pegando resposta do retorno do post
            function (response)
            {
                if (response == 0) {
                    toastr["success"]("Sucesso ao adicionar registro!");
                    atualizarListagem();
                } else {
                    toastr["success"]("Erro ao adicionar registro!");
                }
            }
            , "json" // definindo retorno para o formato json
        );
    }
});
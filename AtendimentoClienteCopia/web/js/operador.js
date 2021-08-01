$(document).ready(function () {
    if($('#msg').val() != "" && $('#msg').val() != undefined){
        var classe = $("#class").val(); 
        toastr[classe]($("#msg").val());
    }
    AtualizarListagem(0);
    getCategorias();
});
//categorias
function getCategorias(){
    var url = "AJAXServlet?action=getCategorias";
    $.ajax({
        url : url, 
        dataType : 'json',  
        success : function(data) {
            $("#categ-selecionada").empty();
            $("#categ-selecionada").append('  <option value="" selected>SELECIONE</option>');
            $.each(data, function(i, obj) {
                $("#categ-selecionada").append('<option value=' + obj.id_categoria + '>' + obj.nome_categoria + '</option>');
            });
        },
        error : function(request, textStatus, errorThrown) {
            alert(request.status + ', Error: ' + request.statusText);
        }
    });
}

$("#categ-selecionada" ).change(function() {
    getProdutos();
});

function getProdutos(){
    var idCategoria = $("#categ-selecionada").val();
    var url = "AJAXServlet?action=getProdutosCat";
    $.ajax({
        url : url, 
        data : {
            id_categoria : idCategoria
        }, 
        dataType : 'json',
        success : function(data) {
            $("#prod-selecionado").empty();
            $("#prod-selecionado").append('  <option value="" selected disabled hidden>SELECIONE</option>');
            $.each(data, function(i, obj) {
                $("#prod-selecionado").append('<option value=' + obj.id + '>' + obj.nome + '</option>');
            });
        },
        error : function(request, textStatus, errorThrown) {
            alert(request.status + ', Error: ' + request.statusText);
        }
    });
}

function AtualizarListagem(filtro){
    $("#listagem").load("AtendimentoServlet?action=listagem_filtros&filtro="+filtro);
}   

$("#opcoes-prod").on("change", function(){
    AtualizarListagem($("#opcoes-prod option:selected").val());
});
function novaCateg() {
    $('#categ-selecionada').val("");
    $('#insere-categ').removeClass('hidden');
    $("#editar-categ").addClass('hidden');
    $("#excluir-categ").addClass('hidden');
    $("#btn-nova-categ").addClass('hidden');
    $('#categ-selecionada').attr("disabled",true);
}
function cancelar(){
    $('#insere-categ').addClass('hidden');
    $("#editar-categ").removeClass('hidden');
    $("#excluir-categ").removeClass('hidden');
    $("#btn-nova-categ").removeClass('hidden');
    $('#categ-selecionada').attr("disabled",false);
    $('#insere-categ input').val("");
}

function editarCateg(event) {
    if($('#categ-selecionada').prop('selectedIndex') != 0) {
        var nome = $('#categ-selecionada option:selected').text();
        $('#insere-categ').removeClass('hidden');
        $("#editar-categ").addClass('hidden');
        $("#excluir-categ").addClass('hidden');
        $("#btn-nova-categ").addClass('hidden');
        $('#categ-selecionada').attr("disabled", true);
        $('#insere-categ input').val(nome).focus();
    }else
        event.preventDefault();
}
function confirmExcl(e) {
    if($('#categ-selecionada').prop('selectedIndex') != 0) {
        var param = $('#categ-selecionada option:selected').text();
        swal.fire({
        title: "Confirme, por favor",
        text: "Excluir a categoria '" + param + "' ?",
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
            url: 'ProdutosServlet?action=remover_categoria&id='+$('#categ-selecionada option:selected').val(), 
            }).done(function( msg ) {
                toastr["success"]("Sucesso ao remover categoria!")
            });
            swal.fire("Removido!", "O registro foi removido com sucesso.", "success");
        } else {
            swal.fire("Cancelado", "Remoção cancelada pelo usuário", "error");
        }
        });
    }else
        toastr["warning"]("Selecione uma categoria para a exclusão!")

}
$("body").on("click", function(e){
    if (e.target.textContent == "OK"){
        location.reload();
    }
});  
function confirmIncl(e) {
    var param = $('#insere-categ input').val();
    var nome = $('#categ-selecionada option:selected').text();
    if(param == nome){
        e.preventDefault();
    }else{
        var msg;
        if($('#categ-selecionada option:selected').val() == ""){
            msg = "Você gostaria de adicionar essa categoria?";
        }else{
            msg = "Você gostaria de modificar essa categoria";
        }
        swal.fire({
        title: "Confirme, por favor",
        text: msg,
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
            url: 'ProdutosServlet?action=adicionar_categoria&id='+$('#categ-selecionada option:selected').val()+ '&nome_categoria='+$('#nome_categoria').val(), 
            }).done(function( msg ) {
                toastr["success"]("Sucesso ao executar operação!")
            });
            swal.fire("Removido!", "O registro foi removido com sucesso.", "success");
        } else {
            swal.fire("Cancelado", "Remoção cancelada pelo usuário", "error");
        }
        });
    }
}
//produtos
function listaProd(){
    if($('#categ-selecionada').prop('selectedIndex') != 0) {
        $('#categ-selecionada').attr("disabled",true);
        $('#form-produtos').removeClass('hidden');
    }
}

function novoProd(e) {
    if($('#prod-selecionado').prop('selectedIndex') != 0) {
        $('#insere-prod').removeClass('hidden');
        $("#editar-prod").addClass('hidden');
        $("#excluir-prod").addClass('hidden');
        $("#btn-nova-prod").addClass('hidden');
        $('#prod-selecionado').attr("disabled", true);
    }else{
        e.preventDefault();
    }
}
function cancelarProd(){
    $('#form-produtos').addClass('hidden');
    $("#insere-prod").addClass('hidden');
    $('#categ-selecionada').attr("disabled",false);
    $("#categ-selecionada").val($("#categ-selecionada option:first"));
    $("#prod-selecionado").val($("#prod-selecionada option:first"));
    $('#btn-cancel-categ').removeClass('hidden');
    $('#insere-prod input').val("");
}

function editarProd(event) {
    if($('#prod-selecionado').prop('selectedIndex') != 0) {
        var nome = $('#prod-selecionado option:selected').text();
        $('#insere-prod').removeClass('hidden');
        $("#editar-prod").addClass('hidden');
        $("#excluir-prod").addClass('hidden');
        $("#btn-novo-prod").addClass('hidden');
        $('#categ-selecionado').attr("disabled", true);
        $('#btn-cancel-categ').addClass('hidden');
        $('#insere-prod input').val(nome).focus();
        $('#insere-prod textArea').val('').focus();
    }else
        event.preventDefault();
        console.log('caius');
}
function confirmExclProd(e) {
    console.log('oi');
    if($('#prod-selecionado').prop('selectedIndex') != 0) {
        var param = $('#prod-selecionado option:selected').text();
        var id = $('#prod-selecionado option:selected').val();
        swal.fire({
        title: "Confirme, por favor",
        text: "Excluir o produto '" + param + "' ?",
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
            url: 'ProdutosServlet?action=remover_produto&id='+id, 
            }).done(function( msg ) {
                toastr["success"]("Sucesso ao executar operação!")
            });
            swal.fire("Removido!", "O registro foi removido com sucesso.", "success");
        } else {
            swal.fire("Cancelado", "Remoção cancelada pelo usuário", "error");
        }
        });
    }else
        event.preventDefault(e);
}

function confirmInclProd(e) {
    var param = $('#insere-prod input').val();
    var nome = $('#prod-selecionado option:selected').text();
    
    if(param == nome){
        e.preventDefault();
    }else{
        var msg;
        if($('#prod-selecionado option:selected').val() == ""){
            msg = "Você gostaria de adicionar esse produto?";
        }else{
            msg = "Você gostaria de modificar esse produto";
        }
        swal.fire({
        title: "Confirme, por favor",
        text: msg,
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
            url: 'ProdutosServlet?action=alterar_produto&id='+$('#prod-selecionado option:selected').val()+ '&nome_prod='+$('#nome_prod').val()+ '&desc_prod='+$('#desc_prod').val(), 
            }).done(function( msg ) {
                toastr["success"]("Sucesso ao executar operação!")
            });
            swal.fire("Alterado!", "O registro foi alterado com sucesso.", "success");
        } else {
            swal.fire("Cancelado", "Alteração cancelada pelo usuário", "error");
        }
        });
    }
}
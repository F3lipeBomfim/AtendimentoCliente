/* EQUIPE */
$(document).ready(function () {
    if($('#msg').val() != "" && $('#msg').val() != undefined){
        var classe = $("#class").val(); 
        toastr[classe]($("#msg").val());
    }
    getEquipe();
});

function getEquipe(){
    var estadoId = $("#estado").val();
    var url = "AJAXServlet?action=getEquipe";
    $.ajax({
        url : url, 
        data : {
            estadoId : estadoId
        }, 
        dataType : 'json',
        success : function(data) {
            $("#membro-selecionado").empty();   
            $("#membro-selecionado").append('  <option value="" selected>EMAIL</option>');
            $.each(data, function(i, obj) {
                $("#membro-selecionado").append('<option value=' + obj.id + '>' + obj.nome+ ' (' +obj.email+ ')'  + '</option>');
            });
        },
        error : function(request, textStatus, errorThrown) {
            alert(request.status + ', Error: ' + request.statusText);
        }
    });
}
$("body").on("click", function(e){
    if (e.target.textContent == "OK"){
         location.reload();
    }
});  
function confirmExcluir(e) {
    if($('#membro-selecionado').prop('selectedIndex') != 0) {
        var param = $('#membro-selecionado option:selected').text();
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
                url: 'UsuarioServlet?action=remover&id_usuario='+$('#membro-selecionado option:selected').val(), 
                }).done(function( msg ) {
                    toastr["success"]("Registro removido com sucesso!")
                });
                swal.fire("Removido!", "O registro foi removido com sucesso.", "success");
            } else {
                swal.fire("Cancelado", "Remoção cancelada pelo usuário", "error");
            }
        });
    }else {
        event.preventDefault();
        Swal.fire({
            icon: 'info',
            title: 'Oops...',
            text: 'Por favor, selecione um membro da equipe para continuar!',
        })
    }
}
function editarMembro(e) {
    if($('#membro-selecionado').prop('selectedIndex') == 0) {
        Swal.fire({
            icon: 'info',
            title: 'Oops...',
            text: 'Por favor, selecione um membro da equipe para continuar!',
        })
        e.preventDefault();
    }else{
        var idUsuario = $('#membro-selecionado option:selected').val();
        window.location.href = "UsuarioServlet?action=editar&id="+idUsuario;
    }
}

$(document).ready(function () {
    $('#tel').mask('(00)0000-0000');
    $('#cpf').mask('000.000.000-00');
    $('#cep').mask('00.000-000');
});

function setMask(div,mask) {
    $(div).attr("placeholder",mask).mask(mask);
}

function validaSenha() {
    if(($('#senha').val()).localeCompare($('#pwd').val()) != 0 ){
        $('#msg-erro').html("Senhas não correspondem");
        return false;
    }
    $('#msg-erro').html("");
    return true;
}

/* RELATORIOS */

function toggleData() {
    var inicio = $('#data-inicio .data');
    var fim = $('#data-fim .data');
    var checkbox = $('.checkbox input');

    if(checkbox.is(':checked')){
        inicio.prop("disabled", true);
        fim.prop("disabled", true);
        fim.val("");
    }else{
        inicio.prop("disabled", false);
        fim.prop("disabled", false);
        var d = new Date();
        var month = d.getMonth()+1;
        var day = d.getDate();
        if(day < 10){
            day = "0"+day;
        }
        var year = d.getFullYear();
        fim.val(year+"-"+month+"-"+day);

    }
}
function verificaData(event) {
    var inicio = $('#data-inicio .data');
    var fim = $('#data-fim .data');
    var checkbox = $('.checkbox input');

    if(!checkbox.is(':checked') && ((inicio.val() == "" || fim.val() == ""))){
        alert("Obrigatório data de início e fim");
        event.preventDefault();
    }

}
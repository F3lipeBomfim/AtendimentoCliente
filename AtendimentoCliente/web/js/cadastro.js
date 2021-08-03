toastr.options = {
  "closeButton": false,
  "debug": false,
  "newestOnTop": false,
  "progressBar": true,
  "positionClass": "toast-top-right",
  "preventDuplicates": false,
  "onclick": null,
  "showDuration": "300",
  "hideDuration": "1000",
  "timeOut": "5000",
  "extendedTimeOut": "1000",
  "showEasing": "swing",
  "hideEasing": "linear",
  "showMethod": "fadeIn",
  "hideMethod": "fadeOut"
}

$(document).ready(function () {
    $('#tel').mask('(00)0000-0000');
    $('#cpf').mask('000.000.000-00');
    $('#cep').mask('00.000-000');
    
    if($('#cpf').val() != ''){
        $('#cpf').attr("disabled", "disabled");
    }
    if($('#email').val() != ''){
       $('#email').attr("disabled", "disabled");
    }
    if($('#id_estado_hidden').val() != '' && $('#id_estado_hidden').val() != 0){
        var id_estado = $('#id_estado_hidden').val();
        setTimeout(function(){
            $('#estado').val(parseInt(id_estado)).attr('selected', 'selected');
                getCidades();
            setTimeout(function(){
                var id_cidade = $('#id_cidade_hidden').val();
                $('#cidade').val(parseInt(id_cidade)).attr("selected", "selected");
            }, 300);
        }, 300);
    }

    getEstados();
});

$("#estado" ).change(function() {
    getCidades();
});
function getEstados(){
    var estadoId = $("#estado").val();
    var url = "AJAXServlet?action=getEstados";
    $.ajax({
        url : url, 
        data : {
            estadoId : estadoId
        }, 
        dataType : 'json',
        success : function(data) {
            $("#estado").empty();
            $("#estado").append('  <option value="" selected disabled hidden>Escolha um estado</option>');
            $.each(data, function(i, obj) {
                $("#estado").append('<option data-uf=' + obj.uf + ' value=' + obj.id + '>' + obj.nome + '</option>');
            });
        },
        error : function(request, textStatus, errorThrown) {
            alert(request.status + ', Error: ' + request.statusText);
        }
    });
}
function getCidades(){
    var estadoId = $("#estado").val();
    var url = "AJAXServlet?action=getCidades";
    $.ajax({
        url : url, 
        data : {
            estadoId : estadoId
        }, 
        dataType : 'json',
        success : function(data) {
            $("#cidade").empty();
            $("#cidade").append('  <option value="" selected disabled hidden>Escolha uma cidade</option>');
            $.each(data, function(i, obj) {
                $("#cidade").append('<option value=' + obj.id_cidade + '>' + obj.nome + '</option>');
            });
        },
        error : function(request, textStatus, errorThrown) {
            alert(request.status + ', Error: ' + request.statusText);
        }
    });
}

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
function verificaCPF(cpf){
    var url = "AJAXServlet?action=verificaCPF";
    $.ajax({
        url : url, 
        data : {
            cpf : cpf,
        }, 
        dataType : 'json',
        success : function(data) {
            if(data == true){
                toastr["error"]("CPF já cadastrado!")
                $("#cpf").val("");
                $("#cpf").focus();
            }
        },
        error : function(request, textStatus, errorThrown) {
            alert(request.status + ', Error: ' + request.statusText);
        }
    });
    
}
function BuscarCep(cep){
    var cep_final = cep.replace("-", "");
        cep_final = cep_final.replace(".", "");   
    var url = 'https://viacep.com.br/ws/'+ cep_final +'/json/';

    $.getJSON(url, function(result) {
        if(result.uf != ""){
            var estado = $('#uf option:contains("'+result.uf+'")').val();
            var id_estado = $('#estado option[data-uf="' + result.uf + '"]').val();
            $('#estado').val(id_estado).attr("selected", "selected");
            if($('#estado').val() > 0){
                getCidades();
            }
            setTimeout(function(){
                var id_cidade = $('#cidade option:contains("'+result.localidade+'")').val();
                $('#cidade').val(id_cidade).attr("selected", "selected");
            }, 1000);
        
            $('#uf').val(estado).attr("selected", "selected");
            $('#rua').val(result.logradouro);
            $('#cidade').val(result.localidade);
            $('#bairro').val(result.bairro);
            $('#nr_cliente').focus();
        }
        if (("erro" in result)) {
            alert("Cep não encontrado!");
        }
    });
}
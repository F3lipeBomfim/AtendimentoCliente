/* CLIENTE-NOVO-ATENDIMENTO*/

function desabilitaSelectProd(param) {
    $('#atend-prod-select').prop('disabled',param);
}

function validaFormAtend() {
    if($('#titulo-novo-atend').val().length == 0 ) {
        $('.msg-erro').html("Todos os campos são obrigatorios");
        $('#titulo-novo-atend').addClass("error");
        $('#atend-prod-select').removeClass('error');
        return false;
    }else {
        $('.msg-erro').html("");
        $('#titulo-novo-atend').removeClass("error");
    }

    if($('#desc-novo-atend').val().length == 0) {
        $('.msg-erro').html("Todos os campos são obrigatorios");
        $('#desc-novo-atend').addClass("error");
        $('#atend-prod-select').removeClass('error');
        return false;
    }else {
        $('.msg-erro').html("");
        $('#desc-novo-atend').removeClass("error");
    }

    if($('#recl-radio').prop("checked") && $('#atend-prod-select').prop('selectedIndex') == 0) {
        $('.msg-erro').html("Selecione um produto");
        $('#atend-prod-select').addClass('error');
        return false;
    }
    return true;
}
/* EQUIPE */

function confirmExcluir(e) {
    if($('#membro-selecionado').prop('selectedIndex') != 0) {
        var param = $('#membro-selecionado option:selected').text();
        if (!confirm("Excluir o membro '" + param + "' da equipe?")) {
            e.preventDefault();
        }
    }else {
        event.preventDefault();
        alert("Selecione um membro da equipe");
    }
}
function editarMembro(e) {
    if($('#membro-selecionado').prop('selectedIndex') == 0) {
        alert("Selecione um membro da equipe");
        e.preventDefault();
    }
}

/* NOVO/EDITAR */

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
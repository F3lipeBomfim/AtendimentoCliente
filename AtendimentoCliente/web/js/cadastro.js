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
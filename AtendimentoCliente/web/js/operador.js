
//categorias

function novaCateg() {
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
        if (!confirm("Excluir a categoria '" + param + "' ?")) {
            e.preventDefault();
        }
    }else
        event.preventDefault(e);
}
function confirmIncl(e) {
    var param = $('#insere-categ input').val();
    var nome = $('#categ-selecionada option:selected').text();
    if(param == nome || !confirm("Incluir a categoria '"+param+"' ?")){
        e.preventDefault();
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
    }else
        event.preventDefault();
}
function confirmExclProd(e) {
    if($('#prod-selecionado').prop('selectedIndex') != 0) {
        var param = $('#prod-selecionado option:selected').text();
        if (!confirm("Excluir o produto '" + param + "' ?")) {
            e.preventDefault();
        }
    }else
        event.preventDefault(e);
}

$(document).ready(function () {
    if($('#msg').val() != ""){
        var classe = $("#class").val(); 
        toastr[classe]($("#msg").val());
    }
});
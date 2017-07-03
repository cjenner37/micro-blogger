$(document).ready(function () {
    $('#edit-profile').click(function () { 
        $('#myModal').modal('show');
    });

    $('#submit-edit-profile').click(function () {
    	$('#edit-profile-form').submit();
    });
});
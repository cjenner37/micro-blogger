$(document).ready(function () {
    $('#edit-profile').click(function () { 
        $('#myModal').modal('show');
    });

    $('#submit-edit-profile').click(function () {
    	$('#edit-profile-form').submit();
    });

    $('#add-comment').click(function () { 
    	console.log("clicked");
        $('#commentModal').modal('show');
    });

    $('#submit-comment').click(function () {
    	$('#write-comment-form').submit();
    });

    $('#user-search').keyup(function () {
    	let searchTerm = $(this).val();
    	if (searchTerm != "") {
    		searchFor(searchTerm);
    	} else {
    		$('#search-results').empty();
    	}
    });

});

function searchFor(searchTerm) {
	$.post('/search_users', {name: searchTerm}, function (html) {
		$('#search-results').html(html);
	});
};
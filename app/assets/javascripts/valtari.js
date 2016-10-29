$(document).on('turbolinks:load', function() {
 jQuery(".best_in_place").best_in_place();

 	//Max characters in decimal input
	var max_chars = 4;

	$('input.decimal').keydown( function(e){
    	if ($(this).val().length >= max_chars) { 
        	$(this).val($(this).val().substr(0, max_chars));
    	}
	});

	$('.input.decimal').keyup( function(e){
    	if ($(this).val().length >= max_chars) { 
        	$(this).val($(this).val().substr(0, max_chars));
    	}
	});

});



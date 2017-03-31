$(document).on('turbolinks:load', function() {
  jQuery(".best_in_place").best_in_place();

 	//Max characters in decimal input
	$('input.decimal').keypress(function(e) {
	    var tval = $('textarea').val(),
	        tlength = tval.length,
	        set = 5,
	        remain = parseInt(set - tlength);
	    $('p').text(remain);
	    if (remain <= 0 && e.which !== 0 && e.charCode !== 0) {
	        $('textarea').val((tval).substring(0, tlength - 1))
	    }
	})
    $('select').material_select();

    //Resize columns w/ colResizable-1.5.min.js
    $(".resizable").colResizable ({
    	liveDrag:true,
        resizeMode: 'fit',
    	'hoverCursor': "col-resize",
    	postbackSafe: true,
        minWidth: 90,
    	gripInnerHtml:"<div class='grip'></div>", 
    	draggingClass:"dragging" 
    });


});


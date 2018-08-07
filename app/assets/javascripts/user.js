
$( document ).ready(function() {

    if($('#user_public_setting').prop('checked')){
  		$('.private').addClass("hide");
	} else {
  		$('.public').addClass("hide");
    }
});

$(function() {
  	$('#user_public_setting').change( function() {

		if($(this).prop('checked')){
	  		$('.public').removeClass("hide");
	  		$('.private').addClass("hide");
		} else {
	  		$('.public').addClass("hide");
	  		$('.private').removeClass("hide");
	    }
  	});
});
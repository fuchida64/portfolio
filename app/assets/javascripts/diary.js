
$('input[type=file]').on('change', function (e) {
	var
      str = $(this).attr("id"),
      num = str.match(/\d/g).join("");
    var reader = new FileReader();
    reader.onload = function (e) {
        $(".preview" + num).attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
});

$(function() {
  	$('#public-id').change( function() {

		if($(this).prop('checked')){
	  		$('.public').removeClass("hide");
	  		$('.private').addClass("hide");
		} else {
	  		$('.public').addClass("hide");
	  		$('.private').removeClass("hide");
	    }
  	});
  	$('#private-id').change( function() {

		if($(this).prop('checked')){
	  		$('.public').removeClass("hide");
	  		$('.private').addClass("hide");
		} else {
	  		$('.public').addClass("hide");
	  		$('.private').removeClass("hide");
	    }
  	});
});

$('.slider').slick({
  dots: true,
  infinite: true,
  speed: 500,
  fade: true,
  cssEase: 'linear'
});

// edit
$( document ).ready(function() {

    if($('#user_public_setting').prop('checked')){
  		$('.private').addClass("hide");
	} else {
  		$('.public').addClass("hide");
    }
});

$('input[type=file]').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
        $(".preview").attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
});

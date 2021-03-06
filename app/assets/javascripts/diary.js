
// new
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

// show
$('.slider').slick({
  dots: true,
  infinite: true,
  arrows: false,
  draggable: true,
  speed: 500,
  fade: true,
  cssEase: 'linear'
});
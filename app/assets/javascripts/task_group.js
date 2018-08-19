
// modal
$(function(){

	// モーダルウィンドウが開くときの処理
	$(".modalOpen").click(function(){

    	var navClass = $(this).attr("class"),
        	href = $(this).attr("href");

        $(href).fadeIn();
    	$(this).addClass("open");
    	return false;
	});

	// モーダルウィンドウが閉じるときの処理
	$(".modalClose").click(function(){
	    $(this).parents(".modal").fadeOut();
	    $(".modalOpen").removeClass("open");
	    return false;
	});

});

$(function(){
	$("input.checkbox[type=checkbox]").click(function(){

    	var browser = $(this).attr("value");
    	location.href = browser
	});
});

$(function () {
    $('.status-field').sortable({
        connectWith: ".status-field",
        helper: "clone",
        appendTo: ".task-list",
        scroll: false,

        update: function (ev, ui) {
            var result1 = $(".status1").sortable("toArray");
            $("#result1").val(result1);

            var result2 = $(".status2").sortable("toArray");
            $("#result2").val(result2);

            var result3 = $(".status3").sortable("toArray");
            $("#result3").val(result3);

            $("#position").submit();
        }
    });
});
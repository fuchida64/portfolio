
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


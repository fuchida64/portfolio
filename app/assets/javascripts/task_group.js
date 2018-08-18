
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
    $('.status-box').sortable({
        connectWith: ".status-box",
        helper: "clone",
        appendTo: ".task-list",
        scroll: false,

        update: function (ev, ui) {
            var result1 = $(".status1").sortable("toArray");
            console.log(result1);  //  例)  [object Array]["item1", "item2", "item3", "item4", "item5"]
            $("#result1").html(result1.join(','));

            var result2 = $(".status2").sortable("toArray");
            console.log(result2);  //  例)  [object Array]["item1", "item2", "item3", "item4", "item5"]
            $("#result2").html(result2.join(','));

            var result3 = $(".status3").sortable("toArray");
            console.log(result3);  //  例)  [object Array]["item1", "item2", "item3", "item4", "item5"]
            $("#result3").html(result3.join(','));
        }
    });
});
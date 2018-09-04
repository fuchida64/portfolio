
// drag & drop
$(function () {
    $('.group-status').sortable({
        helper: "clone",
        scroll: true,

        update: function(){
            var result = $(this).sortable("toArray");

            $.ajax({
                url: "task_groups/position",
                type:'POST',
                dataType: 'json',
                data : {position : result },
                timeout:3000,
            }).done(function(data) {
            }).fail(function(XMLHttpRequest, textStatus, errorThrown) {
            })
        }
    });
});

// checkbox
$(function(){
	$("input.checkbox[type=checkbox]").click(function(){

    	var browser = $(this).attr("value");
    	location.href = browser
	});
});

// drag & drop
$(function () {
    $('.status-field').sortable({
        connectWith: ".status-field",
        helper: "clone",
        appendTo: ".task-list",
        scroll: true,
        cursorAt: {
            left: 60,
            bottom: 0
        },

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

// time transfer
function time_required() {
    var hr = document.task_form.time_required_hr.value;
    var min = document.task_form.time_required_min.value;
    var totalSec = hr*3600+min*60;

    if (totalSec===0) {
        document.task_form.task_task_detail_attributes_time_required.value="";
        document.task_form.task_task_detail_attributes_time_limit.value="";
    } else {
        document.task_form.task_task_detail_attributes_time_required.value=totalSec;
        document.task_form.task_task_detail_attributes_time_limit.value=totalSec;
    }
}


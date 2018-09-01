
// drag & drop
$(function () {
    $('.group-status').sortable({
        helper: "clone",
        scroll: true,

        update: function(){
            var result = $(this).sortable("toArray");

            $.ajax({
                url: "memory_groups/position",
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

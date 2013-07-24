// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require best_in_place


function remove_fields(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".tasks").hide();
}

function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
    $(link).parent().before(content.replace(regexp, new_id));
}



$(document).ready(function() {
    /* Activating Best In Place */
    jQuery(".best_in_place").best_in_place();
});


function show_flash_messages(message){
    jQuery(function () {
        jQuery.notifyBar({
            cls: "error",
            html: message,
            delay: 1000000,
            animationSpeed: "normal",
            close: true
        });
    });
}

function select_listing(user_id,u_name){
    if($("#li_"+user_id).is(':checked')){
        if($("#listing_users_"+user_id).length > 0){
            if($("#se_"+user_id).is(':checked')){
                $("#ch_li_"+user_id).attr("checked",true)
            }
        }else{
            $("#listing_users").append('<div class="row" id="listing_users_'+user_id+'"><div class="assigned-agents-vale1"><input id="ch_li_'+user_id+'" type="checkbox" value="'+user_id+'" name="listing[]" checked></div><div class="assigned-agents-vale1"><input id="ch_se_'+user_id+'" type="checkbox" value="'+user_id+'" name="selling[]"></div><div>'+u_name+'</div></div>')
        }
    }else{
        if($("#se_"+user_id).is(':checked')){
            $("#ch_li_"+user_id).attr("checked",false)
        }else{
            $("#listing_users_"+user_id).remove();
        }
    }
}

function select_selling(user_id,u_name){
    if($("#se_"+user_id).is(':checked')){
        if($("#listing_users_"+user_id).length > 0){
            if($("#li_"+user_id).is(':checked')){
                $("#ch_se_"+user_id).attr("checked",true)
            }
        }else{
            $("#listing_users").append('<div class="row" id="listing_users_'+user_id+'"><div class="assigned-agents-vale1"><input id="ch_li_'+user_id+'" type="checkbox" value="'+user_id+'" name="listing[]"></div><div class="assigned-agents-vale1"><input id="ch_se_'+user_id+'" type="checkbox" value="'+user_id+'" name="selling[]" checked></div><div>'+u_name+'</div></div>')
        }
    }else{
        if($("#li_"+user_id).is(':checked')){
            $("#ch_se_"+user_id).attr("checked",false)
        }else{
            $("#listing_users_"+user_id).remove();
        }
    }
}
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


    jQuery('#leftColumnShow').click(function () {
        jQuery('#leftColumn').slideToggle('slow', function () {})
    });
    jQuery('#closeBox').click(function () {
        jQuery('#leftColumn').slideToggle('slow', function () {})
    });
    jQuery('#addContact').click(function () {
        jQuery('#addContactContent').slideToggle('slow', function () {})
    });
    jQuery('#addContactClose').click(function () {
        jQuery('#addContactContent').slideToggle('slow', function () {})
    });
    jQuery('#addNote').click(function () {
        jQuery('#addNoteContent').slideToggle('slow', function () {})
    });
    jQuery('#addNoteClose').click(function () {
        jQuery('#addNoteContent').slideToggle('slow', function () {})
    });
    jQuery('#newList').click(function () {
        jQuery('#newListContent').slideToggle('slow', function () {})
    });
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

function CreateList(list, trn_id){
    var check = jQuery(list).val()
    $.ajax({
        url: "/checklists",
        data: {"checklist":check, "transaction_id":trn_id},
        method: "POST",
        success: function(data){

        }
    })
}

function TaskStatusUpdate(st, task_id, trn_id){
    var check= $(st).is(':checked')
    $.ajax({
        url: "/tasks/"+task_id+"/update_status",
        data: {"status":check, "transaction_id":trn_id},
        method: "PUT",
        success: function(data){

        }
    })
}
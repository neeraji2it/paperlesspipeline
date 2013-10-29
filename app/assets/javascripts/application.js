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
    $('#transaction_automatic_expire_date').datepicker();
    $('#transaction_close_date').datepicker();
    jQuery('#leftColumnShow').click(function() {
        jQuery('#leftColumn').slideToggle('slow', function() {
        });
    });
    jQuery('#closeBox').click(function() {
        jQuery('#leftColumn').slideToggle('slow', function() {
        })
    });
    jQuery('#addContact').click(function() {
        jQuery('#addContactContent').slideToggle('slow', function() {
        })
    });
    jQuery('#addContactClose').click(function() {
        jQuery('#addContactContent').slideToggle('slow', function() {
        })
    });
    jQuery('#addNote').click(function() {
        jQuery('#addNoteContent').slideToggle('slow', function() {
        })
    });
    jQuery('#addNoteClose').click(function() {
        jQuery('#addNoteContent').slideToggle('slow', function() {
        })
    });
    jQuery('#newList').click(function() {
        jQuery('#newListContent').slideToggle('slow', function() {
        })
    });
});
function show_flash_messages(message) {
    jQuery(function() {
        jQuery.notifyBar({
            cls: "error",
            html: message,
            delay: 1000000,
            animationSpeed: "normal",
            close: true
        });
    });
}

function CreateList(list, trn_id) {
    var check = jQuery(list).val()
    $.ajax({
        url: "/checklists",
        data: {
            "checklist": check,
            "transaction_id": trn_id
        },
        type: "POST",
        dataType: "script",
        success: function(data) {

        }
    })
}

function TaskStatusUpdate(st, task_id, trn_id) {
    var check = $(st).is(':checked')
    $.ajax({
        url: "/tasks/" + task_id + "/update_status",
        data: {
            "status": check,
            "transaction_id": trn_id
        },
        type: "PUT",
        success: function(data) {

        }
    })
}

function select_listing(user_id, u_name) {
    if ($("#li_" + user_id).is(':checked')) {
        if ($("#listing_users_" + user_id).length > 0) {
            if ($("#se_" + user_id).is(':checked')) {
                $("#ch_li_" + user_id).attr("checked", true)
            }
        } else {
            $("#listing_users").append('<div class="row" id="listing_users_' + user_id + '"><div class="assigned-agents-vale1"><input id="ch_li_' + user_id + '" type="checkbox" value="' + user_id + '" name="listing[]" checked></div><div class="assigned-agents-vale1"><input id="ch_se_' + user_id + '" type="checkbox" value="' + user_id + '" name="selling[]"></div><div>' + u_name + '</div></div>')
        }
    } else {
        if ($("#se_" + user_id).is(':checked')) {
            $("#ch_li_" + user_id).attr("checked", false)
        } else {
            $("#listing_users_" + user_id).remove();
        }
    }
}

function select_selling(user_id, u_name) {
    if ($("#se_" + user_id).is(':checked')) {
        if ($("#listing_users_" + user_id).length > 0) {
            if ($("#li_" + user_id).is(':checked')) {
                $("#ch_se_" + user_id).attr("checked", true)
            }
        } else {
            $("#listing_users").append('<div class="row" id="listing_users_' + user_id + '"><div class="assigned-agents-vale1"><input id="ch_li_' + user_id + '" type="checkbox" value="' + user_id + '" name="listing[]"></div><div class="assigned-agents-vale1"><input id="ch_se_' + user_id + '" type="checkbox" value="' + user_id + '" name="selling[]" checked></div><div>' + u_name + '</div></div>')
        }
    } else {
        if ($("#li_" + user_id).is(':checked')) {
            $("#ch_se_" + user_id).attr("checked", false)
        } else {
            $("#listing_users_" + user_id).remove();
        }
    }
}

function show_commentbox(doc_id) {
    jQuery('#commentBox_' + doc_id).slideToggle('slow', function() {
    })
}

jQuery(document).ready(function() {
    jQuery('#leftColumnShow').click(function() {
        jQuery('#leftColumn').slideToggle('slow', function() {
        })
    });
    jQuery('#closeBox').click(function() {
        jQuery('#leftColumn').slideToggle('slow', function() {
        })
    });

    jQuery('#locationI').hover(function() {
        jQuery('#locationBoxN').slideToggle('slow', function() {
        })
    });
    jQuery('#transactionI').hover(function() {
        jQuery('#transactionBoxN').slideToggle('slow', function() {
        })
    });

    jQuery('#transaction_transaction_name').hover(function() {
        jQuery('#transactionName').slideToggle('slow', function() {
        })
    });

    jQuery('#transaction_status').hover(function() {
        jQuery('#transactionStatus').slideToggle('slow', function() {
        })
    });

    jQuery('#transaction_close_date').hover(function() {
        jQuery('#transactionClose').slideToggle('slow', function() {
        })
    });


    jQuery('#transaction_more_info').hover(function() {
        jQuery('#transactionMore').slideToggle('slow', function() {
        })
    });

    jQuery('#transaction_automatic_expire_date').hover(function() {
        jQuery('#transactionAuto').slideToggle('slow', function() {
        })
    });

    jQuery('#transaction_buyer_name').hover(function() {
        jQuery('#transactionBuyer').slideToggle('slow', function() {
        })
    });

    jQuery('#transaction_seller_name').hover(function() {
        jQuery('#transactionSeller').slideToggle('slow', function() {
        })
    });

    jQuery('#transaction_list_price').hover(function() {
        jQuery('#transactionList').slideToggle('slow', function() {
        })
    });

    jQuery('#transaction_sale_price').hover(function() {
        jQuery('#transactionSale').slideToggle('slow', function() {
        })
    });

    jQuery('#transaction_total_commission').hover(function() {
        jQuery('#transactionTotal').slideToggle('slow', function() {
        })
    });
    jQuery('#transaction_commission_summary').hover(function() {
        jQuery('#transactionSum').slideToggle('slow', function() {
        })
    });

    jQuery(document).ready(function() {
        jQuery('#comment').click(function() {
            jQuery('#commentBox').slideToggle('slow', function() {
            })
        });
        jQuery('#leftColumnShow').click(function() {
            jQuery('#leftColumn').slideToggle('slow', function() {
            })
        });
        jQuery('#closeBox').click(function() {
            jQuery('#leftColumn').slideToggle('slow', function() {
            })
        });
    });




    $("#agents_seller").keyup(function() {
        var agents = $(this).val();
        $.ajax({
            url: "/transactions/agents_search",
            data: {
                agent_name: agents
            },
            type: 'GET',
            dataType: 'script',
            success: function(data) {
            }
        });
    });

});
function edit_comment(comment_id) {
    $('#hide-comment_' + comment_id).hide();
    $('#edit-comment_' + comment_id).show();
}

function edit_location(location_id) {
    $('#hide-location_' + location_id).hide();
    $('#locationShow_' + location_id).show();



}

$(document).ajaxStart(function() {
    $('#ajax_loader_big_div').show();
});
$(document).ajaxStop(function() {
    $('#ajax_loader_big_div').hide();
});


function transaction_show(id) {
    window.location.href = "/transactions/" + id
}

$("#cancel_<%= doc.id %>").click(function() {
    $("#commentBox_<%= doc.id%>").fadeOut('slow');
})


function show_commentbox(doc_id) {
    jQuery('#commentBox_' + doc_id).slideToggle('slow', function() {
    })
}


function update_document_reviewed(th, document_id) {
    $.ajax({
        url: "/documents/" + document_id + "/update_reviewed",
        data: {
            "reviewed": $(th).is(":checked"),
            "id": document_id
        },
        type: "POST",
        dataType: "script",
        success: function(data) {
        }
    })
}


function update_document_entered(th, document_id) {
    $.ajax({
        url: "/documents/" + document_id + "/update_entered",
        data: {
            "entered": $(th).is(":checked"),
            "id": document_id
        },
        type: "POST",
        dataType: "script",
        success: function(data) {
        }
    })
}
// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function replaceFonts(selector) {
    Cufon.replace(selector);
    Cufon.now();
}

function initFancyBox(selector) {
    $(selector).fancybox({
        overlayOpacity  : 0.7,
        overlayColor    : "#333"
    });
}

function initTipsy(selector) {
    $(selector).tipsy({gravity: "n"});
}

function initModalDialog(id) {
    return $("<div/>").attr("id", id).appendTo("body").dialog({
        autoOpen  : false,
        modal     : true,
        height    : 400,
        width     : 600,
        show      : "blind"
    });
}

function bindRemoteLinks(dialog, selector) {
    $(selector).click(function() {
        var href = $(this).attr("href");
        var title = $(this).attr("title");
        $(dialog).load(href + " form", function() {
            openForm(this, title);
        });
        return false;
    });
}

function openForm(dialog, title) {
    bindFormSubmit(dialog);
    $(dialog).dialog("option", "title", title);
    $(dialog).find(":text:first").focus();
    $(dialog).dialog("open");
}

function bindFormSubmit(dialog) {
    var $form = $(dialog).find("form");
    var $submit = $form.find(":submit");
    var label = $submit.val();
    $submit.remove();
    var buttons = {};
    buttons[label] = function() {
        $.ajax({
            type    : $form.attr("method"),
            url     : $form.attr("action"),
            data    : $form.serialize(),
            dataType: "script"
        });
        $(dialog).dialog("close");
    };
    buttons["Cancel"] = function() {
        $(this).dialog("close");
    };
    $(dialog).dialog("option", "buttons", buttons);
}


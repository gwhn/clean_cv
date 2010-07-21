// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function replaceFonts(selector) {
    Cufon.replace(selector);
    Cufon.now();
}

function focusOnFirstFormTextField(container) {
    $form = $(container).find("form");
    $form.find(":text:first").focus();
}

function bindFormButtons(container) {
    $form = $(container).find("form");
    $btn = $form.find(":submit");
    var txt = $btn.val();
    $btn.remove();
    var buttons = {};
    buttons[txt] = function() {
        $.ajax({
            type    : $form.attr("method"),
            url     : $form.attr("action"),
            data    : $form.serialize(),
            dataType: "script"
        });
        $(this).dialog("close");
    };
    $(container).dialog("option", "buttons", buttons);
}

function initModalDialog(selector) {
    $(selector).click(function() {
        $("<div/>").attr("id", "form-dialog").appendTo("body").dialog({
            autoOpen  : false,
            modal     : true,
            title     : $(this).attr("title"),
            height    : 400,
            width     : 600
        }).load($(this).attr("href") + " form", function() {
            $(this).dialog("open");
            focusOnFirstFormTextField(this);
            bindFormButtons(this);
        });
        return false;
    });
}

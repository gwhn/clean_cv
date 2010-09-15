// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
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
        open      : function() {
            $(this).find(":input:visible:enabled:first").focus();
        }
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
    $(dialog).dialog("open");
    uniformInputs();
    $("textarea").autogrow();
}

function bindFormSubmit(dialog) {
    var $form = $(dialog).find("form");
    $form.submit(function(){
        $(".spinner").show();
    });
    var $submit = $form.find(":submit");
    var label = $submit.val();
    $submit.remove();
    var buttons = {};
    buttons[label] = formSubmitHandler(dialog);
    buttons["Cancel"] = function() {
        $(this).dialog("close");
    };
    $(dialog).dialog("option", "buttons", buttons);
}

function formSubmitHandler(dialog) {
    var $form = $(dialog).find("form");
    if ($form.attr("target") != '') {
        return function() {
            $form.submit();
            $(dialog).dialog("close");
        }
    }
    return function() {
        $.ajax({
            type    : $form.attr("method"),
            url     : $form.attr("action"),
            data    : $form.serialize(),
            dataType: "script"
        });
        $(dialog).dialog("close");
    };
}

function bindAddChildLinks(selector) {
    $(selector).live("click", function() {
        var assoc = $(this).attr("data-association");
        var content = $("#" + assoc + "_fields_template").html();
        var regexp = new RegExp("new_" + assoc, "g");
        var newId = new Date().getTime();
        $(this).parent().before(content.replace(regexp, newId));
        $("select[id *= '" + newId + "']").uniform();
        return false;
    });
}

function bindRemoveChildLinks(selector) {
    $(selector).live("click", function() {
        var hiddenField = $(this).parent().find("input[type=hidden]")[0];
        if (hiddenField) {
            hiddenField.value = "1";
        }
        $(this).parents(".fields").hide();
        return false;
    });
}

function uniformInputs() {
    $("select, input:checkbox, input:radio, input:file")
            .not(".template select, .template  input:checkbox, .template  input:radio, .template  input:file")
            .uniform();
}

$(function() {
    if ($.cookies.test() && !$.cookies.get("beenHereBefore")) {
        $.cookies.set("beenHereBefore", true);
        $("#test_drive").dialog({modal:true, title: $("#test_drive").attr("class").toUpperCase()});
    }

    initFancyBox("a.lightbox");

    $(".social-media [title]").tooltip({effect: "slide"}).dynamic({bottom: {direction: "down"}});

    $(".accordion").tabs(".accordion .panel", {tabs: "h6", effect: "highlight-slide"});

    $(".move-actions, .update-actions").hide();

    bindRemoteLinks(initModalDialog("form-dialog"), ".remote-link");

    bindAddChildLinks("a.add");

    bindRemoveChildLinks("a.remove");

    uniformInputs();

    $("textarea").autogrow();

    $(".spinner").hide().ajaxStart(function() {
        $(this).show();
    }).ajaxStop(function() {
        $(this).hide();
    });

    $("form").submit(function(){
        $(".spinner").show();
    });

    // UJS authenticity token fix: add the authenticy_token parameter
    // expected by any Rails POST request.
    $(document).ajaxSend(function(event, request, settings) {
        // do nothing if this is a GET request. Rails doesn't need
        // the authenticity token, and IE converts the request method
        // to POST, just because - with love from redmond.
        if (settings.type == 'GET') return;
        if (typeof(AUTH_TOKEN) == "undefined") return;
        settings.data = settings.data || "";
        settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
    });

    $(document).ajaxError(flashMessage);
    $(document).ajaxSuccess(flashMessage);

    function flashMessage(event, request) {
        var msg = request.getResponseHeader('X-Message');
        if (msg) {
            $.pnotify({
                pnotify_title: msg,
                pnotify_type: request.getResponseHeader('X-Message-Info')
            });
        }
    }
});
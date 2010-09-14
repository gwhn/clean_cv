// remap jQuery to $
(function($) {


})(window.jQuery);

// usage: log('inside coolFunc',this,arguments);
// paulirish.com/2009/log-a-lightweight-wrapper-for-consolelog/
window.log = function() {
    log.history = log.history || [];   // store logs to an array for reference
    log.history.push(arguments);
    if (this.console) {
        console.log(Array.prototype.slice.call(arguments));
    }
};

// catch all document.write() calls
(function(doc) {
    var write = doc.write;
    doc.write = function(q) {
        log('document.write(): ', arguments);
        if (/docwriteregexwhitelist/.test(q)) write.apply(doc, arguments);
    };
})(document);

// add new highlight slide effect to the tabs
$.tools.tabs.addEffect("highlight-slide", function(tabIndex, done) {
    const highlight = "ui-state-highlight";
	this.getPanes().slideUp().addClass(highlight);
	this.getPanes().eq(tabIndex).slideDown("slow", function()  {
		$(this).removeClass(highlight);
		done.call();
	});
});

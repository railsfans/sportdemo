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
//= require ext-all
//= require ext-lang-zh_CN
//= require studentinit
//= require highcharts
//= require highcharts-more
//= require exporting 
$(document).ready(function(){

$("li a").hover(function(){
	$(this).addClass("hover");
	}, function(){
	$(this).removeClass("hover");
});
$("li a").click(function(){
	$("li a").removeClass("selected");
	$(this).addClass("selected");
});

$("a").bind("click",function()
{
	$.getScript(this.href);
	history.pushState(null, document.title, this.href);
	return false
});
$(window).bind("popstate", function() {
	$.getScript(location.href);
});


})

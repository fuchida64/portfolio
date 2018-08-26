// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage

//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets


$(function() {
	var nav = $('nav');
	$('li', nav).mouseover(function(e) {
		$('ul', this).stop().slideDown('fast');
		$("ul", this).children("li").css({
            "padding-top": "17px",
         })
	})
	.mouseout(function(e) {
		$('ul', this).stop().slideUp();
	});
});

$( document ).ready(function() {
	$('.alert').animate({'marginRight':'103vw'},1000);
	setTimeout("slideOut()", 8000);
});
function slideOut(){
  	$('.alert').animate({'marginRight':'-105vw'},1000);
}
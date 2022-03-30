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
//= require jquery3
//= require jquery
//= require jquery.raty.js
//= require rails-ujs
//= require jquery.jpostal
//= require jquery-ui
//= require tag-it
//= require popper
//= require bootstrap-sprockets
//= require Chart.min
//= require activestorage
//= require turbolinks
//= require tag_addition
//= require address_autofill
//= require_tree .

$(document).on('turbolinks:load',function(){
  $('.slider').slick({
    autoplay: true,
    autoplaySpeed: 5000,
    dots:true,
  });
});
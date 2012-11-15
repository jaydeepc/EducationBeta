//= require jquery
//= require jquery_ujs

$(function(){
    var $modal = $('#modal'),
    $modal_close = $modal.find('.close'),
    $modal_container = $('#modal-container');

    // Hide close button click
    $('.close', '#modal').live('click', function(){
      $modal_container.hide();
      $modal.css('width', '600px').hide();
      return false;
     });
});

$(document).ready(function() {
  $('.scroller-shower').on('click', function(e) {
    e.preventDefault();
    $(this).siblings('.scroller-collapser').show();
    $(this).hide();
  });
});

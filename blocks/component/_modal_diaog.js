$(document).ready(function() {
  $('.modal-button').on('click', function(e) {
    e.preventDefault();
    $(this).closest('form').next('.modal').modal('show');
  });
});

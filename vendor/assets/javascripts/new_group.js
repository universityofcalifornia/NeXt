$(function () {
  $('#create').attr('disabled','disabled');

  $("#create").click(function () {
    var is_checked = $('input:checked').length;
    var text = $("#group_name").val();
    $.post("/groups/ajax_create",{
      checked: is_checked,
      group_name: text,
      authenticity_token: AUTH_TOKEN
    })
    return false; // stop the browser following the link
  });

  $("#group_name").keyup(function() {
    if($(this).val() != '') {
      $('#create').attr('disabled', false);
    } else {
      $('#create').attr('disabled', true);
    }
  });
});

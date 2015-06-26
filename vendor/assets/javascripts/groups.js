function add_new_group(){
  $("#autocomplete_groups").hide();
  $("#new_group").show();
  $('#groups').val('');
}

function cancel_new_group(){
  $("#autocomplete_groups").show();
  $("#new_group").hide();
  $('#groups').val('');
}
$(function(){
  $("#groups").autocomplete({
    source: '/groups/ajax_index.json',
    open: function(e, ui) {
      $('.ui-autocomplete').prepend("<a onclick='add_new_group()' id='add_group' class='btn' >Create a new group</a>");
    },
    select: function( event, ui ) {
      $.post("/user_groups", {
        id: ui.item.id,
        authenticity_token: AUTH_TOKEN
        });
      return false;
    }
  })
  .autocomplete( "instance" )._renderItem = function( ul, item ) {
    return $( "<li>" )
      .append( "<a>" + item.name + "</a>" )
      .appendTo( ul );
  }
});

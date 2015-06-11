$(document).ready(function(){

  $('.comment_reply_link')
    .bind("ajax:success", function(evt, data, status, xhr){
      var $well = $(this).parent().parent();

      // Insert response partial into page below the form.
      $well.append(xhr.responseText);

    }
  );

});

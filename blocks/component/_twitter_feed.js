$(document).ready(function() {
  if ($('.twitter-timeline').length) {
    window.setTimeout(function() {
      // Override the Twitter iframe's CSS
      CustomizeTwitterWidget({ url: 'stylesheets/blocks.css' });
    }, 500);

    window.setTimeout(function() {
      // Hack to show the border properly
      var iframe = $('.twitter-timeline-rendered');
      iframe.height(iframe.height() + 1);
    }, 1000);
  }
});

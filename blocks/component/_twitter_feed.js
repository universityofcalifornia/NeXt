$(document).ready(function() {
  var twitterChecker;

  if ($('#twitter-feed-wrapper').length) {
    twitterChecker = window.setInterval(function() {
      // Wait until Twitter tells us the iframe is rendered
      if ($('.twitter-timeline-rendered').length) {
        window.clearInterval(twitterChecker);

        // Override the iframe's CSS
        CustomizeTwitterWidget({ url: '/assets/blocks.css' });
      }
    }, 100);
  }
});

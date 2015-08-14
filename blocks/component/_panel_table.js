$(document).ready(function() {
  window.setTimeout(function() {
    var cols = $('.panel-table .panel-cell');

    if (cols.length) {
      var heights = cols.map(function() {
        return $(this).height();
      });
      var maxHeight = Math.max.apply(null, heights);

      cols.height(maxHeight);
    }
  }, 100);
});

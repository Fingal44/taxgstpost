// The message will disappear when get clicked
jQuery(function() {
  $(document).on('click.alert.data-api', '[data-dismiss="alert"]', function(e) {
    return e.stopPropagation();
  });
  return $(document).on('touchstart click', ".bootstrap-growl", function(e) {
    e.stopPropagation();
    $('[data-dismiss="alert"]', this).click();
    return false;
  });
});


// This part of code is VERY IMPORTANT, because it solved an issue for rendering color
// to the danger message.
$.bootstrapGrowl.defaults = $.extend(true, {}, $.bootstrapGrowl.defaults, {
  type_mapping: {
    alert: 'warning',
    error: 'danger',
    notice: 'info',
    success: 'success'
  }
});

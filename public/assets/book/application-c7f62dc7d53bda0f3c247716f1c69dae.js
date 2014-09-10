(function() {
  $(function() {
    return $("a").on("ajax:error", function(event, jqXHR, ajaxSettings, thrownError) {
      if (jqXHR.status === 401) {
        return window.location.replace('/department/login');
      }
    });
  });

  window.ajaxResponseStatusFilter = function(data) {
    if (data.location) {
      window.location = data.location;
      return true;
    }
    if (data.status === -1) {
      console.log('該功能無法使用');
      return true;
    }
    return false;
  };

}).call(this);

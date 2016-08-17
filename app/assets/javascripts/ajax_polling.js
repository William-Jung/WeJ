setInterval(function(){
  var windowUrl = window.location.href;
  var pattern = new RegExp(/playlists\/\d+$/);
  if (pattern.test(location.pathname)) {
    $.ajax({
      method: 'get',
      url: windowUrl
    }).done(function(response){
      $('#song-list').html('');
      $('#song-list').append(response);
    })
  }
}, 1000);

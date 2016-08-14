$(document).ready(function() {

  var songArray = [];
  $('#create-playlist-form').on('submit', (function(event) {
    event.preventDefault();

    var playlistName = $('#spotify_id option:selected').text()
    $playlistForm = $(this)
    var data = $playlistForm.serializeArray();
    data.push({name: 'name', value: playlistName});
    $.ajax({
      url: '/playlists',
      type: 'POST',
      data: data
    })
  })


  );

  $('#song-title').on('click', function() {
    // event.preventDefault();

    console.log('clicked!')
  // $('spotify-track-widget')

  });


});

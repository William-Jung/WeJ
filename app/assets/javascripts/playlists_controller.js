$(document).ready(function() {

  var songArray = [];
  $('#create-playlist-form').on('submit', (function(event) {
    event.preventDefault();

    var playlistName = $('select#_spotify_id option:selected').text()
    $playlistForm = $(this)
    var playlistData = $playlistForm.find('form').serializeArray()
    playlistData.push({name: 'name', value: playlistName});
    $.ajax({
      url: '/playlists',
      type: 'POST',
      data: playlistData
    }).done(function(response) {
    })
  })


  );

  $('#song-title').on('click', function() {
    // event.preventDefault();

    console.log('clicked!')
  // $('spotify-track-widget')

  });


});

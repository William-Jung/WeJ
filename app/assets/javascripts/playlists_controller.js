$(document).ready(function() {


  $('#create-playlist-form').on('submit', (function(event) {
    event.preventDefault();

    var playlistName = $('#spotify_id option:selected').text()
    console.log(playlistName);
    $playlistForm = $(this)
    var data = $playlistForm.serializeArray();
    data.push({name: 'name', value: playlistName});
    $.ajax({
      url: '/playlists',
      type: 'POST',
      data: data
    })
    .done(function() {
      console.log("success");
    })


  })


  );




});

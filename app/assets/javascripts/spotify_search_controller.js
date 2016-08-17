$(document).ready(function() {

  var songArray = [];

  $('#search-form').on('keyup', function(event) {
    event.preventDefault();
    if ($('#search-box').val().length > 4) {
      var data = $(this).serialize();
      $.ajax({
        url: '/spotify',
        type: 'POST',
        data: data
      })
      .done(function(response) {
        songArray = []
        titlesArray = [];
        for (object in response) {
          song = new Song(response[object]);
          titlesArray.push(song.name + " - " + song.artist)
          songArray.push(song)
        }
        $( "#search-box" ).autocomplete({
          source: titlesArray
        });
      })
    }
  });

  $('#search-form').on('submit', function(event) {
    event.preventDefault();
    var id = $(this).parent().attr('id')
    console.log(id)
    var data;
    for (object in songArray) {
      if (songArray[object].name + " - " + songArray[object].artist == $('#search-box').val()) {

      var newSong = songArray[object]
      data = {song: newSong.id}
      break;
      }
    }
    console.log("exited from for loop");
    $.ajax({
      url: '/playlists/' + id,
      type: 'PUT',
      data: data
    })
  });
});

$(document).ready(function() {

  var songArray = [];

  $('#search-form').on('keyup', function(event) {
    event.preventDefault();

    if ($('#search-box').val().length > 4) {
      console.log($(this));
      var data = $(this).serialize();
      console.log(data);
      $.ajax({
        url: '/spotify',
        type: 'POST',
        data: data
      })
      .done(function(response) {
        console.log("success");
        console.log(response);

        songArray = []
        var titlesArray = [];

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
    console.log("yea");

  });

  $('#search-form').on('submit', function(event) {
    event.preventDefault();
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
        url: '/playlists',
        type: 'PUT',
        data: data
      })
      .done(function(response) {
        console.log(response);
        var song =            ,µnew Song(response)
        $('#songs').append('<h1>' + song.name + '</h1>')

      })
  });



});

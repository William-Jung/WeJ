$(document).ready(function() {
  var songArray = [];
  $('#search-form').on('keyup', function(event) {
    event.preventDefault();
    $('#search-results').empty()
    if ($('#search-box').val().length > 4) {
      console.log('keyup if')
      var data = $(this).serialize();
      $.ajax({
        url: '/spotify',
        type: 'POST',
        data: data
      })
      .done(function(response) {
        console.log(response)
        songArray = []
        // var titlesArray = [];
        for (object in response) {
          var song = new Song(response[object]);
          // titlesArray.push(song.name + " - " + song.artist)
          songArray.push(song)
        }
        var songList = new SongList(songArray)
        console.log(songList.toHtml())
        $('#search-results').empty()
        $('#search-results').append(songList.toHtml())
      })
    }
  });

  $('#search-form').on('submit', function(event) {
    event.preventDefault();
    var id = $(this).parent().attr('id')
    var data;
    for (object in songArray) {
      if (songArray[object].name + " - " + songArray[object].artist == $('#search-box').val()) {
        var newSong = songArray[object]
        data = {song: newSong.id}
        break;
      }
    }
    $.ajax({
      url: '/playlists/' + id,
      type: 'PUT',
      data: data
    }).done(function(){
      $('#search-box').val('')
    }).error(function() {
      var modal = $('#myModal').show();
    })
  });

  // display the modal when the user votes on the same song
  $("#myModal").on('click', function(){
    $('#myModal > div').hide();
    $('#search-form')[0].reset();
    $('#search-results').empty()
  })

  $('#search-results').on('mouseenter', 'p', function(){
    $(this).css('background-color', '#EE6D94')
  });

  $('#search-results').on('mouseleave', 'p', function(){
    $(this).css('background-color', '#181019')
  });

  $('#search-results').on('click', 'p', function(){
    var text = $(this).text()
    $('#search-box').val(text)
  });

  $('#song-list').on('submit', '.vote-button', function(event){
    event.preventDefault();
    $.ajax({
      url: $(this).attr('action'),
      method: $(this).attr('method'),
      data: $(this).serialize()
    }).done(function(response){
      $('#requests-remaining').text('Requests remaining: ' + response)
    })
  })
});

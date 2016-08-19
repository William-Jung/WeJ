var SongList = function(songArray){
  this.songArray = songArray
}

SongList.prototype.toHtml = function(){
  var htmlString = ''
  for (var i = 0; i < this.songArray.length; i++){
    htmlString = htmlString.concat("<p class='song-title' id=" + '"' + this.songArray[i].id + '"' + ">" + this.songArray[i].name + " - " + this.songArray[i].artist + "</p>")
  }
  return htmlString
}

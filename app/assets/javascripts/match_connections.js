app.match_connections.controller = {
  show: function(){
    var mutual_matches_div_length = $('#mutual-matches img').length * 320;
    $('#mutual-matches row').css('width', mutual_matches_div_length)
  }
}

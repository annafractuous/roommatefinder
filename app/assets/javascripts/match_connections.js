app.match_connections.controller = {
  edit: function(){
    $('.confirm-interested').on("submit", function(event){
      event.preventDefault();
      var link = $('.confirm-interested').parent().attr('action');
      // $.ajax({
      //   url: link,
      //   type: "GET",
      //   data: $(this).serializeArray(),
      //   dataType: "JSON",
      //   success: function(data, request, settings) {
      //     debugger
      //     $('.overall-match-compatibility').prepend(data);
      //
      //   }
      // });
    });
  },
  show: function(){
    var mutual_matches_div_length = $('#mutual-matches img').length * 320;
    $('#mutual-matches row').css('width', mutual_matches_div_length)
  }
}

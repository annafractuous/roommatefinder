app.desired_match_traits.controller = {
  edit: function(event) {
    // basic info question page elements
    var basic_info_items = ['has-apartment', 'max-rent', 'dealbreakers', 'city-and-move-in',
    'preferred-age', 'preferred-gender', 'submit-basic-info'];

    basic_info_items.forEach(function(element){
      $('#' + element).hide();
    });
    $('#' + basic_info_items[0]).show();
    $('#' + basic_info_items[0]).addClass("current-question");

    basic_info_items.forEach(function(element, index, element_arr){
      $('#submit-' + element).on("click", function(event){
        event.preventDefault();
        if (index != element_arr.length - 1) {
          $('.current-question').fadeOut(400);
          $('.current-question').removeClass("current-question");
          $('#' + element_arr[index + 1]).addClass("current-question");
          $('.current-question').delay(600).fadeIn(500);
        }
      });
    });

    basic_info_items.forEach(function(element, index, element_arr){
      $('#go-to-' + element).on("click", function(event){
        $('.current-question').fadeOut(400);
        $('.current-question').removeClass("current-question");
        $('#' + element).addClass("current-question");
        $('.current-question').delay(600).fadeIn(500);
      });
    });
  }
}

app.desired_match_traits.controller = {
  edit: function() {
    // basic info question page elements
    var basic_info_items = ['has-apartment', 'max-rent', 'dealbreakers', 'city-and-move-in',
    'preferred-age', 'preferred-gender', 'submit-basic-info'];

    basic_info_items.forEach(function(element){
      $('#' + element).hide();
    });
    $('#' + basic_info_items[0]).show();
    $('#' + basic_info_items[0]).addClass("current-question");
    $('#go-to-' + basic_info_items[0]).addClass("current-question-nav");

    basic_info_items.forEach(function(element, index, element_arr){
      $('#submit-' + element).on("click", function(event){
        event.preventDefault();
        $('.current-question').fadeOut(400);
        $('.current-question').removeClass("current-question");
        $('.current-question-nav').removeClass("current-question-nav");
        $('#go-to-' + element_arr[index + 1]).addClass("current-question-nav");
        $('#' + element_arr[index + 1]).addClass("current-question");
        $('.current-question').delay(600).fadeIn(500);
      });
    });

    basic_info_items.forEach(function(element, index, element_arr){
      $('#back-' + element).on("click", function(event){
        event.preventDefault();
        $('.current-question').fadeOut(400);
        $('.current-question').removeClass("current-question");
        $('.current-question-nav').removeClass("current-question-nav");
        $('#go-to-' + element_arr[index - 1]).addClass("current-question-nav");
        $('#' + element_arr[index - 1]).addClass("current-question");
        $('.current-question').delay(600).fadeIn(500);
      });
    });

    basic_info_items.forEach(function(element, index, element_arr){
      $('#go-to-' + element).on("click", function(event){
        $('.current-question').fadeOut(400);
        $('.current-question').removeClass("current-question");
        $('.current-question-nav').removeClass("current-question-nav");
        $('#go-to-' + element).addClass("current-question-nav");
        $('#' + element).addClass("current-question");
        $('.current-question').delay(600).fadeIn(500);
      });
    });
  }
}

app.desired_match_traits.controller = {
  edit: function(event) {
    // basic info question page elements
    var basic_info_questions = ['has-apartment', 'max-rent', 'dealbreakers', 'city-and-move-in',
    'preferred-age', 'preferred-gender', 'submit-basic-info'];

    basic_info_questions.forEach(function(element){
      $('#' + element).hide();
    });
    $('#' + basic_info_questions[0]).show();

    basic_info_questions.forEach(function(element, index, element_arr){
      $('#submit-' + element).on("click", function(event){
        event.preventDefault();
        if (index != element_arr.length - 1) {
          $('#' + element).fadeOut(400);
          $('#' + element_arr[index + 1]).delay(600).fadeIn(500);
        }
      });
    });
  }
}

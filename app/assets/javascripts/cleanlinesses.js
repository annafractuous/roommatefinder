app.cleanlinesses.controller = {
  edit: function(event) {
    // cleanliness question page elements
    var cleanliness_questions = ['kitchen-cleanliness', 'bathroom-cleanliness', 'common-space-cleanliness',
    'roommate-kitchen-cleanliness', 'roommate-bathroom-cleanliness', 'roommate-common-space-cleanliness',
    'submit-cleanliness-questions'];

    cleanliness_questions.forEach(function(element){
      $('#' + element).hide();
    });
    $('#' + cleanliness_questions[0]).show();

    cleanliness_questions.forEach(function(element, index, element_arr){
      $('#submit-' + element).on("click", function(event){
        event.preventDefault();
        if (index != element_arr.length - 1) {
          $('#' + element).fadeOut(400);
          $('#' + element_arr[index + 1]).delay(600).fadeIn(500);
          if (index === Math.floor(element_arr.length / 2) - 1) {
            $('.questions-heading').text("Tell Us About Your Ideal Roommate's Cleanliness");
          }
        }
      });
    });
  }
}

app.habits.controller = {
  edit: function(event) {
    // habit question page elements
    var habit_questions = ['partying-habit', 'drinking-habit', 'four-twenty-habit', 'overnight-visitors-habit',
    'music-habit', 'roommate-partying-habit', 'roommate-drinking-habit', 'roommate-four-twenty-habit',
    'roommate-overnight-visitors-habit', 'roommate-music-habit', 'submit-habit-questions'];

    habit_questions.forEach(function(element){
      $('#' + element).hide();
    });
    $('#' + habit_questions[0]).show();

    habit_questions.forEach(function(element, index, element_arr){
      $('#submit-' + element).on("click", function(event){
        event.preventDefault();
        if (index != element_arr.length - 1) {
          $('#' + element).fadeOut(400);
          $('#' + element_arr[index + 1]).delay(600).fadeIn(500);
          if (index === Math.floor(element_arr.length / 2) - 1) {
            $('.questions-heading').text("Tell Us About Your Ideal Roommate's Habits");
          }
        }
      });
    });
  }
}

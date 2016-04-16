app.schedules.controller = {
  edit: function(event) {
    // schedule question page elements
    var schedule_questions = ['work-schedule', 'sleep-schedule', 'bathroom-schedule', 'kitchen-schedule',
    'roommate-work-schedule', 'roommate-sleep-schedule', 'roommate-bathroom-schedule', 'roommate-kitchen-schedule',
    'submit-schedule-questions'];

    schedule_questions.forEach(function(element){
      $('#' + element).hide();
    });
    $('#' + schedule_questions[0]).show();

    schedule_questions.forEach(function(element, index, element_arr){
      $('#submit-' + element).on("click", function(event){
        event.preventDefault();
        if (index != element_arr.length - 1) {
          $('#' + element).fadeOut(400);
          $('#' + element_arr[index + 1]).delay(600).fadeIn(500);
          if (index === Math.floor(element_arr.length / 2) - 1) {
            $('.questions-heading').text("Tell Us About Your Ideal Roommate's Schedule");
          }
        }
      });
    });
  }
}

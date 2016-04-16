app.schedules.controller = {
  edit: function(event) {
    // schedule question page elements
    var schedule_items = ['work-schedule', 'sleep-schedule', 'bathroom-schedule', 'kitchen-schedule',
    'roommate-work-schedule', 'roommate-sleep-schedule', 'roommate-bathroom-schedule', 'roommate-kitchen-schedule',
    'submit-schedule-questions'];

    schedule_items.forEach(function(element){
      $('#' + element).hide();
    });
    $('#' + schedule_items[0]).show();
    $('#' + schedule_items[0]).addClass("current-question");

    schedule_items.forEach(function(element, index, element_arr){
      $('#submit-' + element).on("click", function(event){
        event.preventDefault();
        if (index != element_arr.length - 1) {
          $('.current-question').fadeOut(400);
          $('.current-question').removeClass("current-question");
          $('#' + element_arr[index + 1]).addClass("current-question");
          if ($('.current-question').attr('id').split('-')[0] === "roommate") {
            $('.questions-heading').text("Tell Us About Your Ideal Roommate's Schedule");
          }
          $('.current-question').delay(600).fadeIn(500);
        }
      });
    });

    schedule_items.forEach(function(element, index, element_arr){
      $('#go-to-' + element).on("click", function(event){
        $('.current-question').fadeOut(400);
        $('.current-question').removeClass("current-question");
        $('#' + element).addClass("current-question");
        if ($('.current-question').attr('id').split('-')[0] === "roommate") {
          $('.questions-heading').text("Tell Us About Your Ideal Roommate's Schedule");
        }
        else {
          $('.questions-heading').text("Tell Us About Yourself");
        }
        $('.current-question').delay(600).fadeIn(500);
      });
    });
  }
}

app.schedules.controller = {
  edit: function() {
    // schedule question page elements
    var schedule_items = ['work-schedule', 'sleep-schedule', 'bathroom-schedule', 'kitchen-schedule',
    'roommate-work-schedule', 'roommate-sleep-schedule', 'roommate-bathroom-schedule', 'roommate-kitchen-schedule',
    'submit-schedule-questions'];

    schedule_items.forEach(function(element){
      $('#' + element).hide();
    });
    $('#' + schedule_items[0]).show();
    $('#' + schedule_items[0]).addClass("current-question");
    $('#go-to-' + schedule_items[0]).addClass("current-question-nav");

    schedule_items.forEach(function(element, index, element_arr){
      $('#submit-' + element).on("click", function(event){
        event.preventDefault();
        $('.current-question').fadeOut(400);
        $('.current-question').removeClass("current-question");
        $('.current-question-nav').removeClass("current-question-nav");
        $('#go-to-' + element_arr[index + 1]).addClass("current-question-nav");
        $('#' + element_arr[index + 1]).addClass("current-question");
        if ($('.current-question').attr('id').split('-')[0] === "roommate") {
          $('.questions-heading').text("Tell Us About Your Ideal Roommate's Schedule");
        }
        $('.current-question').delay(600).fadeIn(500);
      });
    });

    schedule_items.forEach(function(element, index, element_arr){
      $('#back-' + element).on("click", function(event){
        event.preventDefault();
        $('.current-question').fadeOut(400);
        $('.current-question').removeClass("current-question");
        $('.current-question-nav').removeClass("current-question-nav");
        $('#go-to-' + element_arr[index - 1]).addClass("current-question-nav");
        $('#' + element_arr[index - 1]).addClass("current-question");
        if ($('.current-question').attr('id').split('-')[0] === "roommate") {
          $('.questions-heading').text("Tell Us About Your Ideal Roommate's Schedule");
        }
        $('.current-question').delay(600).fadeIn(500);
      });
    });

    schedule_items.forEach(function(element, index, element_arr){
      $('#go-to-' + element).on("click", function(event){
        $('.current-question').fadeOut(400);
        $('.current-question').removeClass("current-question");
        $('.current-question-nav').removeClass("current-question-nav");
        $('#go-to-' + element).addClass("current-question-nav");
        $('#' + element).addClass("current-question");
        if ($('.current-question').attr('id').split('-')[0] === "roommate") {
          $('.questions-heading').text("Tell Us About Your Ideal Roommate's Schedule");
        }
        else {
          $('.questions-heading').text("Tell Us About Yourself");
        }
        $('.current-question').delay(600).fadeIn(500);
        $('.your-schedule').empty()
        
        var kitchenValue = $('#user_schedule_attributes_kitchen option:selected').text(); 
        $('.your-schedule').prepend('<strong>Kitchen:</strong><text> '+ kitchenValue  + '</text><br>')
        var bathroomValue = $('#user_schedule_attributes_bathroom option:selected').text();
        $('.your-schedule').prepend('<strong>Bathroom:</strong><text> '+ bathroomValue  + '</text><br>')
        var sleepValue = $('#user_schedule_attributes_sleep option:selected').text();
        $('.your-schedule').prepend('<strong>Sleep:</strong><text> '+ sleepValue  + '</text><br>')
        var workValue = $('#user_schedule_attributes_work option:selected').text();
        $('.your-schedule').prepend('<strong>Work:</strong><text> '+ workValue  + '</text><br>')
      });

    });
     
  },

   show: function(){

    $('a#schedule-section').on("click", function(event){

       event.preventDefault();

      var link = $('#schedule-section').attr('href');
       $.ajax({
     
      
         url: link,
         method: 'GET',
         //dataType: 'json',

       success: function(data){
      
       
         
        $('.revealSection').html(data);
         //find  the div subset with jquery 
        //loads the html
        //create class the encapsulates each section form 
        //unhide the form 
       app.schedules.controller.edit();
       //hides the html
        // $('#' + schedule_items[0]).addClass("current-question");
        // $('#go-to-' + schedule_items[0]).addClass("current-question-nav");

         
          
       }
       });
  
    });
   }
}

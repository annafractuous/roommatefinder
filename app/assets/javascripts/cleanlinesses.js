app.cleanlinesses.controller = {
  edit: function() {
    // cleanliness question page elements
    var cleanliness_items = ['kitchen-cleanliness', 'bathroom-cleanliness', 'common-space-cleanliness',
    'roommate-kitchen-cleanliness', 'roommate-bathroom-cleanliness', 'roommate-common-space-cleanliness',
    'submit-cleanliness-questions'];

    cleanliness_items.forEach(function(element){
      $('#' + element).hide();
    });
    $('#' + cleanliness_items[0]).show();
    $('#' + cleanliness_items[0]).addClass("current-question");
    $('#go-to-' + cleanliness_items[0]).addClass("current-question-nav");

    cleanliness_items.forEach(function(element, index, element_arr){
      $('#submit-' + element).on("click", function(event){
        event.preventDefault();
        $('.current-question').fadeOut(400);
        $('.current-question').removeClass("current-question");
        $('.current-question-nav').removeClass("current-question-nav");
        $('#go-to-' + element_arr[index + 1]).addClass("current-question-nav");
        $('#' + element_arr[index + 1]).addClass("current-question");
        if ($('.current-question').attr('id').split('-')[0] === "roommate") {
          $('.questions-heading').text("Tell Us About Your Ideal Roommate's Cleanliness");
        }
        $('.current-question').delay(600).fadeIn(500);
      });
    });

    cleanliness_items.forEach(function(element, index, element_arr){
      $('#back-' + element).on("click", function(event){
        event.preventDefault();
        $('.current-question').fadeOut(400);
        $('.current-question').removeClass("current-question");
        $('.current-question-nav').removeClass("current-question-nav");
        $('#go-to-' + element_arr[index - 1]).addClass("current-question-nav");
        $('#' + element_arr[index - 1]).addClass("current-question");
        if ($('.current-question').attr('id').split('-')[0] === "roommate") {
          $('.questions-heading').text("Tell Us About Your Ideal Roommate's Cleanliness");
        }
        $('.current-question').delay(600).fadeIn(500);
      });
    });

    cleanliness_items.forEach(function(element, index, element_arr){
      $('#go-to-' + element).on("click", function(event){
        $('.current-question').fadeOut(400);
        $('.current-question').removeClass("current-question");
        $('.current-question-nav').removeClass("current-question-nav");
        $('#go-to-' + element).addClass("current-question-nav");
        $('#' + element).addClass("current-question");
        if ($('.current-question').attr('id').split('-')[0] === "roommate") {
          $('.questions-heading').text("Tell Us About Your Ideal Roommate's Cleanliness");
        }
        else {
          $('.questions-heading').text("Tell Us About Yourself");
        }
        $('.current-question').delay(600).fadeIn(500);
      });
    });
  }
}

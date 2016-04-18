app = {
  desired_match_traits: {},
  cleanlinesses: {},
  schedules: {},
  habits: {},
  users: {}
};

$(function() {
  // ************* will we be using this? *************
  // $('div#emailReveal').click(function(event){
  //   event.preventDefault();
  //   $('.email').toggle();
  // });

  

  app.desired_match_traits.controller.edit();
  app.schedules.controller.edit();
  app.cleanlinesses.controller.edit();
  app.habits.controller.edit();

  app.schedules.controller.show();

});

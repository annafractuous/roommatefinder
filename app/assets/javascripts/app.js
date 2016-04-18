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

  

  app.desired_match_traits.controller.show();
  //app.cleanlinesses.controller.edit();
  app.schedules.controller.show();
  app.habits.controller.show();
  //app.schedules.controller.edit();
  app.cleanlinesses.controller.show();

  app.users.controller.edit();

  //app.schedules.controller.show();

});

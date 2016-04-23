app = {
  desired_match_traits: {},
  cleanlinesses: {},
  schedules: {},
  habits: {},
  users: {},
  match_connections: {}
};

$(function() {
  app.desired_match_traits.controller.show();
  app.schedules.controller.show();
  app.habits.controller.show();
  app.cleanlinesses.controller.show();
  app.match_connections.controller.show();
  app.users.controller.show();
});

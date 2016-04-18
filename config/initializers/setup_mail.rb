ActionMailer::Base.smtp_settings = {
      :address              => "smtp.gmail.com",
      :port                 => 587,
      :user_name            => "roominateapp@gmail.com",
      :password             => "Roominate888",
      :authentication => :plain,
      :enable_starttls_auto => true
  }
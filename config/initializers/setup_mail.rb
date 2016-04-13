ActionMailer::Base.smtp_settings = {
      :address              => "smtp.gmail.com",
      :port                 => 587,
      :user_name            => "raiseyourhandapp@gmail.com",
      :password             => "raiseyourhand555",
      :authentication => :plain,
      :enable_starttls_auto => true
  }
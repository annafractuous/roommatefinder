class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Roomater')
  end

  def interest_email
    @user = user
    mail(to: @user.email, subject: "Looks like there's mutual interest in a Roominate match!")
  end

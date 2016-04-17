# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  birthdate       :datetime
#  gender          :string
#  dealbreakers    :text
#  has_apartment   :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#  username        :string
#  max_rent        :integer
#

class UsersController < ApplicationController
  before_action :authorize, only: [:edit, :update]
  include ActionView::Helpers::TextHelper

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # TEMPORARY FOR DEVELOPMENT, only send email to gmail users
      if @user.email =~ /gmail\.com\b/
        UserMailer.welcome_email(@user).deliver_now
      end
      session[:user_id] = @user.id
      redirect_to @user, notice: "Welcome to Roominate!"
    else
      flash.now[:error] = @user.errors.to_a
      redirect_to signup_path
    end
  end

  def show
    @user = User.find(params[:id])
    @desired_match_trait = @user.desired_match_trait

    if @user.interested_matches.size > 0
      @interested_matches = @user.interested_matches
      
      # make sure a match connection object exists in the opposite direction
      # after a match has shown interest in a user so that the link
      # to the match show page works
      @interested_matches.each do |match|
        MatchConnection.find_or_create_by(user: @user, match: match)
      end
      size = @interested_matches.size
      flash.now[:message] = "#{pluralize(size, 'user')} think(s) you could make great roommates!"
      render :show
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      flash.now[:error] = @user.errors.to_a
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :username, :name, :birthdate, :gender, :photo)
    end

end

class UsersController < ApplicationController
  before_action :authorize, only: [:edit, :update, :show]
  include ActionView::Helpers::TextHelper

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      
      # UserMailer.welcome_email(@user).deliver_now

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
    @interested_matches = (@user.one_way_interested_matches - @user.not_interested)
  end

  def edit
    @user = User.find(params[:id])
    render :edit, :layout => false
  end

  def update
    @user = User.find(params[:id])
    
    # guard against not choosing a file when updating photo 
    if params[:user]
      if @user.update(user_params)
        redirect_to @user
      else
        flash.now[:error] = @user.errors.to_a
        render :edit
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :username, :name, :birthdate, :gender, :photo)
    end

end

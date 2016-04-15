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

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver
      session[:user_id] = @user.id
      redirect_to @user, notice: "Welcome to RoomMater!"
    else
      flash.now[:error] = @user.errors.to_a
      redirect_to signup_path
    end
  end

  def show
    @user = User.find(params[:id])
    @profile_percent_complete = @user.profile_percent_complete
    @name = @user.display_name
    @age = @user.convert_age
    @gender = @user.gender
    @max_rent = @user.max_rent
    @dealbreakers = @user.dealbreakers
    @has_apartment = @user.has_apartment
    @city = @user.desired_match_trait.city
    @desired_gender = @user.desired_match_trait.print_desired_gender
    @desired_age = @user.desired_match_trait.print_desired_age
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
      params.require(:user).permit(:email, :password, :password_confirmation, :username, :name, :birthdate, :gender)
    end

end

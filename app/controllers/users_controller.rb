# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  age             :integer
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

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Welcome to Roommater!"
    else
      flash[:error] = @user.errors.to_a
      redirect_to signup_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(extra_params)
      redirect_to @user
    else
      flash[:error] = @user.errors.to_a
      redirect_to @user
    end
  end

  private

   def user_params
     params.require(:user).permit(:email, :password, :password_confirmation, :username, :name, :age, :gender)
   end

   def extra_params
    params.require(:user).permit(:dealbreakers, :max_rent, :has_apartment)
  end
end

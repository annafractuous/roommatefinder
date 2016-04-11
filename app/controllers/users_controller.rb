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

  private

   def user_params
     params.require(:user).permit(:email, :password, :password_confirmation, :username, :name, :age, :gender)
   end

end

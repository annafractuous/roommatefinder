class UsersController < ApplicationController

  def new
    @user = User.new(user_params)

    if @user.save
      render :show, notice: "Welcome to Roommater!"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params

  end

end

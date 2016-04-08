class UsersController < ApplicationController

  def new
    @user = User.new(user_params)

    if @user.save
      @user.build_profile
      @user.build_preference
      render :show
    else
      render :new
    end
  end

  private

  def user_params
  end

end

class ProfilesController < ApplicationController

  def new
    # TODO: make this current_user
    @user = User.find(params[:user_id])
    @profile = @user.build_profile
    render 'new'
  end



end

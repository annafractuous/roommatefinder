class ProfilesController < ApplicationController

  def new
    # TODO: make this current_user
    @user = User.find(params[:user_id])
    @profile = @user.build_profile
    render 'new'
  end

  def create
    @user = User.find(params[:user_id])
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:cleanliness, :schedule, :social_habits, :substance_habits, :pets)
  end

end

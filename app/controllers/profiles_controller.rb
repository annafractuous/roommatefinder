class ProfilesController < ApplicationController

  def new
    # TODO: make this current_user
    # not currently using this action
    @user = User.find(params[:user_id])
    # @cleanliness = @profile.build_cleanliness
    # @schedule = @profile.build_schedule
    # @habit = @profile.build_habit
    render 'new'
  end

  # not currently using this action, either
  def create
    binding.pry
    @user = User.find(params[:user_id])
    @profile = @user.build_profile

    if @profile.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:cleanliness, :schedule, :habit)
  end

  # "profile"=>
  #   {"cleanliness"=>{"kitchen"=>"daily", "bathroom"=>"neat", "common_space"=>"never there"},
  #    "schedule"=>{"work"=>"9-6", "sleep"=>"2-8", "bathroom"=>"evening showers", "kitchen"=>"rarely"},
  #    "habit"=>{"drinking"=>"rarely", "four_twenty"=>"daily", "partying"=>"never", "overnight_visitors"=>"hardly", "music"=>"roof-raising"}},
  #  "user_id"=>"1"}

end

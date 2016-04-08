class CleanlinessesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @profile = @user.profile
    @cleanliness = @profile.build_cleanliness
    @preference = @user.preference
    @desired_cleanliness = @preference.build_desired_cleanliness
    render :new
  end

  def create
    @user = User.find(params[:user_id])
    @profile = @user.profile
    
    @cleanliness = Cleanliness.new(cleanliness_params[:cleanliness])
    @desired_cleanliness = DesiredCleanliness.new(desired_cleanliness_params[:desired_cleanliness])
    
    if @cleanliness.save && @desired_cleanliness.save
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  private

  def cleanliness_params
    params.require(:user).permit(:cleanliness =>[:kitchen, :bathroom, :common_space])
  end

  def desired_cleanliness_params
    params.require(:user).permit(:desired_cleanliness =>[:kitchen, :bathroom, :common_space])
  end

 #  "user"=>
 #  {"cleanliness"=>{"kitchen"=>"aw", "bathroom"=>"ga", "common_space"=>"ju"},
 #   "desired_cleanliness"=>
 #    {"kitchen"=>"gu", "bathroom"=>"jew", "common_space"=>"ku"}},
 # "commit"=>"Update User",
 # "controller"=>"cleanlinesses",
 # "action"=>"create",
 # "user_id"=>"1"}
 
end
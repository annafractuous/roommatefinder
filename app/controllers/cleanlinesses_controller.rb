class CleanlinessesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @cleanliness = @user.build_cleanliness
    @desired_cleanliness = @user.build_desired_cleanliness
    @method = "POST"
    @action = user_cleanlinesses_path(@user)
  end

  def create
    @user = User.find(params[:user_id])
    
    @cleanliness = @user.build_cleanliness(cleanliness_params[:cleanliness])
    @desired_cleanliness = @user.build_desired_cleanliness(desired_cleanliness_params[:desired_cleanliness])
    if @cleanliness.save && @desired_cleanliness.save
      redirect_to @user
    else
      render :ne
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @action = user_cleanliness_path(@user, @user.cleanliness)
    @method = "PATCH"
  end

  def update
    @user = User.find(params[:user_id])
    @user.cleanliness.update(cleanliness_params[:cleanliness])
    @user.desired_cleanliness.update(desired_cleanliness_params[:desired_cleanliness])
    redirect_to @user
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
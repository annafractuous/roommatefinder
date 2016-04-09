# == Schema Information
#
# Table name: cleanlinesses
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  kitchen      :string
#  bathroom     :string
#  common_space :string
#  user_id      :integer
#

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
    
    @cleanliness = @user.build_cleanliness(cleanliness_params[:cleanliness_attributes])
    @desired_cleanliness = @user.build_desired_cleanliness(desired_cleanliness_params[:desired_cleanliness_attributes])
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
    @user.cleanliness.update(cleanliness_params[:cleanliness_attributes])
    @user.desired_cleanliness.update(desired_cleanliness_params[:desired_cleanliness_attributes])
    redirect_to @user
  end

  def show
  end

  private

  def cleanliness_params
    params.require(:user).permit(:cleanliness_attributes =>[:kitchen, :bathroom, :common_space])
  end

  def desired_cleanliness_params
    params.require(:user).permit(:desired_cleanliness_attributes =>[:kitchen, :kitchen_importance, :bathroom, :bathroom_importance, :common_space, :common_space_importance])
  end


 
end

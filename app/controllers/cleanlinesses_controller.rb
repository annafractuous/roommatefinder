# == Schema Information
#
# Table name: cleanlinesses
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  kitchen      :integer
#  bathroom     :integer
#  common_space :integer
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
    cleanliness = @user.build_cleanliness(cleanliness_params)
    desired_cleanliness = @user.build_desired_cleanliness(desired_cleanliness_params)

    if cleanliness.save && desired_cleanliness.save
      redirect_to @user
    else
      # flash[:error] = desired_cleanliness.errors.to_a
      render :new
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @action = user_cleanliness_path(@user, @user.cleanliness)
    @method = "PATCH"
  end

  def update
    @user = User.find(params[:user_id])
    cleanliness = @user.cleanliness
    desired_cleanliness = @user.desired_cleanliness

    if cleanliness.update(cleanliness_params) && desired_cleanliness.update(desired_cleanliness_params)
      redirect_to @user
    else
      flash[:error] = desired_cleanliness.errors.to_a
      render :edit
    end
  end

  def show
  end

  private

  def cleanliness_params
    params.require(:user).permit(:cleanliness_attributes =>[:kitchen, :bathroom, :common_space])[:cleanliness_attributes]
  end

  def desired_cleanliness_params
    params.require(:user).permit(:desired_cleanliness_attributes =>[:kitchen, :kitchen_importance, :bathroom, :bathroom_importance, :common_space, :common_space_importance])[:desired_cleanliness_attributes]
  end
end

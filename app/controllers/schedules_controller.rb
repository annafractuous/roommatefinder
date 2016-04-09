# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  work       :string
#  sleep      :string
#  bathroom   :string
#  kitchen    :string
#  user_id    :integer
#

class SchedulesController < ApplicationController
 def new
    @user = User.find(params[:user_id])
    @schedules = @user.build_schedule
    @desired_schedules = @user.build_desired_schedule
    @method = "POST"
    @action = user_schedules_path(@user)
  end

  def create
    @user = User.find(params[:user_id])
    
    @schedule = @user.build_schedule(schedule_params[:schedule_attributes])
    @desired_schedule = @user.build_desired_schedule(desired_schedule_params[:desired_schedule_attributes])
    if @schedule.save && @desired_schedule.save
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @action = user_schedule_path(@user, @user.schedule)
    @method = "PATCH"
  end

  def update
    @user = User.find(params[:user_id])
    @user.schedule.update(schedule_params[:schedule_attributes])
    @user.desired_schedule.update(desired_schedule_params[:desired_schedule_attributes])
    redirect_to @user
  end
  
  private

  def schedule_params
    params.require(:user).permit(:schedule_attributes =>[:work, :sleep, :bathroom, :kitchen])
  end

  def desired_schedule_params
    params.require(:user).permit(:desired_schedule_attributes =>[:work, :work_importance, :sleep, :sleep_importance, :bathroom, :bathroom_importance, :kitchen, :kitchen_importance])
  end

end

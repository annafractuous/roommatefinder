# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  work       :integer
#  sleep      :integer
#  bathroom   :integer
#  kitchen    :integer
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
    schedule = @user.build_schedule(schedule_params)
    desired_schedule = @user.build_desired_schedule(desired_schedule_params)

    if schedule.save && desired_schedule.save
      redirect_to @user
    else
      # flash[:error] = desired_schedule.errors.to_a
      @method = "POST"
      @action = user_schedules_path(@user)
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
    schedule = @user.schedule
    desired_schedule = @user.desired_schedule

    if schedule.update(schedule_params) && desired_schedule.update(desired_schedule_params)
      redirect_to @user
    else
      flash[:error] = desired_schedule.errors.to_a
      @action = user_schedule_path(@user, @user.schedule)
      @method = "PATCH"
      render :edit
    end
  end

  private

  def schedule_params
    params.require(:user).permit(:schedule_attributes =>[:work, :sleep, :bathroom, :kitchen])[:schedule_attributes]
  end

  def desired_schedule_params
    params.require(:user).permit(:desired_schedule_attributes =>[:work, :work_importance, :sleep, :sleep_importance, :bathroom, :bathroom_importance, :kitchen, :kitchen_importance])[:desired_schedule_attributes]
  end

end

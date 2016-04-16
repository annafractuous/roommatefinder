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
  before_action :authorize

  def edit
    @user = User.find(params[:user_id])
    @desired_match_trait = @user.desired_match_trait
    @action = user_schedule_path(@user, @user.schedule)
    @method = "PATCH"
  end

  def update
    @user = User.find(params[:user_id])
    schedule = @user.schedule
    desired_schedule = @user.desired_schedule

    stringified_params = desired_answer_params_to_string

    if schedule.update(schedule_params) && desired_schedule.update(stringified_params)
      redirect_to @user
    else
      flash.now[:error] = schedule.errors.to_a + desired_schedule.errors.to_a
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
      params.require(:user).permit![:desired_schedule_attributes]
    end

    def desired_answer_params_to_string
      question_columns = Schedule.user_input_columns
      question_columns.each do |question|
        if desired_schedule_params[question]
          desired_schedule_params[question] = desired_schedule_params[question].join
        end
      end
      desired_schedule_params
    end

end

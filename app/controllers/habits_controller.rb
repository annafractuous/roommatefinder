# == Schema Information
#
# Table name: habits
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  drinking           :integer
#  four_twenty        :integer
#  partying           :integer
#  overnight_visitors :integer
#  music              :integer
#  user_id            :integer
#

class HabitsController < ApplicationController
  before_action :authorize

  def edit
    @user = User.find(params[:user_id])
    @action = user_habit_path(@user, @user.habit)
    @method = "PATCH"
  end

  def update
    @user = User.find(params[:user_id])
    habit = @user.habit
    desired_habit = @user.desired_habit

    if habit.update(habit_params) && desired_habit.update(desired_habit_params)
      redirect_to @user
    else
      flash[:error] = habit.errors.to_a + desired_habit.errors.to_a
      @action = user_habit_path(@user, @user.habit)
      @method = "PATCH"
      render :edit
    end
  end

  private

    def habit_params
      params.require(:user).permit(:habit_attributes =>[:drinking, :four_twenty, :partying, :overnight_visitors, :music])[:habit_attributes]
    end

    def desired_habit_params
      params.require(:user).permit(:desired_habit_attributes =>[:drinking, :drinking_importance, :four_twenty, :four_twenty_importance, :partying, :partying_importance, :overnight_visitors, :overnight_visitors_importance, :music, :music_importance])[:desired_habit_attributes]
    end

end

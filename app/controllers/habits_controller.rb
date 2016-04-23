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


  def edit
    @user = User.find(params[:user_id])
    @desired_match_trait = @user.desired_match_trait
    @interested_matches = @user.interested_matches if @user.interested_matches.size > 0
    @action = user_habit_path(@user, @user.habit)
    @method = "PATCH"
    render :edit, :layout => false
  end

  def update
    @user = User.find(params[:user_id])
    habit = @user.habit
    desired_habit = @user.desired_habit

    stringified_params = desired_answer_params_to_string

    if habit.update(habit_params) && desired_habit.update(stringified_params)
      redirect_to @user
    else
      flash.now[:error] = habit.errors.to_a + desired_habit.errors.to_a
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
      params.require(:user).permit![:desired_habit_attributes]
    end

    def desired_answer_params_to_string
      question_columns = Habit.user_input_columns
      question_columns.each do |question|
        if desired_habit_params[question]
          desired_habit_params[question] = desired_habit_params[question].join
        end
      end
      desired_habit_params
    end

end

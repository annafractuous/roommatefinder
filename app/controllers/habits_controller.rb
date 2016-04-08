class HabitsController < ApplicationController
 def new
    @user = User.find(params[:user_id])
    @habits = @user.build_habit
    @desired_habits = @user.build_desired_habit
    @method = "POST"
    @action = user_habits_path(@user)
  end

  def create
    binding.pry
    @user = User.find(params[:user_id])
    
    @habit = @user.build_habit(habit_params[:habits])
    @desired_habit = @user.build_desired_habit(desired_habit_params[:desired_habits])
    if @habit.save && @desired_habit.save
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    binding.pry
    @user = User.find(params[:user_id])
    @action = user_habit_path(@user, @user.habit)
    @method = "PATCH"
  end

  def update
    binding.pry
    @user = User.find(params[:user_id])
    @user.habit.update(habit_params[:habits])
    @user.desired_habit.update(desired_habit_params[:desired_habits])
    redirect_to @user
  end
  
  private

  def habit_params
    params.require(:user).permit(:habits =>[:drinking, :four_twenty, :partying, :overnight_visitors, :music])
  end

  def desired_habit_params
    params.require(:user).permit(:desired_habits =>[:drinking, :four_twenty, :partying, :overnight_visitors, :music])
  end

 # Table name: habits
#
#  id                 :integer          not null, primary key
#  profile_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  drinking           :string
#  four_twenty        :string
#  partying           :string
#  overnight_visitors :string
#  music              :string
#
 
end
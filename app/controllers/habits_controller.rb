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
class HabitsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @profile = @user.profile
    @habit = @profile.build_habit
    @preference = @user.preference
    @desired_habit = @preference.build_desired_habit
    render :new
  end

  def create
    #binding.pry
    @user = User.find(params[:user_id])
    
    
    @habit = @user.profile.build_habit(habit_params[:habit])
    @desired_habit = @user.preference.build_desired_habit(desired_habit_params[:desired_habit])
     binding.pry
    if @habit.save && @desired_habit.save
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

  def habit_params
    params.require(:user).permit(:habit =>[:drinking, :four_twenty, :partying, :overnight_visitors, :music])
  end

  def desired_habit_params
    params.require(:user).permit(:desired_habit =>[:drinking, :four_twenty, :partying, :overnight_visitors, :music])
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
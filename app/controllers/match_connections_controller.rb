# == Schema Information
#
# Table name: match_connections
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  match_id      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  compatibility :integer
#

class MatchConnectionsController < ApplicationController

  def create
  end

  def index
    @user = User.find(params[:user_id])
    @matches = @user.find_matches
    @matches = @matches.reject { |match| @user.compatibility_with(match) < 25 }.sort_by { |match| @user.compatibility_with(match) }.reverse
    render 'index'
  end

  def show
    @match = User.find(params[:match_id])
    @user = current_user
    @match_connection = @user.match_connection_object_for(@match)

    bathroom = @match.cleanliness.bathroom
    @bathroom = Cleanliness.cleanliness_quantified[bathroom]
    kitchen = @match.cleanliness.kitchen
    @kitchen = Cleanliness.cleanliness_quantified[kitchen]
    common_space = @match.cleanliness.common_space
    @common_space = Cleanliness.cleanliness_quantified[common_space]

    work = @match.schedule.work
    @work = Schedule.work_schedule_quantified[work]
    sleep = @match.schedule.sleep
    @sleep = Schedule.sleep_schedule_quantified[sleep]
    bathroom_sch = @match.schedule.bathroom
    @bathroom_sch = Schedule.bathroom_schedule_quantified[bathroom_sch]
    kitchen = @match.schedule.kitchen
    @kitchen = Schedule.kitchen_schedule_quantified[kitchen]

    drinking = @match.habit.drinking
    @drinking = Habit.wildness_quantified[drinking]
    four_twenty = @match.habit.four_twenty
    @four_twenty = Habit.wildness_quantified[four_twenty]
    overnight = @match.habit.overnight_visitors
    @overnight = Habit.visitors_quantified[overnight]
    partying = @match.habit.partying
    @partying = Habit.wildness_quantified[partying]
    music = @match.habit.music
    @music = Habit.music_quantified[music]




    sleep
    bathroom_sch
    kitchen

  end


  def update

    @match = User.find(params[:match_id])
    @user = current_user
    @match_connection = @user.match_connection_object_for(@match)
    if @match_connection.update(interested: true)
      redirect_to user_matches_path(@user)
    else
      render :show
    end
  end
end

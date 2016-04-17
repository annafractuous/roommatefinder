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

    #@matchers.where("compatibility > 25").order("compatibility DESC")
    #@matches = @matches.reject { |match| @user.compatibility_with(match) < 25 }.sort_by { |match| @user.compatibility_with(match)}.reverse

    @matches = @matches.reject { |match| @user.compatibility_with(match) < 25 }.sort_by { |match| @user.compatibility_with(match) }.reverse

    render 'index'
  end

  def show
    @match = User.find(params[:match_id])
    @user = current_user
    @total_compatibility = @user.compatibility_with(@match)
    @match_cleanliness = @match.cleanliness.convert_cleanliness(@match.cleanliness)
    @cleanliness_compatibility = @user.mutual_compatibility_score_per_category("cleanliness", @match)
    @match_schedule = @match.schedule.convert_schedule(@match.schedule)
    @schedule_compatibility = @user.mutual_compatibility_score_per_category("schedule", @match)
    @match_habit = @match.habit.convert_habit(@match.habit)
    @habit_compatibility = @user.mutual_compatibility_score_per_category("habit", @match)
  
  end


  def update
    @match = User.find(params[:match_id])
    @user = current_user
    @match_connection = @user.match_connection_object_for(@match)
    if @match_connection.update(interested: true)
      # create the opposite match so user can click link to this users match show page
      connection = MatchConnection.find_or_create_by(user_id: @match.id, match_id: @user.id)
      @match.run_match_calculations(@user)
      redirect_to user_match_path(@user, @match), notice: "You've sent a message to #{@match.username}."
    else
      render :show
    end
  end
end

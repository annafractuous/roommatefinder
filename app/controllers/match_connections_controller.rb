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
    @user.find_matches
    connections = MatchConnection.where("user_id = ? AND compatibility >= ?", @user.id, 25).order(compatibility: :desc)
    @matches = connections.map { |connection| connection.match }
    @mutually_interested_matches = @user.mutually_interested_matches
    if @matches.size == 0
      @top_users = MatchConnection.most_popular_users
      @top_users.each do |match|
        MatchConnection.find_or_create_by(user_id: @user.id, match_id: match.id)
        @user.run_match_calculations(match)
      end
    end
    render 'index'
  end

  def show
    @match = User.find(params[:match_id])

    @user = current_user
    @total_compatibility = @user.compatibility_with(@match)

    @match_cleanliness = @match.cleanliness.convert_cleanliness(@match.cleanliness)
    @cleanliness_compatibility = Cleanliness.print_category_score(@user, @match)

    @match_schedule = @match.schedule.convert_schedule(@match.schedule)
    @schedule_compatibility = Schedule.print_category_score(@user, @match)

    @match_habit = @match.habit.convert_habit(@match.habit)
    @habit_compatibility = Habit.print_category_score(@user, @match)

    @user_to_match_conn = MatchConnection.find_or_create_by(user_id: @user.id, match_id: @match.id)
    @match_to_user_conn = MatchConnection.find_or_create_by(user_id: @match.id, match_id: @user.id)
  end


  def update
    @match = User.find(params[:match_id])
    @user = current_user
    @user_to_match_connection = @user.match_connection_object_for(@match)
    match_to_user_connection = MatchConnection.find_or_create_by(user_id: @match.id, match_id: @user.id)

    if @user_to_match_connection.update(match_connection_params)
      if params[:match_connection][:interested] == "true"
        @match.run_match_calculations(@user)
        redirect_to user_match_path(@user, @match), notice: "You've sent a notification to #{@match.display_name}"
      else
        redirect_to user_path(@user), notice: "You've removed this person from your potential matches sidebar."
      end
    end
  end

  private

  def match_connection_params
    params.require(:match_connection).permit(:interested)
  end
end

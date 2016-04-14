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
    # switch to ActiveRecord SQL-y type statements
    @matches = @matches.reject { |match| @user.compatibility_with(match) < 25 }.sort_by { |match| @user.compatibility_with(match)}.reverse
    render 'index'
  end

  def show
    #binding.pry
    @match = User.find(params[:match_id])
    @user = current_user
    @match_connection = MatchConnection.where("user_id = ? AND match_id = ?", @user.id, @match.id)
    #@action = user_match_path(@user, @user.cleanliness)
    #@method = "PATCH"
  end


  def update
    @match = User.find(params[:match_id])
    @user = current_user
    @match_connection = MatchConnection.where("user_id = ? AND match_id = ?", @user.id, @match.id)
    if @match_connection.update
      redirect_to user_match_path(@user, @match)
    else
      render :show
    end
  end
end

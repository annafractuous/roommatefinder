# == Schema Information
#
# Table name: match_connections
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  match_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MatchConnectionsController < ApplicationController
  
  def index
    render :index
  end

  def create
  end

end

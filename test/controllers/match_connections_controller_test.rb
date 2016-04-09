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

require 'test_helper'

class MatchConnectionsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
end

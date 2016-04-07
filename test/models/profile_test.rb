# == Schema Information
#
# Table name: profiles
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  cleanliness      :string
#  schedule         :string
#  social_habits    :string
#  substance_habits :string
#  pets             :string
#

require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

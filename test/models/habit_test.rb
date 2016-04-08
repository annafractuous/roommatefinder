# == Schema Information
#
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

require 'test_helper'

class HabitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

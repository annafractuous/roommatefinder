# == Schema Information
#
# Table name: desired_schedules
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  work          :string
#  sleep         :string
#  bathroom      :string
#  kitchen       :string
#  preference_id :integer
#

require 'test_helper'

class DesiredScheduleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

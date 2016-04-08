# == Schema Information
#
# Table name: desired_schedules
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  work       :string
#  sleep      :string
#  bathroom   :string
#  kitchen    :string
#

require 'test_helper'

class DesiredScheduleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

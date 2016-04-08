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

class DesiredSchedule < ActiveRecord::Base
  belongs_to :preference
end

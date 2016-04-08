# == Schema Information
#
# Table name: desired_schedules
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  work       :string
#  sleep      :string
#  bathroom   :string
#  kitchen    :string
#  user_id    :integer
#

class DesiredSchedule < ActiveRecord::Base
  belongs_to :user
end

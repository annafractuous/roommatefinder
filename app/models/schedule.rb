# == Schema Information
#
# Table name: schedules
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

class Schedule < ActiveRecord::Base
  belongs_to :profile
end

# == Schema Information
#
# Table name: schedules
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

class Schedule < ActiveRecord::Base
  belongs_to :user
end

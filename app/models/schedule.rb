# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  work       :integer
#  sleep      :integer
#  bathroom   :integer
#  kitchen    :integer
#  user_id    :integer
#

class Schedule < ActiveRecord::Base
  include ChoicesQuantifiable::Schedule
  include Validatable
  extend InputColumnable
  belongs_to :user
end

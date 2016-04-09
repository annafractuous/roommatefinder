# == Schema Information
#
# Table name: desired_schedules
#
#  id                  :integer          not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  work                :integer
#  sleep               :integer
#  bathroom            :integer
#  kitchen             :integer
#  user_id             :integer
#  kitchen_importance  :integer
#  bathroom_importance :integer
#  work_importance     :integer
#  sleep_importance    :integer
#

class DesiredSchedule < ActiveRecord::Base
  belongs_to :user
  include HowImportantToYouAble
end

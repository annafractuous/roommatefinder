# == Schema Information
#
# Table name: desired_habits
#
#  id                            :integer          not null, primary key
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  drinking                      :integer
#  four_twenty                   :integer
#  partying                      :integer
#  overnight_visitors            :integer
#  music                         :integer
#  user_id                       :integer
#  drinking_importance           :integer
#  partying_importance           :integer
#  music_importance              :integer
#  four_twenty_importance        :integer
#  overnight_visitors_importance :integer
#

class DesiredHabit < ActiveRecord::Base
  include HowImportantToYouAble
  include ChoicesQuantifiable::Habit
  include Validatable
  extend InputColumnable
  belongs_to :user

  validate :preference_and_importance_entered?, :cannot_select_pick_one
  
end

# == Schema Information
#
# Table name: desired_habits
#
#  id                            :integer          not null, primary key
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  drinking                      :string
#  four_twenty                   :string
#  partying                      :string
#  overnight_visitors            :string
#  music                         :string
#  user_id                       :integer
#  drinking_importance           :integer
#  partying_importance           :integer
#  music_importance              :integer
#  four_twenty_importance        :integer
#  overnight_visitors_importance :integer
#

class DesiredHabit < ActiveRecord::Base
  belongs_to :user
  include HowImportantToYouAble
end

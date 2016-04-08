# == Schema Information
#
# Table name: habits
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  drinking           :string
#  four_twenty        :string
#  partying           :string
#  overnight_visitors :string
#  music              :string
#  user_id            :integer
#

class Habit < ActiveRecord::Base
  belongs_to :user
end

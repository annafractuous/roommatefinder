# == Schema Information
#
# Table name: habits
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  drinking           :integer
#  four_twenty        :integer
#  partying           :integer
#  overnight_visitors :integer
#  music              :integer
#  user_id            :integer
#

class Habit < ActiveRecord::Base
  include ChoicesQuantifiable::Habit
  include Validatable
  extend InputColumnable::ClassMethods
  include InputColumnable
  validate :cannot_select_pick_one

  belongs_to :user
end

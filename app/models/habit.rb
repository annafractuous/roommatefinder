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
  extend ChoicesQuantifiable::Habit
  include Validatable
  extend InputColumnable::ClassMethods
  include InputColumnable
  validate :cannot_select_pick_one

  belongs_to :user

  def convert_habit(match_habit)
    habit_hash = Habit.user_input_columns.each_with_object({}) do |col, hash|
    hash[col] = Habit.send("#{col}_quantified")[match_habit.send(col)]
    end
    habit_hash
  end

end

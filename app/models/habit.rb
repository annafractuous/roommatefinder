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

  belongs_to :user

  def convert_habit(match_habit)
    habit_hash = Habit.user_input_columns.each_with_object({}) do |col, hash|
      hash[col] = Habit.send("#{col}_quantified")[match_habit.send(col)]
    end
    habit_hash
  end

  def self.print_category_score(user, match)
    score = MatchCalculation.mutual_compatibility_score_per_category(user, match, self.name.downcase)
    if score == -1
      "One of you hasn't answered any questions in this category"
    else
      "You are #{score}% compatible in this category!"
    end
  end

end

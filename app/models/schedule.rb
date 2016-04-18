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
  extend ChoicesQuantifiable::Schedule
  include Validatable
  extend InputColumnable::ClassMethods
  include InputColumnable

  belongs_to :user


  def convert_schedule(match_schedule)
    schedule_hash = Schedule.user_input_columns.each_with_object({}) do |col, hash|
    hash[col] = Schedule.send("#{col}_schedule_quantified")[match_schedule.send(col)]
    end
    schedule_hash
  end

end

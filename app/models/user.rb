# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  age             :integer
#  gender          :string
#  dealbreakers    :text
#  has_apartment   :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string
#  username        :string
#

class User < ActiveRecord::Base
 has_secure_password

 has_one :cleanliness
 has_one :desired_cleanliness
 has_one :schedule
 has_one :desired_schedule
 has_one :habit
 has_one :desired_habit
 has_many :match_connections
 has_many :matches, through: :match_connections
 accepts_nested_attributes_for :habit, :desired_habit
 accepts_nested_attributes_for :cleanliness, :desired_cleanliness
 accepts_nested_attributes_for :schedule, :desired_schedule

 validates_presence_of :email, :username, :name, :age, :gender
 validates_uniqueness_of :email, :username
 validates_presence_of :password, on: :create
 validates_confirmation_of :password


 def completed_profile_percentage
 
  classes=[Cleanliness, DesiredCleanliness, Schedule, DesiredSchedule, Habit, DesiredHabit]

  completion_hash=classes.each_with_object({total: 0, completed: 0}) do |class_name, completion_hash|
    class_name.user_input_columns.each do |col_name| 
      # need an extra if-statement here to guard for an object
      # that is not created, i.e. the first time the user logs in
      # self.cleanliness = nil
      if self.send(class_name.name.underscore)
        if self.send(class_name.name.underscore).send(col_name)
          completion_hash[:completed] += 1
        end
      end
      completion_hash[:total] += 1
    end
  end

  (completion_hash[:completed].to_f / completion_hash[:total] * 100).round(2)
 end

end



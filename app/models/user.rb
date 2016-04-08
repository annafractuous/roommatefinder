# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string
#  email         :string
#  age           :integer
#  gender        :string
#  dealbreakers  :text
#  has_apartment :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class User < ActiveRecord::Base
 has_one :cleanliness
 has_one :desired_cleanliness
 has_one :schedule
 has_one :desired_schedule
 has_one :habit
 has_one :desired_habit
 accepts_nested_attributes_for :cleanliness, :desired_cleanliness, :schedule, :desired_schedule, :habit, :desired_habit
end

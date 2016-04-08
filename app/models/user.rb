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
 has_one :preference
 has_one :profile
 has_one :cleanliness, through: :profile
 has_one :desired_cleanliness, through: :preference
 has_one :schedule, through: :profile
 has_one :desired_schedule, through: :preference
 has_one :habit, through: :profile
 has_one :desired_habit, through: :preference
end

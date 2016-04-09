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


end

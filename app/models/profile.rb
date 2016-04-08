# == Schema Information
#
# Table name: profiles
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  cleanliness      :string
#  schedule         :string
#  social_habits    :string
#  substance_habits :string
#  pets             :string
#

class Profile < ActiveRecord::Base
  belongs_to :user
  has_one :cleanliness
  has_one :schedule
  has_one :habit
end

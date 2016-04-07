# == Schema Information
#
# Table name: preferences
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

class Preference < ActiveRecord::Base
  belongs_to :user
end

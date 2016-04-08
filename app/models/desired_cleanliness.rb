# == Schema Information
#
# Table name: desired_cleanlinesses
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  kitchen      :string
#  bathroom     :string
#  common_space :string
#  user_id      :integer
#

class DesiredCleanliness < ActiveRecord::Base
  belongs_to :user
end

# == Schema Information
#
# Table name: desired_cleanlinesses
#
#  id                      :integer          not null, primary key
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  kitchen                 :string
#  bathroom                :string
#  common_space            :string
#  user_id                 :integer
#  kitchen_importance      :integer
#  bathroom_importance     :integer
#  common_space_importance :integer
#

class DesiredCleanliness < ActiveRecord::Base
  belongs_to :user
  include HowImportantToYouAble
end

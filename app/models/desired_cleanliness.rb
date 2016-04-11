# == Schema Information
#
# Table name: desired_cleanlinesses
#
#  id                      :integer          not null, primary key
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  kitchen                 :integer
#  bathroom                :integer
#  common_space            :integer
#  user_id                 :integer
#  kitchen_importance      :integer
#  bathroom_importance     :integer
#  common_space_importance :integer
#

class DesiredCleanliness < ActiveRecord::Base
  include HowImportantToYouAble
  include ChoicesQuantifiable::Cleanliness
  include Validatable
  extend InputColumnable
  belongs_to :user

  validate :preference_and_importance_entered?

end

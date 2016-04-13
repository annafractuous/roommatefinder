# == Schema Information
#
# Table name: cleanlinesses
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  kitchen      :integer
#  bathroom     :integer
#  common_space :integer
#  user_id      :integer
#

class Cleanliness < ActiveRecord::Base
  include ChoicesQuantifiable::Cleanliness
  include Validatable
  extend InputColumnable::ClassMethods
  include InputColumnable
  validate :cannot_select_pick_one

  belongs_to :user
end

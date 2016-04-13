# == Schema Information
#
# Table name: desired_match_traits
#
#  id           :integer          not null, primary key
#  gender       :string
#  move_in_date :datetime
#  min_age      :integer
#  max_age      :integer
#  city         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#

class DesiredMatchTrait < ActiveRecord::Base
  belongs_to :user
  include ChoicesQuantifiable::Cleanliness
  include Validatable
  extend InputColumnable::ClassMethods
  include InputColumnable
end
